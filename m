Return-Path: <linuxppc-dev+bounces-19704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B92F34C5E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:45:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvVZH1scPz2yjV;
	Tue, 14 Apr 2026 00:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776091527;
	cv=none; b=cePzbatubbnRHBr/TNY3VJeYNhEW3hVrBXaEZAMfCV2D2qkL4r4/BtTnH4a8cNtMdFbRGpsn79YxGkvWppe0TbhOstCCZaxUYqnaCC2yTGp0wJrA/eOgJkW3cMRk7Kt/47NOP+YyjUZQ1sguvXlqAO0VPGzyFydC1wvY56JsphZIyQ91Ir53fMdZC0SpT+zJtSH5Eh2aJ6abm63JTJgk8xIvQWnQnvDqf0mzrxLyVLO2fJvj27IbBwxLsKn/z//SmrLY93Fwh+/9kcQZJ0YsCwL69nxv4iztEAO8E9mYl2YS9WRU73z4rRaVqjIeFuf50r8oQoggyHGoixT6QVF4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776091527; c=relaxed/relaxed;
	bh=I+t/kQciCWPYQ9TuTtwE8ePqtDE4emYgbGk8M0JrxkM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hs9l8+dvMuXyiI+jCNptnKkkBjaJ11POj8jwDEBY4qcQkaMpFh3VpHdZ4JaXksvv9HwiEZfEApAHisP01H6pqsKcvtRmlNN5l4EeR3Bd7/6ChkMU280wWWKJ1pFW+kwgDYWyWGb+xhpH2pULaPNkmvc7PNxrycnztXxIWvU9WV5uzsMhLq16JgcIv/9Jb1EcmgQtEWR9F3zavgem/XuiRMPugo7VvmsJ4xHtgiHaVOktlL5aoD+GtbFrMOR709b+KSRSdN/QgtREBfAo5BSgTGdUoZiUMvbC5Qd/fJVNRRH91/Q/w44/fDAF3lbzWV+UMdMGw4vATJquuF55NhQ4Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=VAzPN0Q8; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qocQPWN5; dkim-atps=neutral; spf=pass (client-ip=202.12.124.137; helo=flow-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=VAzPN0Q8;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qocQPWN5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.137; helo=flow-b2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvVZG25dDz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 00:45:26 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 63FD713004A2;
	Mon, 13 Apr 2026 10:45:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 10:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776091523;
	 x=1776098723; bh=I+t/kQciCWPYQ9TuTtwE8ePqtDE4emYgbGk8M0JrxkM=; b=
	VAzPN0Q8M06ZrISBiijyTlSN7zZjXii1iyjsU0Nd55Go1hDvnVgLbRCBducupWL/
	I7xPJiEoPevkjLJ80mYbEW/a8BVGP+DZJqRCjUfrjm3tX4hey3YtL6Qx00JZuF8v
	WjI3i2GDGrKOX6lfMDr3NkI8PTwxLuJCiP0sOV4NGpZgf3fzkLLYGy+I5Zeauesx
	Pa7bVz5nZwM+gS/NQ9njvgK3O3s/OSp/mqYNiLR905iGGN0vAev7wD2BsAy/ZN5n
	HSi20BHM/ZKZ23MgIDcWnPLPjukDeFEfSjoTKa2sxYcORDHf2CMGKzIaSruFiqz+
	oZNoQZjdZwrcCPF2MdR51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776091523; x=
	1776098723; bh=I+t/kQciCWPYQ9TuTtwE8ePqtDE4emYgbGk8M0JrxkM=; b=q
	ocQPWN5vz5eOrV7RW4YLt61EpInPDUzfRCh54wFp6y2Qkmlnv6ZW6xi1Aoq7RlzZ
	r6AxqNsae7V2QoCSPbuAl0ssOCnVNF+Nwe1zzee6gqmSKirEjbwPzN/lznn6IgkI
	jFNhpABUlOOZaUVrUhHeH/vSP+NehNFWpty8kiiS8k4XWDW1V04VNj0ojxWNDsG/
	IfeL1IDdAfa9wVDrNQg30BEe1ROTtYd65N72SkxvxptAHs7jfN3985PGHUPTFvJI
	wKmIau3hzR296XeSLQyJhwIMCCxcc2mnbgbKz8VUFGlqAJo5mE6KGja1OZI6dhmy
	PrqiKmwzjhsEhLvP09Hgg==
X-ME-Sender: <xms:ggHdaTXgJGelzz_lzrVxB1-qyO567-GVmNc01ydITgap5FTeQTDzsg>
    <xme:ggHdaWbojY5ZlN23wxAxRcQ_6Dhj9KvjWf-KNsyKBcK8W8C_Dp62np5kJfJ8b515H
    9E3UwX-YmVDxTygAoDQVAtNvx28yeQKuUCb0K1tX4I6jWCY1o3q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthdrshgrihhlvghrsegrlhhumhhnihdrvghthhiirdgthhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprhihrggsihhnihhnrdgrrdgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhl
    vghrsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:ggHdaWvF06daWzpSpjs739v0aJtN6iuik26sDQBaw3w5gAf8SR2C_A>
    <xmx:ggHdaZ9awg7nUXhN5OpyKRMUZCbM9osYFN5RNP6GaSqeakIU3Racag>
    <xmx:ggHdacmWL1YHAZe8ol6oPFOZFwQU0SOjOVhuke7wt-o0cNx1zs0O2w>
    <xmx:ggHdaXZVfqhFVoJvGmfQg_vToEFHdnDFmb_H9i_ab2aUXdlRPO64dg>
    <xmx:gwHdabAQPN9OqlO9_5-GhrI_SeY-FYfEJ9AFMKsVeX_HsRytcY0IapPu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88869700065; Mon, 13 Apr 2026 10:45:22 -0400 (EDT)
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
X-ThreadId: APG-r6FMkt-Z
Date: Mon, 13 Apr 2026 16:45:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
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
 "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Paul Walmsley" <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-Id: <0166c8e1-b19a-44f8-aab6-f8f161c8542b@app.fastmail.com>
In-Reply-To: <20260410120320.163559629@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120320.163559629@kernel.org>
Subject: Re: [patch 38/38] treewide: Remove asm/timex.h includes from generic code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 10, 2026, at 14:21, Thomas Gleixner wrote:
> asm/timex.h does not provide any functionality for non-architecture code
> anymore.
>
> Remove the asm-generic fallback and all references in include and source
> files along with the random_get_entropy() #ifdeffery in timex.h.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/asm-generic/Kbuild  |    1 -
>  include/asm-generic/timex.h |   15 ---------------
>  include/linux/random.h      |    3 +++
>  include/linux/timex.h       |   26 --------------------------

Acked-by: Arnd Bergmann <arnd@arndb.de>

