Return-Path: <linuxppc-dev+bounces-24299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E1BC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 11:36:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0Yyl3TFVz2yb9;
	Wed, 15 Jul 2026 21:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784115359;
	cv=none; b=d/uUIjkc8bmjE4VJ6EocTp1AwflBFh1blhjIPJw1mGnzPxEqzdI0BjSkQufT87I355xsNJg9R4zZUBeiq8b6ZKdU4pAhq98BpjVW+W3qZBk90j0A9lwO+LoeeSt5WhKPxEMWmJ+BFIhENltEspoeCWHDo6bjSaQdujhiG7zX4A0Nro2Rz33L3VWIkE7J7iyP4VgjSEcCzAaE6QGBF0oAbG9WzNQLNodB8SWBNAU/Mc+jacNuuzaeOkxcEDcXOLryXDt4fd7uAyrqehxvHsBpkZv8XrA+eOP8Lwl1A+C7crp/qfPPvv2qoDF+xJirQuMkHGTrU3ozwPuE7OstStn/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784115359; c=relaxed/relaxed;
	bh=01If23sRWVX5qrUA4FIRgNgbBaWGDr8CtRCDXCzfa0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ss3MW2+gcccwaf+uK0M6q7WcX/BIS7pQL8giv++yB8ztYMuHDJyrwBnZZiB52VGeQzRgQeMS8/tqQX3zEVeL/N5ek82/dTEWwOWdGWbBPWhWsViwnVIdiM6Y0q9FrvAHtzUieybdqRj9Uv7/Q+VxBBBKZvgyil72BorIm2xE2Nm2uVO3j+NL7T37IwwG9fCf9aVU4MXmZ9EOiymJpYK2SJtEuKkJChADup6Wc+JBxv1KIArqhKRx7s1bCdvCvL/oDkWm9ZCF6E6GTRCGh9fsGLdlzgxrezLqawHxBlfYRrqWts+dV07YbrYA93+6V5jLvU/mpCZZcptrkXAbLTL8Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RE+RJRZT; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NxdzLWFm; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RE+RJRZT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NxdzLWFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 441 seconds by postgrey-1.37 at boromir; Wed, 15 Jul 2026 21:35:57 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0Yyj74nMz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 21:35:57 +1000 (AEST)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784114910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01If23sRWVX5qrUA4FIRgNgbBaWGDr8CtRCDXCzfa0k=;
	b=RE+RJRZTQDOn9Kbi2CJq8wR08/rXnJROmk+vfTu87VvuTFlybLNgFrNhFb0kwLN4XuJHnX
	GM+/HYv0Cv15OCk1vSXbIHcLYLwUDkWOteZLlHLiHixHW+wSXYE3qSHy82mpzlaZoohrXX
	KojxKbGy3IS3tmUQ+sdV9g6cbCVZq+zITaY+xp6IHT5GjdApzmlnbNMp0eqTj2+7V31C+2
	ACDXdmzDSb/q8Znk59fXEhqLYWEJdNVAjg0DqW2PKkBV1AbFJfomcdVpyOzB7xUFBf8M2S
	YmmzfMy/Iti6bnnVDhDKruywOO69rI7aIQO1qfitv72qCZ6l6vlepY+WSPinog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784114910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01If23sRWVX5qrUA4FIRgNgbBaWGDr8CtRCDXCzfa0k=;
	b=NxdzLWFmo33PnuT0OOCdY1Ugu3O6J6EOVV/Mm4OC8yM1YUDkYzJjhag7g4WV+C2UBu9Nzx
	bqlkzJlQwaTBs3Dg==
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Andreas Schwab
 <schwab@linux-m68k.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com,
 sshegde@linux.ibm.com, thuth@redhat.com, ruanjinjie@huawei.com,
 akpm@linux-foundation.org, macro@orcam.me.uk, ldv@strace.io,
 charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com,
 ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com,
 segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com,
 pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <ak0uuO-rhItbx9uw@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <87wlvazrdy.fsf@igel.home>
 <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
 <87wlv9tiyy.fsf@igel.home>
 <akyWi0a69Az59X5Z@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <875x2qu5ay.fsf@igel.home>
 <ak0uuO-rhItbx9uw@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Wed, 15 Jul 2026 13:34:29 +0206
Message-ID: <87mrvstrtu.fsf@jogness.linutronix.de>
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
Content-Type: text/plain

Hi Mukesh,

On 2026-07-07, Mukesh Kumar Chaurasiya <mkchauras@gmail.com> wrote:
> On Tue, Jul 07, 2026 at 06:34:45PM +0200, Andreas Schwab wrote:
>> On Jul 07 2026, Mukesh Kumar Chaurasiya wrote:
>> 
>> > diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
>> > index fc636c42e89a..b6373bae4524 100644
>> > --- a/arch/powerpc/include/asm/entry-common.h
>> > +++ b/arch/powerpc/include/asm/entry-common.h
>> > @@ -286,14 +286,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>> >  
>> >  static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
>> >  {
>> > -       /*
>> > -        * Adjust at exit so the main handler sees the true NIA. This must
>> > -        * come before irq_exit() because irq_exit can enable interrupts, and
>> > -        * if another interrupt is taken before nap_adjust_return has run
>> > -        * here, then that interrupt would return directly to idle nap return.
>> > -        */
>> > -       nap_adjust_return(regs);
>> > -
>> >         arch_interrupt_exit_prepare(regs);
>> >  }
>> >  
>> > diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
>> > index fb42a664ae54..1b45a49e9bed 100644
>> > --- a/arch/powerpc/include/asm/interrupt.h
>> > +++ b/arch/powerpc/include/asm/interrupt.h
>> > @@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)                   \
>> >         instrumentation_begin();                                        \
>> >         irq_enter_rcu();                                                \
>> >         ____##func (regs);                                              \
>> > +       nap_adjust_return(regs);                                        \
>> >         irq_exit_rcu();                                                 \
>> >         instrumentation_end();                                          \
>> >         arch_interrupt_async_exit_prepare(regs);                        \
>> 
>> This allows the system to boot normally.
>> 
> Thanks for testing this. I am assuming you tried this without
> "powersave=off" command line option.

I am here after bisecting the same problem. (I also use a G5.)

I can also confirm that the above hack on top of v7.2-rc3 will boot
(without specifying powersave=off).

John Ogness

