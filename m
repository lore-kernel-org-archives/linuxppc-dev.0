Return-Path: <linuxppc-dev+bounces-19712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3EAF34C63
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvYWm4XRhz2yvV;
	Tue, 14 Apr 2026 02:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776099508;
	cv=none; b=d0aLsNsFpPbASyKuMQtqMZkiOtzE07mXzYPaXe4Fu0uD1TgvG5ceHYwZFILdTIKoNd1NPF7GI7TleqQu+bMWoRvKTArBkxve6J0sGHs7FJiKpbovu0lFwSZ4jQc8UlfIGcuRnfSQSyesjR7Qw8m8QUQJxzloSahOVYRJE2U8aWvP4fyKUrA/DNSQcEfq5VbzHXmNHbl25opEHE9JqZrVZ2eVztzUD4FLXv6TUQgKW8r5q61opmUbi1ymwUYF16hixxuYCXMq9d6Itm5tsAuKDm6BGVHHa7fYlFRw2uR9cBbYV9Pdi7j3NRzzD56GdOC4rbpMTXKixFwXrUvHt9WzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776099508; c=relaxed/relaxed;
	bh=iXftkA/TtE/FAvx0eFBxkT/BsHoSgTPpPrjxa1Rt22Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RmtGZGeQi18qexmzZki4NTAZABTL8vzSmh0IJyw9iN/XuGBF7PKZRREl35TNhPoywonup8jetI9hQ01q+FBnvLoKTcodoiFMj60eCOB09uC+lrZVNck/kuBhkGGdsGvdHBzmZEr+Jd7xViT6akNr+wsLE8MQpo4mVlsLAwdNqok/0kwzxzM7H+63bmYGhlnD7aSGn9qSAeKnqEZpC9PRhQdSADEc3QutP6naUhZquicSKMdnPtD3/W8hL2yTbJ2MH/Ty1aqSlWs4MqbLVjjNtktFD60r4a2howj+6AFIEsyqDSsyOuOqIz/HhXq3cqSOnWkQ0I5RzrEqcuJbaFA4Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=dwbQA4rC; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lB+wNBtw; dkim-atps=neutral; spf=pass (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=dwbQA4rC;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lB+wNBtw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvYWh4WFfz2yvS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 02:58:23 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADD167A0225;
	Mon, 13 Apr 2026 12:58:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 12:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776099499;
	 x=1776185899; bh=iXftkA/TtE/FAvx0eFBxkT/BsHoSgTPpPrjxa1Rt22Y=; b=
	dwbQA4rCjG6+MaG2iXNI86l9LVJkOQ6HNR18FztjnIp9UiYjuEimlRUvuABkyaPI
	uFkio5XpeH2nIfp68QMFuOKRnCgAwnES0eGebxzPZ5JWXMUTkGFgWS5XE6s4kkBZ
	fIeKDGIrxabOikF/a+GxM0Dcz5b/VxrNtU6hU0xm6mQR8aXW1wKygv2mYxG8xPQU
	9tTq6cEQLFk84f61DOawvKr1vkwxBqdk85tx8yBHBnMDw3Dj/HbMkX0EPCrNBkPe
	XkAUGZu2ZZVwn/nisJ8UluJe6G2Oa51n6r1RgiALvccOTY0jQylzzKNd6RHsLwhv
	c3HpB4IIRaZTkmlkadtPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776099499; x=
	1776185899; bh=iXftkA/TtE/FAvx0eFBxkT/BsHoSgTPpPrjxa1Rt22Y=; b=l
	B+wNBtwPnjIN/R58PpGG/hOmAatu+iQo0p5KYrPi7cqaCha25sVxj0AGOj1SOOD/
	6WP+RGKq0FABllqvQ3QnlFUTOfJDiAONti962rNSGAgRvLayoSNkZkJ+qOlDKTUd
	sWg4oxdmbPIUhW+GfkDr3wJIV2X/6o88NEzC4HNjPD8pTLJxghPTTjeSeOfR8Rhj
	DD0BGCtDLY+BY4hXfB7RIOxfbfGnZdAOQ78qpHlX1E0oc68hd1qwXRygBv88tJpW
	R/7t1ERF1lR0CMh4ePn6X9LWffzeJmrsR0IcDawsgxP6gC46aUV3J++d5gTokxvS
	Fqq7d7Kvil/Z9wYAlWI4g==
X-ME-Sender: <xms:qSDdabxcXtGK7zn72oOTjQLLw_m0n-fpLvAlMFO_CdQGvah9ir58Vg>
    <xme:qSDdaeE3XU3VxacmZtpSzB7VX0eFTmTLuZVpvMhV1YFGIs7lHqAdeSj03Dl-s8Hq1
    ExABtmjWuowvgt99hbo3Mhs7FCQcefUQXxNHY6SuMD_edhE9Jnygg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhssghoghgvnh
    gusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopegtrghtrghlihhnrdhm
    rghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgrsh
    gtihhnohesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtg
    hpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhlvghr
    ohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:qSDdaavx47-MxifP9e0NgnW1DR20ZXqAKWkcKv1MxvffIm8cFkuzxg>
    <xmx:qSDdabAu41iLHMXHXIGROZ67HTuNFVHob8GAV_8Qq_wfxbXbP0n3kQ>
    <xmx:qSDdaVyd52wrfUMBrV9lrYFsmRklna0TfVm9aTbLJF8v9erm00lE5w>
    <xmx:qSDdaaKbH1FkC36VrqjRdLG_SQciQtaIRXLrkDuWWuH9TNnz1oocqA>
    <xmx:qyDdaQwn82ueHGh7hcir24sAx6Xr8S1xCeJkgWh7lkzUIwIF2T3Cagtw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEDE0700065; Mon, 13 Apr 2026 12:58:17 -0400 (EDT)
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
Date: Mon, 13 Apr 2026 18:57:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
Message-Id: <e9487ebe-3730-438a-9c23-e45f75986ecc@app.fastmail.com>
In-Reply-To: 
 <20260413180541-e13f374c-b990-4236-bc83-8fde948899df@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
 <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
 <03cd1e21-a2f2-46a1-a674-cbaef9712016@app.fastmail.com>
 <20260227103226-cc3bb32c-0107-4c09-b81a-ca33ea03ad5c@linutronix.de>
 <49b7c9f9-198a-49f7-880b-6ae74d7bd985@zytor.com>
 <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>
 <20260410091131-46b6354c-9d06-4e47-9345-ee224d8528f7@linutronix.de>
 <15925544-1ae5-406a-b9cc-af5935cc9f02@app.fastmail.com>
 <20260413180541-e13f374c-b990-4236-bc83-8fde948899df@linutronix.de>
Subject: Re: [PATCH 1/7] x86/vdso: Respect COMPAT_32BIT_TIME
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, at 18:13, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Apr 13, 2026 at 05:59:52PM +0200, Arnd Bergmann wrote:
>> On Fri, Apr 10, 2026, at 09:24, Thomas Wei=C3=9Fschuh wrote:
>
>> > * Always provide settimeofday(). If CONFIG_COMPAT_32BIT_TIME is *no=
t*
>> >   set, reject passing any 'tv' argument where it may not be y2038 s=
afe.
>>=20
>> This sounds wrong to me now: the case I'm worried about is a 32-bit
>> system calling settimeofday() based on the value of an RTC or NTP.
>> The idea of CONFIG_COMPAT_32BIT_TIME=3Dn is to catch this by causing
>> an intentional ENOSYS error even for valid times, so it doesn't
>> suddenly start breaking in 2038.
>
> This is what I meant with "where it *may*" be not y2038 safe.
> Even if the value fits, the call would be rejected.

Ok, that's fine then.

> My wording was crappy indeed, though.
>
> In code:
>
> if (tv && !IS_ENABLED(CONFIG_COMPAT_32BIT_TIME) && sizeof(tv->tv_sec) =
< 8) {
> 	pr_warn_once(...);
> 	return -EINVAL;
> }
>
> Or maybe drop the EINVAL but still emit a warning. That warning would =
be
> useful for gettimeofday(), too.

We discussed this during the original y2038 work and decided
at the time to not have those warnings for syscalls. We could
bring that back, but I think I would want one level of abstraction
there and control this using a global Kconfig switch for all
syscalls as well as ioctl commands that could use such a check.

     Arnd

