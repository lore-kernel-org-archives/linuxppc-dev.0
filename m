Return-Path: <linuxppc-dev+bounces-21914-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C5CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFkH3y6Nz2xLm;
	Wed, 03 Jun 2026 01:53:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780415639;
	cv=none; b=Bmf/y8Gb8tQy8B+D0M/LtDxfn6ZmrfUmzgtRrp3hRY/ttOAx+PNK+P7Uz2e4pnQ+Uyn8nDmO8fiStEetiBzoYUfq8C/Qrn2PZorOtpHPe7Rp+1dd0fEyhcMVFZvkwIM+H0DG0da+ZDc7yGMTT5dt1Fgkm8jKB2kUaF0DvCAlC2lGoXV/0KcUOF50Ant/bd4gEqkCt1wiaayEULSBF2oVp8iz7YgYpd7Q2HoBY4Hakr1EuNFjI1aM6Ut2r/hnxtD3URWnulf/dwQlhkz1li6+Oia389CvUFRrJ1PeLeBSNLvgxFVSKRFu77dGyPmSQAUwq8SboHYSsGQkcVIJkrgjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780415639; c=relaxed/relaxed;
	bh=H0t4szX+D9iinR+2CXzH9bJD6RSU3VKzeZkaGpftbhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/r01/d06R78gaAEVmen/fBCmN8TFrWDu5pgdP08CMFDs7oZ6/3qrfmD/waIbuv9/BYgWRBTez5+pPoqCbEGGBZAaiYiQ9YRFTqXZCOlWe4aljYuLI3uhiQdLhjk3FH76bu/5w+To0aSv/PnQgmrwcjeKC2ZD0qjv0pmzAkfPHCr+hZT/+CMyb2pZUjk222Ki4kOzSg3aXQcEIPCIUdK8auO9uAVsimp7D0rynuJDfXffZGCkJoTkbD8La6DSTZwVHf90XOY5fnNhInlepakT9tGKg2mZM1gH0L5mbjHVg0SMO6PsuKdcuOYfAtUMGnr4OCm2z+hpTNJR4PI/yMUAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IDBLodH2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IDBLodH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFkF1zCGz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:53:56 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5197702a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415634; x=1781020434; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H0t4szX+D9iinR+2CXzH9bJD6RSU3VKzeZkaGpftbhQ=;
        b=IDBLodH2aV7dVCshzbst3tOuiqSV5+SXM1Lq/jHlkF5ZI158JPTsEEdGDSyGkNU0Hq
         vXwtazpVf/c/cnF+fcu/T5rHIzTJaxThMpk3gBJhNozwtk5cNDgz7nPJRNPSGRiOA2MP
         bc0M5kJ0hKmq/KKozhHJJxn4Em2TakXMXcb9kkEV3r7Q/5o1EJcVFWEGPSp6Rj/0JeSR
         eoarjyTNVSeiNNVAO5gomnl19XHuJ53UB0xP3A+Qb7JXb0BzaY02XmjYWiQ8D5VetcvO
         4YLRXoZWPN2z6mfE3G5bY4CZMxvAy/D07tH99M5nfLW+HTzLEmAHfXULwP8JuWGN00X8
         1j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415634; x=1781020434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0t4szX+D9iinR+2CXzH9bJD6RSU3VKzeZkaGpftbhQ=;
        b=c/uLzryJf7IE0fF3pM3zHr2MnWUtipWVU9rNbfpWhCZrR6vZBXf5Rl/4X0GqhcA2lN
         U3fQNnPxJ17ObC3N4PvYgnlSIekgE9mL5ikp08Cp6pBQ0sO0swwY5iU2bkRLvR95APXk
         Cs7vAGaTZ4U181vUBTVc5pK80M1N07O0KecwE+sPGy/iCn1NjFtMg03MCEqYUT5ocQpk
         +nTuu3Fazr4Ss9KI0MZXFtWVt5SH4RtZQip/o+FSZDWvgsRmt2IWubpdAxULCYhkqvY8
         NEXBE35u1a5RaYw1rg899ORmGimv/yXPljEz4+mmVKN62RcQ4aN7v1P8SgQNSdACipVe
         dXqg==
X-Forwarded-Encrypted: i=1; AFNElJ/Xbu25YUX/w0g+K2HTlN5C82ZOjN2cVp5cI7P85kC2mskjQA+5/Y1yer7mzhfL3yje8sS2WPLrM26C0kg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqRV7vEl+Ht2HoQUDJlDEASpoKLhQcrHiDhHVzsNtZiiJjxCHm
	M0sskyDYE+/A+4A6J5Bg1SVldKbzyy5UT5cIICJaRZTD+XYZR8jNv4lE
X-Gm-Gg: Acq92OGTAQnNJzYWFgb4PocITYaz6WyQ+mOaFxsoExxSjYWoQ0xbT0PZg1I1DCfmPme
	TQxyQmt+hzJ+9Z7zUBbeXeYGzJ+NCh+kgF7o/786yBPzGZ04csvdJBVU3RKLpq5VGSG8/Xm/r8l
	ynuqRdaM/fIJhzQuBrjLgMIMm7yJZge+NhPp2Hoy1YhtkptMYEbGbcXnsYYHHZrz4JkvTlxSp/C
	BENrPeyODatsVnak3FOg9Amm6hy6PJUBZceUfUTj+43uNXBgRUncJiW4eqbQ+F/t0qCZ2/Ou+4f
	FsrDcZ8Y5ruZ9ZjrU/k0hLXtIW0/ruMy6QpYAAEtxffKGaiwJ1DOa9H4laa4O1gF8VbmP7i2IGe
	hvKsgObnJICUkf7WcLurIjBbpkA8e1O3PFzDaJXxGJlZbls/q5Pzhj0ockz1jgeyVrMSFs9Aauo
	t7ny7nOKoOoPmJQ1meZNAOTD/efFK4NptcMTyo2e+H9klHwA6fJS3EOn/tYLvJsIt6e8fmSjMA4
	3xASm54kA==
X-Received: by 2002:a17:90b:3dd0:b0:36b:936e:73c8 with SMTP id 98e67ed59e1d1-36c5fd00c9dmr16395895a91.19.1780415633978;
        Tue, 02 Jun 2026 08:53:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a2769d1sm84736a91.9.2026.06.02.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:53:53 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:23:47 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Srikar Dronamraju <srikar@linux.ibm.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [next20260529]powerpc/pseries: multiple WARNs: RCU not watching
 for tracepoint and lockdep_hardirq_context() during boot and cpuidle
 (Power11)
Message-ID: <ah76WemGbrDgEokh@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
 <87715824-b1b8-48ed-a58b-aceefb14aede@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87715824-b1b8-48ed-a58b-aceefb14aede@linux.ibm.com>

On Tue, Jun 02, 2026 at 08:54:54PM +0530, Shrikanth Hegde wrote:
> Hi Venkat, Thanks for the report.
> 
> On 6/1/26 6:57 PM, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> > 
> > 
> > I am observing multiple reproducible WARN_ONs related to RCU and lockdep
> > IRQ state tracking on a Power11 pSeries system when running on latest
> > linux-next kernel.
> > 
> > 
> > Environment:
> >    Architecture: ppc64le (Power11, pSeries LPAR)
> >    Kernel: 7.1.0-rc5-next-20260529
> >    Config: PREEMPT(lazy)
> >            CONFIG_LOCKDEP=y
> >            CONFIG_PROVE_LOCKING=y
> > 
> > 
> > Warning1:
> > 
> > [    0.008277] ------------[ cut here ]------------
> > [    0.008285] RCU not watching for tracepoint
> > [    0.008294] WARNING: ./include/trace/events/preemptirq.h:36 at
> > trace_hardirqs_off+0x16c/0x1a0, CPU#1: swapper/1/0
> > [    0.008306] Modules linked in:
> > [    0.008316] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.1.0-
> > rc5-next-20260529 #1 PREEMPT(lazy)
> > [    0.008322] Hardware name: IBM,9080-HEX Power11 (architected)
> > 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> > [    0.008327] NIP:  c0000000004bb2a8 LR: c0000000004bb2a4 CTR:
> > 0000000000000000
> > [    0.008331] REGS: c0000000049cb690 TRAP: 0700   Not tainted (7.1.0-
> > rc5-next-20260529)
> > [    0.008336] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE> CR: 44000208
> > XER: 00000005
> > [    0.008348] CFAR: c00000000022e9d4 IRQMASK: 3
> > [    0.008348] GPR00: c0000000004bb2a4 c0000000049cb950 c000000001ccf100
> > 000000000000001f
> > [    0.008348] GPR04: 3fffffffffff7fff c0000000049cb740 c0000000049cb738
> > 0000000000000000
> > [    0.008348] GPR08: c0000000029d1230 0000000000000001 c0000000049e8000
> > 0000000000000003
> > [    0.008348] GPR12: c000000002d514e0 c000000effffeb00 0000000000000000
> > 0000000000000000
> > [    0.008348] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    0.008348] GPR20: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    0.008348] GPR24: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    0.008348] GPR28: 0000000000000000 0000000000000001 c000000002414988
> > c00000000005be40
> > [    0.008403] NIP [c0000000004bb2a8] trace_hardirqs_off+0x16c/0x1a0
> > [    0.008408] LR [c0000000004bb2a4] trace_hardirqs_off+0x168/0x1a0
> > [    0.008413] Call Trace:
> > [    0.008416] [c0000000049cb950] [c0000000004bb2a4]
> > trace_hardirqs_off+0x168/0x1a0 (unreliable)
> > [    0.008423] [c0000000049cb9d0] [c00000000005be40]
> > arch_interrupt_enter_prepare+0xa0/0x19c
> > [    0.008430] [c0000000049cba00] [c00000000005bf78]
> > doorbell_exception+0x3c/0x4c4
> > [    0.008436] [c0000000049cbaa0] [c00000000000a2fc]
> > doorbell_super_common_virt+0x28c/0x290
> > [    0.008443] ---- interrupt: a00 at plpar_hcall_norets_notrace+0x18/0x2c
> > [    0.008449] NIP:  c0000000001b4fc8 LR: c0000000001bcea0 CTR:
> > 0000000000000000
> > [    0.008453] REGS: c0000000049cbad0 TRAP: 0a00   Not tainted (7.1.0-
> > rc5-next-20260529)
> > [    0.008457] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> > 24000008  XER: 00000000
> > [    0.008469] CFAR: 0000000000000000 IRQMASK: 0
> > [    0.008469] GPR00: 0000000000000000 c0000000049cbd90 c000000001ccf100
> > 0000000000000000
> > [    0.008469] GPR04: 0000000000000000 8004000038407c10 0000000000000000
> > 0000000000000003
> > [    0.008469] GPR08: 0000000000000001 0000000000000000 0000000000000090
> > 0000000000000001
> > [    0.008469] GPR12: 8004000038407c00 c000000effffeb00 0000000000000000
> > 000000002ef01820
> > [    0.008469] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    0.008469] GPR20: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000001
> > [    0.008469] GPR24: 0000000000000001 000000000000dedc c000000003086150
> > 0000000000000001
> > [    0.008469] GPR28: c0000000049e8000 c000000002241548 c000000002241550
> > c000000002241548
> > [    0.008523] NIP [c0000000001b4fc8] plpar_hcall_norets_notrace+0x18/0x2c
> > [    0.008528] LR [c0000000001bcea0] pseries_lpar_idle.part.0+0x74/0x160
> > [    0.008533] ---- interrupt: a00
> > [    0.008536] [c0000000049cbd90] [c0000000049cbe30] 0xc0000000049cbe30
> > (unreliable)
> > [    0.008544] [c0000000049cbe10] [c000000000022c5c]
> > arch_cpu_idle+0x4c/0x120
> > [    0.008551] [c0000000049cbe30] [c0000000015afe70]
> > default_idle_call+0x154/0x454
> > [    0.008558] [c0000000049cbec0] [c0000000002d3dfc]
> > cpuidle_idle_call+0x2dc/0x2e0
> > [    0.008565] [c0000000049cbf10] [c0000000002d3f48] do_idle+0x148/0x1f0
> > [    0.008571] [c0000000049cbf60] [c0000000002d43c8]
> > cpu_startup_entry+0x4c/0x50
> > [    0.008578] [c0000000049cbf90] [c00000000006371c]
> > start_secondary+0x27c/0x28c
> > [    0.008585] [c0000000049cbfe0] [c00000000000e258]
> > start_secondary_prolog+0x10/0x14
> > [    0.008590] Code: 4bfffcc4 60000000 3d220132 8929db46 2c090000
> > 4082ff94 3c62ffd6 3d220132 3863d398 9ba9db46 4bd73655 60000000
> > <0fe00000> 60000000 4bffff74 60000000
> > [    0.008611] irq event stamp: 20
> > [    0.008614] hardirqs last  enabled at (19): [<c0000000002d3dfc>]
> > cpuidle_idle_call+0x2dc/0x2e0
> > [    0.008620] hardirqs last disabled at (20): [<c00000000005be40>]
> > arch_interrupt_enter_prepare+0xa0/0x19c
> > [    0.008625] softirqs last  enabled at (0): [<c00000000022b6ac>]
> > copy_process+0xb24/0x1dec
> > [    0.008632] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [    0.008637] ---[ end trace 0000000000000000 ]---
> > 
> 
> Equivalent to trace_hardirqs_off is done by irqentry_enter.
> So it is not essential in arch_interrupt_enter_prepare.
> 
> irqentry_enter
> 	lockdep_hardirqs_off(CALLER_ADDR0);
> 	trace_hardirqs_off_finish();
> 
> 
> For reference:
> void trace_hardirqs_off(void)
> {
>         lockdep_hardirqs_off(CALLER_ADDR0);
> 
>         if (!this_cpu_read(tracing_irq_cpu)) {
>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
>                 trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
>         }
> }
> 
> void trace_hardirqs_off_finish(void)
> {
>         if (!this_cpu_read(tracing_irq_cpu)) {
>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
>                 trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
>         }
> 
> }
> 
> > 
> > Warning2:
> > 
> > [    0.010098] ------------[ cut here ]------------
> > [    0.010103] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> > [    0.010107] WARNING: kernel/locking/lockdep.c:4406 at
> > lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/1
> > [    0.010116] Modules linked in:
> > [    0.010120] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     W
> >    7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
> > [    0.010125] Tainted: [W]=WARN
> > [    0.010127] Hardware name: IBM,9080-HEX Power11 (architected)
> > 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> > [    0.010131] NIP:  c00000000031549c LR: c000000000315498 CTR:
> > 0000000000000000
> > [    0.010135] REGS: c0000000045bf100 TRAP: 0700   Tainted: G   W
> > (7.1.0-rc5-next-20260529)
> > [    0.010139] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR:
> > 44044228  XER: 00000005
> > [    0.010147] CFAR: c00000000022e9d4 IRQMASK: 3
> > [    0.010147] GPR00: c000000000315498 c0000000045bf3c0 c000000001ccf100
> > 000000000000002e
> > [    0.010147] GPR04: 3fffffffffff7fff c0000000045bf1b0 c0000000045bf1a8
> > 0000000000000000
> > [    0.010147] GPR08: c0000000029d1230 0000000000010002 c0000000048b2b00
> > 0000000000000003
> > [    0.010147] GPR12: c000000002d514e0 c000000003ea1000 c000000000011ae4
> > 0000000000000000
> > [    0.010147] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    0.010147] GPR20: 0000000000000000 0000000000000004 c000000000272684
> > c0000000029bb0c0
> > [    0.010147] GPR24: 0000000ebc171000 c000000ebeb63850 c000000003084d00
> > c00000000308b2d0
> > [    0.010147] GPR28: c00000000002a488 0000000000000001 0000000000000000
> > c000000002246e08
> > [    0.010188] NIP [c00000000031549c]
> > lockdep_hardirqs_on_prepare+0x22c/0x2d4
> > [    0.010192] LR [c000000000315498]
> > lockdep_hardirqs_on_prepare+0x228/0x2d4
> > [    0.010196] Call Trace:
> > [    0.010198] [c0000000045bf3c0] [c000000000315498]
> > lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
> > [    0.010204] [c0000000045bf430] [c0000000004bb778]
> > trace_hardirqs_on+0xec/0x1b0
> > [    0.010209] [c0000000045bf4b0] [c0000000015ad574]
> > irqentry_exit+0x58c/0xe1c
> > [    0.010213] [c0000000045bf540] [c00000000002a488]
> > timer_interrupt+0x210/0x564
> > [    0.010219] [c0000000045bf5f0] [c00000000003b960]
> > __replay_soft_interrupts+0x14c/0x374
> > [    0.010224] [c0000000045bf7d0] [c00000000003bd74]
> > arch_local_irq_restore.part.0+0x1ec/0x224
> > [    0.010230] [c0000000045bf810] [c0000000015c17d4]
> > _raw_spin_unlock_irqrestore+0x54/0xac
> > [    0.010235] [c0000000045bf840] [c0000000002cdd54]
> > set_user_nice+0x110/0x220
> > [    0.010240] [c0000000045bf8e0] [c000000000266a94]
> > create_worker+0x13c/0x310
> > [    0.010245] [c0000000045bf9a0] [c0000000002726f4]
> > workqueue_prepare_cpu+0x70/0xe4
> > [    0.010251] [c0000000045bf9e0] [c000000000232604]
> > cpuhp_invoke_callback+0x1e8/0x3c0
> > [    0.010256] [c0000000045bfa50] [c000000000232924]
> > __cpuhp_invoke_callback_range+0x148/0x230
> > [    0.010261] [c0000000045bfaf0] [c000000000234f68] _cpu_up+0x19c/0x3cc
> > [    0.010265] [c0000000045bfbb0] [c00000000023533c] cpu_up+0x1a4/0x1f4
> > [    0.010269] [c0000000045bfc40] [c00000000203d1f4]
> > bringup_nonboot_cpus+0xbc/0x128
> > [    0.010275] [c0000000045bfca0] [c00000000204b98c] smp_init+0x44/0xd0
> > [    0.010279] [c0000000045bfd00] [c000000002006d4c]
> > kernel_init_freeable+0x23c/0x3b0
> > [    0.010284] [c0000000045bfdc0] [c000000000011b0c] kernel_init+0x30/0x274
> > [    0.010288] [c0000000045bfe30] [c00000000000debc]
> > ret_from_kernel_user_thread+0x14/0x1c
> > [    0.010292] ---- interrupt: 0 at 0x0
> > [    0.010296] Code: 4182ff74 3d22013c 3929c1d4 81290000 2c090000
> > 4082ff60 3c82ffda 3c62ffd9 3884f998 38634590 4bf19461 60000000
> > <0fe00000> 4bffff40 60000000 60000000
> > [    0.010310] irq event stamp: 7440
> > [    0.010312] hardirqs last  enabled at (7439): [<c0000000015c1824>]
> > _raw_spin_unlock_irqrestore+0xa4/0xac
> > [    0.010317] hardirqs last disabled at (7440): [<c00000000003bc30>]
> > arch_local_irq_restore.part.0+0xa8/0x224
> > [    0.010323] softirqs last  enabled at (0): [<c00000000022b6ac>]
> > copy_process+0xb24/0x1dec
> > [    0.010328] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [    0.010331] ---[ end trace 0000000000000000 ]---
> > 
> > 
> 
> This should be fixed by the diff where interrupts are disabled
> when going to irqentry_exit.
> 
> > 
> > Warning3:
> > 
> > [    1.718239] ------------[ cut here ]------------
> > [    1.718247] RCU not watching for tracepoint
> > [    1.718255] WARNING: ./include/trace/events/preemptirq.h:40 at
> > trace_hardirqs_on+0x180/0x1b0, CPU#19: swapper/19/0
> > [    1.718266] Modules linked in: ibmvscsi ibmveth scsi_transport_srp
> > pseries_wdt
> > [    1.718275] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Tainted: G W
> >      7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
> > [    1.718280] Tainted: [W]=WARN
> > [    1.718283] Hardware name: IBM,9080-HEX Power11 (architected)
> > 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> > [    1.718287] NIP:  c0000000004bb80c LR: c0000000004bb808 CTR:
> > 0000000000000000
> > [    1.718290] REGS: c000000004a4b9e0 TRAP: 0700   Tainted: G   W
> > (7.1.0-rc5-next-20260529)
> > [    1.718294] MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE> CR:
> > 44000208  XER: 00000005
> > [    1.718305] CFAR: c00000000022e9d4 IRQMASK: 3
> > [    1.718305] GPR00: c0000000004bb808 c000000004a4bca0 c000000001ccf100
> > 000000000000001f
> > [    1.718305] GPR04: 3fffffffffff7fff c000000004a4ba90 c000000004a4ba88
> > 0000000ebe5e2000
> > [    1.718305] GPR08: 0000000000000027 0000000000000002 c000000004a62b00
> > 0000000000000003
> > [    1.718305] GPR12: c000000002d514e0 c000000effff1300 0000000000000000
> > 000000002ef01a60
> > [    1.718305] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    1.718305] GPR20: 0000000000000000 0000000000000000 0000000000000000
> > 00000000666a3c88
> > [    1.718305] GPR24: c00000000105088c 000000000000dedc c000000003084d00
> > 0000000000000000
> > [    1.718305] GPR28: c000000ec09fe440 0000000000000001 c000000002414988
> > c00000000003bca8
> > [    1.718347] NIP [c0000000004bb80c] trace_hardirqs_on+0x180/0x1b0
> > [    1.718351] LR [c0000000004bb808] trace_hardirqs_on+0x17c/0x1b0
> > [    1.718355] Call Trace:
> > [    1.718357] [c000000004a4bca0] [c0000000004bb808]
> > trace_hardirqs_on+0x17c/0x1b0 (unreliable)
> > [    1.718362] [c000000004a4bd20] [c00000000003bca8]
> > arch_local_irq_restore.part.0+0x120/0x224
> > [    1.718369] [c000000004a4bd60] [c0000000015b065c] snooze_loop+0xa0/0x270
> > [    1.718374] [c000000004a4bda0] [c0000000015af06c]
> > cpuidle_enter_state+0x110/0x8fc
> > [    1.718379] [c000000004a4be60] [c00000000105088c]
> > cpuidle_enter+0x50/0x74
> > [    1.718384] [c000000004a4bea0] [c0000000002ca85c] call_cpuidle+0x48/0xa0
> > [    1.718389] [c000000004a4bec0] [c0000000002d3c80]
> > cpuidle_idle_call+0x160/0x2e0
> > [    1.718395] [c000000004a4bf10] [c0000000002d3f48] do_idle+0x148/0x1f0
> > [    1.718400] [c000000004a4bf60] [c0000000002d43c8]
> > cpu_startup_entry+0x4c/0x50
> > [    1.718405] [c000000004a4bf90] [c00000000006371c]
> > start_secondary+0x27c/0x28c
> > [    1.718411] [c000000004a4bfe0] [c00000000000e258]
> > start_secondary_prolog+0x10/0x14
> > [    1.718415] Code: 60000000 3d220132 8929db48 2c090000 4082ff64
> > 3c62ffd6 39200001 3d420132 3863d398 992adb48 4bd730f1 60000000
> > <0fe00000> 60000000 4bffff40 60000000
> > [    1.718430] irq event stamp: 0
> > [    1.718432] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [    1.718436] hardirqs last disabled at (0): [<c00000000022b6ac>]
> > copy_process+0xb24/0x1dec
> > [    1.718442] softirqs last  enabled at (0): [<c00000000022b6ac>]
> > copy_process+0xb24/0x1dec
> > [    1.718447] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [    1.718450] ---[ end trace 0000000000000000 ]---
> > 
> > 
> 
> Idle loop is expected to use the variant without the traces.
> raw_* is being used in the diff.
> 
> > 
> > I am reporting all three warnings in one report, as its flagging
> > inconsistencies around IRQ enable/disable transitions.
> > 
> > 
> > If you happen to fix this, please add below tag.
> > 
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > 
> > 
> > 
> > Regards,
> > 
> > Venkat.
> > 
> > 
> 
> 
> Can you try the below diff and check if all three gets solved?
> 
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index de5601282755..a7f30875d14a 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -210,9 +210,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>         /* Enable MSR[RI] early, to support kernel SLB and hash faults */
>  #endif
> -       if (!regs_irqs_disabled(regs))
> -               trace_hardirqs_off();
> -
>         if (user_mode(regs)) {
>                 kuap_lock();
>                 account_cpu_user_entry();
> @@ -253,16 +250,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>  static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>  {
>         if (user_mode(regs)) {
> -               BUG_ON(regs_is_unrecoverable(regs));
> -               BUG_ON(regs_irqs_disabled(regs));
> +               WARN_ON(regs_is_unrecoverable(regs));
> +               WARN_ON(regs_irqs_disabled(regs));
>                 /*
>                  * We don't need to restore AMR on the way back to userspace for KUAP.
>                  * AMR can only have been unlocked if we interrupted the kernel.
>                  */
>                 kuap_assert_locked();
> -
> -               local_irq_disable();
>         }
> +
> +       /* irqentry_exit expects to be called with interrupts disabled */
> +       local_irq_disable();
>  }
Hey,

I tried this, it didn't resolve the issue. It's something else I guess.

>  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index b89e7111e7b8..a0d18deb7119 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -73,7 +73,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>         set_thread_flag(TIF_POLLING_NRFLAG);
> -       local_irq_enable();
> +       raw_local_irq_enable();
>         snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
>         dev->poll_time_limit = false;
> @@ -100,7 +100,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>         if (!dev->poll_time_limit)
>                 clear_thread_flag(TIF_POLLING_NRFLAG);
> -       local_irq_disable();
> +       raw_local_irq_disable();
>         return index;
>  }
> 
> 

I tried this diff. Doesn't seems to solve the issue.

[    0.010278] ------------[ cut here ]------------
[    0.010285] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
[    0.010300] WARNING: kernel/locking/lockdep.c:4406 at lockdep_hardirqs_on_prepare+0x22c/0x2e0, CPU#184: swapper/184/0
[    0.010316] Modules linked in:
[    0.010332] CPU: 184 UID: 0 PID: 0 Comm: swapper/184 Not tainted 7.1.0-rc6-next-20260601-dirty #2 PREEMPT(lazy) 
[    0.010340] Hardware name: IBM,9043-MRU Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.11 (RF1110_119) hv:phyp pSeries
[    0.010347] NIP:  c00000000036acac LR: c00000000036aca8 CTR: 0000000000000000
[    0.010353] REGS: c00000000417b4a0 TRAP: 0700   Not tainted  (7.1.0-rc6-next-20260601-dirty)
[    0.010359] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44004228  XER: 00000005
[    0.010377] CFAR: c000000000261518 IRQMASK: 1 
               GPR00: c00000000036aca8 c00000000417b760 c00000000251a700 000000000000002e 
               GPR04: 3fffffffffff7fff 0000000000000001 c00000000417b558 0000000000000000 
               GPR08: c000000003d2cce8 0000000000010002 c000000003c91700 c00000000417b560 
               GPR12: c000007fd383ff90 c000000004f80000 0000000000000000 0000007ff9e90000 
               GPR16: 0000007ff9e70000 0000000000000000 0000007ff9e90114 0000000000000000 
               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
               GPR24: 0000000048000054 c0000000032c0680 c000000004fe0000 c00000000002a4c4 
               GPR28: c0000000041e3d80 c0000000041ea340 c0000000032c0580 c0000000032c6e08 
[    0.010447] NIP [c00000000036acac] lockdep_hardirqs_on_prepare+0x22c/0x2e0
[    0.010453] LR [c00000000036aca8] lockdep_hardirqs_on_prepare+0x228/0x2e0
[    0.010464] Call Trace:
[    0.010470] [c00000000417b760] [c00000000036aca8] lockdep_hardirqs_on_prepare+0x228/0x2e0 (unreliable)
[    0.010482] [c00000000417b7e0] [c0000000005269e0] trace_hardirqs_on+0xf0/0x1b0
[    0.010495] [c00000000417b860] [c000000001c5f474] irqentry_exit+0x544/0x1010
[    0.010506] [c00000000417b8f0] [c00000000002a4c4] timer_interrupt+0x224/0x580
[    0.010514] [c00000000417b9a0] [c00000000003d840] __replay_soft_interrupts+0x150/0x3a0
[    0.010522] [c00000000417bb80] [c00000000003dc24] arch_local_irq_restore.part.0+0x194/0x200
[    0.010529] [c00000000417bbc0] [c000000000187520] patch_mem+0x360/0x520
[    0.010541] [c00000000417bc50] [c000000000060ba4] arch_jump_label_transform+0x64/0x78
[    0.010551] [c00000000417bc70] [c0000000007043f0] __jump_label_update+0x70/0x140
[    0.010558] [c00000000417bcf0] [c000000000704d70] static_key_enable_cpuslocked+0xd0/0x120
[    0.010566] [c00000000417bd60] [c000000000704dec] static_key_enable+0x2c/0x50
[    0.010573] [c00000000417bd90] [c0000000030764a8] security_add_hooks+0x74/0xb8
[    0.010586] [c00000000417be10] [c00000000307542c] capability_init+0x30/0x48
[    0.010598] [c00000000417be30] [c000000003075b24] lsm_init_single+0x74/0xb4
[    0.010607] [c00000000417bea0] [c0000000030769fc] security_init+0x478/0x4a8
[    0.010614] [c00000000417bf30] [c00000000300e838] start_kernel+0x5f0/0x670
[    0.010623] [c00000000417bfe0] [c00000000000e998] start_here_common+0x1c/0x20
[    0.010631] Code: 4182ff80 3d2201cd 3929fc44 81290000 2c090000 4082ff6c 3c82ffd3 3c62ffd2 3884cc60 38631590 4bef6775 60000000 <0fe00000> 4bffff4c 60000000 60000000 
[    0.010664] irq event stamp: 38250
[    0.010672] hardirqs last  enabled at (38249): [<c000000000187514>] patch_mem+0x354/0x520
[    0.010682] hardirqs last disabled at (38250): [<c00000000003db34>] arch_local_irq_restore.part.0+0xa4/0x200
[    0.010691] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.010700] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.010705] ---[ end trace 0000000000000000 ]---
[...]
[    1.002143] ------------[ cut here ]------------
[    1.002153] RCU not watching for tracepoint
[    1.002162] SED: plpks not available
[    1.002165] WARNING: ./include/trace/events/preemptirq.h:36 at trace_hardirqs_off+0x168/0x190, CPU#177: swapper/177/0
[    1.002177] Modules linked in: aes_gcm_p10_crypto crypto_simd cryptd
[    1.002190] CPU: 177 UID: 0 PID: 0 Comm: swapper/177 Tainted: G        W           7.1.0-rc6-next-20260601-dirty #2 PREEMPT(lazy) 
[    1.002202] Tainted: [W]=WARN
[    1.002206] Hardware name: IBM,9043-MRU Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.11 (RF1110_119) hv:phyp pSeries
[    1.002215] NIP:  c000000000526f98 LR: c000000000526f94 CTR: 0000000000000000
[    1.002224] REGS: c00000001249f9b0 TRAP: 0700   Tainted: G        W            (7.1.0-rc6-next-20260601-dirty)
[    1.002234] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000288  XER: 00000005
[    1.002244] CFAR: c000000000261518 IRQMASK: 3 
               GPR00: c000000000526f94 c00000001249fc70 c00000000251a700 000000000000001f 
               GPR04: 3fffffffffff7fff 0000000000000001 c00000001249fa68 0000000000000001 
               GPR08: c000000003d2cce8 0000000000000002 c00000001241dc00 c00000001249fa70 
               GPR12: c000007fd383ff90 c000007ffbda3f00 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
               GPR20: 0000000000000000 0000000000000000 000000003bbb7c02 c00000000162d534 
               GPR24: 00000000000000b1 0000000000000000 c0000000041e3d80 0000000000000000 
               GPR28: c0000000023de0a8 c000007fd5efc740 c0000000032c1ad0 c00000000003db34 
[    1.002318] NIP [c000000000526f98] trace_hardirqs_off+0x168/0x190
[    1.002325] LR [c000000000526f94] trace_hardirqs_off+0x164/0x190
[    1.002331] Call Trace:
[    1.002335] [c00000001249fc70] [c000000000526f94] trace_hardirqs_off+0x164/0x190 (unreliable)
[    1.002342] [c00000001249fcf0] [c00000000003db34] arch_local_irq_restore.part.0+0xa4/0x200
[    1.002347] [c00000001249fd30] [c000000001c62c24] snooze_loop+0xb4/0x28c
[    1.002353] [c00000001249fd80] [c000000001c612c8] cpuidle_enter_state+0x118/0xae0
[    1.002358] [c00000001249fe50] [c00000000162d534] cpuidle_enter+0x44/0x60
[    1.002363] [c00000001249fe90] [c000000000315cf8] call_cpuidle+0x48/0xa0
[    1.002369] [c00000001249feb0] [c00000000031ffc0] cpuidle_idle_call+0x160/0x2d0
[    1.002375] [c00000001249ff00] [c000000000320288] do_idle+0x158/0x200
[    1.002384] [c00000001249ff50] [c000000000320714] cpu_startup_entry+0x44/0x50
[    1.002394] [c00000001249ff80] [c00000000006a0b0] start_secondary+0x290/0x300
[    1.002401] [c00000001249ffe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
[    1.002411] Code: 60000000 60420000 3d4201c1 894a3c68 2c0a0000 4082ff9c 3d4201c1 3c62ffcf 386386c8 992a3c68 4bd3a489 60000000 <0fe00000> 4bffff7c 49739cf9 60000000 
[    1.002426] irq event stamp: 0
[    1.002429] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    1.002434] hardirqs last disabled at (0): [<c00000000025d72c>] copy_process+0xecc/0x2910
[    1.002440] softirqs last  enabled at (0): [<c00000000025d72c>] copy_process+0xecc/0x2910
[    1.002445] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.002448] ---[ end trace 0000000000000000 ]---
[    1.002454] ------------[ cut here ]------------
[    1.002457] RCU not watching for tracepoint
[    1.002460] WARNING: ./include/trace/events/preemptirq.h:40 at trace_hardirqs_on+0x17c/0x1b0, CPU#177: swapper/177/0
[    1.002468] Modules linked in: aes_gcm_p10_crypto crypto_simd cryptd
[    1.002473] CPU: 177 UID: 0 PID: 0 Comm: swapper/177 Tainted: G        W           7.1.0-rc6-next-20260601-dirty #2 PREEMPT(lazy) 
[    1.002478] Tainted: [W]=WARN
[    1.002481] Hardware name: IBM,9043-MRU Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.11 (RF1110_119) hv:phyp pSeries
[    1.002493] NIP:  c000000000526a6c LR: c000000000526a68 CTR: 0000000000000000
[    1.002502] REGS: c00000001249f9b0 TRAP: 0700   Tainted: G        W            (7.1.0-rc6-next-20260601-dirty)
[    1.002512] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000288  XER: 00000005
[    1.002524] CFAR: c000000000261518 IRQMASK: 1 
               GPR00: c000000000526a68 c00000001249fc70 c00000000251a700 000000000000001f 
               GPR04: 3fffffffffff7fff 0000000000000001 c00000001249fa68 0000000000000001 
               GPR08: c000000003d2cce8 0000000000000002 c00000001241dc00 c00000001249fa70 
               GPR12: c000007fd383ff90 c000007ffbda3f00 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
               GPR20: 0000000000000000 0000000000000000 000000003bbb7c02 c00000000162d534 
               GPR24: 00000000000000b1 0000000000000000 c0000000041e3d80 0000000000000000 
               GPR28: c0000000023de0a8 c000007fd5efc740 c0000000032c1ad0 c00000000003dbc4 
[    1.002573] NIP [c000000000526a6c] trace_hardirqs_on+0x17c/0x1b0
[    1.002580] LR [c000000000526a68] trace_hardirqs_on+0x178/0x1b0
[    1.002586] Call Trace:
[    1.002590] [c00000001249fc70] [c000000000526a68] trace_hardirqs_on+0x178/0x1b0 (unreliable)
[    1.002600] [c00000001249fcf0] [c00000000003dbc4] arch_local_irq_restore.part.0+0x134/0x200
[    1.002607] [c00000001249fd30] [c000000001c62c24] snooze_loop+0xb4/0x28c
[    1.002614] [c00000001249fd80] [c000000001c612c8] cpuidle_enter_state+0x118/0xae0
[    1.002620] [c00000001249fe50] [c00000000162d534] cpuidle_enter+0x44/0x60
[    1.002625] [c00000001249fe90] [c000000000315cf8] call_cpuidle+0x48/0xa0
[    1.002636] [c00000001249feb0] [c00000000031ffc0] cpuidle_idle_call+0x160/0x2d0
[    1.002645] [c00000001249ff00] [c000000000320288] do_idle+0x158/0x200
[    1.002651] [c00000001249ff50] [c000000000320714] cpu_startup_entry+0x44/0x50
[    1.002655] [c00000001249ff80] [c00000000006a0b0] start_secondary+0x290/0x300
[    1.002660] [c00000001249ffe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
[    1.002664] Code: 4bffff80 3d2201c1 89293c66 2c090000 4082ff6c 39200001 3d4201c1 3c62ffcf 386386c8 992a3c66 4bd3a9b5 60000000 <0fe00000> e9010060 4bffff44 60000000 
[    1.002678] irq event stamp: 0
[    1.002680] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    1.002688] hardirqs last disabled at (0): [<c00000000025d72c>] copy_process+0xecc/0x2910
[    1.002696] softirqs last  enabled at (0): [<c00000000025d72c>] copy_process+0xecc/0x2910
[    1.002706] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.002712] ---[ end trace 0000000000000000 ]---
[...]

This is most probably due to generic entry/exit. 
I am trying to find the root cause for this.

Regards,
Mukesh

