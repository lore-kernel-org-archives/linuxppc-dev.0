Return-Path: <linuxppc-dev+bounces-17369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C181FD5310
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:50:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMhq93kN8z2xLv;
	Fri, 27 Feb 2026 19:50:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772182213;
	cv=none; b=FpSEdFs8aADzxQCyXqojO5bEEv5qyRHVUtqlrQYSXUtwAPI5qbttlUl+ObEs0/wdjDvy6fkgBaeSXK0+O9Q5hPc4dpt+zUFu2DkrysJ4rZKgobatFX0VqOSqcSOeYtjwdfjLqKF3jSiB01uFp/YSOTSZNA6+EfzPYfMJrmYOhpGaAmmtC4XLcg0X+oiyxSQDwGrus9/wcUmP4p3XeSZjOAPlDPDLioAPx4b3BycG36o4NkzkdqbhKtw3ATVUi+OyfnOilIN5Os0YdHy1/p4dEptJYZ2SuKaDj51ar2LyCBiNwj9tlIgEXAoKYAPFtA5bqjnB0r4Wm0UiMH8Mg5XXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772182213; c=relaxed/relaxed;
	bh=xwefPv2uVlZj1+2rN1oX1U6/y4L5neteDEWAT3K3DU0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M5WjWzXYFy4FKdpt3grjKu4jQIDLLFoH4cgZ92WeFPBGmINesSFAnFXd3jQteLov7n0F5uKQhVxgIwTImYvM8Y0OyO9ZzBMesgM4uO3bNG6PVPu2wo00bY3Rp1a2ysGy54r+Gl0VV5+KQ0aOEleRdDX8uCYFKpNtSZpvnUp+DIP6Oh4hj/+ebcMErfN5HCn0WZKNw/jTcuWvx5bAW2sTZcag/0pw7RZDeLwppVPbzuGfresXy1Xa9l1n3oYK5UfeFsDGAf1nn+qhymCl9k8nnhimGu+Hfdnxs0Oyy1hzZ0S4wDiQdTGdvWutJwWs8uV65Aa0Q0vUZM14RsQWGpeVdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=CpQkqgYf; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ya59htWC; dkim-atps=neutral; spf=pass (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=CpQkqgYf;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ya59htWC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMhq86Sk5z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:50:12 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDEA77A006C;
	Fri, 27 Feb 2026 03:50:09 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 03:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772182209;
	 x=1772268609; bh=xwefPv2uVlZj1+2rN1oX1U6/y4L5neteDEWAT3K3DU0=; b=
	CpQkqgYfKds40olKRxYLSKAiGe5Rmy/9BCh5Z7MPXPxZ5F9LkngTRdlArkVNRjl8
	7ZqGnCIKRmMyrZJeCBiLf4/HN2UwaqtGzYvz33ugvRadhG1Ukrmp9gQIHnpcxj2z
	4tWE0307vhEYdklvnh8Hp2KUVlCY1Kc6fUscg6oVc4PMeNbnjdT+Jw4IKQ5SIwGf
	A0XFJqGIxJV+b9Pw1NfRhTq32a56fOkq43bvOQgPrBhd+4BNZGnpTo63/4pVj+X3
	ziLnwuOGm/2TpCZHvvuD3JP8kb36KC7Oxq5r8aLFdoVFMaA29W4RRCcbbb9lHQNC
	z9UDShjAp+mcTUCLvFglqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772182209; x=
	1772268609; bh=xwefPv2uVlZj1+2rN1oX1U6/y4L5neteDEWAT3K3DU0=; b=Y
	a59htWC7mo5ur5Ru4AgAGJLqF9zIgIxnBpDFt5UgHdLUD8RPtbpyt3V3Nt80/SK1
	k1hirZHj7G2q9sY4pZHUbqslH90QY8FE6DUnSY2L43FKyo0yHdaX1R+i9qRbdueL
	oL5yGYKXrCmJmqN9TiNymHUKYlqr4aejj6YWngHGjFwY1NTAMsVN2i5jFim4J+HC
	jCNbCrQQqButTpG/aSIHiFGyg7L7CdSE0663rkLBd0WsuSZ5mk9mfHw6i39ZWAyk
	Il+1PcbDoIlUFKKriY3O+5tFM3Eh7mCjfOS6/3ejj2OtGerRvi9WC0OxavVSe0pz
	8M9CQwwTcyQnTocXUICqA==
X-ME-Sender: <xms:wVqhacI1rkOi6xw-07DwQDbocsXu_hDWjrP2hK5KGSJsQn4jHH6Gog>
    <xme:wVqhaW8D4Pu5jKC7Qcu7NwRD1ra8Pw5CMbd0Q6E6L46abVMVGzPr63Yj3dB8PfSR5
    QMVPd3tdG80nQ3287dbrTxU2-um9ej7tIYsHfo_fg3gtluKACfkysiP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtshgsohhgvg
    hnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptggrthgrlhhinhdr
    mhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrg
    hstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhig
    rdhorhhgrdhukhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprh
    gtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgv
    rhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:wVqhaaHGvD1Eiphu0UQvGUsq8vY3JJvW3HPTel60R0guHhN6xnR5Rw>
    <xmx:wVqhaW7fUmT6ZYnp_qtntaBRP9PPVqGSyZrlJMiGqJqhTltRN6xefA>
    <xmx:wVqhaUKSaFcKmvsheEHP93T2yCFnay2qeiSgMOXt0_B0uhzNXAAM5w>
    <xmx:wVqhaZCFFj7dMt-LHLYVuTBmp18q048sjfw7koAKvPBMhqTeSHu69A>
    <xmx:wVqhaVIB3264bON7NJGum-trK_DULEFvHVCsrGVbwK02X2Xrf1p4BHQc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6ED33700065; Fri, 27 Feb 2026 03:50:09 -0500 (EST)
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
X-ThreadId: AULtxbNmleaw
Date: Fri, 27 Feb 2026 09:49:49 +0100
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
Message-Id: <0b12efc9-0c3f-4a4a-b6fc-0e5c9a6d2cde@app.fastmail.com>
In-Reply-To: 
 <20260227-vdso-compat_32bit_time-v1-7-3f0286a7bac3@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-7-3f0286a7bac3@linutronix.de>
Subject: Re: [PATCH 7/7] vdso/gettimeofday: Verify COMPAT_32BIT_TIME interactions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, at 07:57, Thomas Wei=C3=9Fschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality.
>
> Add some build-time validations to make sure the architecture-specific
> glue satisfies this requirement.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Good idea

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

