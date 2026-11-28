Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=eP7Aqklo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbyx058CLz2y97;
	Sat, 28 Nov 2026 16:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=109.224.244.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795837872;
	cv=none; b=mHOxmo9LA1NPVEToM37csTf9SbwcIKXz8hKdwe1GoxcscqZUzUVFPNZlzlPVoyzMRY3v1O9W/8XEX2c0ARxOU6hX92YkogJKjfR8aVWDzfvUc9gqF+6QQpcE/1mkJ+vVe4FU+L/In8nWWFdpLkbz5HviL6cumcpeGrNF2EgGBTQbfHyEVXI+67MRZKeXu4rNqLJnaEymU7lv0dO0GbMe8Cw/DCoknYhxjWqEaGjIj5YgK6LwhD41gklnvLZJKcuicGKjOJA9eJHXN5DrAdqZCdzDLff5IqzSrEotzC9deeYl01zywyDTwsD7YPd3KiB1D0kOOI2E3a/5a9c+9laxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795837872; c=relaxed/relaxed;
	bh=izHP/C9NAuemLVsJ9g8YC454Fc8reNwACxwd8cLNkco=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjkNaB0/2NSaQxGdtySPOafmF9KdjJa6bl8TjUv744mIzRS4SNnPOAA4ZHY+YGbtHFhU/Mb/z042TT+1YQpJtPkpZlVxehQqyW2smd7eDJOp24S/Sq+4B3QyAHi0ICuUSuiUDb/vPNKhiAGSHhcRjHCIyD9vJsv7rKs8VGO+P4oL5FBHt29F/mL4CiIiIYqV5B0oQgPNMoizhAnKoFMrMW+b3nQy2LDXYmZzbdYiZ3gdf290FrgUjZS+4bQejE7L/YxAPQqLFyPrLzDsMw7b6Cy98iUrIPXwZVsWsFn8OyHwmvyMNkBkOry591WGxRa2IGhFA5cOUT9gpOXBmfgSVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=eP7Aqklo; dkim-atps=neutral; spf=pass (client-ip=109.224.244.28; helo=mail-24428.protonmail.ch; envelope-from=tomgrzybow@protonmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=protonmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=eP7Aqklo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=protonmail.com (client-ip=109.224.244.28; helo=mail-24428.protonmail.ch; envelope-from=tomgrzybow@protonmail.com; receiver=lists.ozlabs.org)
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbxCf3Mgtz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 14:51:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795837860; x=1796097060;
	bh=izHP/C9NAuemLVsJ9g8YC454Fc8reNwACxwd8cLNkco=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eP7AqkloBx33u1Agsi+4tJN900omtCR/flEW0QRuHdCk2oebkXt3Ea9WFgc9Ir336
	 5QWLMmVqlQlY9bxyDHPb3C+2Mlk4rNNHyHSicLHIZuSVrZb6/rDb4uyPSMvR6ctLSp
	 iAZxW6gegsvwh/dbabFuE6Nvg79CqCDFoyfl+QvpQG9vf/+fP4qNJnVpVcC/FaN1Ym
	 9tEmFnFoNQ+1+IDbOmFpP/go6DCx86jRg+jPdCuXxGQZYbqAN6bD2QW7B0Rygv5Fz0
	 xnFx1hugtKu146806uVXccnZyisHrFH4QYpJrMCdQv0BWrg+g8QkpdnZ1mHkLnO7j4
	 VYK6oHD1L1vlg==
Date: Sat, 28 Nov 2026 03:50:54 +0000
To: Dan Whitehouse <drw@dim-sum.org>
From: Thomas Grzybowski <tomgrzybow@protonmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, debian-powerpc <debian-powerpc@lists.debian.org>, gentoo-powerpc <gentoo-powerpc@lists.gentoo.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Should the community reconsider their efforts on PowerPC?
Message-ID: <5HJPHLEATDG843styfhcwgdprq49njzb8oUg3r2TrzD6FP0G-4j-GCi50HWN4xFE1WywTkebXjn-2xmyao1N7AVCc17_S7w2YbaPTBuXCQE=@protonmail.com>
In-Reply-To: <86799B87-DFD3-44F3-8A04-00972FBADF9C@dim-sum.org>
References: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de> <86799B87-DFD3-44F3-8A04-00972FBADF9C@dim-sum.org>
Feedback-ID: 8225560:user:proton
X-Pm-Message-ID: 02f92fe74abb81069d914596927c002b1f7ad1b2
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I would like to suggest that we put together a PowerPC release which largel=
y works, and simply support that static release, ad infinitum.


Thomas Grzybowski

Sent with Proton Mail secure email.

On Thursday, November 26th, 2026 at 11:21 PM, Dan Whitehouse <drw@dim-sum.o=
rg> wrote:

> Adrian,
> Before I write anything else on this subject I would like you to know tha=
t I=E2=80=99m extremely grateful for your efforts.
> I cannot possibly express how much I appreciate the hard work you have pu=
t in to not only the PPC ports, but all the work you do not only for the De=
bian project, but also free software in general.
> Selfishly I would like you to continue working on PPC however I=E2=80=
=99ve witnessed things like kvm-pr wither on the vine and seen Red Hat depr=
ecate kvm on IBM=E2=80=99s PPC platforms.
>=20
> To make a long story short, speaking selfishly, I would answer your quest=
ion with a resounding =E2=80=9CNO!=E2=80=9D. However, that doesn=E2=80=
=99t mean that I don=E2=80=99t (at some level) understand the challenges yo=
u face and would not understand if you decided to call it a day.
> If it=E2=80=99s not fun anymore and is more trouble than its worth, I won=
=E2=80=99t begrudge you putting it to bed. I=E2=80=99ll still be appreciati=
ve of all the work you have done and I won=E2=80=99=E2=80=99t begrudge you =
spending your efforts on other ports.
>=20
> Thanks again,
>=20
> Dan
>=20
>=20
> > On 26 Nov 2026, at 21:04, John Paul Adrian Glaubitz <glaubitz@physik.fu=
-berlin.de> wrote:
> >
> > Hello,
> >
> > as some of you may know, IBM has been pushing to deprecate any PowerPC
> > platforms that they aren't earning money with anymore. This includes
> > mainly POWER platforms before POWER8 and big-endian PowerPC.
> >
> > Recently, IBM engineers have remove JIT support in OpenJDK after sendin=
g
> > an email for feedback to a non-public, unmonitored Debian email address=
 [1].
> >
> > Since IBM engineers have also killed off support for big-endian PowerPC
> > in Golang, V8 and also don't look after LLVM on big-endian PowerPC anym=
ore,
> > I wonder what is left for the community working on PowerPC.
> >
> > I personally feel that IBM thinks they own the PowerPC platform in the
> > open-source world and can single-handedly decide whether a certain proj=
ect
> > will support older PowerPC targets or not. And I'm starting to feel tha=
t
> > this will sooner or later also happen to the kernel parts, GCC and binu=
tils.
> >
> > As someone who has invested endless hours of my free time into working
> > Linux and open-source software on PowerPC, I feel really let down by
> > how IBM is handling this and currently I feel like it's starting to bec=
ome
> > pointless to invest my free time working on PowerPC support in Linux
> > and open-source projects.
> >
> > Adrian
> >
> >> [1] https://bugs.openjdk.org/browse/JDK-8331859
> >
> > --
> > .''`.  John Paul Adrian Glaubitz
> > : :' :  Debian Developer
> > `. `'   Physicist
> >  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> >
>=20
> 

