Return-Path: <linuxppc-dev+bounces-21007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769C5CD4F47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 15:50:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJQPp4Kzvz2xdh;
	Mon, 18 May 2026 01:50:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=89.208.246.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779033038;
	cv=none; b=GUD54m8f6Ziym2/HQabToRyqkJcBcMXWTYZF0UAwV2QTDkhaX3g/ReOUmEkeTQpH6bVlBLyBKvt6t5A7+zh1EjQ6c/GGSF/wma0mPDDlptj+x1Wf13R4dr6WL38SX+Om5sRo6yBL+gj5xIN9G3dU3EFgfc2D70QEPqcnc7ynxtsDc/7UK7fBloacvd+yln0kzlzXSF0GEC3Qhp/1oJXceq72ipr78kK6CbNY94o5S5dSWLDuFgorFMaZAfFGxJbEnkJmeoWdtgqTyjEZSzlf1evi5tmUJQeU7iYAy+gYBG7k7QWtUiEoxfzqrRx7ujEA6a3zi6bRO1jq2hvnq1ojag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779033038; c=relaxed/relaxed;
	bh=acTPhhZ8T4/kftVIx/SIb/SY4r6jw6Sos9c0kyE9qlg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYMvMnGOyJ3RnuFyYZylT7Kh+LCI88qtjxWLaItoCGOKp5BO8mV4fX82ObRiuGM6coIHCPX6vZrx4OqDNiGzJiPufNd0fzYl6qXNMskQsEJ69g4caI1sWkUQVs6m9ch6gKeHivpv2C40/ZDjmmPsiJPfCh8etJl/s2NsErawALw+OQj6oui/uCeAtMHLwXtx2SXA6r3UiSkRCC/pyfxwj0wBeqnahn3PfHnlpe+zycvWZDBGC0Oip9gT/2bSsfMbg/WXV7CzTGWM/ZbMOuVgWUhG8fanzJCUqAJGz3sfJHonv9OlJdT2woaTcOxs9Xtn+jfovlEOzdS7suvJMFmwPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.a=rsa-sha256 header.s=default header.b=MLM5Z8rn; dkim-atps=neutral; spf=pass (client-ip=89.208.246.23; helo=xry111.site; envelope-from=xry111@xry111.site; receiver=lists.ozlabs.org) smtp.mailfrom=xry111.site
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.a=rsa-sha256 header.s=default header.b=MLM5Z8rn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xry111.site (client-ip=89.208.246.23; helo=xry111.site; envelope-from=xry111@xry111.site; receiver=lists.ozlabs.org)
X-Greylist: delayed 530 seconds by postgrey-1.37 at boromir; Mon, 18 May 2026 01:50:37 AEST
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJQPn2V1mz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 01:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779032472;
	bh=acTPhhZ8T4/kftVIx/SIb/SY4r6jw6Sos9c0kyE9qlg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MLM5Z8rncS6vPb6+OXBQRN56srVPBuQNT1pqM52QYCt7iAkmMHZC4gYE8dxwyxYsR
	 9cPwUU0tsyZRLGnwyTUBn30yoPb/hfiIyeM+ag977u6bHs+XEy6TblgzEUqqSMlmbe
	 Hf1STzLpmfqq4bViX8Mt0ffPoVNTrUZexB8+GIZA=
Received: from [192.168.42.56] (unknown [182.102.57.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E2A116597E;
	Sun, 17 May 2026 11:41:10 -0400 (EDT)
Message-ID: <ce45668b766e6dd58ff0eda8e7fe1c07e14ef758.camel@xry111.site>
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
From: Xi Ruoyao <xry111@xry111.site>
To: David Laight <david.laight.linux@gmail.com>, Mingcong Bai
 <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, 	linuxppc-dev@lists.ozlabs.org
Date: Sun, 17 May 2026 23:40:37 +0800
In-Reply-To: <20260517145421.2d1ac77c@pumpkin>
References: <20260517041423.71243-1-jeffbai@aosc.io>
	 <20260517145421.2d1ac77c@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
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

On Sun, 2026-05-17 at 14:54 +0100, David Laight wrote:
> On Sun, 17 May 2026 12:14:21 +0800
> Mingcong Bai <jeffbai@aosc.io> wrote:
>=20
> > Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu")=
,
> > define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> > warnings:
> >=20
> > =C2=A0 ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=
=E2=80=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef=
]
> > =C2=A0=C2=A0=C2=A0=C2=A0 59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp=
@intel.com/
> > Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> > ---
> > =C2=A0arch/powerpc/include/asm/sfp-machine.h | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/incl=
ude/asm/sfp-machine.h
> > index 8b957aabb826d..db8525605c026 100644
> > --- a/arch/powerpc/include/asm/sfp-machine.h
> > +++ b/arch/powerpc/include/asm/sfp-machine.h
> > @@ -319,10 +319,12 @@
> > =C2=A0#define abort()								\
> > =C2=A0	return 0
> > =C2=A0
> > -#ifdef __BIG_ENDIAN
> > +#ifdef __BIG_ENDIAN__
> > =C2=A0#define __BYTE_ORDER __BIG_ENDIAN
> > +#define __LITTLE_ENDIAN 0
> > =C2=A0#else
> > =C2=A0#define __BYTE_ORDER __LITTLE_ENDIAN
> > +#define __BIG_ENDIAN 0
> > =C2=A0#endif
>=20
> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 o=
r 4321.
> (apart from pdp11's 2143).

Should we just do

#define __BYTE_ORDER __BYTE_ORDER__
#define __LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
#define __BIG_ENDIAN __ORDER_BIG_ENDIAN__

then?  __BYTE_ORDER__ etc. are available since gcc 4.6 and now we
requires gcc >=3D 8 to build the kernel.


--=20
Xi Ruoyao <xry111@xry111.site>

