Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dim-sum.org header.i=@dim-sum.org header.a=rsa-sha256 header.s=chowmein header.b=DX8YmRhf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbBwG67wfz2yCS;
	Fri, 27 Nov 2026 10:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=81.187.240.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795734318;
	cv=none; b=d0yKuZNrFMlmXAHCROqabqydEWMhP8L+9CbvOoXzeCIlawfSKzVPaZEJC5n27abGb7KWlEI8rpIlWbaw29zvVA10lhGD+Osayn9WMXJ2P7b1ClvQrWi8TB58lknIsUIoA3IU8AciNSA5lza7rvJEbyZYvmzNDe0iph8KaPDBiK9eMAxynmYUxQiczSf56DU561eB9FzZjdeZuVgA6HAMHwvWm4cmseWcqJ9/n35zVyxLXLZttefbsoJoYmPYYogjOhVUc9kA6ulrImAgIfG9N2AN829IF+8QXISlgN2+IadWSm4betWObGxbMeDZjoNgyMx1v3tiqd5dpoFX05Ev3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795734318; c=relaxed/relaxed;
	bh=Sj/aWkcJoX8osNOaYguPCPfPhZLRWGD842MdJCjN+4Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WOtNxRA+ZcwFUv7Hox+R92t/DSxqKH6a+QkR2PowKKsn87I8Ouq6uF1LJ4eOmt7G66WDHEP4FS0ddDPdkOLYaAlx7xAAMQonejV7fkZlSRiv2rpHnUtveiYafzMTiHYHQewlqOQcKtLuoGdxtMLCqNpofMHffcBujMWeucZMOetx8QuCHAMAmTpDTkJOHFAluFoe9YAQrpgD5iR05cjdX27P5vajhJOPmQYE/IwVfoieriXPbp3oVlH8p5gsKRvyZTKroCpNPvSdsv5AYqEWuHlmziNGm7Cx1fukOY6vnF14TKXA6DdL4z1Pt++WllXFl5njD/0RE3Ug2fqSG9G8CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=dim-sum.org; dkim=pass (2048-bit key; unprotected) header.d=dim-sum.org header.i=@dim-sum.org header.a=rsa-sha256 header.s=chowmein header.b=DX8YmRhf; dkim-atps=neutral; spf=pass (client-ip=81.187.240.206; helo=chowmein.spicy.dim-sum.org; envelope-from=drw@dim-sum.org; receiver=lists.ozlabs.org) smtp.mailfrom=dim-sum.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=dim-sum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dim-sum.org header.i=@dim-sum.org header.a=rsa-sha256 header.s=chowmein header.b=DX8YmRhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=dim-sum.org (client-ip=81.187.240.206; helo=chowmein.spicy.dim-sum.org; envelope-from=drw@dim-sum.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 422 seconds by postgrey-1.37 at boromir; Fri, 27 Nov 2026 10:05:16 AEDT
Received: from chowmein.spicy.dim-sum.org (chowmein.spicy.dim-sum.org [81.187.240.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbBwD0KwCz2y96
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 10:05:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dim-sum.org;
	s=chowmein; t=1795733882;
	bh=lLSmzbK5NyJ4QRnqYbL+KLBr5kMfkKFsEvEgBH8TQP4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=DX8YmRhf83EN3YIuwv9weX8O6SjISbzZjkrR8IRHNZO3qZd1HAx/7v7lzMgWtOdiz
	 WdYd7gncUeWBPwS0K/1lPEIpV/9Z6CqyCGlbqKEN5nYrKv3obDzkRTWagelYoXCPNh
	 S7ON7LMk9Q1THeWIh0UgqqW08D7FIsSz9zFd0A5ylsGjJCj3TgcKAX+dvz2xV3FapM
	 XPnhI1k1Ea7CA5a4HYhvccrqNZd5DHlTj0ZazMznwX35GTCKHO3vb4JcOkv9XP2MQR
	 Ao01VXZWOWxXuwM6/dgsPYPgPqKSCQS0P4vWr5gDqbhlLn2IKrL3Jfx2xr8k8FuEsO
	 HwvzY3yckWj9Q==
Received: from smtpclient.apple (unknown [IPv6:2001:8b0:ff99:15:1a2:f725:9750:5716])
	by chowmein.spicy.dim-sum.org (Postfix) with ESMTPS id 34EB6BF54A;
	Thu, 26 Nov 2026 22:58:01 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: Should the community reconsider their efforts on PowerPC?
From: Dan Whitehouse <drw@dim-sum.org>
In-Reply-To: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de>
Date: Thu, 26 Nov 2026 22:57:51 +0000
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
 gentoo-powerpc <gentoo-powerpc@lists.gentoo.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86799B87-DFD3-44F3-8A04-00972FBADF9C@dim-sum.org>
References: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adrian,
Before I write anything else on this subject I would like you to know =
that I=E2=80=99m extremely grateful for your efforts.
I cannot possibly express how much I appreciate the hard work you have =
put in to not only the PPC ports, but all the work you do not only for =
the Debian project, but also free software in general.
Selfishly I would like you to continue working on PPC however I=E2=80=99ve=
 witnessed things like kvm-pr wither on the vine and seen Red Hat =
deprecate kvm on IBM=E2=80=99s PPC platforms.

To make a long story short, speaking selfishly, I would answer your =
question with a resounding =E2=80=9CNO!=E2=80=9D. However, that =
doesn=E2=80=99t mean that I don=E2=80=99t (at some level) understand the =
challenges you face and would not understand if you decided to call it a =
day.
If it=E2=80=99s not fun anymore and is more trouble than its worth, I =
won=E2=80=99t begrudge you putting it to bed. I=E2=80=99ll still be =
appreciative of all the work you have done and I won=E2=80=99=E2=80=99t =
begrudge you spending your efforts on other ports.

Thanks again,

Dan=20


> On 26 Nov 2026, at 21:04, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hello,
>=20
> as some of you may know, IBM has been pushing to deprecate any PowerPC
> platforms that they aren't earning money with anymore. This includes
> mainly POWER platforms before POWER8 and big-endian PowerPC.
>=20
> Recently, IBM engineers have remove JIT support in OpenJDK after =
sending
> an email for feedback to a non-public, unmonitored Debian email =
address [1].
>=20
> Since IBM engineers have also killed off support for big-endian =
PowerPC
> in Golang, V8 and also don't look after LLVM on big-endian PowerPC =
anymore,
> I wonder what is left for the community working on PowerPC.
>=20
> I personally feel that IBM thinks they own the PowerPC platform in the
> open-source world and can single-handedly decide whether a certain =
project
> will support older PowerPC targets or not. And I'm starting to feel =
that
> this will sooner or later also happen to the kernel parts, GCC and =
binutils.
>=20
> As someone who has invested endless hours of my free time into working
> Linux and open-source software on PowerPC, I feel really let down by
> how IBM is handling this and currently I feel like it's starting to =
become
> pointless to invest my free time working on PowerPC support in Linux
> and open-source projects.
>=20
> Adrian
>=20
>> [1] https://bugs.openjdk.org/browse/JDK-8331859
>=20
> --=20
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>=20


