Return-Path: <xenidis@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id E9668DDED0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 23:36:17 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so4362anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Apr 2008 05:36:16 -0700 (PDT)
In-Reply-To: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for 44x
	platforms
Date: Fri, 4 Apr 2008 08:36:11 -0400
To: Jerone Young <jyoung5@us.ibm.com>
Sender: Jimi Xenidis <xenidis@gmail.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2008, at 3:06 AM, Jerone Young wrote:

> # HG changeset patch
> # User Jerone Young <jyoung5@us.ibm.com>
> # Date 1207292108 18000
> # Node ID afed3e5de82ab6c0ac8d6ceeb0292b6c41ece1ed
> # Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
> [v2] Add idle wait support for 44x platforms
>
> This patch adds the ability for the CPU to go into wait state while  
> in cpu_idle loop. This helps virtulization solutions know when the  
> guest Linux kernel is in an idle state. There are two ways to do it.
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
>
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
>
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/ 
> platforms/44x/Makefile
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -1,4 +1,4 @@ obj-$(CONFIG_44x)	:= misc_44x.o
> -obj-$(CONFIG_44x)	:= misc_44x.o
> +obj-$(CONFIG_44x)	:= misc_44x.o idle.o
>  obj-$(CONFIG_EBONY)	+= ebony.o
>  obj-$(CONFIG_TAISHAN)	+= taishan.o
>  obj-$(CONFIG_BAMBOO)	+= bamboo.o
> diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/ 
> platforms/44x/idle.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/idle.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2008 IBM Corp.
> + *
> + * Derived from pasemi/idle.c
> + * 	by Olof Johansson <olof@lixom.net>
> + *
> + * Added by: Jerone Young <jyoung5@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA   
> 02111-1307 USA
> + *
> + */
> +
> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <asm/machdep.h>
> +
> +static int current_mode = 0;

Doesn't matter if the 0 is functionally redundant or pleasing to your  
eye, it is the "Linux way" to leave out the " = 0", so just do it  
please.

> +
> +struct sleep_mode {
> +	char *name;
> +	void (*entry)(void);
> +};
> +
> +static void ppc44x_idle(void)
Perhaps "ppc44x_wait" is more appropriate?
> +{
> +	unsigned long msr_save;
> +
> +	msr_save = mfmsr();
> +	/* set wait state MSR */
> +	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);

Did we decide to drop MSR_DE?

> +	/* return to initial state */
> +	mtmsr(msr_save);

It may be my paranoia but I'm pretty sure you need the isync() after  
_both_ mtmsr()s
Certainly can't hurt.

> +}
> +
> +static struct sleep_mode modes[] = {
> +	{ .name = "spin", .entry = NULL },
> +	{ .name = "wait", .entry = &ppc44x_idle },
> +};
> +
> +int __init ppc44x_idle_init(void)
> +{
> +	void *func = modes[current_mode].entry;
> +	struct device_node *node;
> +
> +	node = of_find_node_by_path("/hypervisor");
> +	if (node) {
> +		/* if we find /hypervisor node is in device tree,
> +		   set idle mode to wait */
> +		func = &ppc44x_idle; /* wait */
> +		of_node_put(node);
> +	}
> +
> +	ppc_md.power_save = func;
> +	return 0;
> +}
> +
> +arch_initcall(ppc44x_idle_init);

IIRC, this would over-ride the idle_param() below, is that the  
intended behavior?

> +
> +static int __init idle_param(char *p)
> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(modes)/ARRAY_SIZE(modes); i++) {

It is supposed to be:
	for (i = 0; i < ARRAY_SIZE(modes); i++) {
What you have will actually eval to 0 and would have never checked  
anything :)

> +		if (!strcmp(modes[i].name, p)) {
> +			current_mode = i;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +early_param("idle", idle_param);
>
> ---------------------------------------------------------------------- 
> ---
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/ 
> marketplace
> _______________________________________________
> kvm-ppc-devel mailing list
> kvm-ppc-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-ppc-devel
