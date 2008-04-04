Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B88FDDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 13:01:09 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34216jV008054
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:01:06 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34216Tc252292
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:01:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34216t6007851
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:01:06 -0400
Date: Thu, 3 Apr 2008 21:00:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080403210027.05339204@zod.rchland.ibm.com>
In-Reply-To: <7226bef216680748a503.1207262582@thinkpadL>
References: <7226bef216680748a503.1207262582@thinkpadL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 03 Apr 2008 17:43:02 -0500
Jerone Young <jyoung5@us.ibm.com> wrote:

> # HG changeset patch
> # User Jerone Young <jyoung5@us.ibm.com>
> # Date 1207262487 18000
> # Node ID 7226bef216680748a50327900572c2fbc3e762b0
> # Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1

As a complete and unrelated side note to the actual patch, wtf is this
hg stuff?  I can't really tell what tree you're even basing this off of.

> Add idle wait support for 44x platforms
> 
> This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.

This huge single line needs fixing in the next version of the patch.

> 
> 1) Command line
> 	idle=spin <-- CPU will spin (this is the default)
> 	idle=wait <-- set CPU into wait state when idle
> 
> 2) The device tree will be checked for the "/hypervisor" node
>    If this node is seen it will use "wait" for idle, so that
>    the hypervisor can know when guest Linux kernel it is in
>    an idle state.
> 
> This patch, unlike the last, isolates the code to 44x platforms.

In addition to the comments Tony and Hollis made, I have a few of my
own.

> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> 
> diff --git a/arch/powerpc/platforms/44x/44x.h b/arch/powerpc/platforms/44x/44x.h
> --- a/arch/powerpc/platforms/44x/44x.h
> +++ b/arch/powerpc/platforms/44x/44x.h
> @@ -5,4 +5,6 @@ extern void as1_writeb(u8 data, volatile
>  extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
>  extern void ppc44x_reset_system(char *cmd);
> 
> +extern int ppc44x_idle_init(void);
> +
>  #endif /* __POWERPC_PLATFORMS_44X_44X_H */

The changes to this file aren't needed.  See below.

> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -1,4 +1,5 @@ obj-$(CONFIG_44x)	:= misc_44x.o
>  obj-$(CONFIG_44x)	:= misc_44x.o
> +obj-$(CONFIG_44x)	+= idle.o

Just add this target to the already existing obj-(CONFIG_44x)

>  obj-$(CONFIG_EBONY)	+= ebony.o
>  obj-$(CONFIG_TAISHAN)	+= taishan.o
>  obj-$(CONFIG_BAMBOO)	+= bamboo.o
> diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
> --- a/arch/powerpc/platforms/44x/bamboo.c
> +++ b/arch/powerpc/platforms/44x/bamboo.c
> @@ -61,3 +61,5 @@ define_machine(bamboo) {
>  	.restart			= ppc44x_reset_system,
>  	.calibrate_decr 	= generic_calibrate_decr,
>  };
> +
> +machine_late_initcall(bamboo, ppc44x_idle_init);

Ugh.  Don't add an init call to every 4xx board like this.  It's not
needed.  See below.

> diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/platforms/44x/idle.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/idle.c

If you're ever going to extend bare metal support for this to 40x, then
this is the wrong place for it.  It should reside in
arch/powerpc/sysdev/ppc4xx_soc.c in that case.

> +
> +#include <linux/of.h>
> +#include <asm/machdep.h>
> +
> +static void ppc44x_idle(void);

This isn't needed.  Move the structures below the function.

> +struct sleep_mode {
> +	char *name;
> +	void (*entry)(void);
> +};
> +
> +static struct sleep_mode modes[] = {
> +	{ .name = "spin", .entry = NULL },
> +	{ .name = "wait", .entry = &ppc44x_idle },
> +};

<snip>

> +int __init ppc44x_idle_init(void)
> +{
> +	if(of_find_node_by_path("/hypervisor") != NULL) {
> +		/* if we find /hypervisor node is in device tree,
> +		   set idle mode to wait */
> +		current_mode = 1; /* wait mode */
> +	}
> +
> +	ppc_md.power_save = modes[current_mode].entry;
> +	return 0;

I liked Hollis' method of assignment here.

> +}

Add an arch_initcall(ppc44x_idle_init); here and dispense with
changing every board .c file in the 44x directory.

josh
