Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 7A45F67C36
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 09:46:17 +1100 (EST)
Date: Mon, 6 Nov 2006 16:46:03 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061106224603.GG6848@localdomain>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
	<20061031110515.GB7884@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061031110515.GB7884@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M wrote:
>
> Index: linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.19-rc3.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> @@ -658,7 +658,7 @@ static void __init xics_setup_8259_casca
>  
>  void __init xics_init_IRQ(void)
>  {
> -	int i;
> +	int i, j;
>  	struct device_node *np;
>  	u32 ilen, indx = 0;
>  	const u32 *ireg;
> @@ -686,23 +686,23 @@ void __init xics_init_IRQ(void)
>  	for (np = of_find_node_by_type(NULL, "cpu");
>  	     np;
>  	     np = of_find_node_by_type(np, "cpu")) {
> -		ireg = get_property(np, "reg", &ilen);
> -		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
> -			ireg = get_property(np,
> -					"ibm,ppc-interrupt-gserver#s", &ilen);
> -			i = ilen / sizeof(int);
> -			if (ireg && i > 0) {
> -				default_server = ireg[0];
> -				/* take last element */
> -				default_distrib_server = ireg[i-1];
> -			}
> -			ireg = get_property(np,
> +		ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> +		i = ilen / sizeof(int);
> +		for (j = 0; ireg[j] && j < i; j+=2) {
                            ^^^^^^
I don't understand this condition in the loop -- zero is a valid (and
common) value for interrupt servers:

# xxd /proc/device-tree/cpus/PowerPC,POWER5@0/ibm,ppc-interrupt-server#s
0000000: 0000 0000 0000 0001

# xxd /proc/device-tree/cpus/PowerPC,POWER5@0/ibm,ppc-interrupt-gserver#s
0000000: 0000 0000 0000 00ff 0000 0001 0000 00ff

So I think this patch wouldn't always work.

> +			if (ireg[j] == get_hard_smp_processor_id(boot_cpuid)) {
> +				if ( j + 1 < i) {
> +					default_server = ireg[j];
> +					default_distrib_server = ireg[j+1];
> +				}
> +				ireg = get_property(np,
>  					"ibm,interrupt-server#-size", NULL);
> -			if (ireg)
> -				interrupt_server_size = *ireg;
> -			break;
> +				if (ireg)
> +					interrupt_server_size = *ireg;
> +				goto out;
> +			}
>  		}
>  	}
> +out:
>  	of_node_put(np);


I think we need a helper function or two to make this easier to do
correctly and readably, e.g.

/* Returns the device node (with refcount incremented)
 * corresponding to the given logical cpu id */
struct device_node * cpuid_to_of_node(int cpu) {
	struct device_node *np;
	u32 hcpuid = get_hard_smp_processor_id(cpu);

	for_each_node_by_type(np, "cpu") {
		int len, i;
		u32 *intserv = get_property(np,
				"ibm,ppc-interrupt-server#s", &len);

		if (!intserv)
			intserv = get_property(np, "reg", &len);

		i = len / sizeof(u32);

		while (i--)
			if (intserv[i] == hcpuid)
				return np;
	}
	return NULL;
}


And then the loop in xics_init_IRQ can be replaced with something like:

np = cpuid_to_of_node(boot_cpuid);
BUG_ON(!np);
ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
hcpuid = get_hard_smp_processor_id(boot_cpuid);

if (ireg[0] == hcpuid)
	default_distrib_server = ireg[1];
else
	default_distrib_server = ireg[3];

default_server = hcpuid;

...
