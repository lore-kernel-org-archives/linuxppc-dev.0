Return-Path: <linuxppc-dev+bounces-17503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A2D58E7D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 08:42:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPXWC4V5cz2xc8;
	Mon, 02 Mar 2026 19:42:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772440967;
	cv=none; b=U9qi2uExTxV9GNwA8vnJyWeuCX2xnVMAjRzxjGtsD/g55snfQ6DdwrjxL5AmprcZy71Z0mQJT2hANaD3K+eBBhXqJupuFm3zF7qQLEPqT9Nr143Jyp4YXECaONNT6ySfrO1qjK/C6GklDYZVpR6YX+JKx16B0Qu0rxrCHRlX8W0olAXuSV55owgF2RGe3Q2nFxITcZ/l3XLOtr6UvrtSYUNUWguo3GE2ppNZG4WX1SlfaLw+ESSh7Xjvf3sJxk1D4+Lq4K+OV8V2YRoVCIdmObH+Ct5G3SB1LmMtWcdmS+7knU3z5lsZQ/JxcsYS3jEUyYEi1nuoc6LOJ7ZPSURiag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772440967; c=relaxed/relaxed;
	bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f9DcB3Wl2zfrVPZn5sgqBoRcX2ZZomJBxctpF6BHuI5nNw/Du/ZPRRXNGmkYe8NSTA3zOyyWtvXwUBmjv5TGZ7cj21Ok+HBkaJ4bMUhdOHE22tZBYJuT3x98FoBfiMZiEwpQJzJE+xcY36c0lYExZfXIeFqguMEfyw5ySMSvbK6jdCQO6vduJSlZ1I59/3ULzI2Wb86KW27/M9wBArelqv5qwj5r5t36qt73OIU+bK7W6ou0SmH2avS0fUXe4Q4z+Y37imVgvP8/uttNAgWtpp7tOEDMbV/SbTmFT9YLPddCDNCCu77L/u2CFQFpqeBIuB50N8f29k4qRZxOHW2cVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=e2wS1ibg; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ah31G6bY; dkim-atps=neutral; spf=pass (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=e2wS1ibg;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ah31G6bY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPXWB5bldz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 19:42:46 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 018851380B26;
	Mon,  2 Mar 2026 03:42:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 03:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772440964;
	 x=1772448164; bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=; b=
	e2wS1ibg6RlMucGIXZl11U5siRG7DFGtm6bC+PvUNh0qFf4wfWBBXXJeTNHjGQPB
	7tkCZx/djVx6l8Ss53ZWAkChKLcYizXbkoeZuuCZl/13XFwOWZDPM4cDgVwb6keI
	To7Al8a+0zieDm3PfukQn3Qytc8yek3XV5o9zvRHIPRnBxwpeKsdwRCj55uGwY1w
	/askmm8A+N1GBD3FueEfC3XgGG+S68UYLr7HD04n6bsZuCTAkuD0pAe/WtVNk3TK
	JIwK2dPY3b4gouLDtUOu4wX4Dkuj/5xG1wx3ZUMdzV/Q3/0tYck4b35KMhYb7C2d
	W453iFmdh6RYeuvi5h5PMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772440964; x=
	1772448164; bh=/G/ZevRGGBg7KBKwoflwzGFQp2KlchdCPLCsl3Vk++A=; b=a
	h31G6bYCgDas6Z5wnLlsnt8YvsDHw2wxwEklZob0IRcCMqtrMS68u5Ho5/cp+GVA
	jDmmUOzh7wybdc0EVm9mZO0wBGwxw9pKRGZD5fUfx3vT+Mw/bKiAC113rtIo1rdB
	kZ8bRxLQx1Gm0raSyUdMRYtXrDQeQCjNsUijJBIbnNXw0FgL2xqqyXj1mjv85MlS
	veqi4GconvZYq+OZodgiE5rrmdDO4nFM2o2fgs7PmabKOpC4syv7vjt7u5qLBXnN
	S1jIA90Sq7XPHZTiLdmlTVzLAaXoptC/DndW80dX3jrMJu4bU4L/0aMiBxTv4PVm
	X4tT2TtTGQfwvhE0RaCfg==
X-ME-Sender: <xms:hE2ladcfH9f9_Zr-sx7Dx6LZlcocAKisa-XNrZxzm51PJqde9AHiSQ>
    <xme:hE2laWCMnjZhK8Hn5tEzVBiNF538-t8HL5tLyHfIW9RG7M5iu5qlgrHuI3T3VKU9c
    sFNv6h9DKAgGTVhLvxhDdjG-HFzxwamlMdS-RpvUJGbQ9Q2WKYRe60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgtph
    htthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgt
    phhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgvrh
    hohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hE2laVZq5YKB6OhbVzvQCRgWqbQSVDij-E-tlHIVbOfbeUE2GupkHg>
    <xmx:hE2laVmUMMQbmghaTN41BAhN-xukVfPXA6QwQJ6adig593UAc2esOA>
    <xmx:hE2laSEBsRubi0_AhFr6ENy4rDCDrKPXHTwlR85hHXsBNVnqYAV7Xw>
    <xmx:hE2laUh08LZUdmubbMhAM0FF3Vh_ouuQqvmSHlaV_H8NF6gUP9kfdQ>
    <xmx:hE2laSYGsbiwpNRuskHVP_Okhh0P19Msa_gddsDIxAAPYywdFpDfnAsP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D7A9700065; Mon,  2 Mar 2026 03:42:44 -0500 (EST)
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
X-ThreadId: AgePG58Eu4E-
Date: Mon, 02 Mar 2026 09:42:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "David Laight" <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <204f4051-4fdd-41c8-8bcd-cab7551474ea@app.fastmail.com>
In-Reply-To: 
 <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
Subject: Re: [PATCH v2 3/5] s390: Add -m64 to KBUILD_CPPFLAGS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026, at 08:58, Thomas Wei=C3=9Fschuh wrote:
> Some non-code files, like linkescripts, are preprocessed with the C
> preprocessor and make use of regular kernel headers.
> As -m64 is not passed to those preprocessor invocations this leads
> to an inconsistency between __BITS_PER_LONG and the C type 'long'.
> An upcoming consistency check will be tripped by this.
>
> Make sure -m64 is also defined for those preprocessing steps.
>
> As KBUILD_CPPFLAGS is inherited by both KBUILD_AFLAGS and KBUILD_CFLAG=
S,
> drop -m64 from these variables.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

