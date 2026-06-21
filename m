Return-Path: <linuxppc-dev+bounces-22851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B60CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 10:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjnGB6Xphz2xQD;
	Sun, 21 Jun 2026 20:13:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782036786;
	cv=none; b=edhdujPVMbW0FiNX24qSdeKhQwtY3sAWQ9Lf1GtLrM7n0Lc054AAimNoWjFpt9qjs+xsMbmzcU99KlsofJI1RuSyxNzwO2HwZGvT81DUsv3HQ9iyl8OEhlXIHy9UfljoD7UU/irOBySd5YPOP2bVBqPPIDUaG+GtyVqRhccpmMLkYxf43BMU/fm7RF9tAZ+mIUCgGNfq9TipqcH4lVocLBZJGvt7b8Frrf+kIamLwgLQ4v9/KghTfJPeXdFZmYd5tjuQy/12Trq/4m1gsAXGxNu8LP6gx01r7u5b1oez3BfK+HHD6ePHdtcBIeyQoO8tOKKRnPAwq+H0hwY0XOU6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782036786; c=relaxed/relaxed;
	bh=6XsKwg1GS9lT4/Q7bmwm9MowVi5d7q2SDPsQIWMoNaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8xf+niGIwCVW2q7prZcoceRzhTExemSSdDGURylZ6BSDAML5XPhgeapwy+VWa7G+tjZU7kLr969d6N/VtTIM6QohvDsRj0RhexZtTecneLwnN1co/cay2tcrgefLfdnL2F9FG5u+0NvnizG1bFXRtizzmY4e7RTp3MrW/jm5LBvczqDIX8M0nGQwlVyZEWbTyqat5GV4ykRYHaMTupaZVnI3zbZ/X/Mh+y0X4xV+ImhRyezgfCuLzhUt1jY0cF0M6Rre5T+L8gc+jHk1sDwdgVzq4iuByy2c+rgp6C86jOmnOL3E+YpYydFpuEgsy+WaWA6M9pqB/EiGnYKEtc+HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsyZ+1Ts; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsyZ+1Ts;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjnG96gXkz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 20:13:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7228F60051;
	Sun, 21 Jun 2026 10:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508F1F000E9;
	Sun, 21 Jun 2026 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782036783;
	bh=6XsKwg1GS9lT4/Q7bmwm9MowVi5d7q2SDPsQIWMoNaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SsyZ+1TsvgLflg0juXYCjcA3pH8vd+Y9MqLc0jYTOhxn+P6dy4eY5MVrVxb5LOEoG
	 RrsJ0srGqaRi77KiHkc+wrXh1Emat3ZrzazsysIAaCQMNMGheBK5y3Hia7XGDjeIwh
	 LpelPKZxXhh8Y2s446VszI2jLhTRwLl2n4aoLyozgo8nfNqijIIBJo83nfZDkhDjVn
	 zeV/f4D/0nNSdjN56lwbs/1HvvZ3/sR6vxbzEQ0DhZ/vS4thbxkh+Wd09+S0HmhHwJ
	 J68RbJ78ssT3222GKOLcajGNFfc3WxJv5d4ocntPrsfqRDltQ6MWCkBxIPIk+xpkfW
	 jKewonDrI7TBQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
In-Reply-To: <20260621093811.168514984@kernel.org>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
Date: Sun, 21 Jun 2026 12:13:00 +0200
Message-ID: <87ik7cmcb7.ffs@fw13>
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

On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> Instead of having trace_printk.h included in kernel.h, create a config
> TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> Makefile to allow developers to add trace_printk() without the need to add
> the include for it. Having it included in the Makefile keeps it from being
> in the dependency chain and it will not waste extra CPU cycles for those
> building the kernel without using trace_printk.

IOW, you make it worse just because.

With the header being separate I add the three trace_printk()s and the
include to the source file I'm investigating. The recompile will build
exactly this source file.

Having to enable the config knob will result in a full kernel rebuild
for no value.

Seriously?

Thanks,

        tglx



