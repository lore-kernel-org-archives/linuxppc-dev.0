Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqm9aMvt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jStr73s0cz2xdR;
	Tue, 17 Nov 2026 03:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794847191;
	cv=none; b=bkV5egIsmLxEAXh1tNxqfXAbUF+QyTjXu+i8lJ3Z7m1sktAbCwDrSlmu/8vLlMA/x3lv+jO7ggIWzhAIuty7HWeYZhYesA7PM1Rvck4AKmslvC+57LWlVANmWamgkYrGbGTQjGkj9ZBjpR/UDuyiXFbzu53R/1eDncrhYvDsIOr+UfTdXbeH2IX4t4d9uAbXEJm4zL2OMa6jDlehHndXZjMKioGuTl7PZnHzZ8ldVYaA9WKhBD2b7g8alQJJpC05JlYRO5ibHtSci/bgeeiuYFEvPo1wyI0iAdgI/vvHwc5DWm0DukqRxRDaBBgq7YElfyWi12d1J7Y4SAXQPMhRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794847191; c=relaxed/relaxed;
	bh=anLUZAdg+yS//6sj2yfcS+Rizyqykf4Omnwq1z+HIPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0Cu/5fAZ3cpJj9fMfyBOOtSIK+7bQ4ZZaLyZIyc+heI4cUmhg7huF6V2rlTjnkGRrNSuuca8DDwiQzvN5cMZDdyF4yqp1U7lJOisYTPTgGmzebp52Tnyx9WYUgA+OtrfljopW7TsAOsuHnxiPVHsHnsS/S+2HwAw4xWWKlvRIQ7MADZhrK+FjBBLJl5Sisy7444+9lwDgPnlNlQxq85zJGWxhpk20mr0+WuRTVQW1ltTegwK9bcWnH1+4IdOvZSS7PRQN7HAlldoiOjaM59GYqTcAPpf1Jj8Kp2mDYFBkDTZiZwGTj8cIeECj20fp72NoLdlFX970U7CiILxmNR3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqm9aMvt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqm9aMvt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jStr56tr3z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 03:39:49 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8a07078200fso1639125b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794847186; x=1795451986; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=anLUZAdg+yS//6sj2yfcS+Rizyqykf4Omnwq1z+HIPg=;
        b=nqm9aMvtEZZGHhanUuSAcx/sa3fMI9sPMTwzwHO8YYzFDq3+P/GqaS583sYYzI9OY4
         rkbVFW0mAWZ0v9QEVQr5sJDQzNVweAHVQgQtJJv+qlbsEmfMtX21vTTRndwHuYSSrqK/
         jVD0mkzJ5bU8PD7AfGlMONeRIDWWNS4a9boSGytkTefSsBf97e5gYHQEddF8hoJ59GUZ
         vP6iJz952FZvUp0aqS/bihaQMMc+hNMNGj52LhN86oTrMlKLaEN2d/I8dkWWB7q6OE5F
         0wwqxCDH88zkPPEAnfb9f7iEZUJveH1MKC7+H+prYeLrHWso05YT7eqvL+PV8eQBdxwV
         LQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847186; x=1795451986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anLUZAdg+yS//6sj2yfcS+Rizyqykf4Omnwq1z+HIPg=;
        b=2X3mk+HqJTkIsSqEE/ByoA9itpHbux19TmAdF5+xSUcrNHaYOGMu4mKqcmialcaTW2
         UndbrIfTf7gdiOcQ0k2eDSXSquNOObgt3fo9dnC4BzAmo6xrEUxCe0Zt9sMhJwM/UcNh
         Ht0ulGHnzNw2BUAS/cpB2AI7KtnIH2uUaLK/AzrlBsoMsPc8gAreQJwY8uV0zCGF+lPZ
         IPcxYUSPx4QZaqByMcBov8zbTeJz9UuwENX/nGdCgDQeF9ybrN5fg226IyP+QmfR1vEf
         d42Y89CF6hFML5ALbkaGAKKvw7UlXdmnkZbk5koD4kb6mEYuYPigkRmgdlOQkbBAxSbu
         S4Yw==
X-Forwarded-Encrypted: i=1; AL+hErHcDqgbOh+ZM0TeiJbC3ciSGcI4XmJZkeB7sfLnxebZe/0Ki9BYwpC0UVR46JzygzJ0rcY+9PXu/QQncVU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8wNhQZyuUDKyAnIeKwNcx0zK3yVvoGp3h3Jyh8JklCrRkyzUpq
	zXaRX9BalCp1yQvBIJOA9BWQueqvWlHQNmGILs6Pp0f4IRr/4EKCcsfc
X-Gm-Gg: AYBFou1Hn+0G9J0bD9c6bQE0IlgAwSJ2SWc91cbRiMjMx7AN63HTVRnsmF7rThpc6A1
	Gu00WcB0XetCrEbr5OmPwggCH6fTV33YwL3eMhR9s+ZG1gqTGcdaAWxBi7IiBOivKoMlLNzSFV1
	+zfe58DBZmMMFXn7/6OQITxhuwBR8RSK7PoMjUZa1rbejmFNW3uph9FhEfKCrI40elBePsy39ZL
	MAo6NgGUKSiMvh4yLD4yspvpfOY/fBmwh/neVBJuCuNA5H6q9J18zMaQrvFd5gnba6Yi/tgfwQR
	ENZmVK/PP1EEo1JdtXx41plMTl1UP23QJs9mXHnX6goixGe5PwFmIx2plNDhD63buzA7ZvA4hHW
	Ch5h1Q4q1JrW8ENrwGKgbcBf0VrOFm/Hdfe2p8Ji7xsLATIkSan7mAJYyfwZ4EIyT+wE4PLvQyd
	xDLEUpGvSvjc4ZdVmgYVDGWJmz/8jmlxLs9aayYdp5uhjpek0gUGcBVlLMkQ2vNw40Ju1bIRkk8
	fUqKX7wnUaUnhDBGYS0E+flxCAAUi48drV4psVtAwWWYi2NVcEdG/nTTHdbizgdOKls+c+uNwfJ
	5cMllI3erPEynpMq9cz58Re6zoDHaH7Mop10i29r46maBWgyNBuTsZ0ypLSW43r8h8fM5FZQwk0
	=
X-Received: by 2002:a05:6a00:4b54:b0:886:3a6c:a9da with SMTP id d2e1a72fcca58-8beb619a613mr10209991b3a.26.1794847185885;
        Mon, 16 Nov 2026 08:39:45 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.207.233.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b199cesm4137290b3a.52.2026.11.16.08.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:39:45 -0800 (PST)
Date: Mon, 16 Nov 2026 22:09:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, 
	venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH v3 1/3] powerpc/irq: Add ppc_hard_irq_disable()
Message-ID: <avsxGj4j9P7eFwGO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261112130913.4124175-1-sshegde@linux.ibm.com>
 <20261112130913.4124175-2-sshegde@linux.ibm.com>
 <fqx4802o.ritesh.list@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fqx4802o.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 10:46:15AM +0530, Ritesh Harjani wrote:
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
> > Add a flavour of interrupt disable which could be used in
> > multiple places which also takes care of lockdep in both 32 and
> > 64 bit archs.
> >
> > On PPC64:
> > - Disable hard interrupts using hard_irq_disable. It takes care of
> >   lockdep and tracing. local_irq_disable only alters softmask's state.
> >
> > On PPC32:
> > - Interrupts are hard disabled with local_irq_disable. It also takes
> >   care of lockdep and tacing.
> >
> > Subsequent patch uses this API in KVM code to avoid the warnings.
> > Wider use of it is possible, but it will be taken subsequently.
> >
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> > index b7eee6385ae5..075442366e1e 100644
> > --- a/arch/powerpc/include/asm/hw_irq.h
> > +++ b/arch/powerpc/include/asm/hw_irq.h
> > @@ -516,6 +516,23 @@ static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
> >  
> >  #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
> >  
> > +/*
> > + * Hard-disable interrupts while keeping the IRQ tracing state
> > + * consistent.
> > + *
> > + * On PPC64, local_irq_disable() only soft-disables interrupts, leaving
> > + * a window where an interrupt can be recorded in irq_happened before
> > + * interrupts are hard-disabled.
> > + *
> > + * On PPC32, hard_irq_disable() does not update the IRQ tracing state, so
> > + * use local_irq_disable().
> > + */
> > +#ifdef CONFIG_PPC64
> > +#define ppc_hard_irq_disable()	hard_irq_disable()
> > +#else
> > +#define ppc_hard_irq_disable()	local_irq_disable()
> > +#endif
> > +
> 
> So I looked up the history of how did we end up here. And looks like we
> will be papering over the problem, if we make the above change and add
> yet another helper on PPC :)
> 
> Ideally, ppc32 shouldn't need a hard_irq_disable() definition at all.
> As I understand it, the contract when this was all added was that, it is
> meant for architectures which implement lazy IRQ disabling i.e.
>     commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
>     Author: Paul Mackerras <paulus@ozlabs.org>
>     Date:   Wed Oct 4 16:47:49 2006 +1000
>         [POWERPC] Lazy interrupt disabling for 64-bit machines
>  
> ...where local_irq_disable() only sets a soft mask. Code that really
> wants interrupts disabled at the hardware level then calls
> hard_irq_disable() as well.
> 
> This commit which defined a generic stub for hard_irq_disable() makes the
> contract clear i.e.
>     commit 2d3fbbb391e280724f7f7804ab00ff61cf1b6a4c
>     Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Date:   Thu May 10 22:22:46 2007 -0700
> 
>         Add hard_irq_disable()
> which says:
>     This patch implements a generic hard_irq_disable() function which is meant to
>     be called -after- local_irq_disable() and ensures that interrupts are fully
>     disabled on that CPU.  The default implementation is a nop, though powerpc
>     does already provide an appropriate one.
> 
> And then the following even implements such a contract in stop_machine() i.e.:
>     commit a12bb44471b819c7f33d8a83044e7116c124e3d5
>     Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Date:   Thu May 10 22:22:47 2007 -0700
> 
>         stop_machine() now uses hard_irq_disable
> 
>         Add a call to hard_irq_disable() to stop_machine so that we make sure IRQs are
>         really disabled and not only lazy-disabled on archs like powerpc as some users
>         of stop_machine() may rely on that.
> 
>         [akpm@linux-foundation.org: build fix]
>         Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>         Acked-by: Rusty Russell <rusty@rustcorp.com.au>
>         Cc: Paul Mackerras <paulus@samba.org>
>         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
>     diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>     index daabb74ee0bc..fcee2a8e6da3 100644
>     --- a/kernel/stop_machine.c
>     +++ b/kernel/stop_machine.c
>     @@ -8,6 +8,8 @@
>     #include <linux/sched.h>
>     #include <linux/stop_machine.h>
>     #include <linux/syscalls.h>
>     +#include <linux/interrupt.h>
>     +
>     #include <asm/atomic.h>
>     #include <asm/semaphore.h>
>     #include <asm/uaccess.h>
>     @@ -45,6 +47,7 @@ static int stopmachine(void *cpu)
>             if (stopmachine_state == STOPMACHINE_DISABLE_IRQ 
>                 && !irqs_disabled) {
>                 local_irq_disable();
>     +			hard_irq_disable();
>                 irqs_disabled = 1;
>                 /* Ack: irqs disabled. */
>                 smp_mb(); /* Must read state first. */
>     @@ -124,6 +127,7 @@ static int stop_machine(void)
> 
>         /* Make them disable irqs. */
>         local_irq_disable();
>     +	hard_irq_disable();
>         stopmachine_set_state(STOPMACHINE_DISABLE_IRQ);
> 
>         return 0;
> 
> 
> However, note that after introducing the lazy interrupt disabling in
> 2006, we saw build failures on ppc32, since hard_irq_disable()
> definition didn't exist on that until then. This commit adds that
> definition, which is not wrong, since the lazy interrupt disabling patch
> really needed hard_irq_disable() to disable hardware interrupts. Hence
> this commit defined it on PPC32 as well, as local_irq_disable() itself
> i.e.
> 
>     commit 143db67af02cecab28032ec3a52e586b1433fe70
>     Author: Michael Ellerman <michael@ellerman.id.au>
>     Date:   Sun Nov 26 17:36:15 2006 +1100
> 
>         [POWERPC] Provide dummy hard_irq_enable/disable() for PPC32
> 
>         To allow arch/powerpc/kernel/crash.c to build on 32-bit we need a
>         definition of hard_irq_disable(). 32-bit doesn't support the lazy
>         interrupt disabling mechanism, so on 32-bit hard_irq_disable() is
>         simply local_irq_disable(). Add a definition for hard_irq_enable()
>         just for completeness.
> 
>         This allows (KEXEC=y && PPC32=y) to build again. Broken since
>         d04c56f73c30a5e593202ecfcf25ed43d42363a2.
> 
>         Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>         Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
>     diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
>     index fd3f2a206271..d604863d72fb 100644
>     --- a/include/asm-powerpc/hw_irq.h
>     +++ b/include/asm-powerpc/hw_irq.h
>     @@ -102,6 +102,9 @@ static inline void local_irq_save_ptr(unsigned long *flags)
>     #define local_irq_save(flags)	local_irq_save_ptr(&flags)
>     #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
> 
>     +#define hard_irq_enable()	local_irq_enable()
>     +#define hard_irq_disable()	local_irq_disable()
>     +
>     #endif /* CONFIG_PPC64 */
> 
>     #define mask_irq(irq)						\
> 
> 
> Note that the above is where we first defined hard_irq_disable() for
> PPC32.
> Ideally, IIUC, we don't really need this on PPC32 assuming the contract
> is only for archs which uses lazy interrupt disabling (i.e. PPC64),
> however, there were places where we ended up using hard_irq_disable()
> assuming it disables hardware interrupts for both PPC32 and PPC64 code
> and later maybe at a number of other places too.
> 
> Note that until this time, lockdep and IRQ tracing was not added. So it
> wasn't a problem. However, later somewhere we ended up changing the
> definition of hard_irq_disable(), to arch_local_irq_disable, maybe in
> this...
>    commit 5d38902c4838 ("powerpc: Add irqtrace support for 32-bit powerpc")
> 
> 
> So IMO, in the longer term, I think we don't need hard_irq_disable() for
> PPC32, and it should fallback to generic empty stub, after we fix all
> those code paths and use appropriate helpers there. However, that might
> need careful inspection of a lot of code paths.
> 
Yeah this makes sense. PPC32 shouldn't have hard_irq_disable at all.

> 
> Hence, meanwhile, I think instead of defining another helper like
> ppc_hard_irq_disable(), (which was stupid on my part to even suggest w/o
> looking at this history), we should change hard_irq_disable() definition
> back to local_irq_disable() for PPC32, which anyways takes care of
> trace_hardirqs_off().
> 
> Therefore, I think we need the following 2 diffs - which should fix both
> of the reported issues as well. And this way, we don't need another hard
> irq disabling helper on PPC.
> 
> DIFF(1)
> 
>     diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>     index b7eee6385ae5..ddb850e62abd 100644
>     --- a/arch/powerpc/include/asm/hw_irq.h
>     +++ b/arch/powerpc/include/asm/hw_irq.h
>     @@ -464,7 +464,7 @@ static inline bool arch_irqs_disabled(void)
>             return arch_irqs_disabled_flags(arch_local_save_flags());
>      }
>     
>     -#define hard_irq_disable()             arch_local_irq_disable()
>     +#define hard_irq_disable()             local_irq_disable()
>     
>      static inline bool regs_irqs_disabled(struct pt_regs *regs)
>      {
> 
> 
> and...
> 
> DIFF(2)
> 
>     diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>     index 13ad4cf5fa71..543479fc9630 100644
>     --- a/arch/powerpc/kvm/booke.c
>     +++ b/arch/powerpc/kvm/booke.c
>     @@ -722,7 +722,6 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>             if (vcpu->arch.shared->msr & MSR_WE) {
>                     local_irq_enable();
>                     kvm_vcpu_halt(vcpu);
>     -               local_irq_disable();
>                     hard_irq_disable();
> 
>                     kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
>     diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>     index 9194cf492d1c..f4db7dea57b3 100644
>     --- a/arch/powerpc/kvm/powerpc.c
>     +++ b/arch/powerpc/kvm/powerpc.c
>     @@ -81,12 +81,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>             int r;
> 
>             WARN_ON(irqs_disabled());
>     -       /*
>     -        * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
>     -        * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
>     -        * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
>     -        */
>     -       local_irq_disable();
>             hard_irq_disable();
> 
>             while (true) {
>     @@ -101,7 +95,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>                             */
>                             local_irq_enable();
>                             r = kvm_xfer_to_guest_mode_handle_work(vcpu);
>     -                       local_irq_disable();
>                             hard_irq_disable();
>                             if (r) {
>                                     /*
>     @@ -134,7 +127,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>                             local_irq_enable();
>                             trace_kvm_check_requests(vcpu);
>                             r = kvmppc_core_check_requests(vcpu);
>     -                       local_irq_disable();
>                             hard_irq_disable();
>                             if (r > 0)
>                                     continue;
> 
> 
> @Shrikanth, @Mukesh, your thoughts?
Yeah this looks good. We can go ahead with this implementation.
> If this looks good to you too, would you like to take this forward?
> 
> And, if I am not wrong, with the above 2 diffs, we don't need this patch
> either [1].
> 
> [1]: [PATCH] powerpc/entry: Trace the IRQ disable before irqentry_exit() on 32-bit
> [1]: https://lore.kernel.org/linuxppc-dev/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/
> 
> 
> 
> -ritesh
Regards,
Mukesh

