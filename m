Return-Path: <mohan@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E28367A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 20:10:34 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAT9ArRg007868
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 04:10:53 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAT9ASOG284976
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 04:10:28 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAT9ASH7009892
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 04:10:28 -0500
Date: Wed, 29 Nov 2006 14:40:22 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: paulus@samba.org, Anton Blanchard <anton@samba.org>
Subject: [PATCH] Fix for interrupt distribution
Message-ID: <20061129091022.GA11119@in.ibm.com>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
	<20061031110515.GB7884@in.ibm.com>
	<20061106224603.GG6848@localdomain>
	<20061116125637.GB13004@in.ibm.com>
	<20061116153616.GA670@krispykreme>
	<20061117121224.GC22383@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061117121224.GC22383@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 05:42:24PM +0530, Mohan Kumar M wrote:
> On Fri, Nov 17, 2006 at 02:36:16AM +1100, Anton Blanchard wrote:
> > 
> > Hi,
> > 
> > Thanks for fixing this problem. One thing I noticed in the patch:
> > 
> > > +	np = cpuid_to_of_node(boot_cpuid);
> > > +	BUG_ON(!np);
> > > +	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> > > +	hcpuid = get_hard_smp_processor_id(boot_cpuid);
> > > +
> > > +	if (ireg[0] == hcpuid)
> > > +		default_distrib_server = ireg[1];
> > > +	else
> > > +		default_distrib_server = ireg[3];
> > 
> > While this will work on current firmware it would be more robust to loop
> > through interrupt-gserver#s until you find your cpuid. For example we
> > set up multiple interrupt-gserver#s entries in the lab so we can have
> > chip, node local and global targets:
> > 
> > ibm,ppc-interrupt-server#s
> > 	00000002 00000003
> > 
> > ibm,ppc-interrupt-gserver#s
> > 	00000002 000000ff 00000003 000000ff 00000002 000000f7
> > 	00000003 000000f7 00000002 000000d7
> > 	00000003 000000d7
> > 
> > We always put the global target at the end (0xd7 in this case) because
> > the current code in Linux just grabs the last entry in the array to get
> > the global server. So the question is, do we look for the first or the
> > last entry that matches your cpuid to find the global server?
> > 
> > It might be worth getting something added to the architecture (PAPR) to
> > clear it up. To match what current Linux does, we would want servers to
> > go from including the least to the most cpus, so the global one is at
> > the end.
> >

Hi Paul,

I updated the patch as per Anton's suggestion. Can you please consider
this patch to be merged in the powerpc git tree?

Regards,
Mohan.
 
> 
> Thanks Anton,
> 
> I have modified the patch to loop through ibm,ppc-interrupt-gserver#s
> property to find the global distribution server from the last entry
> that matches with boot cpuid. So this patch will work with above
> situation also.
> 
> o The following patch allows any secondary CPU thread also to become
>   boot cpu for POWER5. The patch is required to solve kdump boot issue
>   when the kdump kernel is booted with parameter "maxcpus=1". XICS init
>   code tries to match the current boot cpu id with "reg" property in
>   each CPU node in the device tree. But CPU node is created only for
>   primary thread CPU ids and "reg" property only reflects primary CPU
>   ids. So when a kernel is booted on a secondary cpu thread above
>   condition will never meet and the default distribution server is left
>   as zero. This leads to route the interrupts to CPU 0, but which is not
>   online at this time.
> 
> o The patch uses ibm,ppc-interrupt-server#s to check for both primary
>   and secondary CPU ids. Accordingly default distribution server value
>   is initialized from "ibm,ppc-interrupt-gserver#s" property.
> 
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/xics.c |   68 ++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 19 deletions(-)
> 
> Index: linux-2.6.19-rc5/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.19-rc5.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6.19-rc5/arch/powerpc/platforms/pseries/xics.c
> @@ -656,13 +656,38 @@ static void __init xics_setup_8259_casca
>  	set_irq_chained_handler(cascade, pseries_8259_cascade);
>  }
> 
> +static struct device_node *cpuid_to_of_node(int cpu)
> +{
> +	struct device_node *np;
> +	u32 hcpuid = get_hard_smp_processor_id(cpu);
> +
> +	for_each_node_by_type(np, "cpu") {
> +		int i, len;
> +		const u32 *intserv;
> +
> +		intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
> +
> +		if (!intserv)
> +			intserv = get_property(np, "reg", &len);
> +
> +		i = len / sizeof(u32);
> +
> +		while (i--)
> +			if (intserv[i] == hcpuid)
> +				return np;
> +	}
> +
> +	return NULL;
> +}
> +
>  void __init xics_init_IRQ(void)
>  {
> -	int i;
> +	int i, j;
>  	struct device_node *np;
>  	u32 ilen, indx = 0;
> -	const u32 *ireg;
> +	const u32 *ireg, *isize;
>  	int found = 0;
> +	u32 hcpuid;
> 
>  	ppc64_boot_msg(0x20, "XICS Init");
> 
> @@ -683,26 +708,31 @@ void __init xics_init_IRQ(void)
>  	xics_init_host();
> 
>  	/* Find the server numbers for the boot cpu. */
> -	for (np = of_find_node_by_type(NULL, "cpu");
> -	     np;
> -	     np = of_find_node_by_type(np, "cpu")) {
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
> +	np = cpuid_to_of_node(boot_cpuid);
> +	BUG_ON(!np);
> +	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> +	if (!ireg)
> +		goto skip_gserver_check;
> +	i = ilen / sizeof(int);
> +	hcpuid = get_hard_smp_processor_id(boot_cpuid);
> +
> +	/* Global interrupt distribution server is specified in the last
> +	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
> +	 * entry fom this property for current boot cpu id and use it as
> +	 * default distribution server
> +	 */
> +	for (j = 0; j < i; j += 2) {
> +		if (ireg[j] == hcpuid) {
> +			default_server = hcpuid;
> +			default_distrib_server = ireg[j+1];
> +
> +			isize = get_property(np,
>  					"ibm,interrupt-server#-size", NULL);
> -			if (ireg)
> -				interrupt_server_size = *ireg;
> -			break;
> +			if (isize)
> +				interrupt_server_size = *isize;
>  		}
>  	}
> +skip_gserver_check:
>  	of_node_put(np);
> 
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
