Return-Path: <linuxppc-dev+bounces-20824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C8DCD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 05:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFht82pDZz2xpp;
	Wed, 13 May 2026 15:32:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778650336;
	cv=none; b=PTVHLp48m0R2z7AZY+Tdd3Aep/7dmgPnSW8L27waee1AGT9LMXkKgBG+khTHDx6aMrPL8liZcrDILZRIwZCgM0BhCSOwSrIdRujhvFjiTV51z5exQyBLjc+wYD7jEKPZqVhb4kG4TSy+mQZwj6ZAiZUFNe5V+2zN03c0dqKdiRS5+OsxzuvAMURH2AW0nr6+4UVwRhwSgm69nnBkmjfrbY7PBgWvjetEUfzWf4eoE/Up1w3zY8mlWQLpyO8EBaDZ0sOGO2XzqAryfw9Am+0OHnnarKSoLCVOikQNJhBVga7gp7Ui/8owxR29W7lkjNetfFOvbMSu9IJ8vigOCilv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778650336; c=relaxed/relaxed;
	bh=Odlz6dn4AMU3xpWoO+zOes01KTSuDtmQ6fjIHbN8+tI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=MT4oYBh+NRFXdK85nOqEww9mytqp2C0nWEe1Cuo+V2DrVeesLn996wajPqbIcrgl8sxctbsQchvyEj3c6ddjaeUYftCuvWgtIfXHspLz0Tjef/ONJKVJ1gCLDvffHMLSLjOt60YMCvZ2pMFgAONgfiDhg2guUX2ayRXhhRj+YbBPRqA3tR+HLMFpSMK1NkaxLsY4go0p2R9oAA+MVWCaYzlTigBU5Rd2m8yDICHk3hP+RhAY5Y8iru/DsmybSu2maI4EfnkrYKyh2belamJn5SQJ74RCFbCQcPBgPUB+491BmXQeebZVauhkgewEMriprick/1B0I/qcwD0/QikCzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C5LUzQXa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C5LUzQXa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFht65pQPz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 15:32:13 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso4421358a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778650331; x=1779255131; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Odlz6dn4AMU3xpWoO+zOes01KTSuDtmQ6fjIHbN8+tI=;
        b=C5LUzQXaoXKDJA5aIkhgg51UlwAL4phGMIaEWgXYX2ZnecNlqIeVHLL0HtPbJmmD91
         dj6pu6XxDrUHB7Qj51llNF7xPxe7c9aTj9CsWF0oeJ5Oc67G3konTNXLIfVIyJBIZSm8
         jQhHC8D3eMe49Z96Sl1lJDkm754SieWzvdry/TqLXxjx446ZRQ/1F+2Ik+CK+y6zsLrj
         o+6ujY9ZWykvtPsDcbk12rkN6OBCkqUuziz8aEjIexk2eQcVTsm7g+HlEEZrTeVGoCOq
         9udmRWwhUtq6kwl6uAc3m6TVKhhG3Ap3Dc1tLdsfto3J92xnyXmND2t+lXB06NNmDLT/
         iNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778650331; x=1779255131;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Odlz6dn4AMU3xpWoO+zOes01KTSuDtmQ6fjIHbN8+tI=;
        b=Jr8Q8zmWjbtobRxS/HLajXZTYJSZMzMPZvKnVf/LOm6S87uKk2urRDECxazryXh1S3
         I5+AUq56dNpEiOHv1Sw1akK84KCdYFcMctnyg0BIQhyrJ8cu+bAX5O+DeaHWOtW3n/3u
         u8i/p9BHJ/EJl5ErsIqSacVlz+5jDL/Pk7VvL9HNHi1KGSweAYyAm8qz34qXWx2WRXRz
         PplIVP3oPwfk53RG30Wx5cD5q6UH8VolWzKIeWTGopnxzkyYC1jKlJ2RD6BxMhiX4+3H
         FXufVYfdaIdbE0u3dmvu7m7hFbzrCJRtv5LQSYNWXjtiu3UMXg808JF+1Bhg8D1NYrdU
         79Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+7WpjQNyAqB16DwklIk4rixVKlj/OEuPyzEh52mwr0yT2DcDcC5PajCRydskQS/qeDp6uRr2tWEmA/h0M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9CLq0md+/5BVoHA0y6eMA1X2MO9fqIgdQmeqPr3q1EeFbKFJx
	Pdz5xmev+WgchniiZqAVrsOewoMRFrLEVJ72MbRNyObi6CAdPSM1c3te
X-Gm-Gg: Acq92OGU2hvHVuuaD6XK5Xm165AQCOETJlBvCQbV1CGwFyZe+97Q6sRblCXh9zJAtYQ
	ABWfjohzfzAEYWg84Jj5peh+JZrw81zdhAaj6H5ARaCKqtkQIGyr9mTTH0pHKITtTwymxN8d7xI
	1Iw7I3h7QQMzF+7FcCQ3OKpFqEl2YPlNEB5ipzoPobcbDRFdA3IkkNJLvDoLHXR3uJuhIo4DNPr
	Rw9e9agj7pPqWOeqU2b+K6NACL0EZgIduk92p6XgN+zAbIvJr8VYWSVMGhjj8BwJ8QtA6VxdqG/
	X6ENQwf2b5vWze5/Jd/GTzIfmWOFPOgzBcBBWpmoRr1XCN+eWQeaNut68SCQ0oU52nEIDwu+S0A
	S9NvQfV/30YVO6GW+u/pfQFM6Oi/UCt3jbNCytgB2lFw88zZuq5+9elSm3hlGP7ySqwSq/Sw7it
	8ceDDohfpc/a+HVDkDg8zvGw==
X-Received: by 2002:a17:90b:2702:b0:366:4782:139a with SMTP id 98e67ed59e1d1-368f79930c2mr1396471a91.17.1778650330660;
        Tue, 12 May 2026 22:32:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede49dfcsm1614075a91.7.2026.05.12.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 22:32:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com, chleroy@kernel.org
Subject: Re: [PATCH 1/3] powerpc/time: remove preempt_disable/enable from arch_irq_work_raise()
In-Reply-To: <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
Date: Wed, 13 May 2026 10:00:49 +0530
Message-ID: <pl30q6bq.ritesh.list@gmail.com>
References: <cover.1778057685.git.sayalip@linux.ibm.com> <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
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

Sayali Patil <sayalip@linux.ibm.com> writes:

> A kernel panic is observed when handling machine check exceptions from
> real mode.
>
>   BUG: Unable to handle kernel data access on read at 0xc00000006be21300
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
>   LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150

[14626.841925] MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 88222248  XER: 00000005
[14626.841939] CFAR: c00000000003ffc4 DAR: c00000006be21300 DSISR: 40000000 IRQMASK: 0


Let's also add the above MSR state along with the call stack showing
MSR[EE] was 0 when this triggered. This also shows the DAR as 0xc....
while MSR[IR|DR] = 0. 

>   Call Trace:
>   [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
>   [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0
>
> The crash occurs because arch_irq_work_raise() calls preempt_disable()
> from machine check exception (MCE) handlers running in real mode. In
> this context, accessing the preempt_count can fault, leading to the panic.
>
> The preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
> was originally added by commit 0fe1ac48bef0 ("powerpc/perf_event: Fix
> oops due to perf_event_do_pending call") to avoid races while raising
> irq work from exception context.
>
> Later, commit 471ba0e686cb ("irq_work: Do not raise an IPI when
> queueing work on the local CPU") added preemption protection in
> irq_work_queue() path, while commit 20b876918c06 ("irq_work: Use per
> cpu atomics instead of regular atomics") added equivalent
> protection in irq_work_queue_on() before reaching arch_irq_work_raise():
>
>   irq_work_queue() / irq_work_queue_on()
>     -> preempt_disable()
>       -> __irq_work_queue_local()
>         -> irq_work_raise()
>           -> arch_irq_work_raise()
>
> As a result, callers other than mce_irq_work_raise() already execute
> with preemption disabled, making the additional
> preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
> redundant.
>
> Remove it to avoid accessing preempt_count from real mode context.
>
> Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")

Agree with the Fixes tag. This patch actually moved mce to use
arch_irq_work_raise(). It was ok until the CONFIG_PREEMPTION was
disabled on powerpc since macros like preempt_enable|disable() were
mostly a no-op. However, after lazy preemption got enabled, access to
preempt_count while in real mode can cause the issue you described.


One more thing which we should add to the commit msg is:
The arch_irq_work_raise() function executes in NMI context when called
from MCE handler, hence we won't be preempted or scheduled out since we
are in NMI context with MSR[EE]=0, hence it is safe to remove
preempt_disable|enable() call from here.

And let's change the commit subject to:
    powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()


BTW, thanks for adding a nice commit msg with the sequence of events.
With the above changes - pease feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  arch/powerpc/kernel/time.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 4bbeb8644d3d..a99eb43f6ce9 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -471,10 +471,8 @@ void arch_irq_work_raise(void)
>  	 * which could get tangled up if we're messing with the same state
>  	 * here.
>  	 */
> -	preempt_disable();
>  	set_irq_work_pending_flag();
>  	set_dec(1);
> -	preempt_enable();
>  }
>  
>  static void set_dec_or_work(u64 val)
> -- 
> 2.52.0

