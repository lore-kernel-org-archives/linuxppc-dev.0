Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E41BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BC120700
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7BZIXqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BC120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vqqw41cWzDqHb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:22:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7BZIXqV"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vqp52GX6zDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 16:21:01 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so445785pll.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H7cqWRrZc/IbG1WyoPD7+5RUvrMQOXm6QyxFwWYUNQE=;
 b=f7BZIXqVj04hYZc04nugkXDyO93uDTSoVZhvHmQFDYJdGlFcvgvqGCtXRXKvH+GY8b
 FWAXA8jZOLkBgUAx8gzTygHXx+zkx0vQjJiQ0/u4wnQi/oMR4mUAf94irE0v/5b4wLzk
 InvQmbXhLMoLWgYXdBmsFuH0q+04+HQ2qwAJPw/Nqk23OEmrD4ax2igshtR+8u2ySQsO
 /rGPySuZdEXfheQWy1OHwMEMDPTHFVBA//5mBazGRvAr2SZdA1sb/vrfqDw0UC9k3e5b
 2pCHsEjDNPAHgGl71OG3zJBz3MwZ1XEgwMTxjhazcM3zSIXEq/vvDIEGcmn7mGdiY1wg
 gU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H7cqWRrZc/IbG1WyoPD7+5RUvrMQOXm6QyxFwWYUNQE=;
 b=QGC+TCwvnAUDGxSQiDNKbja928xKq9G7CQjSnFm+cYAPNeXo7thislQ6BrDGHPTvSy
 XaJKLwmZzzE0SzLPLD5bRKs5M7nFLmhz0jhQfh+wVzimLqc++xId7bmyzXYOcQ0WXmKV
 4zWUT6haGjGBtvjYJ+h7tJz592mPgBWYXWTKq61Who3XTbhlKbN+vadA5r9bnCpLylJo
 eqrWI1mV0yd4GDaYfCRgjmsASOqGQoHPqXYjQjtpuvmz5lp8Uie/XqR2Y+gF2F90UG6k
 O+sQEt984ATiSoBeaLxkLzyqQpqWHdcUoYI3LbKebJtpMe0Wu6r8QX7aro0wP2Apqj96
 SrFA==
X-Gm-Message-State: APjAAAUhgvZkKuTSw18dvU2o/P2gyn0iPl1MYjKbAcTa2OoPlJ5RXruC
 Q8GLpAR7xhOq5ICbTl9YPCM=
X-Google-Smtp-Source: APXvYqzJQVb3zg+HKoeWthppG4fo4o4ZHbGr3OmVQ9oBmrHD4ESZzTp3Ps3LjlSk/P9m/3VVV2hToQ==
X-Received: by 2002:a17:902:bb0c:: with SMTP id
 l12mr47508681pls.108.1553836858192; 
 Thu, 28 Mar 2019 22:20:58 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id o76sm1739748pfa.156.2019.03.28.22.20.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Mar 2019 22:20:56 -0700 (PDT)
Message-ID: <1553836851.2264.2.camel@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 qemu-ppc@nongnu.org
Date: Fri, 29 Mar 2019 16:20:51 +1100
In-Reply-To: <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: tglx@linutronix.de, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-03-27 at 17:51 +0100, Cédric Le Goater wrote:
> On 3/27/19 5:37 PM, Cédric Le Goater wrote:
> > On 3/27/19 1:36 PM, Sebastian Andrzej Siewior wrote:
> > > With qemu-system-ppc64le -machine pseries -smp 4 I get:
> > > 
> > > > #  chrt 1 hackbench
> > > > Running in process mode with 10 groups using 40 file
> > > > descriptors each (== 400 tasks)
> > > > Each sender will pass 100 messages of 100 bytes
> > > > Oops: Exception in kernel mode, sig: 4 [#1]
> > > > LE PAGE_SIZE=64K MMU=Hash PREEMPT SMP NR_CPUS=2048 NUMA pSeries
> > > > Modules linked in:
> > > > CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
> > > > NIP:  c000000000046978 LR: c000000000046a38 CTR:
> > > > c0000000000b0150
> > > > REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
> > > > MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> > > > 42000874  XER: 00000000
> > > > CFAR: c000000000046a34 IRQMASK: 1
> > > > GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00
> > > > 0000000028000000
> > > 
> > > …
> > > > NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
> > > > LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
> > > > Call Trace:
> > > > [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0
> > > > (unreliable)
> > > > [c0000001fffebba0] [c0000000000b0170]
> > > > smp_pseries_cause_ipi+0x20/0x70
> > > > [c0000001fffebbd0] [c00000000004b02c]
> > > > arch_send_call_function_single_ipi+0x8c/0xa0
> > > > [c0000001fffebbf0] [c0000000001de600]
> > > > irq_work_queue_on+0xe0/0x130
> > > > [c0000001fffebc30] [c0000000001340c8]
> > > > rto_push_irq_work_func+0xc8/0x120
> > > 
> > > …
> > > > Instruction dump:
> > > > 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000
> > > > 3929ffff
> > > > 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020
> > > > 3c4c00a2 38425080
> > > > ---[ end trace eb842b544538cbdf ]---
> > > 
> > > and I was wondering whether this is a qemu bug or the kernel is
> > > using an
> > > opcode it should rather not. If I skip doorbell_try_core_ipi() in
> > > smp_pseries_cause_ipi() then there is no crash. The comment says
> > > "POWER9
> > > should not use this handler" so…
> > 
> > I would say Linux is using a msgsndp instruction which is not
> > implemented
> > in QEMU TCG. But why have we started using dbells in Linux ? 

Yeah the kernel must have used msgsndp which isn't implemented for TCG
yet. We use doorbells in linux but only for threads which are on the
same core.
And when I try to construct a situation with more than 1 thread per
core (e.g. -smp 4,threads=4), I get "TCG cannot support more than 1
thread/core on a pseries machine".

So I wonder why the guest thinks it can use msgsndp...

> 
> ah. It seems arch_local_irq_restore() / replay_interrupt() generated
> some interrupt.
> 
> C.
> 
