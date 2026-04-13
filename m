Return-Path: <linuxppc-dev+bounces-19703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6DCF34C5C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvVXN5473z2yjV;
	Tue, 14 Apr 2026 00:43:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776091428;
	cv=none; b=XymMLMIuSM1HmS0kUW0e2Y5e4NlK5Ypm6YC6CeIAg7Nkk9oxp1wgRieZ6OMTGAMmFQVDTPlnCj9a6ybM1nW6QctVDefJOibszuzpWjOAgAS8hTSTYrghi1Ms7aeVU89DKt8TZUd206bRU1qdP6Ya4Bqxj/9c60k2e8vsywwUTvfpklq+9zfZq1Rl5vSBfwjLcxVtPYrxcR1euAq1xxUUbjgkWWyJjBiAX2I3UyuXPvYQKCXWRqDJC+rmTLap7ou9+NpnKtt1xRfxlqegytSzpFc6kXo29ntAeKF3WlLjVJM0ekvY2edtG77VHp/y+292D3xq7CSbnaRRU1TsQfIptg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776091428; c=relaxed/relaxed;
	bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DaBgbMutRWcz20+Oz0b5SPGRj9kbjbz6HdnYZRLNbJtYEaNbo91wUAADlHHpjs/negSKhQy65lI+eXxmQHrJwV0PdkUuPwDaJ1tnE1ptZ5X2FCS4VUhmV0HYkHEVRrD0C6z/IH+TR/B0WFQmBbBRJgFpmPnkuPS9tarL0RHyHETxLVzRvqK4/R0tE/SvZXqGna2wYjCAZ5+bUdaI1Shsvtk/WZP6nBDNCUKmY1eF8NTNWeCMkMJbgLPvIPaRYNIVetUjREPBo5Wf/mT3hs4Ia6ELHdQZJ74L6TVbTnlt7mG4lFOLbKW2GP9HLuufFM3cuxOk4Mh1pzvG1GEdXrjYNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=dThTVDJR; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mKaUdPcE; dkim-atps=neutral; spf=pass (client-ip=202.12.124.137; helo=flow-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=dThTVDJR;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mKaUdPcE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.137; helo=flow-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvVXJ5x3qz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 00:43:44 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 580C613004A2;
	Mon, 13 Apr 2026 10:43:39 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776091419;
	 x=1776098619; bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=; b=
	dThTVDJRrT61VUkRS+cdt7Y0Z5RRsLEBjlt5LbUT/Wkj3XuC1dVyKWZPgLth6rHI
	xbXnXmRzoJxvLeN5K5KTS4bLI9JTPMUMZHJQi9mq2+Mm0O8HtxzN6gdwi5dKMGzS
	o1z8qIdRudVgAnBmJYPys1vSE6iXXFJKhXBunGcqiXTQxSIZPwExbixipylrVyN9
	4kf4i5YSOQ5TyiEguuaQMFY1bjfsEzY4T5yjV+i49k3OFs/Vmf2QAO7EvG9pkkWh
	N8bT6ZPczJACaYt7v0DdNhd+Jcw1QSr4sfdnPLEq3qIenfqRfJd23mvz1BSPAcJy
	t7jf+cR2gTZwsPDeAUjd8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776091419; x=
	1776098619; bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=; b=m
	KaUdPcERkC+zzfJk9o14B4ADxV7hBFIrlwDzvbBZEzHm0PKs68AEHjccunfdwCIR
	xandwmc3ligmxNR3yrYrjDSRktpJmwg0D7TTzo3rAlmWy0gSHQXh1wFw4+NYGyVg
	zDlM8PgR4QH15XnDMMXbSfnGvjJh/j4eK/GlCalmtgkTknPnFph+dfWco8cTlWse
	WFEPDTU+OA38Yo/f8OVtqBAERl/dqEvgrfDqnngro8UiU3Du4URjogCH7u9C6eP/
	RYqA02k02M2VwiJpdNWH8HG6r4KmynyPDoJYdxTNeNoiAqYyt88JcV7BBjOLulpB
	DJUQhLG59C0zm2Z5pxrQg==
X-ME-Sender: <xms:GAHdaVYGCaKUPjfNsUorzxAck0ngCpZdPLdqJKjZEoxtd6QEkfV5yg>
    <xme:GAHdaXPKX2B9tilU84LfHthnj4XuzUMENgXV2EBsOOdx9XMImcZUEPIIzoIwFqvOh
    pcGkwnRvUUR4OUGZGU3iYkbbpFp25Dx9wq8LoeuFKlAv-Ydx1YT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthdrshgrihhlvghrsegrlhhumhhnihdrvghthhiirdgthhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprhihrggsihhnihhnrdgrrdgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhl
    vghrsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:GAHdadx3OaLmpgnQ-qR09fFSyphBizIiykQxx2Qr5HCiMADvCUw5LA>
    <xmx:GAHdabzajIhZOwZQz55Cqp-WmIPvMJl0Qeu3WJrRVrqO07JZC9K3bQ>
    <xmx:GAHdaSIxPmEuEecG1TMTc2ieeRuLkqK7w1Mgwy5a1Wj0e-ew_hD6MQ>
    <xmx:GAHdaVsDbvRI-p-Ezq237oUrDyOkdrmimmA3aH1JiaBrwsVneKVMbQ>
    <xmx:GwHdaelj14NT6xOHjmTv_huVndzlY2JM81Rr0b3-wFbundNAWyZ-7jZM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9F8A700065; Mon, 13 Apr 2026 10:43:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AaL_vZcj0OrJ
Date: Mon, 13 Apr 2026 16:43:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Bernie Thompson" <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Marco Elver" <elver@google.com>, "Dmitry Vyukov" <dvyukov@google.com>,
 kasan-dev@googlegroups.com, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Thomas Sailer" <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, "Dinh Nguyen" <dinguyen@kernel.org>,
 "Jonas Bonn" <jonas@southpole.se>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org,
 "Paul Walmsley" <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-Id: <3d7c3433-2325-4bb2-a8f6-ddd11c82f71d@app.fastmail.com>
In-Reply-To: <20260410120319.723429844@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.723429844@kernel.org>
Subject: Re: [patch 32/38] powerpc/spufs: Use mftb() directly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 10, 2026, at 14:21, Thomas Gleixner wrote:
> There is no reason to indirect via get_cycles(), which is about to be
> removed.
>
> Use mftb() directly.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

