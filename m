Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734B606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+RXgnC6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTnM96RQCz2xlY;
	Wed, 18 Nov 2026 14:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794972981;
	cv=none; b=FukVPQx3gJWu1z4KG9NjZTnQEI0PTAuwl/KNFJvGkMhJM2Q792eUprONTcD301BOuCr1Xm96fBjavYFgTTRL3jIkTmQ6EsG0Yupw4f9ve2vanfIaiQyrfnGzoYhdZy+ti8z5NJqGIBjKYHqmcI1T4Ocwfxw5+ZmPbdHnkCVj8/9HSgAbOsOp/KpXwrw8xwU7UgJegDalo4KBjtTBs6oGIP0laXcpnkUuINRHkHANo6/bb8ovwV6K5v1jNX35zMvHY92dxdfJ/K+aXbns6zZmKmALPDhGgkTlwVSIe7CxFCzlT9G8nTUkxVSVxgZTXpRRYv4R9/iOjfoVweM36UJ8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794972981; c=relaxed/relaxed;
	bh=11RTZk9ANOdZGuwayk1pIL4zWdN4kr7W2Yo5uEDiGwk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=lH267IvujEWnF5dhNWdzCvR4Y+TDD1Un9WFI/Ij4B/kKa969KbajIuop655Kwp1LX7CG1YBruIAPTlmwgWtIMHOdesJnCj2Kfikxjw54bVtw+E2vmAwKANGdKGlWzGDQxiCAPWay4atF/tyYa7XsFfCn0L32GGUk8+CkUL/Woe5aAHRsvLctHX9CRp3YWM4yrgGkUo0VjZVmPo8kbUZZ2fUhQpvK/Lq3ZdFoS6aifJGrZ7TENsfQUG3l+d9frhEYitGp/rnxJxiPBhJT8EJQcNozKa1oCFscehWs1GCpqhbbafTNoia7+sw3ZWfz1d+YiGYmKnbUiP1q9WtA5vXQTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+RXgnC6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+RXgnC6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTnM82KDkz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 14:36:20 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3712b6d9843so687462eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794972978; x=1795577778; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=11RTZk9ANOdZGuwayk1pIL4zWdN4kr7W2Yo5uEDiGwk=;
        b=z+RXgnC6N7BGSRxXZJwWxBSOKNyGWsKOXxXcBuESojZaOetKx1f5VYu/GPps7xoINx
         0fPk4A/HNIg+4y1sIPB/NmGf/WS9jnFVidjF3JOzdqh9enbbHirNmWcHW5iNLREQK3up
         X68/rZbnr/18x5Dipx8yktjQaQ0acQKBs3XTqiSGNKSsK6LVB3wR51plcCu9P4JS9NIN
         suSgJbRdC/2xLOdWDjeDqm0CgwrF+GVoz1lUtkYed19Mt8Eg8Z9kfceWmPn2RLzSK/hY
         pxHeeIaIZb0oAHBrJq5QVBv6z+5z+ugG4/9q7ymgjCo84WLhFqslIAd4OGlvh/4a4hcB
         Oydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794972978; x=1795577778;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11RTZk9ANOdZGuwayk1pIL4zWdN4kr7W2Yo5uEDiGwk=;
        b=Qv5IGYp/r9YPju8VNgmMImKge3x1nTezxDNwOlwFEM3iF8z0uhyYWG02GYQmuTXWHk
         sXvyT7b2rhyk5HfLlf2BHZREKyq9gnklJBWaEGVFy9Lk6S2rZqGPprRWUcizegxrKpls
         ea6jBdhiP8f/zAHdLTBaI6HFOpky609eIHcYOuMXiJ3LLWvnbPx/zxUxhuC4+1OhX0ZD
         rs5lBVPolbufJT/XFZzZtPuMCLFbUOH7u0SRgE+7yLSPu8bw+4WTsBJH9PJO3BWtS+da
         6xFjVDezsnf/wI0knQ9UljTXAHKa0sMf2K4/1wu9JrflMnSys1cEib2v4Ib20EmlbniY
         r5Jg==
X-Forwarded-Encrypted: i=1; AL+hErGjBqg0GbcAuB30xNKouK0qAuSj59F0p/QTQiKElO9LI7NA4O0M7qUIzZnTOZ3v/AX9NsOUpWz9M7SOlRY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9cArMyczADKtK2HrnY/VoSjdv99/MCqDRU2zWA/xBSABYn3OfT
	e2YceDV6njog5S/Q1cLtV1V4sijaVVgr2bHMyvtZX2IZOzo7LGeqvtBl
X-Gm-Gg: AZFdTZdsRqbdyHCLUiLNnpIRsEYxNiPt+hfzBcz8LcrVITMzYb+ieVN1OhsDj1s+9Cr
	O5XIq0hxFTgpJpuRexoSdkA4ge9xBg6Ny4mRTV3UPT7XnIz2grtvI+Recw7RJCQW4aCP8vjN/3H
	tQzQu2zWTsj8MyWkm3JIwejFNMWq9/6NIGhEEy9u9q3S12PEqUXFFKVt004TlPMetYfMpOxkXii
	N8OxUiNLGXX7ikIeSbLCxJ8N18m8MicEh5ObKM2cTegYrEmtj5D8z4Jl8ej3jE/3AlKX5jsOdOz
	ZYu8+B+5LBS3SBae7gDIRZ0TRnzv8IquW6oYpTouHgh86GP62iKBOpUGXLMbsZwS7ckR2erXI8d
	KwG0VMGKZRrmywOXXu4VopmuLQvP/yfQdxgU4Sy/N9amhdpmYtZ7pZEhsyWnJxQMRAzr4Seg7RI
	xVTwUit6ITqnCbu6PziqELNuX8bybaFwE5+0psqVwFzXhtT2zh7W8rLL/XinDSURresQUvySY94
	tJcC8iE03SgxOoWgvCWT8ws9ASU4XzWeMPEOUSvavz/nWXol1iblRZUAsyQXk+GYK7xBWoGPnBf
	K3Nhq5iFcvioLchYtS/ps29WZ2A=
X-Received: by 2002:a05:7300:7314:b0:381:1580:cb4c with SMTP id 5a478bee46e88-38281023cfemr1749374eec.24.1794972977304;
        Tue, 17 Nov 2026 19:36:17 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a76d70fasm2677074eec.22.2026.11.17.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 19:36:16 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
In-Reply-To: <07b9bd2b-19da-4e3c-9b01-552364a82269@kernel.org>
Date: Wed, 18 Nov 2026 08:39:23 +0530
Message-ID: <se0y7s4c.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com> <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com> <07b9bd2b-19da-4e3c-9b01-552364a82269@kernel.org>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 17/11/2026 à 15:25, Ritesh Harjani (IBM) a écrit :
>> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>>    DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>>    WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>>    NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>>    REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>>    MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>>    NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>>    LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>>    Call Trace:
>>      lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>>      trace_hardirqs_on+0x98/0x11c
>>      irqentry_exit+0x64c/0x1064
>>      timer_interrupt+0x274/0x6bc
>>      __replay_soft_interrupts+0x158/0x380
>>      arch_local_irq_restore+0x1cc/0x244
>>      console_flush_one_record+0x438/0x654
>>      console_unlock+0xb8/0x1e0
>>      vprintk_emit+0x300/0x56c
>>      vprintk+0x20/0x34
>>      _printk+0x40/0x54
>>      lockdep_init+0xdc/0x104
>>      start_kernel+0xa24/0xc68
>>      start_here_common+0x1c/0x20
>> 
>> Since commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") a
>> replayed handler always returns via irqentry_exit(), which traces hardirqs
>> on while the replay is still inside irq_enter():
>>    arch_local_irq_restore()
>>      irq_enter()                        hardirq_context = 1
>>      __replay_soft_interrupts()
>>        timer_interrupt(&regs)
>>          irq_enter_rcu()                hardirq_context = 2
>>          irq_exit_rcu()                 hardirq_context = 1
>>          irqentry_exit()
>>            trace_hardirqs_on()          hardirq_context != 0 -> WARN
>>        next_interrupt()
>>          lockdep_hardirq_exit()         too late
>> 
>> Leave the hardirq context before each replayed handler instead of
>> after it:
>>    arch_local_irq_restore()
>>      irq_enter()                        hardirq_context = 1
>>      __replay_soft_interrupts()
>>        lockdep_hardirq_exit()           hardirq_context = 0 // fix
>>        timer_interrupt(&regs)
>>          irq_enter_rcu()                hardirq_context = 1
>>          irq_exit_rcu()                 hardirq_context = 0
>>          irqentry_exit()
>>            trace_hardirqs_on()          ok
>>        next_interrupt()
>>          trace_hardirqs_off()
>>          lockdep_hardirq_enter()        hardirq_context = 1
>>      irq_exit()                         hardirq_context = 0
>> 
>> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/kernel/irq_64.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
>> index d5c48d1b0a31..b189e796eb34 100644
>> --- a/arch/powerpc/kernel/irq_64.c
>> +++ b/arch/powerpc/kernel/irq_64.c
>> @@ -75,12 +75,6 @@ static inline void next_interrupt(struct pt_regs *regs)
>>   		WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
>>   	}
>> 
>> -	/*
>> -	 * We are responding to the next interrupt, so interrupt-off
>> -	 * latencies should be reset here.
>> -	 */
>> -	lockdep_hardirq_exit();
>> -	trace_hardirqs_on();
>>   	trace_hardirqs_off();
>>   	lockdep_hardirq_enter();
>>   }
>> @@ -137,18 +131,21 @@ static __no_kcsan void __replay_soft_interrupts(void)
>>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
>>   	    irq_happened_test_and_clear(PACA_IRQ_HMI)) {
>>   		regs.trap = INTERRUPT_HMI;
>> +		lockdep_hardirq_exit();
>
> Can we include that in irq_happened_test_and_clear() instead of 
> duplicating it 5 times ?
>

Thanks for the suggestion. We can actually simplify this if we move this
into the caller itself i.e. __replay_soft_interrupts(). I think we could
change it to this diff then:

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..e2f1e5b7a3a7 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
        }

        /*
-        * We are responding to the next interrupt, so interrupt-off
-        * latencies should be reset here.
+        * We are responding to the next interrupt. The irqentry_exit() of the
+        * replayed handler has traced hardirqs on, which also reset the
+        * interrupt-off latencies. Trace them off again.
         */
-       lockdep_hardirq_exit();
-       trace_hardirqs_on();
        trace_hardirqs_off();
-       lockdep_hardirq_enter();
 }

 static inline bool irq_happened_test_and_clear(u8 irq)
@@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
         */
        local_paca->irq_happened |= PACA_IRQ_REPLAYING;

+       /*
+        * The irq_enter() of our callers is there to hold off softirqs. Each
+        * replayed handler enters and leaves the hardirq context itself and
+        * returns through irqentry_exit(), which again traces hardirqs on.
+        * Since lockdep only allows that outside of hardirq context, so leave
+        * it for the duration of the replay.
+        */
+       lockdep_hardirq_exit();
+
        ppc_save_regs(&regs);
        regs.softe = IRQS_ENABLED;
        regs.msr |= MSR_EE;
@@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
                next_interrupt(&regs);
        }

+       lockdep_hardirq_enter();
+
        local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
 }

The above simplifies it a lot, and the new state machine with
hardirq_context and hardirqs_enabled which lockdep cares about, will
look like this:
                                           hardirq_context  hardirqs_enabled
arch_local_irq_restore()
  trace_hardirqs_off()                     0             1 -> 0
  irq_enter()                           0 -> 1           0          (softirqs held off)
  __replay_soft_interrupts()
    lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
    timer_interrupt(&regs)
      irq_enter_rcu()                   0 -> 1           0          handler starts
      irq_exit_rcu()                    1 -> 0           0          handler done
      irqentry_exit()
        trace_hardirqs_on()                0             0 -> 1     legal: context is 0
    next_interrupt()
      trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
    ...                                 same for each pending interrupt
    lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
  irq_exit()                            1 -> 0           0          softirqs may run now
  trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled


Let me know if this looks good, then I can re-spin the next revision
with the above changes.

-ritesh


