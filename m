Return-Path: <linuxppc-dev+bounces-20133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCB7FF8850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 22:04:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3ghf09lMz2xSd;
	Mon, 27 Apr 2026 08:04:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777241057;
	cv=none; b=a/mYAtCP0tJsGzDtiS+NYXWgU8MDJmQenb/aofXv45zNgjEJQIb7FCfuy8OIYUv7X8QACjVYueIFZLoTBoGA1dTmvuhKrQGDmYobC3gzvI7sb2vEHknOpyPSXW2ItNHE2w8uUjGYfCRT1pbS5LXUHjU66ORTvDH2BZ1RZo4rINdZdQIJKW0JUpnTvpAypeEUw6/758poDtrRXkiQ6i3iySoV7Hc5M5mfoFB/Q82CioQfwNYEki89jJlREh/60v2GTK0HTX0cmk4VXFZUWIxHtrwtZmKacUL7PNoGsCE3eQ1245o0+UYqEQK/64VYqSbLcroVneG7TbX3uVize4tHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777241057; c=relaxed/relaxed;
	bh=TOSUyfe/TldkyeaDzXd5HdT1X+MuNFQMhpVSGu+NHxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKIgRUpESTTWPRvwWjB9A+j78EYWYehoAD3pDJ7k0P8rzRWGfow8EtyHLnu+IezaL0TNfbJ5LEmSZCsr923OZuQfWpCerM4wltTXt1Ub68vQNoGMtabQT1XpL4/9SIl8gNgTLFTx/FDm9R9NXMnuH+bOgA46D8w6ghPjFZ5PyJAOJI1CdXa955bb045Ox2F7bJQn34gw2R09Nwoq/1g5ZIix1BlOHicjgJXkOE+pp51/Q4lKhNOBLMz+4zUdbIM2d1A7wDjaesizWVqdOQjgFpuucU5bcYdOdOV4GMGgcXmw4W4GEjBLgUqeQJkEUMBFzI67Q27VQCSfI3YwOqVYJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oD4A9AAU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oD4A9AAU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3ghc1tvkz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 08:04:15 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso95849715e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777241050; x=1777845850; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOSUyfe/TldkyeaDzXd5HdT1X+MuNFQMhpVSGu+NHxw=;
        b=oD4A9AAU1e9+nlt/NcNom6GYVM4C7rCLm6Q3YwWfXzdlOwD1//d/CKGV7NuT3onzsk
         EdaqsZzNTqhOit5gh0oilWAaVdbMoP+H6sUSJ6JJaH5AlN4TGE5n+6s2sOc/nD2KZ/xF
         SDWeopmyYCAALMdA/aenhbkQS5ZG+fBUNoa/jPDJjkjLhjPhKhE9O6Ya52GQEMDL5iHm
         pho2EZBt3/Fd41USFhF0R0vCG+/JGyTeaWDhycNHfPYiBXUd3uuFqqGu2CvhqkkFJOC1
         8SYBjC8DsNvBa5oz2Ohw5GsAaGt/z5AQAe/MVbbzvzK/hGKvS+UroMbR+chWNSznTj7L
         KsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777241050; x=1777845850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOSUyfe/TldkyeaDzXd5HdT1X+MuNFQMhpVSGu+NHxw=;
        b=nbSSEA91fDrI1zTkNKTvUQSISRYbja3T36wjk018LxxjX635+ZSqmyKacMCaW//dkS
         YFi3PpTmddiuZ6a+0ADzB8H3uFGivQ8f63es5NutLOt7k//IKlmlp+ksFzOMeYA6xZET
         iOHqYm0iFsUaKsPF3zZKc99DqJT30905pUhrJiInc/WtAQrwRcy5nYXfrtq0+gurZVV7
         6di6fyhLN1Qm1WMs4bhSKvatV3zLIIlJBkpC9FrIrc9YCMB3vNHeUnMEKBMgnaRQMfyh
         pS7xOxu1sd4sW/jGnFkRtEoXtxfoKUw2cXQnvjAHStZvHcAJz3qqMPHNxv2gS5PLjz44
         NbrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TsKzd52gaSp6gJL5iCjUAf4EGZMZG35TnXKO8o3NvR+FyGG5r0rPhG/+j994sCkToJRSDS5Q3vJg67R8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyve+qK3pcrVhVn2u73WOGw8Rf1OJ1YZPQCdbDqX9GdBs3Z9A6h
	gusCrG8HHNYyc9iQSqTnsm8hfCI6QdXBr0tS6K3JifivTXT/O9e99rqt
X-Gm-Gg: AeBDietKSTvGhzt05SPFVzbU/rJ33/md0mjiQfGyiIMcvv7dMq0jUgfGjel/5YZ9yU+
	5eDsdcFFi0oHm4qPihsRpVYIWkX9FJI6EupqZ2lRyCO8pc1XZqaK7nr5t0EgKRk0SE7Ps58UZ0T
	aI63Fh/UT1QPUVsRTr1z4ScICOHM5fhNsH6vxrqvCWVFgkgtsEg8ZpIiMaKd6H3pcNh3izlbkMN
	KMakMa4fVdgTWJKmz7aAloE8Z14qivzFQk+ANy01xTdwmypgsHWeRNPrXNqNsK/gAbJoZeGdrAr
	1uYlqum2jjri1CWurp/+0USkoEEfH3qmIOkubL5Dx9KV0UPluMCNAtxj174c/Bkn9a4yltFW6FM
	LxlpCQVf8KGFwaXnCHilXdRxauPYYZwO3LZMI3mLMHryUccr2hSKx+DzUmu/byn07BqFDOQrJwm
	o39Do5depwnVum/tgt5imcDMdNjQr2WgwpVJ92jL95iRvuTkgPmBv1qvmcbeCYdhwFbUSaP98VD
	oc=
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488fb8b9debmr118860245e9.13.1777241050182;
        Sun, 26 Apr 2026 15:04:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55743c06sm137051075e9.2.2026.04.26.15.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 15:04:09 -0700 (PDT)
Date: Sun, 26 Apr 2026 23:04:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, <maddy@linux.ibm.com>,
 <mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <rostedt@goodmis.org>, <ardb@kernel.org>,
 <sumit.semwal@linaro.org>, <christian.koenig@amd.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <tamird@kernel.org>, <arnd@arndb.de>,
 <nsc@kernel.org>, <simona.vetter@ffwll.ch>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>, "Link Mauve" <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260426230408.489c68c3@pumpkin>
In-Reply-To: <DI35IFD8M019.2WGRH5ADW6NOG@garyguo.net>
References: <20260424054742.45832-1-mkchauras@gmail.com>
	<20260424054742.45832-6-mkchauras@gmail.com>
	<DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
	<ae3C2gqzoVaovY-h@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
	<DI35IFD8M019.2WGRH5ADW6NOG@garyguo.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 15:20:31 +0100
"Gary Guo" <gary@garyguo.net> wrote:

> On Sun Apr 26, 2026 at 8:52 AM BST, Mukesh Kumar Chaurasiya wrote:
> > On Fri, Apr 24, 2026 at 01:43:43PM +0100, Gary Guo wrote: =20
> >> On Fri Apr 24, 2026 at 6:47 AM BST, Mukesh Kumar Chaurasiya (IBM) wrot=
e: =20
> >> > From: Link Mauve <linkmauve@linkmauve.fr>
> >> >
> >> > The core crate currently depends on these two functions for i64/u64/
> >> > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t =
use that in
> >> > the kernel so let=E2=80=99s panic if they are ever called.
> >> >
> >> > This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udiv=
di3 when
> >> > CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the =
kernel
> >> > build on PPC32. =20
> >>=20
> >> Can we always build libcore with `-C opt-level=3D2` even if
> >> `CONFIG_CC_OPTIMIZE_FOR_SIZE` is specified? It feels like a better fix=
 than
> >> stubbing things out.
> >>=20
> >> Best,
> >> Gary
> >>  =20
> > The issue is not coming from libcore itself. It's the driver that's
> > causing this. =20
>=20
> Sorry. I quoted the wrong part. I was asking if compiling libcore with O2=
 gets
> rid of its use of the builtins, as that's what the change this commit is =
for.
>=20
> Formatting of u64 will be needed, so we should make sure that these works=
 as
> intended.

This code (from nolibc) will convert u64 to ascii in any base:

#define _U64TOA_RECIP(base) ((base) & 1 ? ~0ull / (base) : (1ull << 63) / (=
(base) / 2))
static int _u64toa_base(u64 in, char *buffer, unsigned int base, u64 recip)
{
	unsigned int digits =3D 0;
	unsigned int dig;
	u64 q;
	char *p;
=20
	/* Generate least significant digit first */
 	do {

#if defined(__SIZEOF_INT128__) && !defined(__mips__)
		q =3D ((unsigned __int128)in * recip) >> 64;
#else
		u64 p =3D (u32)in * (recip >> 32);
		q =3D (in >> 32) * (recip >> 32) + (p >> 32);
		p =3D (u32)p + (in >> 32) * (u32)recip;
		q +=3D p >> 32;
#endif
		dig =3D in - q * base;
		/* Correct for any rounding errors */
		if (dig >=3D base) {
			dig -=3D base;
			q++;
 		}

		if (dig > 9)
			dig +=3D 'a' - '0' - 10;
		buffer[digits++] =3D '0' + dig;
	} while ((in =3D q));
=20
 	buffer[digits] =3D 0;

	/* Order reverse to result */
	for (p =3D buffer + digits - 1; p > buffer; buffer++, p--) {
		dig =3D *buffer;
		*buffer =3D *p;
		*p =3D dig;
	}

	return digits;
}

int u64toa_r(u64 in, char *buffer)
{
	return _u64toa_base(in, buffer, 10, _U64TOA_RECIP(10));
}

Not hard to do without any divides at all.

	David

