Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A5E3B6EEA
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 08:56:49 +1100 (EST)
Message-ID: <4F44130B.5020300@freescale.com>
Date: Tue, 21 Feb 2012 15:56:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v5 1/4] KVM: PPC: epapr: Factor out the epapr init
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, B07421@freescale.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2012 10:46 PM, Liu Yu wrote:
> from the kvm guest paravirt init code.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v5:
> 1. fix the if test
> 2. use patch_instruction()
> 3. code cleanup
> 4. rename the files
> 5. make epapr paravirt user-selectable
> 
>  arch/powerpc/include/asm/epapr_hcalls.h |    2 +
>  arch/powerpc/kernel/Makefile            |    1 +
>  arch/powerpc/kernel/epapr_hcalls.S      |   25 ++++++++++++++
>  arch/powerpc/kernel/epapr_paravirt.c    |   54 +++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/kvm.c               |   28 ++--------------
>  arch/powerpc/kernel/kvm_emul.S          |   10 ------
>  arch/powerpc/platforms/Kconfig          |    7 ++++
>  7 files changed, 92 insertions(+), 35 deletions(-)
>  create mode 100644 arch/powerpc/kernel/epapr_hcalls.S
>  create mode 100644 arch/powerpc/kernel/epapr_paravirt.c
> 
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
> index f3b0c2c..0ff3f24 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -148,6 +148,8 @@
>  #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
>  #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
>  
> +extern bool epapr_para_enabled;
> +extern u32 epapr_hypercall_start[];

I asked for s/epapr_para/epapr_paravirt/, at least in anything that is
exposed beyond a single file.

>  /*
>   * We use "uintptr_t" to define a register because it's guaranteed to be a
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index ee728e4..ba8fa43 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -136,6 +136,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
>  obj-y				+= ppc_save_regs.o
>  endif
>  
> +obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>  
>  # Disable GCOV in odd or sensitive code
> diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
> new file mode 100644
> index 0000000..697b390
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr_hcalls.S
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/threads.h>
> +#include <asm/reg.h>
> +#include <asm/page.h>
> +#include <asm/cputable.h>
> +#include <asm/thread_info.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +
> +/* Hypercall entry point. Will be patched with device tree instructions. */
> +.global epapr_hypercall_start
> +epapr_hypercall_start:
> +	li	r3, -1
> +	nop
> +	nop
> +	nop
> +	blr
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
> new file mode 100644
> index 0000000..e601da7
> --- /dev/null
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -0,0 +1,54 @@
> +/*
> + * ePAPR para-virtualization support.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/of.h>
> +#include <asm/epapr_hcalls.h>
> +#include <asm/cacheflush.h>
> +#include <asm/code-patching.h>
> +
> +bool epapr_para_enabled = false;

No need to explicitly initialize to false.

> +static int __init epapr_para_init(void)
> +{
> +	struct device_node *hyper_node;
> +	const u32 *insts;
> +	int len, i;
> +
> +	hyper_node = of_find_node_by_path("/hypervisor");
> +	if (!hyper_node) {
> +		printk(KERN_WARNING
> +		       "ePAPR paravirt disabled: No hypervisor node found\n");
> +		return -ENODEV;
> +	}
> +
> +	insts = of_get_property(hyper_node, "hcall-instructions", &len);
> +	if (insts && !(len % 4) && len <= (4 * 4)) {
> +		for (i = 0; i < (len / 4); i++)
> +			patch_instruction(epapr_hypercall_start + i, insts[i]);
> +
> +		epapr_para_enabled = true;
> +	} else {
> +		printk(KERN_WARNING
> +		       "ePAPR paravirt disabled: No hypervisor inst found\n");
> +	}

Do not warn just because there's no hypervisor or hcall-instructions.
There's nothing wrong with that.  Only warn if they are present but wrong.

-Scott
