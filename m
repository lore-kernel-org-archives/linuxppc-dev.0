Return-Path: <linuxppc-dev+bounces-25971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16607C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 08:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ0Xz3NC4z2yCL;
	Wed, 19 Aug 2026 18:46:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787129187;
	cv=none; b=hKFsamAW7dSJ2/aAZND0+7YQSwlBqJR5ya78fT5iMJi+jqzBIxXV8GvvXufNQmb7ItedEBsSJiUpV6ufb00vy5V3wA5Dlbh7zMBwI8gCTgpR3UjWfewLpqPIAvflc3rW6zFR0u7cA3FhKBLlk/5zyCEx4+5i35T46DCk5JnKmA4VLMxmTrgjn8LPXhFz8N5DzHmFv0Vjhl2MhSADD1fZuaNsBDwNr6jqQ6Pl6rTYpWv61pynE68QjFHiPzzgleDVtgB6Sf8uZVvlUEutPoSKLE6uhGY1/CdCSSfMvlkKSGolPyGXH3Wr/mL/YxP/6U3rBZH8J1cZIKFkQLsc5jJduA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787129187; c=relaxed/relaxed;
	bh=2tBzwIXkLm7G4HsQ9tq2d6c16rBFeHS7yTPuWCq9R+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gew2m9ig+wLqX8optaPfQjzy8s0ed3iYzaOl2bYYXQCwvasEnZBl7oLxuTOs1qdipRNudjf6Ouq0E0SyXiDuscWMwlrtt2TjqkefEO505xaiU6jRu0fOgG9jYOuzY5YkYOSJs9SQoPwOM+uZ3JI2AnNSZ5bkqFkmZDjfzOJ1+xzDZmyOdOdpP9XdKZm/VChxk4iYv2r2gWWkhl5lWCT22I8924alGU2wPGSBF/UzmQDpzBhi7DUYBtHdzlUEcPPz0Gwld6aNVapdFC9kgcJ0w6XJm06iVGAMVPKNc9yBVhK//JmK0qRxGjrznIInPyLpTK4UdIwj9zFTDueeeK6hUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZyF0J/lB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZyF0J/lB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ0Xx2ghFz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 18:46:24 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1066787a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787129181; x=1787733981; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tBzwIXkLm7G4HsQ9tq2d6c16rBFeHS7yTPuWCq9R+Q=;
        b=ZyF0J/lBIA3Z7PBwVM6wyDR9J3eSOoMu0QqLghGJegqWeqkC0yK/GNX36BZ7yVu2XT
         bLeY7RaMJ7/THYaR/w7z6UA3loD4LqzzLYTNjhYLZ8A9vSGviv7AVwE9cyU7Vg7Vm7Fo
         XhkrFh5NJiQoFFX1A4Qz3dK0VySQEaZvnpNM+sL4pnD+3OYbg+PReeUWKantzH6pEcHP
         oYr9cCsEmzoiyV26kaLnz0xCFmIcpgnBUNkJrK+6R3J3xEbJY6GQxQD3gEwm4owyE4qc
         sagTYM3/07vgWtKC2auFVWPVEQW+gC4kAFhN2PEoQckvAOM58EP7v49Cv52zkA+cxRPL
         3RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129181; x=1787733981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2tBzwIXkLm7G4HsQ9tq2d6c16rBFeHS7yTPuWCq9R+Q=;
        b=AcT69663COQwW4X/x1qakHXdV56tDyWnFOzDyOpWzFOOu57S8R/UG79Tp27KSwNME7
         iJwclfXEdbD2Kd6dbLZDKZom9q28xKWSaJ+MKtIicxEY4YVq6EbufLSwIUDxeWya1M7Q
         tJvhC50dOpCp4RtLT/2If+gdJ99GaueCwNxZS2NXOpxvbAHMzJYx8vFg9MPu8RNWXA/p
         UtUFcxK2BCk+2cMUhLeIcnx3xlcUQdRSx62NPJQmLXBRiMPFX9LIjupRQWYDCNhWL3wT
         SmvSrE18VmmnGUZKb1BDh3/9tz4h2jGbGWTJIDq2kvPpt8Cw6+Xm0r7a5pY2ipmuSkuY
         YxAA==
X-Forwarded-Encrypted: i=1; AHgh+RqOzGq7Z6E+l2fX4JSU9/RdJpD9tURjZeD0L8ugWH/kmdExyDlxRq63HAMUg0DIqvGXr5U0Gz9ofDe6gEA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++njlQaxHi3x3RAbmlTO06GFPRs789Jzm0r0kr6/1UEcAfKjRp0d
	xKpXnUViPYC8IsmE6ktzwSEiSZSUPYRT2gYyIGnRczOopcg8IoZ/uyDH
X-Gm-Gg: AR+sD12UFmOe5N843rqAoOF7XdvlsKG3a65EItZAmI8lBMQ8U6ptewIUoz2/8NLk3Hu
	J/9SMxlr0fVlQfuY1ABTMfTU/ZGIQ6Z/W5v6q7lbjKsbqQGFm8nj1QYbKIe0sBaM4qigKc+MmC/
	82GV+IHUrYbZA7Ig8SYz7ubP5F/Od93sEYUORZX/lkGQgrEhvh3IguANzg3CvSyVBFh2FR7KNGl
	0dQwhQ0Txc2zhC+5PN4gjGf3pGMDm6WFakQEqs0uRSmfWEbhFM9pGkFhLdEDpZULP66X9UbcIV2
	mxWTHbmIq8qslFCykkiL+fr+IvT0cKREJx0HILdPqKrQyBRl5ScsBqBFymUWxLZVEsA6GbpnX67
	Lnh3l/cLH8da4L+sO+kQUkcTguIbd0+Iyki66+xWUx56MWTtfkoyRw6V6lgv+QX3LI0txyppBsE
	rUVjuvtM0DHMVVvQUI/74f07MpI9gFG2e1WZKCQQNMpS66loe+4A3a+ZLhTJReFtg7uPS0R0MHv
	JT8Tsljr2XAL4dndTyTJEVi2hkwJhRT
X-Received: by 2002:a17:90b:2d85:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3958127ae44mr5887809a91.14.1787129181170;
        Wed, 19 Aug 2026 01:46:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957faf6849sm1807230a91.10.2026.08.19.01.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:46:20 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:16:14 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, mchauras@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Message-ID: <aoVrvjiSMmEDbwIF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
 <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <999c327b-3ec9-4636-a29e-57795d333912@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <999c327b-3ec9-4636-a29e-57795d333912@linux.ibm.com>

On Wed, Aug 19, 2026 at 11:24:40AM +0530, Venkat Rao Bagalkote wrote:
> 
[...]
> > Hey Venkat,
> > 
> > Can you try this diff,
> > 
> > diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> > index d5c48d1b0a31..2fbfebef74fe 100644
> > --- a/arch/powerpc/kernel/irq_64.c
> > +++ b/arch/powerpc/kernel/irq_64.c
> > @@ -117,7 +117,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
> >   	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
> >   	ppc_save_regs(&regs);
> > -	regs.softe = IRQS_ENABLED;
> > +	regs.softe = IRQS_DISABLED;
> >   	regs.msr |= MSR_EE;
> >   	/*
> > 
> Hello Mukesh,
> 
> With the proposed change, I still the issue.
> 
> [    0.742633] ------------[ cut here ]------------
> [    0.742633] WARNING: arch/powerpc/kernel/irq_64.c:75 at
> __replay_soft_interrupts+0x104/0x220, CPU#6: swapper/0/1
> [    0.742637] Modules linked in:
> [    0.742638] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   W         
>  7.2.0-rc7-dirty #25 PREEMPT
> [    0.742639] Tainted: [W]=WARN
> [    0.742640] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.742641] NIP:  c00000000003a384 LR: c00000000003a360 CTR:
> c000000000029f00
> [    0.742642] REGS: c000000009757410 TRAP: 0700   Tainted: G W           
> (7.2.0-rc7-dirty)
> [    0.742643] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE> CR: 88024824 
> XER: 00000003
> [    0.742646] CFAR: c00000000002a708 IRQMASK: 1
> [    0.742646] GPR00: c00000000003a360 c0000000097576b0 c000000001b28100
> c0000000097576d8
> [    0.742646] GPR04: 0000000000000000 0000000000000001 c00000000968d200
> c0000000096eb200
> [    0.742646] GPR08: 0000000000000001 0000000000000041 0000000000000001
> 000000002c1b8100
> [    0.742646] GPR12: c000000000029f00 c0000005ffff8f00 0000000000000000
> c00000000968d200
> [    0.742646] GPR16: c000000002f3aaf8 0000000000000000 c00000000284e138
> 0000000000000000
> [    0.742646] GPR20: c00000000303aaf8 c00000000303ade8 0000000000000001
> 0000000000000000
> [    0.742646] GPR24: c00000000303ae08 0000000000000000 0000000000000000
> 0000000000000002
> [    0.742646] GPR28: 0000000000000003 fcffffffffffffff fcffffffffffffff
> c00000000968d200
> [    0.742662] NIP [c00000000003a384] __replay_soft_interrupts+0x104/0x220
> [    0.742665] LR [c00000000003a360] __replay_soft_interrupts+0xe0/0x220
> [    0.742668] Call Trace:
> [    0.742668] [c0000000097576b0] [c00000000003a360]
> __replay_soft_interrupts+0xe0/0x220 (unreliable)
> [    0.742672] [c000000009757860] [c00000000003a694]
> arch_local_irq_restore+0x1f4/0x2d8
> [    0.742675] [c0000000097578b0] [c0000000002face0]
> console_flush_all+0x3ec/0x558
> [    0.742676] [c000000009757a00] [c0000000002faee4]
> console_unlock+0x98/0x1d8
> [    0.742678] [c000000009757a80] [c0000000002fc698]
> vprintk_emit+0x2c0/0x3f4
> [    0.742680] [c000000009757af0] [c0000000002fdc70] vprintk+0x30/0x7c
> [    0.742682] [c000000009757b10] [c0000000002f6c78] _printk+0x3c/0x50
> [    0.742683] [c000000009757b30] [c00000000205d814]
> load_system_certificate_list+0x24/0x5c
> [    0.742685] [c000000009757b90] [c00000000001111c]
> do_one_initcall+0x5c/0x3f0
> [    0.742687] [c000000009757c70] [c00000000200684c]
> do_initcalls+0x11c/0x270
> [    0.742689] [c000000009757d30] [c000000002006c78]
> kernel_init_freeable+0x228/0x3c0
> [    0.742690] [c000000009757de0] [c000000000011600] kernel_init+0x30/0x260
> 
> [    0.742692] [c000000009757e50] [c00000000000df7c]
> ret_from_kernel_user_thread+0x14/0x1c
> 
> 
> Regards,
> 
> Venkat.
> 

Hey Venkat, 
Thanks for verifying.

The regs.softe = IRQS_DISABLED change only prevents 
irqentry_exit_cond_resched() preemption path from running — it does nothing
about PACA_IRQ_HARD_DIS being cleared by the handler and not restored.
hard_irq_disable() fixes both: it atomically sets PACA_IRQ_HARD_DIS, sets
irq_soft_mask = IRQS_ALL_DISABLED, and clears MSR[EE], leaving a fully
consistent disabled state that next_interrupt() expects, regardless of
which entry path (idle wakeup or irqrestore) triggered the replay.

To answer's shrikanth question
it worked before because there was literally no interrupt-disabling code
on the handler exit path during replay. The new GENERIC_ENTRY
infrastructure brought a real exit sequence with it, and that sequence
needs hard_irq_disable() — not local_irq_disable() — to keep PPC64's
two-level interrupt state (irq_soft_mask + PACA_IRQ_HARD_DIS) consistent.

Hey Madhavan,
I think we are ok with this patch if there are no more objections from
anyone.

Regards,
Mukesh

