Return-Path: <linuxppc-dev+bounces-17370-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF029FD5310
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:52:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMhsF3y6Pz2xLv;
	Fri, 27 Feb 2026 19:52:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772182321;
	cv=none; b=lxdxn4W8Qzd6iyKxQB8H1IpjmFCf8caDl9CKYfV+dqo/334ysN3CecWwVJ8bOudr4nD0I/CDdW1sn6GGrL6/iaVHoET4Mqj5hUNIboQVhhBTF3N90utWGCmD1ZfDtdfKMs4LBjg1KZDOZWuMYPs7yWUh2u19sQTeE8gyGCxcELErHEQ+Wae1Qovcvun1xZFZSgo/9RmfV/3jqq+xfM3LoodAWiUVlPybqyzDcozACfVnhVMP1Osn/4wCnCeDbinWiYJju/xPLgUtlhUiyruZggP2rQzN1/lbe9P+dpHA8OA0PImBl0zj5Oz5wcpgLRUrE94U8hmth139DZHf6w0D9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772182321; c=relaxed/relaxed;
	bh=+KCsio2wrHwIiV5/dMoK3Tw/3j2a8KEfcABD565rOG4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LNj55rr1+R5dTMyEg8ZUBbI+x0g+Ebg9YFwHOFehzi1j7h7h9BCMgQ1iu2DqR1mfLI0A4UsKzU+66KP+TLTVYuzlZDwuCXxZxoyCO0dRtgIuhJGRsVUBPgZUO5FZJQedIbJMjsfTvnYQjqWwKKk1I+9mgwBQHP4/eAPAIimwBCQ8T0FSlUXtIeWoVpj9e01S0zdQuleKYPSMaQ/foMlmp9ZtWkQFYTVmcgeoErldYxVixUbmRIJZe7ynCaxtRMIclSFIeMOVbF1rYjnzjGpGHeujpymDDq+X2g2czaM2Gp+AmallOCAvC1TVU0yLzr4ycx1clzNdn4XqhufOsHOmiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Blq25ZTI; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JGOXmZzM; dkim-atps=neutral; spf=pass (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Blq25ZTI;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JGOXmZzM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMhsD5j9pz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:52:00 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B193B7A0090;
	Fri, 27 Feb 2026 03:51:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 03:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772182318;
	 x=1772268718; bh=+KCsio2wrHwIiV5/dMoK3Tw/3j2a8KEfcABD565rOG4=; b=
	Blq25ZTIr2oecLSxKNEUueJHjo4Evtx26CAq9L8MjT0z2zDKnwTIxAIj/Zu5djrd
	7qzXiXqL/PwjOp5EfNRC8OPb34ozFWwrtdfMyw1HboBSWlZfa9EEhfdDoSm6aBKQ
	VGoZUgtcBIFNI61PU7/lbEe+C75i5BAGouT1SL+9PDRH1LhPxwTVTZjOtEBCWYWe
	nnlXz6pqvrBQvkr2UQxUiL7NIlzwXbsSAI6ceOjzrd1PeFQ775FgObKnWtcxVPSN
	6aOTxej5pe9OSwP+/TqZJT4k3hejBMbsYW8iXX8fXFR58C9gniRSbZAoUiqXoaMZ
	nxrLJPWqZBZoZ/VVr3MNcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772182318; x=
	1772268718; bh=+KCsio2wrHwIiV5/dMoK3Tw/3j2a8KEfcABD565rOG4=; b=J
	GOXmZzMJnGKWMmUc0ue+u2pXOBIrYTmAxLuSpTsDuTA5n+4c/vPWyCj15FGwcRVK
	0fkFIm6TdWSW3J7Nn0U9/1Z2eTnPTMgxfIpBU6Ul6Mybmo0ZOpuUoqoXzqkLFO76
	13lDWTgKrLRbY2anDPqF1c8UO1H3I+sgEXDTXTjMCVg7G7fFfDWQNNYFyIc+4ST/
	+l6aNHJ1K6YEyzCd19lv7Ov8bpTEojUBLObCB4Jb3/vYDuTPbyNnKxXYyQxabwbK
	rwcWaGKjkbdZa54IgyKm0QuDgPq5L8lZorSgZ5UUzU1QXmpef0pXIhRE9VC2G4jz
	BUeuwyKS/6B4Zl91OHsxQ==
X-ME-Sender: <xms:LluhaSAzAZPE6KRpH-aznGnF-edp0VO-ppRwUVRjiDU_PLNE5eifNw>
    <xme:LluhaXVYgGg7XgYWCfF-hlJ8ZwLAiAe7nZuMDZj6Q6diFbueVzkr-FShp7OpwZj4_
    OGHjawiQzyyZPvBUw2XeIV1qQBo18Uem0bu1iyHO03nIT4-gCKjs44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtshgsohhgvg
    hnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptggrthgrlhhinhdr
    mhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrg
    hstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhig
    rdhorhhgrdhukhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprh
    gtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgv
    rhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:Lluhaa_Z-NYZFJU8JxieTGZ8X3mA1PQy2-Wi-UNa4EOIGcjh0y3j-A>
    <xmx:LluhaWSQ7VCUZ699wMGLPT878vS4RJq1aVEnB16IRyXAvSX5DB0rsQ>
    <xmx:LluhaQDvCoc1WHlNRQytR8CUzFe0vNQ5VFFCAmDi1T64p4zRiMCv7g>
    <xmx:LluhaXa2sqhlcTFagSv8ygCNJkXiUVnmn1YeXZkzLMSw8yQbGYA5lg>
    <xmx:LluhafC83NJGThoiRMmADNRyjJkNd33U8dE4gx47yWse_NbXWivPWLf4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B969700065; Fri, 27 Feb 2026 03:51:58 -0500 (EST)
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
X-ThreadId: ARwL1vy566MZ
Date: Fri, 27 Feb 2026 09:51:37 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
Message-Id: <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
In-Reply-To: 
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
Subject: Re: [PATCH 1/7] x86/vdso: Respect COMPAT_32BIT_TIME
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, at 07:57, Thomas Wei=C3=9Fschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality. This is the intended
> effect of the kconfig option and also the fallback system calls would
> also not be implemented.
>
> Currently the kconfig option does not affect the gettimeofday() syscal=
l,
> so also keep that in the vDSO.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

