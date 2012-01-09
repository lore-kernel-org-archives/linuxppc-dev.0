Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 29622B6FA7
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2012 08:15:38 +1100 (EST)
Message-ID: <4F0B58F3.7040308@freescale.com>
Date: Mon, 9 Jan 2012 15:15:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v2 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
 <1325754412-29963-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1325754412-29963-2-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, agraf@suse.de,
 linuxppc-dev@ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2012 03:06 AM, Liu Yu wrote:
> diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
> index 3e2b95c..6ea95f0 100644
> --- a/arch/powerpc/kernel/idle_e500.S
> +++ b/arch/powerpc/kernel/idle_e500.S
> @@ -85,6 +85,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
>  2:	b	2b
>  #endif /* !E500MC */
>  
> +#ifdef CONFIG_KVM_GUEST
> +/*
> + * r3 contains the pointer to in[8]
> + * r4 contains the pointer to out[8]
> + * r5 contains the hcall vendor and nr
> + * r6 contains the handler which send hcall
> + */
> +_GLOBAL(e500_ev_idle)
> +	rlwinm	r7,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
> +	lwz	r8,TI_LOCAL_FLAGS(r7)	/* set napping bit */
> +	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
> +	stw	r8,TI_LOCAL_FLAGS(r7)	/* it will return to our caller */
> +	wrteei	1
> +	mtctr	r6
> +	bctr
> +#endif /* KVM_GUEST */

You'll need to branch back to the hcall invocation in an infinite loop
-- the only way we should leave is via an interrupt.

> +static void kvm_hcall_idle(void)
> +{
> +#ifdef CONFIG_KVM_E500
> +	ulong in[8];
> +	ulong out[8];
> +
> +	e500_ev_idle(in, out, HC_VENDOR_EPAPR | HC_EV_IDLE, kvm_hypercall);
> +#endif
> +}

kvm_hypercall is C code.  As stated before, you cannot use C code while
_TLF_NAPPING is set.

> +static bool kvm_para_has_idle(void)
> +{
> +#ifdef CONFIG_BOOKE
> +	return epapr_hcall_has_idle;
> +#else
> +	return false;
> +#endif
> +}
> +
>  static int __init kvm_guest_init(void)
>  {
>  	if (!kvm_para_available())
> @@ -594,6 +614,10 @@ static int __init kvm_guest_init(void)
>  	powersave_nap = 1;
>  #endif
>  
> +	/* Install hcall based power_save for guest kernel */
> +	if (kvm_para_has_idle())
> +		ppc_md.power_save = kvm_hcall_idle;

Why did you only move it halfway out of KVM code?  ePAPR features such
as idle hcall should work on any ePAPR hypervisor, even with all KVM
code disabled.

Plus everything Alex said. :-)

-Scott
