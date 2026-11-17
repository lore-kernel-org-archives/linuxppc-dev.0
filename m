Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48537606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY+cEPzz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTLMs00xbz2xly;
	Tue, 17 Nov 2026 21:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794910824;
	cv=none; b=Lp/xE5N+wFiNfb1ACxYUh8BUl6aH9zwUN5eraBlm7XhwBI3UOTro6h9FSJzQucvci9hXP1KWBWH5GOYRssFzL4o4pv1hSEALz13Sa28/1qEKfiZtFRncezqtdlnRRA/pNqjAdsxk8Zjj8vB1/HINGd0ODpotaSosJIYpIgrrn/x9v3MZv7LcWifUPxq5LiY4x7hk8K/+dg7ZWldDN7f2yvceh9mXskowZjF6C2U1SigaP57iVV0W8qEeMjyHl40rKIDMIPS+AmDP+Du+o1q9Vg7UT1R0tSniuMjRDzfquz2XNpjuFlSLGUqiRGGkD3Yu8erPKQGscv+2/00Gcl+SoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794910824; c=relaxed/relaxed;
	bh=LYjA64OY7mzK30+EmXCloZ1d2MnMctrR1lEa4XYe6Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQM/YguqOdRkVixD5B04Zu33p8Lz1YG/LZDp58XUY84AuRW4vC4zTkL+pYRQ5BJhLCU9nvxUPlI5tNZcYviRrhDNebG6waEACrMHhXDfFCL/oIIYs9lB7cpWcnNKu5B3XNzbrYMKAyMHJQmHNJZBPNhGERrlwjOA0SDuVzhSYef7tez3dOQ8TuPs2iCy16VLrrbJ+NfNPan+PvR7kQ7BR8Phkgx9GONv0hq6qf4vCa/y3UEktUbxbLBpHJm8K6lyqvgiog8Soemei6QH+rDEfv+gRIOLcGJ6NYk3df0NtOf7UG950IkbjZmYjCDBHbUAZTtK9BWPjFMfAa/AgWPUXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY+cEPzz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY+cEPzz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTLMr1LCGz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 21:20:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D97862C51
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D661F000C7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910821;
	bh=LYjA64OY7mzK30+EmXCloZ1d2MnMctrR1lEa4XYe6Og=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VY+cEPzzOeQl350iSplr3YTbz/NtmEMKg6hNuwMjP304qeTNTNVYjYn69bfPeDIrr
	 lS7RhvYXF4dCg9CZ8zAIS1K9t+Ts2W6/CwaJXt+xpLSgkZ0KkEjPZXcp/4WYY1aOjX
	 KgvvCBalfuTh7MDTCxX/lqDxO0eqA51GFCKXPRmVhjH860W+HS8ZWHfZiUv4Pdg1Ot
	 NCKtr9f/uT0p7JoxmLwfDWgnAn25r4zqaX1A+yEahv/mz5de0wAQrWh37dAKryhSDf
	 cNDA/Jg4XwFcxwYpEWDh98BL5zveMpdl6T3nP6EeJ1kkzMzwF5iA0j/fkoFcXeZHyS
	 WTgYOuBxjFWFA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so4417985e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 02:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG9DcefpmJLsV/Mjsokmr6TsPTZCNSX1jkn8DsofEvutfKsGhi8XlOVzQGRAk9u8us1Nh1eZULuzYsfuzo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8T3UA5tc9pJIT/kHxGyaBy878cr6Qk/HB7hBzNS9IcQNJMMCOW
	ZOSUTlkoSv2YTwlD2sPT4l5vt7eS42ijGIBkQnI45ptCFD0JbNp4+zkDLzgAj30kV5fiGwuaUyJ
	Xz5/mgBFS0AUULpdw4QOxwqnrITiT9/A=
X-Received: by 2002:a05:6512:3c89:b0:5c1:57d3:efd0 with SMTP id
 2adb3069b0e04-5c170b45aa9mr4736734e87.35.1794910819929; Tue, 17 Nov 2026
 02:20:19 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-4-3aad0860b984@free.fr>
 <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com> <au9YgytCc4TKfETI@l3017727.home>
In-Reply-To: <au9YgytCc4TKfETI@l3017727.home>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 11:20:05 +0100
X-Gmail-Original-Message-ID: <CAD++jLnWcVDbh-vf20w4nfvOSZik619XqoEjXTBZ29sJkX-bCQ@mail.gmail.com>
X-Gm-Features: Aa3M54rAvJrdH2ioBjmTcd53sA32PoIoppu6eV1QG1zyBMjvlTxU-cDEh9WFtc0
Message-ID: <CAD++jLnWcVDbh-vf20w4nfvOSZik619XqoEjXTBZ29sJkX-bCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux driver
To: Vincent Jardin <vjardin@free.fr>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 5:58=E2=80=AFPM Vincent Jardin <vjardin@free.fr> wro=
te:

> > Can this be applied separately once reviewed?
>
> I do not see how: this 4th patch needs fsl_guts_rcw_read(), and
> few other fsl_guts_*() which are from the patch 3.

OK

> Could an ack of Christophe Leroy be enough on patch 3 to 1...4 could land=
 into the pinctrl tree ?
> Then, patch 5 could be managed apart.

OK let's try to do it like that.

Yours,
Linus Walleij

