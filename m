Return-Path: <linuxppc-dev+bounces-19742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E0DED7B96
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 10:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw0Z54GJbz2ySS;
	Tue, 14 Apr 2026 20:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776161821;
	cv=none; b=TFCH/52+5qkuZRcsSqqqowbUo3vN1epUjnhg6svHROYSOqsAVYXMoKzcbE+0bzgrclET+rXw6ssuLS+2Ha7c0cYz0pUybDSgp1QJGKBt2SLf9edAsX8k4YtPsyVmn1muzkuzxARTRtfd6uGHvgmmdJFElgUJ5tiKXBF+PQ57cS5hVCVlTwG8Tiud2KFmSIPmGKdvaxTvN5a9mJGrbh7YvU8iIMfUbcINPE319QRpauxBhOTQ8AeF84aKqYcSm9MU0CQjAEcGBGIal2ckCJoZLi6zBmGxXPfN5tefqnYLAeToFWIt8LTPQJKCNlQ76niOHyiczs0J+cZOEUWSWQQFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776161821; c=relaxed/relaxed;
	bh=BiErSfuvJerZIQ4L+JF5tzrkBbOhwbYuWVg9ZYwOn2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhrwutXg5NKW4c47iZuhBQaASVEEcOMm79To4U1Rt6+Fi24XyKc48X/NRpIDNY3BrtA+p9Q+JctyY1v/WLIqegBD1vcYYFDepTqHWznTgwm8w3nAnLSF5CQA4juerRts/wmsXdIOdRGPWjIU4ScMLAwnkgZSv7zQ98338/hoKfGmixUuUR7glPetRmFix//s/xQ0fDI7sC1JxcUn/7nSeZOtKXvklkxvLdHkzFtGnEgHceK1jVlueE37xdRkHQgAj9jk2345nS1MLtoLCdqRLTUvMDu047iLPVNduj1goTa80RaijN8J88LZ1DZs41o1EKQMlqVr99HxyjmxfUfdLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OSiqxWwo; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=M7Iqvv7a; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OSiqxWwo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=M7Iqvv7a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw0Z43sGRz2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 20:17:00 +1000 (AEST)
Date: Tue, 14 Apr 2026 12:16:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776161811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BiErSfuvJerZIQ4L+JF5tzrkBbOhwbYuWVg9ZYwOn2Q=;
	b=OSiqxWwog8Eyo5f66GW9p/l3q7TUrwpoIhrfJTw1X9DwXVATfIR9taZHEoi2HlR1g93VOJ
	eWDOYZFl9F7WspBEmNsFtXcOp7KlR84eLbwD94B1YXA/2DperGZ+c2FryF4Vkagz0HohfD
	H4Iwp6tgQJHAeYDhYNpAFW8TOIJpoZDAl6g3jq+josSBCcV8cQmHyl2aYHQ3f+/agOFmuj
	8cRkDhm+/y6dcV4xI2TF9VXKk37gtYgHC/6VtixvpKy4MVxbp+otsY11rquc2cydJJTitW
	d5YHjEvCWtOUvedgzu4xwx1jPp2fPPB6TxTX1g80dUPcZ96+w3zRG2fwJZE+0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776161811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BiErSfuvJerZIQ4L+JF5tzrkBbOhwbYuWVg9ZYwOn2Q=;
	b=M7Iqvv7amB/lm/Bd9iU0BxSxraoC4Y4+3sMwzQ/SGLGAc2KrGilQkv7tAoHXQw2xoJuVJv
	+oP09+VAFyvd00DQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/7] x86/vdso: Respect COMPAT_32BIT_TIME
Message-ID: <20260414121405-29c9514e-590c-404e-a31d-905b1848afb4@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
 <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
 <03cd1e21-a2f2-46a1-a674-cbaef9712016@app.fastmail.com>
 <20260227103226-cc3bb32c-0107-4c09-b81a-ca33ea03ad5c@linutronix.de>
 <49b7c9f9-198a-49f7-880b-6ae74d7bd985@zytor.com>
 <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>
 <20260410091131-46b6354c-9d06-4e47-9345-ee224d8528f7@linutronix.de>
 <15925544-1ae5-406a-b9cc-af5935cc9f02@app.fastmail.com>
 <20260413180541-e13f374c-b990-4236-bc83-8fde948899df@linutronix.de>
 <e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com>
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
In-Reply-To: <e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com>

On Mon, Apr 13, 2026 at 06:57:57PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 13, 2026, at 18:13, Thomas Weißschuh wrote:

(...)

> > if (tv && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME) && sizeof(tv->tv_sec) < 8) {
> > 	pr_warn_once(...);
> > 	return -EINVAL;
> > }
> >
> > Or maybe drop the EINVAL but still emit a warning. That warning would be
> > useful for gettimeofday(), too.
> 
> We discussed this during the original y2038 work and decided
> at the time to not have those warnings for syscalls. We could
> bring that back, but I think I would want one level of abstraction
> there and control this using a global Kconfig switch for all
> syscalls as well as ioctl commands that could use such a check.

I'd like to avoid another kconfig option. Linus doesn't sound too
excited about those [0].


Thomas

[0] https://lore.kernel.org/lkml/CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com/

