Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6028606A329
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wz1WmfEx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRVsc1c6lz30P3;
	Sat, 14 Nov 2026 21:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794652580;
	cv=none; b=IHex6odEcPyIDn0dLYI8d22ufelvTA9Q9I/ib/IdHjoTiH4fouQ7JIz0Roy2Dx8YPnk4HSn9g1j4MZnwDl16Qm4mF0LuiaokqLPWZ/FOjkJynIsfzpdJj0OOuct99Fl3pleiMjjw9JSwys5i08Cj0fOTxKiapeWmmw6l+mXOrbJWeN6sXJboTvpovRkpdncYeDHGs4XQQ5W0/Y8/iItRnQ10RRplncKB55kT6xhtqoVzhyEzhx9ckB5LQzLwvtoFG0cmywKwTbGJb7Myx6rMt1qbZL7ssWS9I6JmX1DtdMsOB7371W1e6YUwoJh3Q/rN07rMsR7TWYHnJrMBfhQA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794652580; c=relaxed/relaxed;
	bh=eo/LUF38V7+DYWv6Y1kyhmG3AAWawCm0XQ6aJuiVHCw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NG9Uk2nFqmAPz4dXLuQ0rTOhyKIkqUnXASaE0Gax1a5ynQzm126hks0AjzlQwd5zfrPP2imVCq9lDzmcg/Nntk33Os2L65xfaeZ14GL9nWqWNrQS6JV8+Ctklv/AYyaHXn6k12I4UmNgWvYhIVsebwjnKlJZzxW8pVNY6rPlhfbd6oCAPK+nDsP8f/kz/ABleDlpPkzLtaqr2eYTyqYobow6rnKBjf/flq+CYrmMnY7+Zp44JbkpAbiVJGj2XwdvuTCMCTur2DYxdFfc7H6k9MNs4kZyD3HAaKBJyGAkGYFbKNwio5+hATDhtKLCaFIiqrCZDrfEjE4AwoXnh1TuCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wz1WmfEx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wz1WmfEx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRVsZ5kvjz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 21:36:18 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1b3acec6677so2394660c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794652575; x=1795257375; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eo/LUF38V7+DYWv6Y1kyhmG3AAWawCm0XQ6aJuiVHCw=;
        b=wz1WmfExP6sD6kbLyaVd4EFIFSmsGpucw9QIkUYf82HNuE2UjvIZIiCFyTKF1POREw
         Lx0bQlCH+HCNBH6D/sqLo0/nka5mJt6a2It0hhZTZib3iRHMnCXMWUgTgJSYhXJdQ8Ux
         pA2Df9kYQO0zbdVAeiadLECGtxuFYfl4aXxdZ4VfDmaoVMFTtjBCiTo7qHI9ss6LRm5i
         VhY/ldhOj7+bOI7oV/6W6qyUM5+O0zZdrFnTcGiNxpcG4qCMqP1UURs0Hw45lV6Z6one
         9gF2Ag0/99lE5Af5DNCBTcS511gqM4tBSQomlBppXiZ+FUq8M42SZBtl7V+QBBlOsSlh
         R7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794652575; x=1795257375;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eo/LUF38V7+DYWv6Y1kyhmG3AAWawCm0XQ6aJuiVHCw=;
        b=pWCKZV167zSc3fSvufiXPEq9Vdkb8Jy4LZUb71BIOS+xqIMIIzD0zUf1MLY0H9rREu
         Lsg8L5nRNdBHblllzLwzh1TNk+oaU2yCLy9JXNF/MPN4Uhh0nqeVy72EV4C3jazLm7Cs
         4NG7QqiT3jBH/QuVWsrI1/mLbqOsJ0Jr5GR82xBAhLM820XiNuxe5rb66abZLfjRbXVr
         BrW8T4quEuiyHLqUkyjoUEtq9MR0DAMYtzsYR+YnHZwSK7SDhpH1q1Xbi82ImehWe7aF
         QimL8yXUJUcK1Y6pfqGbfx61tfPU+ahzHUTpcWXfpBXdIH2OlQhXXWMxoil6lf9ojtbq
         G7+g==
X-Forwarded-Encrypted: i=1; AL+hErEwSZWoHraNwkh0VpxiODYGSFeuBVzzmeOdmss+r4etOCxHRNxs/0+jLdD8MnPyq4MqhOhXga/ud2kgd5M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+onR6z9adVuEmgPCgSkBUMMN33BSaGpdrq+mIk0g8RTSPPX/Qw
	KRltEO3gNUrnVxKmh2mDHv8UhW4nfxl64MSgiYL2ncTG7vBfZjJFRVeQ
X-Gm-Gg: AYBFou2e9f1BsuK7AZhOe9B1/cCblIzILL0CPHLqoJuehCHMwd/uwrzr2myeFWKMSPC
	Y/AMYYy5Ls5LUtDIKqTrCDdmlfYSu6t2RLYCX2Hnh/EeU+3sxoY6RYzT1Tr7kckbE7x5afeJpJ8
	UwNHL/riv5vVIASBLTWhbHe+1LiAtsfqTjfzWTwkRBfUDqEM7pmFvfsrp0vls1kvr3HP5cEJSss
	Rb50X5IUPlwFzR2zmf2D/ibnfUBtjDs7FVHYWeLQELXUgIhauZf0q90Xr5I6UG1LJGVujkgTvaJ
	eoHP8ksIFzIBRtcEh5gUayXEns0nRkuSSWj7TL0GJgaLdOHF2mdJLyfhWaEjqk9I87ObUorQBXr
	NwsxgNVwJB2N+a/YJQF00ffw5QunxqlqBllsiMHq8bm1m0oQTVP3ON/+4PUaNOIIw/KPrgNmxgP
	yEEhqaXKE1n7X7HMOjRVw900b0Tb1Bq2s+yZOAXemDMRVmccTnBLcLtNzOtGvMofdQBIwfU7URC
	3lzsxDagZxsctRvVAJDRbApsXCUFnjvD5o6Q1i/TkkISHc8+lWgieu5tjau8jQJqVplH9HVS0EN
	YNeOazxkTCTF3C0xt3cVKuUI3wbUrEtOPgYn+00PtoMxRYtxfg==
X-Received: by 2002:a05:693c:808f:b0:351:29c8:643 with SMTP id 5a478bee46e88-379675fc97fmr4946543eec.18.1794652574783;
        Sat, 14 Nov 2026 02:36:14 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm23108783eec.18.2026.11.14.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:36:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v3 1/3] powerpc/irq: Add ppc_hard_irq_disable()
In-Reply-To: <20261112130913.4124175-2-sshegde@linux.ibm.com>
Date: Sat, 14 Nov 2026 10:46:15 +0530
Message-ID: <fqx4802o.ritesh.list@gmail.com>
References: <20261112130913.4124175-1-sshegde@linux.ibm.com> <20261112130913.4124175-2-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> Add a flavour of interrupt disable which could be used in
> multiple places which also takes care of lockdep in both 32 and
> 64 bit archs.
>
> On PPC64:
> - Disable hard interrupts using hard_irq_disable. It takes care of
>   lockdep and tracing. local_irq_disable only alters softmask's state.
>
> On PPC32:
> - Interrupts are hard disabled with local_irq_disable. It also takes
>   care of lockdep and tacing.
>
> Subsequent patch uses this API in KVM code to avoid the warnings.
> Wider use of it is possible, but it will be taken subsequently.
>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index b7eee6385ae5..075442366e1e 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -516,6 +516,23 @@ static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
>  
>  #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
>  
> +/*
> + * Hard-disable interrupts while keeping the IRQ tracing state
> + * consistent.
> + *
> + * On PPC64, local_irq_disable() only soft-disables interrupts, leaving
> + * a window where an interrupt can be recorded in irq_happened before
> + * interrupts are hard-disabled.
> + *
> + * On PPC32, hard_irq_disable() does not update the IRQ tracing state, so
> + * use local_irq_disable().
> + */
> +#ifdef CONFIG_PPC64
> +#define ppc_hard_irq_disable()	hard_irq_disable()
> +#else
> +#define ppc_hard_irq_disable()	local_irq_disable()
> +#endif
> +

So I looked up the history of how did we end up here. And looks like we
will be papering over the problem, if we make the above change and add
yet another helper on PPC :)

Ideally, ppc32 shouldn't need a hard_irq_disable() definition at all.
As I understand it, the contract when this was all added was that, it is
meant for architectures which implement lazy IRQ disabling i.e.
    commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
    Author: Paul Mackerras <paulus@ozlabs.org>
    Date:   Wed Oct 4 16:47:49 2006 +1000
        [POWERPC] Lazy interrupt disabling for 64-bit machines
 
...where local_irq_disable() only sets a soft mask. Code that really
wants interrupts disabled at the hardware level then calls
hard_irq_disable() as well.

This commit which defined a generic stub for hard_irq_disable() makes the
contract clear i.e.
    commit 2d3fbbb391e280724f7f7804ab00ff61cf1b6a4c
    Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Date:   Thu May 10 22:22:46 2007 -0700

        Add hard_irq_disable()
which says:
    This patch implements a generic hard_irq_disable() function which is meant to
    be called -after- local_irq_disable() and ensures that interrupts are fully
    disabled on that CPU.  The default implementation is a nop, though powerpc
    does already provide an appropriate one.

And then the following even implements such a contract in stop_machine() i.e.:
    commit a12bb44471b819c7f33d8a83044e7116c124e3d5
    Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Date:   Thu May 10 22:22:47 2007 -0700

        stop_machine() now uses hard_irq_disable

        Add a call to hard_irq_disable() to stop_machine so that we make sure IRQs are
        really disabled and not only lazy-disabled on archs like powerpc as some users
        of stop_machine() may rely on that.

        [akpm@linux-foundation.org: build fix]
        Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
        Acked-by: Rusty Russell <rusty@rustcorp.com.au>
        Cc: Paul Mackerras <paulus@samba.org>
        Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
        Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

    diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
    index daabb74ee0bc..fcee2a8e6da3 100644
    --- a/kernel/stop_machine.c
    +++ b/kernel/stop_machine.c
    @@ -8,6 +8,8 @@
    #include <linux/sched.h>
    #include <linux/stop_machine.h>
    #include <linux/syscalls.h>
    +#include <linux/interrupt.h>
    +
    #include <asm/atomic.h>
    #include <asm/semaphore.h>
    #include <asm/uaccess.h>
    @@ -45,6 +47,7 @@ static int stopmachine(void *cpu)
            if (stopmachine_state == STOPMACHINE_DISABLE_IRQ 
                && !irqs_disabled) {
                local_irq_disable();
    +			hard_irq_disable();
                irqs_disabled = 1;
                /* Ack: irqs disabled. */
                smp_mb(); /* Must read state first. */
    @@ -124,6 +127,7 @@ static int stop_machine(void)

        /* Make them disable irqs. */
        local_irq_disable();
    +	hard_irq_disable();
        stopmachine_set_state(STOPMACHINE_DISABLE_IRQ);

        return 0;


However, note that after introducing the lazy interrupt disabling in
2006, we saw build failures on ppc32, since hard_irq_disable()
definition didn't exist on that until then. This commit adds that
definition, which is not wrong, since the lazy interrupt disabling patch
really needed hard_irq_disable() to disable hardware interrupts. Hence
this commit defined it on PPC32 as well, as local_irq_disable() itself
i.e.

    commit 143db67af02cecab28032ec3a52e586b1433fe70
    Author: Michael Ellerman <michael@ellerman.id.au>
    Date:   Sun Nov 26 17:36:15 2006 +1100

        [POWERPC] Provide dummy hard_irq_enable/disable() for PPC32

        To allow arch/powerpc/kernel/crash.c to build on 32-bit we need a
        definition of hard_irq_disable(). 32-bit doesn't support the lazy
        interrupt disabling mechanism, so on 32-bit hard_irq_disable() is
        simply local_irq_disable(). Add a definition for hard_irq_enable()
        just for completeness.

        This allows (KEXEC=y && PPC32=y) to build again. Broken since
        d04c56f73c30a5e593202ecfcf25ed43d42363a2.

        Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
        Signed-off-by: Paul Mackerras <paulus@samba.org>

    diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
    index fd3f2a206271..d604863d72fb 100644
    --- a/include/asm-powerpc/hw_irq.h
    +++ b/include/asm-powerpc/hw_irq.h
    @@ -102,6 +102,9 @@ static inline void local_irq_save_ptr(unsigned long *flags)
    #define local_irq_save(flags)	local_irq_save_ptr(&flags)
    #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)

    +#define hard_irq_enable()	local_irq_enable()
    +#define hard_irq_disable()	local_irq_disable()
    +
    #endif /* CONFIG_PPC64 */

    #define mask_irq(irq)						\


Note that the above is where we first defined hard_irq_disable() for
PPC32.
Ideally, IIUC, we don't really need this on PPC32 assuming the contract
is only for archs which uses lazy interrupt disabling (i.e. PPC64),
however, there were places where we ended up using hard_irq_disable()
assuming it disables hardware interrupts for both PPC32 and PPC64 code
and later maybe at a number of other places too.

Note that until this time, lockdep and IRQ tracing was not added. So it
wasn't a problem. However, later somewhere we ended up changing the
definition of hard_irq_disable(), to arch_local_irq_disable, maybe in
this...
   commit 5d38902c4838 ("powerpc: Add irqtrace support for 32-bit powerpc")


So IMO, in the longer term, I think we don't need hard_irq_disable() for
PPC32, and it should fallback to generic empty stub, after we fix all
those code paths and use appropriate helpers there. However, that might
need careful inspection of a lot of code paths.


Hence, meanwhile, I think instead of defining another helper like
ppc_hard_irq_disable(), (which was stupid on my part to even suggest w/o
looking at this history), we should change hard_irq_disable() definition
back to local_irq_disable() for PPC32, which anyways takes care of
trace_hardirqs_off().

Therefore, I think we need the following 2 diffs - which should fix both
of the reported issues as well. And this way, we don't need another hard
irq disabling helper on PPC.

DIFF(1)

    diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
    index b7eee6385ae5..ddb850e62abd 100644
    --- a/arch/powerpc/include/asm/hw_irq.h
    +++ b/arch/powerpc/include/asm/hw_irq.h
    @@ -464,7 +464,7 @@ static inline bool arch_irqs_disabled(void)
            return arch_irqs_disabled_flags(arch_local_save_flags());
     }
    
    -#define hard_irq_disable()             arch_local_irq_disable()
    +#define hard_irq_disable()             local_irq_disable()
    
     static inline bool regs_irqs_disabled(struct pt_regs *regs)
     {


and...

DIFF(2)

    diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
    index 13ad4cf5fa71..543479fc9630 100644
    --- a/arch/powerpc/kvm/booke.c
    +++ b/arch/powerpc/kvm/booke.c
    @@ -722,7 +722,6 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
            if (vcpu->arch.shared->msr & MSR_WE) {
                    local_irq_enable();
                    kvm_vcpu_halt(vcpu);
    -               local_irq_disable();
                    hard_irq_disable();

                    kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
    diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
    index 9194cf492d1c..f4db7dea57b3 100644
    --- a/arch/powerpc/kvm/powerpc.c
    +++ b/arch/powerpc/kvm/powerpc.c
    @@ -81,12 +81,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
            int r;

            WARN_ON(irqs_disabled());
    -       /*
    -        * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
    -        * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
    -        * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
    -        */
    -       local_irq_disable();
            hard_irq_disable();

            while (true) {
    @@ -101,7 +95,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
                            */
                            local_irq_enable();
                            r = kvm_xfer_to_guest_mode_handle_work(vcpu);
    -                       local_irq_disable();
                            hard_irq_disable();
                            if (r) {
                                    /*
    @@ -134,7 +127,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
                            local_irq_enable();
                            trace_kvm_check_requests(vcpu);
                            r = kvmppc_core_check_requests(vcpu);
    -                       local_irq_disable();
                            hard_irq_disable();
                            if (r > 0)
                                    continue;


@Shrikanth, @Mukesh, your thoughts?
If this looks good to you too, would you like to take this forward?

And, if I am not wrong, with the above 2 diffs, we don't need this patch
either [1].

[1]: [PATCH] powerpc/entry: Trace the IRQ disable before irqentry_exit() on 32-bit
[1]: https://lore.kernel.org/linuxppc-dev/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/



-ritesh

