Return-Path: <linuxppc-dev+bounces-19710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A82F34C64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:14:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvXXX4nCYz2yw7;
	Tue, 14 Apr 2026 02:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776096844;
	cv=none; b=oPxNKKjJHLoYF80dydrqMmF6WLufPkVBhGrfkdZkQj25FRiOLda14dCd/+xLCaFKPe0ILipYEb4bCAN6nKgJ0h4NcZS7Xwv+09zicwDhIVPiu3fRKQMO7zNcxwuY1b/qNBTcUQcal9Nk83lrSxKU/DMxg67eD25Lh8JnfaG8h2d8v6Goqd9XzjvgEJcn+S/o4GDkwlJc6nMIGnt1RmYbi5TsAlg+MLSS/l1Na8QStxBg3JnOuMulcSqTJ+h4W2tc2+VP1gHqzso8qP0S+5V4EF6+Zskj90jlt6ztYexJTJ5n+M/83XMuN9lbQxl2kLlyicWb3Zy59mPKPpUkVUSbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776096844; c=relaxed/relaxed;
	bh=QTxZjlPwQbG3YSd8NjMQF965BtCe0lPqly+S72Myshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4+Gm0I4t7kRJsvpkP9m4HU+z2YtH2ApJCLmO2D+Nx7QL77/WpyZ5znkdSo3TXWTwWlFYtf4a1nirIFT+gPUXwY8p77gWiD2H87GLculrxMsNq1IZG6LFM5t8b+N+S9EWb92eUq5jl9WplcxLp55Hbk+y53eULf2Kgy4h2CcIQQxlTVjPlbS8CM4gQ5W50KvP2p8qqNDqn6aj0mnQiYy40MUjhEZUGq4ssYRd7pmXTykVHPv8p24WaTe1NVXKyf+yoUUVgB+gy348wxl/0A5YH8RTdnYzx765fGgP6qN5+XViL9OM++jqmKv5U7EdQw4DGBsIqlzV4B84Du7yVjLiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tkXY4nmg; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LoVkYl6M; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tkXY4nmg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LoVkYl6M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvXXW1jklz2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 02:14:03 +1000 (AEST)
Date: Mon, 13 Apr 2026 18:13:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776096838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTxZjlPwQbG3YSd8NjMQF965BtCe0lPqly+S72Myshs=;
	b=tkXY4nmg+ufLH8pIEREGPRIN7lEqDgcVyS4rMzP1pwHp3yL9b7kXJNaCAOrhLb02cE7TGx
	ggSSsIsYsGtFlAqRc8UG2XgBwu4Qk7X16r+d5lL2igIBjpcbMUvCVDWy7ZLItlTIXxZD2z
	h84JvMJNCIi1kvdvkxIIavJgYl+u/z8BcToeOgc+aJOW6lKeBrGdb3kEMvdFXGg6XytgEk
	rPMpXXME1ph1vQl4s9O5z+BEsC7htoA6IsUN921QvLHj7U4PfLX+8Y45VLFAq5AKYwtmoY
	FG1tRrjVloQGmzZUNVRNkeyCEHHE5ks19vbY61zf1F/NW+xmp2dLuPlt0SZxoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776096838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTxZjlPwQbG3YSd8NjMQF965BtCe0lPqly+S72Myshs=;
	b=LoVkYl6MMLeNBjAM4BvQVhVn1NnaY+OSsVvNNOBvu1HsCV87BqTgHRgkWFHBm1kAvMqe5B
	HVlxTATbwykTSSCg==
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
Message-ID: <20260413180541-e13f374c-b990-4236-bc83-8fde948899df@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
 <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
 <03cd1e21-a2f2-46a1-a674-cbaef9712016@app.fastmail.com>
 <20260227103226-cc3bb32c-0107-4c09-b81a-ca33ea03ad5c@linutronix.de>
 <49b7c9f9-198a-49f7-880b-6ae74d7bd985@zytor.com>
 <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>
 <20260410091131-46b6354c-9d06-4e47-9345-ee224d8528f7@linutronix.de>
 <15925544-1ae5-406a-b9cc-af5935cc9f02@app.fastmail.com>
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
In-Reply-To: <15925544-1ae5-406a-b9cc-af5935cc9f02@app.fastmail.com>

On Mon, Apr 13, 2026 at 05:59:52PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 10, 2026, at 09:24, Thomas Weißschuh wrote:

(...)

> > Recap/Proposal:

(...)

> > * Always provide settimeofday(). If CONFIG_COMPAT_32BIT_TIME is *not*
> >   set, reject passing any 'tv' argument where it may not be y2038 safe.
> 
> This sounds wrong to me now: the case I'm worried about is a 32-bit
> system calling settimeofday() based on the value of an RTC or NTP.
> The idea of CONFIG_COMPAT_32BIT_TIME=n is to catch this by causing
> an intentional ENOSYS error even for valid times, so it doesn't
> suddenly start breaking in 2038.

This is what I meant with "where it *may*" be not y2038 safe.
Even if the value fits, the call would be rejected.
My wording was crappy indeed, though.

In code:

if (tv && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME) && sizeof(tv->tv_sec) < 8) {
	pr_warn_once(...);
	return -EINVAL;
}

Or maybe drop the EINVAL but still emit a warning. That warning would be
useful for gettimeofday(), too.

Thomas

