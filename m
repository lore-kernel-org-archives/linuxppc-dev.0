Return-Path: <linuxppc-dev+bounces-18636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7804AF483DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 17:59:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffgsY0HhCz2yWK;
	Tue, 24 Mar 2026 04:59:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774288752;
	cv=none; b=D4NvZEB8MbXo5n3wSjY8ynq51pgw6TGSY/WEs4diZoAlMVunCKMTCdKxk5ejXqXu1etywTz0hvyhyY8KwcN/OMngxudOgxuUipMHDDgnq16BmEpeci9UKBHIEvXaI9+mows9aRO+3XcprpBE3kUBVtGpSTK/wnJdfsonf7H3FMq77k3MoBfcs1JeeMKFalby38MefhknRxgarX1dNy2nQdpX06aSS5xVSnJNlEN+qSc980suIFooaR0CQ7dLgluKOieKpu86viV2ZeKretyDPurz7NnCLhpdifm0CxNPA2tLQN1rArgu20jiBjYkxTUCN3PzT8E7KZW3Vs1g+Dvenw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774288752; c=relaxed/relaxed;
	bh=9//ngg5kruKbTXJVMtBYvuO2Yyk5sA4yoS9uHWcYrNw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W+xrZ+Q+cNgWwT8FxDx8gL49ZMWYfdZoSSbpcrh0H65OdQgDjjf/AqNqFduQkkEFF09tszrihHZp46sOxYAJFCgmDHh2v/RX4WsurqePGsUv+cpAnAYAI5eb2aOzIH0fyIa7r4SJ6L42qaEIeBuyquDKFIGTSUtSwUTW/+iW1JXAJl0O1Ynu+TYF6N0ix4LKs7Chu/6+0p/RhcZ50tv8S+0AZ8slHtaHvFPbCjteDMZ8pAM7fBaEW67VHmymh5muDeb5F4LwFINjSiNsL+byg7+vFZ/YqpeuL9HNLADmOJBLi+Al8e9xxtsGxRGUYtBfd7fhKeR0U24vq3In4XHYeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=rb8gdWzQ; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=opOP0Cn4; dkim-atps=neutral; spf=pass (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=rb8gdWzQ;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=opOP0Cn4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffgsT5bBnz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 04:59:08 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E716D14001FA;
	Mon, 23 Mar 2026 13:59:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 13:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774288745;
	 x=1774375145; bh=9//ngg5kruKbTXJVMtBYvuO2Yyk5sA4yoS9uHWcYrNw=; b=
	rb8gdWzQVB5tVaNMZwPuConUKvmU822ggoi5oYQm0vM0a02VJp5nSwpsad+tRnpK
	/miIFh0la18u/BMLyobqy5Ud+kw3bjiAfMZH8gjDnpC2GVZcjGhA3xNIWySICxX0
	LHCCgvQBXvmPjT0p5ShIrS2s6Syl07Dn625JBa0re8YmE6S0LURYtqXMmVo1oKuj
	Htjw5XmqmWpc41JQPd9oiJxlGfqDSWz5rPpfXGSUMwVB4SPJHMjxPyIkXFpAuhIi
	j62XN71hM16XUKF/7qYQpvIkllJdvBJ/KNTHNKEdUAS3i0aIys2U5thsaN2H2ywn
	8DezqVbSfaqH3jIaQ3dFyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774288745; x=
	1774375145; bh=9//ngg5kruKbTXJVMtBYvuO2Yyk5sA4yoS9uHWcYrNw=; b=o
	pOP0Cn4bvlSZuEaksJvdfg05x8HVkeAyEz0y29TJh18EQ2KQdTHlwKJlSMRKJWqN
	IPAmAeIHRZXSNTj6DCtyV4qnqXz5eFoE2qXYePxvPB/zjsk9amuY+hCi1j39q1u4
	IyfBuY3rVWXagnh1+zAAHSvOYmsq25vCmWu/RNEOYGN8GCzAMuTjxLqogv3BYePG
	ejCXMYnnd+fHyDDZTGKaWp6hHOfc/2ARVmIayFYokNGvIjnRQ4ODPoum8z0xGiX9
	JecXlCWzcKi13GcD6iPg2DvKeq1xqZyxlU9nrpXIW5znZng9UJf0rdpXxFfP7upe
	d17voTdmfLIKJatMgWLMg==
X-ME-Sender: <xms:aX_BaZtlt5TvwsgmuXNStxRb4wvwoAPnYiApLGAKgVQwgxJic-BTKA>
    <xme:aX_BadRY0gcV1cpIAtgpC9xTrolETBK875HgJOcOSlOD7167i2ykkMAb3VZv5Il7r
    fcMLo4lzuarkkmF7fzTuBIYi9h8IlsOtaVRRu2ZErRpfXa7mfYxAHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegthhhlvghrohihsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhstg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthgrmhhirhgusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aX_BaelCqb8kBDifuG9xZCCkolGtkjL57aUvhwlx2PrTq44MWS3DQg>
    <xmx:aX_BaQisoIx-yth0qKcTpXtesnC_IwxK7D1gSOA2n3ynjitJhzxRXQ>
    <xmx:aX_BaTQiGM-2boqCwl-kMf25dz8QWvNoL5qnuEKsWrn-Wwe2HZaHDw>
    <xmx:aX_BadjjGRmY6WBMtQbWCvxirw6Iktw96dlR0nOzNK_FmOiK5XkuPw>
    <xmx:aX_Bad3IPYan2AFPPeAdLSNcEZEzppxnYv0gOD7JjIK_M2Xn4u74tsQG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83BEB700065; Mon, 23 Mar 2026 13:59:05 -0400 (EDT)
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
X-ThreadId: AKWsChL5O-hF
Date: Mon, 23 Mar 2026 18:58:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <chleroy@kernel.org>,
 "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, tamird@kernel.org,
 "Steven Rostedt" <rostedt@goodmis.org>, ihor.solodrai@linux.dev,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Message-Id: <00d4c865-3068-4f98-a32f-e9565cf1499d@app.fastmail.com>
In-Reply-To: <e6db8617-6b12-4f90-967d-85c9f7805823@kernel.org>
References: <20260323073220.25798-1-venkat88@linux.ibm.com>
 <e6db8617-6b12-4f90-967d-85c9f7805823@kernel.org>
Subject: Re: [PATCH v2] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable
 warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026, at 11:14, Christophe Leroy (CS GROUP) wrote:
> Le 23/03/2026 =C3=A0 08:32, Venkat Rao Bagalkote a =C3=A9crit=C2=A0:
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..2fd744bf9093 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -308,8 +308,10 @@ static long nvram_misc_ioctl(struct file *file,=20
> unsigned int cmd,
>   		}
>   #endif
>   		break;
> -#ifdef CONFIG_PPC32
>   	case IOC_NVRAM_SYNC:
> +		if (IS_ENABLED(CONFIG_PPC64))
> +			break;
> +
>   		if (ppc_md.nvram_sync !=3D NULL) {
>   			mutex_lock(&nvram_mutex);
>   			ppc_md.nvram_sync();

Right, this works as well, though I still like the idea better
of removing the mutex and all its callers, leaving the locking
to be done inside of the individual operations, as they all
do.

     Arnd

