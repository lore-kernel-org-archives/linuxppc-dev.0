Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27741B6FAA
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2012 23:11:12 +1100 (EST)
Message-ID: <4F4377AD.4000501@windriver.com>
Date: Tue, 21 Feb 2012 18:53:33 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v5 3/4] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
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

Liu Yu wrote:
> If the guest hypervisor node contains "has-idle" property.
> 
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v5: no change
> 
>  arch/powerpc/kernel/epapr_hcalls.S   |   29 +++++++++++++++++++++++++++++
>  arch/powerpc/kernel/epapr_paravirt.c |   11 ++++++++++-
>  2 files changed, 39 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
> index 697b390..72fa234 100644
> --- a/arch/powerpc/kernel/epapr_hcalls.S
> +++ b/arch/powerpc/kernel/epapr_hcalls.S
> @@ -15,6 +15,35 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
>  
> +#define HC_VENDOR_EPAPR		(1 << 16)
> +#define HC_EV_IDLE		16

Why not use 'EV_IDLE' directly?

> +
> +_GLOBAL(epapr_ev_idle)
> +epapr_ev_idle:
> +	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
> +	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
> +	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
> +	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
> +
> +	wrteei	1
> +
> +idle_loop:
> +	LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)

And could this line be simplified as something like this:

LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))

If so, even we can remove the previous HC_VENDOR_EPAPR definition as well.

Tiejun

> +
> +.global epapr_ev_idle_start
> +epapr_ev_idle_start:
> +	li	r3, -1
> +	nop
> +	nop
> +	nop
> +
> +	/*
> +	 * Guard against spurious wakeups from a hypervisor --
> +	 * only interrupt will cause us to return to LR due to
> +	 * _TLF_NAPPING.
> +	 */
> +	b	idle_loop
> +
>  /* Hypercall entry point. Will be patched with device tree instructions. */
>  .global epapr_hypercall_start
>  epapr_hypercall_start:
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
> index e601da7..43d875e 100644
> --- a/arch/powerpc/kernel/epapr_paravirt.c
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -21,6 +21,10 @@
>  #include <asm/epapr_hcalls.h>
>  #include <asm/cacheflush.h>
>  #include <asm/code-patching.h>
> +#include <asm/machdep.h>
> +
> +extern void epapr_ev_idle(void);
> +extern u32 epapr_ev_idle_start[];
>  
>  bool epapr_para_enabled = false;
>  
> @@ -39,8 +43,13 @@ static int __init epapr_para_init(void)
>  
>  	insts = of_get_property(hyper_node, "hcall-instructions", &len);
>  	if (insts && !(len % 4) && len <= (4 * 4)) {
> -		for (i = 0; i < (len / 4); i++)
> +		for (i = 0; i < (len / 4); i++) {
>  			patch_instruction(epapr_hypercall_start + i, insts[i]);
> +			patch_instruction(epapr_ev_idle_start + i, insts[i]);
> +		}
> +
> +		if (of_get_property(hyper_node, "has-idle", NULL))
> +			ppc_md.power_save = epapr_ev_idle;
>  
>  		epapr_para_enabled = true;
>  	} else {
