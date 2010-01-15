Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E60D11007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 14:00:28 +1100 (EST)
Subject: Re: [PATCH 2/2] Update ibm,client-architecture call field based on
	device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <1263501674.4869.142.camel@jschopp-laptop>
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501674.4869.142.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 13:58:21 +1100
Message-ID: <1263524301.724.387.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-14 at 14:41 -0600, Joel Schopp wrote:
> In the previous patch the client-architecture field for the number of
> cores supported is set statically as high as is possible.  However, that
> static setting could be too high if the system supports smt, resulting
> in cpus assigned to Linux that are not booted.  This patch reads the
> device tree (before it is unflattened) to determine the amount of smt.
> It then dynamically updates the entires in the array with the proper
> number of cores supported.  Tests show this correctly detecting SMT4 on
> a Power7 and still booting all the supported cores on a large machine.

Same comments about submission format as the previous patch...

> Signed-off-by:Joel Schopp<jschopp@austin.ibm.com> 
> Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
> +++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
> @@ -141,6 +141,8 @@ typedef u32 cell_t;
>  
>  extern void __start(unsigned long r3, unsigned long r4, unsigned long r5);
>  
> +static int __init prom_smt_way(void);

Do you really need a forward declaration ? We generally avoid those and
prefer instead having the functions in the right order to make it
unnecessary.

>  #ifdef CONFIG_PPC64
>  extern int enter_prom(struct prom_args *args, unsigned long entry);
>  #else
> @@ -811,9 +813,17 @@ static void __init prom_send_capabilitie
>  {
>  	ihandle elfloader, root;
>  	prom_arg_t ret;
> +	u32 *cores;
>  
>  	root = call_prom("open", 1, 1, ADDR("/"));
>  	if (root != 0) {
> +		/*
> +		 * If you add to the struct, please be sure the 100 index
> +		 * didn't change.  The BUILD_BUG_ON is a reminder.
> +		 */
> +		BUILD_BUG_ON(sizeof(ibm_architecture_vec) != 108);

This is indeed a bit fishy... a nicer way may have been to have the
vector in an asm file with labels but that's probably overkill. Just
maybe add a runtime test that checks the value read initially is
NR_CORES and if not, print a big fat warning ?

> +		cores = (u32 *) &ibm_architecture_vec[100];
> +		*cores = (u32) (NR_CPUS/prom_smt_way());

The style is a bit gross though I suppose it will do. Drop the cast on
the second line, it's not useful, and stick some spaces around that
division. Also maybe print out a message saying to what value you
adjusted the max number of supported cores, might be useful on the field
to diagnose issues.

>  		/* try calling the ibm,client-architecture-support method */
>  		prom_printf("Calling ibm,client-architecture-support...");
>  		if (call_prom_ret("call-method", 3, 2, &ret,
> @@ -1031,6 +1041,45 @@ static void __init reserve_mem(u64 base,
>  	RELOC(mem_reserve_cnt) = cnt + 1;
>  }
>  
> +
> +static int __init prom_smt_way(void)
> +{
> +	phandle node;
> +	char type[64];
> +	unsigned int plen;
> +
> +	for (node = 0; prom_next_node(&node); ) {
> +		type[0] = 0;
> +		prom_getprop(node, "device_type", type, sizeof(type));
> +
> +		if (type[0] == 0) {
> +			/*
> +			 * CHRP Longtrail machines have no device_type
> +			 * on the memory node, so check the name instead...
> +			 */
> +			prom_getprop(node, "name", type, sizeof(type));

They also have no SMT :-) Just continue instead. You could also have
instead gone for /cpus and peeked at the first child. Might have lead to
a simpler construct (and faster runtime)

> +		}
> +		if (strcmp(type, RELOC("cpu")))
> +			continue;
> +
> +		/*
> +		 * There is an entry for each smt thread, each entry being
> +		 * 4 bytes long.  All cpus should have the same number of
> +		 * smt threads, so return after finding the first.
> +		 */
> +		plen = prom_getproplen(node, "ibm,ppc-interrupt-server#s");
> +		prom_debug("smt %x\n", (unsigned long) plen);

Might only be a debug message but it should be a tad more verbose about
what it's actually printing.

> +		if (plen >= 4)
> +			return plen / 4;
> +	}
> +	/*
> +	 * If things go wrong and we get here fallback to SMT1
> +	 */
> +	prom_debug("unable to determine smt from device tree, guessing smt1\n");
> +	return 1;
> +
> +}
> +

Cheers,
Ben.

>  /*
>   * Initialize memory allocation mechanism, parse "memory" nodes and
>   * obtain that way the top of memory and RMO to setup out local allocator
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
