Return-Path: <linuxppc-dev+bounces-24848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052CFC53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 00:10:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7fBg3YTVz2xYh;
	Mon, 27 Jul 2026 10:10:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785090823;
	cv=none; b=bcI82RMeEShsC5aB+CpIxSRUniq1EsXDtTysAHaxqla+UvsbR8fAGU3i7r32WO89N6Ma5UCOl84i/F2AazvYVy0XKh4wJqt/awjYFYuin/OOOAMxavZP35NWi+0qzCc3M4EL2vUB4FZdjlndtDx/q2YHyvNvHv2clnHZxber4+FUZLY2QlAuOZCfjqWdUx1+8U7mkWCnvU6KfUDJhyoDRw+E5wKOrtdk1ODB7phMg8Iwdto94vU2CuzYpwvii99BJF+N7FToVlrTx2YeGMTIjzHzYstiLDq6hWfKjmb+l55/zQ/kjdYGIfsSehp3w14ZWZd65ABVrluu8DA8W5oElA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785090823; c=relaxed/relaxed;
	bh=yVealb4sFVoDbYxayhe1Zlrv/ofox1SJd4UpEW5hJr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxQF1T8AUhbhA2+2CNIFS5kc7hma1p4hAWMNYXd6/0rYfY82SIpLv7fY+NvsRyST8TIjj0umN3v19QDp2iBpTH77Gqxn48S1BJpxU86oks2F0+A6ozbXtt0ebkKx77WdC2gEGR1Xd8Gx9KKbTFufzRH0c1hJf/x7UVrvlT+a2te8aIgu/fJvsbre/a6XFYw5zjB3J19OwzUQuHP1hAXyxy5laJLomrdSEHDbJ82MQr7weuYArkxgHv/QHAPX1mYI1DX2aeLrpB0DxWYVY7koL2hnxhQUBDm15RbjaVXBcwNrji9YhuWyZ8Lyw1hVvWjDIP9/MdtvSxleoiqgfcoDOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W113DrNt; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciH2eAX; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W113DrNt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciH2eAX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7Vjf59GSz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 04:33:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785090817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVealb4sFVoDbYxayhe1Zlrv/ofox1SJd4UpEW5hJr4=;
	b=W113DrNti/kYR83oD7MNgqGr5mEaX4R6anna2LzjJdH8cOYvD0o2tms4lO3LSdrmUbuEAV
	0GLvtmWOhnJbWYVEY4I6guRA83BUgAK28kTvxAqOPNxvoFIQ3l7FBMIRQH7wACH+z1hNW5
	fY5BVWk/5pdC98UctJz3Hcpjrcnvipc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785090818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVealb4sFVoDbYxayhe1Zlrv/ofox1SJd4UpEW5hJr4=;
	b=TciH2eAXwl7etJ7P8tnWHeWG6tl3Gx3J971KZKEfBosz4nPhKGOzWwNOwfH9WhxFWT7NZl
	AL4b8CtzUG4WKYNi6F4yIiHY9/G4vVluUjyAC9yMnZ3HmP52NJmIb8auMhRAlgtNkwSTs5
	OBA7iRHWaSy20OTgZwvTQ4AhJEx4JHo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-9mb2eBeJMO6-ktARQyarVw-1; Sun, 26 Jul 2026 14:33:36 -0400
X-MC-Unique: 9mb2eBeJMO6-ktARQyarVw-1
X-Mimecast-MFC-AGG-ID: 9mb2eBeJMO6-ktARQyarVw_1785090815
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6823efcso18661005ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 11:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090815; x=1785695615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVealb4sFVoDbYxayhe1Zlrv/ofox1SJd4UpEW5hJr4=;
        b=GLHmzLfYkY9mD/YGGhgM8lUlrMPzN0CR9/9L4lq1MNcjOgR8w0toQU7TY92htzuP2e
         mLQ/TylXxHn6kxIFvDFAhdb5CB5UrrZ7Vo2jjhEw2gBh04eGcyvO/6k57NCroqbDnG6L
         BgZzWlQoKFpthNdFcIzBvibVdJdoZ4KA5WFS3iZkqXSNECIhTeh8/NURPpRxgxRGzA8L
         uQX507MCcORTKc2falhVKjW8hCTNdUgUKQN/Xq7qW3S8fCf9aGapCu4TcLdUFlLSYNmn
         NUaerlYpdGcVEvywSlCKJHCZDeSd22pN8fP/V/JsOghIBmuMjtR4hJNdxiq0ImQi2omX
         0UBA==
X-Forwarded-Encrypted: i=1; AHgh+RrLe4OWsqB8Su9XQKN6tDC7iNX7U89aYIROrIE7HoVSgDSv4/m/ka1rkJr3T8QRlxLol6voHtG+S6jdeBU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3h5fz906P8Kdr8sslInMRbYoO7wJM38nECRbGG06J+jnTV1IX
	rg8Kyvbz/m9grnzokvP4RvKP4toOvRffn66lbiPVQ6AUX98DqNnNjoA3B3Ce8VCg0gI8iPhRdZO
	49Q6xzvWjzJoRB0hmOPHmbjH5v93BGIRSIJpGTONOPXhsYbalaWoAV+l5ppUvny+GjgA3WqEyzD
	fFcnUmAyLUUWow8wy1eopDCkkA2Ikk7qIQmkzh019K1Q==
X-Gm-Gg: AR+sD12R/iYv1PsbL49r75Gpp/cn2aeoVqjwPwvqm2ffJv2zZOtVTzpZ5Q5nICH0l3v
	B1jQEYg8BUTWSGQFhbwTyH3FwPgoJib8OMS7c8KiJIWRNWjJU2fastLSMwi+hCjbajA6L/yIBrJ
	aPa0J13wGkoHQTtFVffzm9jUFhzq16fQpTzeW2hls0XUuLcC1s0bVc+QM=
X-Received: by 2002:a17:902:d584:b0:2cc:670d:9b2f with SMTP id d9443c01a7336-2cfde8679afmr51645755ad.33.1785090814585;
        Sun, 26 Jul 2026 11:33:34 -0700 (PDT)
X-Received: by 2002:a17:902:d584:b0:2cc:670d:9b2f with SMTP id
 d9443c01a7336-2cfde8679afmr51645595ad.33.1785090814132; Sun, 26 Jul 2026
 11:33:34 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20250210184334.567383-1-sshegde@linux.ibm.com> <20250210184334.567383-2-sshegde@linux.ibm.com>
In-Reply-To: <20250210184334.567383-2-sshegde@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Sun, 26 Jul 2026 20:33:21 +0200
X-Gm-Features: AUfX_mwiKOcJ_Rw_48d0QO6Qsq6VmchWO0XwvQsoSu1wuG85hzJRgAtfRa8Esgk
Message-ID: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, 
	Jirka Hladky <jhladky@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XghKHqgI397wXOUposCAbIXrXov83iF20uPsPttzpbw_1785090815
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi Shrikanth, Christophe,

 I'm seeing a significant performance regression on ppc64le after this
 patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
 once HAVE_PREEMPT_DYNAMIC_KEY is selected.

 Benchmark: stress-ng kill stressor (tight kill() syscall loop),
 single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).

 Bisected across Fedora ELN kernel builds on ppc64le:

   kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
 ---  6.15-rc6 (eln148)    no                   103,207
   6.16     (eln150)          yes                   70,281    (-32%)
   6.18     (eln154)          yes                   72,552    (-30%)

 For comparison, x86_64 (AMD EPYC 9355P) with the same config change
 shows only a 2.8% regression:

   6.12 x86_64          37,436
   7.2  x86_64           36,392    (-2.8%)

 perf report shows the overhead comes from rcu_read_lock/unlock in the
 SELinux AVC path (check_kill_permission -> security_task_kill ->
 selinux_task_kill -> avc_has_perm -> avc_lookup):

   Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
 ---  avc_lookup                          15.23%              24.79%
   __rcu_read_lock                      ~0%                 4.52%
   __rcu_read_unlock                    ~0%                 4.17%
   selinux_task_kill                    6.23%               7.35%
   audit_signal_info*                   0.94%               3.59%

 On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
 (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
 implementation, the weak memory model requires real barriers
 (lwsync/isync) making each RCU read-side critical section
 significantly more expensive.

 This aligns with Christophe's earlier review comment that
 HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
 implementing static calls for ppc64 be feasible to close this gap?

 Test details:
 - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
 - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
 - Tuned profile: virtual-guest
 - SELinux: enforcing (permissive recovers only ~7%)

 Happy to run additional tests if needed.


On Mon, Feb 10, 2025 at 7:46=E2=80=AFPM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
>
> Once the lazy preemption is supported, it would be desirable to change
> the preemption models at runtime. So add support for dynamic preemption
> using DYNAMIC_KEY.
>
> ::Tested lightly on Power10 LPAR
> Performance numbers indicate that, preempt=3Dnone(no dynamic) and
> preempt=3Dnone(dynamic) are close.
>
> cat /sys/kernel/debug/sched/preempt
> (none) voluntary full lazy
> perf stat -e probe:__cond_resched -a sleep 1
>  Performance counter stats for 'system wide':
>              1,253      probe:__cond_resched
>
> echo full > /sys/kernel/debug/sched/preempt
> cat /sys/kernel/debug/sched/preempt
> none voluntary (full) lazy
> perf stat -e probe:__cond_resched -a sleep 1
>  Performance counter stats for 'system wide':
>                  0      probe:__cond_resched
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig               |  1 +
>  arch/powerpc/include/asm/preempt.h | 16 ++++++++++++++++
>  arch/powerpc/kernel/interrupt.c    |  6 +++++-
>  arch/powerpc/lib/vmx-helper.c      |  2 +-
>  4 files changed, 23 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/preempt.h
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 424f188e62d9..364edaea1f88 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -275,6 +275,7 @@ config PPC
>         select HAVE_PERF_EVENTS_NMI             if PPC64
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
> +       select HAVE_PREEMPT_DYNAMIC_KEY
>         select HAVE_RETHOOK                     if KPROBES
>         select HAVE_REGS_AND_STACK_ACCESS_API
>         select HAVE_RELIABLE_STACKTRACE
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/as=
m/preempt.h
> new file mode 100644
> index 000000000000..000e2b9681f3
> --- /dev/null
> +++ b/arch/powerpc/include/asm/preempt.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_POWERPC_PREEMPT_H
> +#define __ASM_POWERPC_PREEMPT_H
> +
> +#include <asm-generic/preempt.h>
> +
> +#if defined(CONFIG_PREEMPT_DYNAMIC)
> +#include <linux/jump_label.h>
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#define need_irq_preemption() \
> +       (static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +#else
> +#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> +#endif
> +
> +#endif /* __ASM_POWERPC_PREEMPT_H */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 8f4acc55407b..e0c681d0b076 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -25,6 +25,10 @@
>  unsigned long global_dbcr0[NR_CPUS];
>  #endif
>
> +#if defined(CONFIG_PREEMPT_DYNAMIC)
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#endif
> +
>  #ifdef CONFIG_PPC_BOOK3S_64
>  DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
>  static inline bool exit_must_hard_disable(void)
> @@ -396,7 +400,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs)
>                 /* Returning to a kernel context with local irqs enabled.=
 */
>                 WARN_ON_ONCE(!(regs->msr & MSR_EE));
>  again:
> -               if (IS_ENABLED(CONFIG_PREEMPTION)) {
> +               if (need_irq_preemption()) {
>                         /* Return to preemptible kernel context */
>                         if (unlikely(read_thread_flags() & _TIF_NEED_RESC=
HED)) {
>                                 if (preempt_count() =3D=3D 0)
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.=
c
> index 58ed6bd613a6..54340912398f 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
>          * set and we are preemptible. The hack here is to schedule a
>          * decrementer to fire here and reschedule for us if necessary.
>          */
> -       if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
> +       if (need_irq_preemption() && need_resched())
>                 set_dec(1);
>         return 0;
>  }
> --
> 2.39.3
>
>


--=20
-Jirka


