Return-Path: <linuxppc-dev+bounces-17368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B614EFD5310
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:46:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMhlN5tdBz2xLv;
	Fri, 27 Feb 2026 19:46:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772182016;
	cv=none; b=V5WT1ioBJydvUvlMXN0Kia636k9uw86vQXuQ819Ppwc/vMEXnvwtHR7aZYqvCeVit48kE309BxHizUvBiO1kxRWcJmwxJmyIMdhDxaMjDwCKpFwMLwO+SYqASndpa399RyAxkExS/rBO5s9Ed4FdTuDdgITk6nvZFRiTRMf8EZWs2Cf3pxgWypbNv2C6BbKXjMlMxYicl6gc9FyYh8vPS2DgZd8+lnp2ELG8YwJLZHul0uHBQBJ/F0/hNIOm+s4z2zE0knZEOaiuovm4QbYWMO3vgLUFy8OyO26VezAcKa1bvsx0sIJZqEFJJMz0HOEYFUua8A64QArKVgfoL7VOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772182016; c=relaxed/relaxed;
	bh=F+3BcJKrbmh5HDXIlppj+4J9SMA+tEFmqsXlBVhyu40=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cjyrF+2Z2czm+TeJsgfO1yw66T/0wcgZdEvGj6bLzGhkbPoew7ExYlUTDe/nBSh/ST1GPYqMixrwpq/SKVLwQHSEhUNE1ybhowCGtHfK4qr3KgecugN7gZcbyclfkUWjpA11giLuFJtBRuCXiwvO4YzcTEHECzGdK87lotI64p/q0yayAKxfmllt/6uYO88hDOFbR2yoRxgawKRghEYuV8D9GVmC/sYNOfzUoEvNYDNt6RLjdZHuR9pscaosrZZae3SZYbyctP9IB7MsFlU4Bl4lLDNgnFlGKA6wZ5wjEUuQC+A2709L4XF804a99ifKKSFyy6g8pZD5444o1bzFdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=cGvNnKUw; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vSr2hfZw; dkim-atps=neutral; spf=pass (client-ip=202.12.124.148; helo=fout-b5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=cGvNnKUw;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vSr2hfZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.148; helo=fout-b5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMhlJ3VVbz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:46:51 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 16B9E1D00147;
	Fri, 27 Feb 2026 03:46:47 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 03:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772182006;
	 x=1772268406; bh=F+3BcJKrbmh5HDXIlppj+4J9SMA+tEFmqsXlBVhyu40=; b=
	cGvNnKUwExIKhugmG3txxHJKsmYF7sQOwK4ZFPWd3YWKyXSMYAvngw9Kh8yQdsV8
	AzyyVFf3ZJcdrfJii3QFpJn/2gJOVgaDRD3Vq73CDw9t2oQ3Ga/2zZjtv1gSd3HI
	ikm/fHOfDFZAOro++75wFTe4TXopEGt6Uzr40J9TaubVGUlWRILEYPwTQsarfFfs
	MWORvyQObYvojwJtpyjFEsmedVxXnd6i74sxVm7nAZm4zKFJlT9e74xKTWLiw7Xp
	OIqbMV+sQqtJJDXEVW8Fa4mS29pFJyOtM1dShfUT5S1f553juzm0b3MB16EDRJTl
	nDSSC0lC42tekS3HS1soCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772182006; x=
	1772268406; bh=F+3BcJKrbmh5HDXIlppj+4J9SMA+tEFmqsXlBVhyu40=; b=v
	Sr2hfZw59Q8neZEcZ8v0I4dpVvdYjE/ofJV6gLELXY95W7UWgeb3aYrG2jUz3xpA
	wfpNl480fLte+YUDJ1QkekZGDlAUxwIqPKIetIbwpPD7HDTf7YGdbJEzLuFw5+e+
	UKJUmors6vDjbFQEve6ArLpuosycSVZl3HjGmuv0EQyCReWVsdV+YEl1n4KyTRSo
	eu5MRRfvy+K6g3sPPzjgqCtPPDiDg9YPmXbsekks8rWFjIrlcN+FS2Xb6YzFz7La
	ltqrX9F6WlzcP2WWoCSA/nf3C+GL3euJBrjiQZFzHqVv9rciY3gwrpt+2KpoAj6O
	OFVWk5sTPkhZ5X7+XnOXw==
X-ME-Sender: <xms:9FmhaQEMS6SVdcYdRZgW_kT1IO55F7UdfwskkFSJwNwPf3pQgqLR6g>
    <xme:9FmhaULWNyvqb-9if6HIEi9E8dBdfdgEeviL-8RAECb2NrSySW54U97ZesSYhui-x
    uBcI8h4j4xdxAtC9YJSYwM8ZL49_0HB9Z0aG4ob1JSwJbs9H2wE_PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9FmhaTgeJf8JakorKAw7334pjkusPDME-O6xuYJGuiYYBToV_lIUMg>
    <xmx:9FmhabnUpS3zRA3x5jyvpdBF6zC2epEpxNq0b5cSVGVkIA5Dadq6kA>
    <xmx:9FmhaTFlQMPBza8GR8LZ5S1Fpbf-o-agGmzpPeS8JMDHtESMO1MRCg>
    <xmx:9FmhaVMP0saCF9AaIT-zzAYDh428TuJ-YSKQomKcDsIyI56PeTlk8g>
    <xmx:9lmhabF0NvNVXamTn40LHRKq3s_HXqsl0SmilA9rziUipV6RkGmWh2P5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C38D700065; Fri, 27 Feb 2026 03:46:44 -0500 (EST)
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
X-ThreadId: AC9z6Mxcl7jk
Date: Fri, 27 Feb 2026 09:46:23 +0100
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
Message-Id: <7fb5b531-2d78-409f-8f65-e12757f9296e@app.fastmail.com>
In-Reply-To: 
 <20260227-vdso-compat_32bit_time-v1-5-3f0286a7bac3@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-5-3f0286a7bac3@linutronix.de>
Subject: Re: [PATCH 5/7] MIPS: VDSO: Drop kconfig MIPS_CLOCK_VSYSCALL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, at 07:57, Thomas Wei=C3=9Fschuh wrote:
> This configuration option exists so "that we don't provide the symbol
> when there's no possibility of there being a usable clocksource".
> However it only covers __vdso_gettimeofday() and none of the other vDSO
> functions which should be affected by the same circumstances.
> As these are more widely used than gettimeofday() and nobody seems to
> have had an issue with them so far, drop MIPS_CLOCK_VSYSCALL completel=
y.
>
> The removal of the ifdeffery will also make some upcomming changes
> easier to read.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

The #ifdef was originally been added in commit 7d2aa4bb90f5 ("mips:
Fix gettimeofday() in the vdso library") as a bug fix. This may not
have been the correct fix because I don't see how it addressed the
case of a kernel with MIPS_CLOCK_VSYSCALL enabled running on a
CPU without the timer registers, but I think we should try to make
sure that there is no regression from reverting it now.

> -config MIPS_CLOCK_VSYSCALL
> -	def_bool CSRC_R4K || CLKSRC_MIPS_GIC
> -

An easy alternative might be to drop the entire VDSO in
configurations that turn off the gettimeofday vsyscall today:

diff --git a/arch/mips/vdso/Kconfig b/arch/mips/vdso/Kconfig
index 70140248da72..4f6fba9e108f 100644
--- a/arch/mips/vdso/Kconfig
+++ b/arch/mips/vdso/Kconfig
@@ -3,4 +3,4 @@
 # the lack of relocations. As such, we disable the VDSO for microMIPS b=
uilds.
=20
 config MIPS_DISABLE_VDSO
-	def_bool CPU_MICROMIPS
+	def_bool CPU_MICROMIPS || !(CSRC_R4K || CLKSRC_MIPS_GIC)


    Arnd

