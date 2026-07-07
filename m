Return-Path: <linuxppc-dev+bounces-23672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A877C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 06:05:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvW1C3KTvz3brc;
	Tue, 07 Jul 2026 16:05:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783404335;
	cv=none; b=UrKHeTeRfQLAiMupb2mb8uhdaTjyYSD5kBXcXqT5j3rVPrOIWf7BXQyrCc0vI2OsoGOt0v82Cl/TvJMCltE5HZrGnwpwTeH6fHf7MDzKY1U69Ssb9MZVjCXxzEq19OL0goM43iRZY040eMM9b2QRwo9SnU3AlAexVOjHSsJU/5X/0QPcVLWYfVDHU7p8pPZ3zeKmXrRUIihmwTyIpvRfypn2kYQ+JLPxypls0UsSMh4Rv/I28mM4BsHw/kDedxa/zeXxX7KPv/OvkS1iahWTUD0QD4W6WTbt4h5PC2zGGIvlarMGkk+5l+hDeTFBvAHLKuJczvgQHVzeWTRPd+OWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783404335; c=relaxed/relaxed;
	bh=5hSf98TXXtynOTZ3bnvTSQp9m+FQuepCzRJQYwBNiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVKowj1xr22bDUrK5S8IRzY8A0G8/gaUC0f8u4DiEOiRgqOSsO5+/OUK/v0/GqaS8wXPl6s+rSkblnkDvih6ZqFv6BiC2k9fVpD+SsZLgKU7+YmpDZI+ZYYQdvjLRCRgQw3YmyA2wtU9H8PE1unn5QAE4pay0YIoXkDsBUK4dzWbVl04iFmp+fJm5uDYWKySSx7dK0dmRVVpm0gDlQmYEC1J0jcC64iQNbm8SQFUd3/q/2nPoLoYiUz1jdmQSkP9jYXzSZ9mTL5cu78Og9Sup/vtmHLIobmL+S2Tju7pB5Pi5m0d0qyN233AZ79LN83bBIsTwnbQzS3dV5O+2GcGqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KjE4Cavn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KjE4Cavn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvW1B3rq8z3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 16:05:33 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2529918a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783404331; x=1784009131; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5hSf98TXXtynOTZ3bnvTSQp9m+FQuepCzRJQYwBNiY0=;
        b=KjE4CavnlSLDbZLKXsVWLMeE/8yPJGLikkZQbUVPlcD6iPKQU9+tdxWtriUhJx+p8x
         eSoYGt8XtgeRJruYpQAiBxfNeuEbJ05FTCqib0uS/221b2Flp41hvPcHaQMZj1T9BNvj
         5N1mWoDSDjHZINCChSfzDQaxc/tCoLCkiXCC7ovwC5kU65+IqcqAfi4cTOkaHX60UQMr
         y3FSRgV30MjKz/E6/t/e5V+Kqcf7639mTZbPRXzDRp7TTOZC21LvNaYg7pulT0tAh7nm
         bm88x0q0pYWUVO2L4G9XCVqG0U9NB7LKQS6A09XsMpdGc9gJ7l31dapIptc+oPThJq0l
         ZW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404331; x=1784009131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hSf98TXXtynOTZ3bnvTSQp9m+FQuepCzRJQYwBNiY0=;
        b=RiR8Iaf3G5SjkZFM8WmP3ArRSWY9p6XR/e6mEZfUINIBBDMKno5Hlz0g1wAd10N8rV
         W5E1iUpifhWdavTkTCThSljkncJ97tGKg01z8fEdJ0Uy5gdWlgbBP5QNH00mlPcLttcx
         jKWkYM3pDwlk5WmtPDyPnwfYMZ4ZQXpu8inbkGviRqByPbuOMPGN14Er48QE0Kqulas1
         NQUnD3wOhOgccGrYjviUhjy0EHGRLrEsvMOK5MXbCMDklN9tbc/N/lvOwLZh8DAFDVpT
         1AZ2ty2/6GCPMiUp5p+DgcELaw/EcJH5y9VxuKy1/AwIPCxpgdIWpD+DfoWGZcmAf6hO
         /ZeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrXbQwRyvzYKJo7hi9rIMkhhjF/yAPK6Zegq39MEPGf3NDoVIQM6pBFqVVpIJeNUbyGcnDiHItH5Ph6Bo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyrDnZ9ly+4+Lw7/55UtHuUkABxsGhvb4Gfn4ewO3AFy85ZI6ey
	UnraVPlrDdVHYGC9PF0Ig//KhJgb3GUUiG1DErRckBbj47vT+eRrRYXn
X-Gm-Gg: AfdE7cltcRpqg77NXgxx+fVtTXWl5CgTqp8KJT8EjycI6GA+rPQsqM4lavXKXGPF2BP
	KzA921wQeO7e/sgpI/tfa0bAmAKH5d4hq8zTib9tP+KhS34F5rbsAs0tUhsrQ63ahJMiddUqZD9
	RbW5vydgWGSogp9zpHelptKRhsUFR9NequyBHEfqywjT65MLQxD9QLnyNTr+eMc8kkHkTkyixUG
	niBQhoE8L916a5PV1m5/cBSvvnVV/aoVN+QDewB/nhIvJfh4SxDITRdcQYlphKcZKiJjv966uv0
	OofAFMYJKm2Jw69sHV+WlLt4MoF3qFjh0gxH7dezPW0EJ2PWNF3mPAV4QzmeerKvZxZL0LkdMb8
	Ut6in0ND8BuG8ZltBEew8ZqRtQLbNHopDpUPzE2lA7jpB2nIajSbTb7aFII1b21S+Lkl6eeinrL
	lBZ+9edcSO3rXx+0V7BXEABSC/IBvWC0Q2XbMeqvTRAoTKxh2r9+M6Vbv6AuY2MpFR3qYJ4fo=
X-Received: by 2002:a17:90b:3c86:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-3875528aca4mr3406240a91.2.1783404331134;
        Mon, 06 Jul 2026 23:05:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d12fcd8esm475448a91.3.2026.07.06.23.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:05:30 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:35:17 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, ldv@strace.io, 
	charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, ritesh.list@gmail.com, 
	yeoreum.yun@arm.com, agordeev@linux.ibm.com, segher@kernel.crashing.org, 
	mark.rutland@arm.com, ryan.roberts@arm.com, pmladek@suse.com, 
	feng.tang@linux.alibaba.com, peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <akyWi0a69Az59X5Z@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <87wlvazrdy.fsf@igel.home>
 <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
 <87wlv9tiyy.fsf@igel.home>
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
In-Reply-To: <87wlv9tiyy.fsf@igel.home>

On Sun, Jul 05, 2026 at 08:00:21PM +0200, Andreas Schwab wrote:
> Most of the time it prints nothing, and when it prints something it is
> mostly scrolled out.
> 
> 
> .handle_softirqs+0xcc/0x264
> .do_softirq_own_stack+0x30/0x38
> .__irq_exit_rcu++0x7c/0x120
> .timer_interrupt+90x1ß9/0x2c4
> decrementer_common_virt+9x214/0x22ß
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

Hey,

Thanks for reporting this. I don't have a powermacG5 to test this.
Can you try out the below diff and check whether this fixes the issue?
Please note this is not a proper fix, I just want to understand the issue
so that i can make a proper fix.

Regards,
Mukesh


diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index fc636c42e89a..b6373bae4524 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -286,14 +286,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
 
 static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
 {
-       /*
-        * Adjust at exit so the main handler sees the true NIA. This must
-        * come before irq_exit() because irq_exit can enable interrupts, and
-        * if another interrupt is taken before nap_adjust_return has run
-        * here, then that interrupt would return directly to idle nap return.
-        */
-       nap_adjust_return(regs);
-
        arch_interrupt_exit_prepare(regs);
 }
 
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index fb42a664ae54..1b45a49e9bed 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)                   \
        instrumentation_begin();                                        \
        irq_enter_rcu();                                                \
        ____##func (regs);                                              \
+       nap_adjust_return(regs);                                        \
        irq_exit_rcu();                                                 \
        instrumentation_end();                                          \
        arch_interrupt_async_exit_prepare(regs);                        \


