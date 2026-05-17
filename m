Return-Path: <linuxppc-dev+bounces-21006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EFCCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 13:54:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJMqw36BJz2xdh;
	Sun, 17 May 2026 23:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779026076;
	cv=none; b=C5ku/bzBOLOfMTNWEv695tpKrJjTv1gMFuHoXabWF1kJQRlS6Hk6Vte373+DIdJL1Eho9LnKrnrJVbcT8NiXqnOA0Vh8JItJy1tgbBnK1ifsFL72g8JExHViA2VBBUDCo92zslk7E/lLPboBaVLXiArv2Y2DJlrx2KKriT11rKIVIBOLivIjdNBakX//GdRweTYHtVvZRowUPIz2rmIdOyJsEgSAujbPAH6uISmkZjpUZl80vbHi5CwBV2R3A7PO3DF6zQzcyck4UNyk4YmhhlP5Mji7L2H1ckqktmExXFvKd8UPVUteeWQl50L/K10HPihYxqEUbsZi/MvxoOznqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779026076; c=relaxed/relaxed;
	bh=uCmNoyXACxi7HeEYBB30N/6mk1BYNcK6sHffQdI0OFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oU3mei4Rkhlx3shLlUgw2y9eCTFtabY3l0RzMP2Qy7NjkdxA5d3DSmsy5JCjsCzwEkwbpg9mOKalOq+faVpHyf0YmQ4VnWMPSGUXXMDF0HAdIrH6Bx1SrIu5sILUGjT3ap81xBqZ8n7VikoBwaCJUMH20EJYtEkLCFbs8QU/nPwD1ieYtzIE9P/8AosQMW3KGYIWzdy+dKTK252JFxCJwEJ3e+UoOWweLk4fhfOLiBtzUyopM/P0KqqLBf4PJKYirKzvLR9X13nWAMomogKYDY2ee6+6hR9xcnrnz78+Hn8qqVrnnP4QDQrHAuvwR9P2SCbfIqsmlJtCh6CZ4Xl/3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZktLBhzh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZktLBhzh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJMqt0xjVz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 23:54:32 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so7085465e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779026064; x=1779630864; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCmNoyXACxi7HeEYBB30N/6mk1BYNcK6sHffQdI0OFI=;
        b=ZktLBhzhQchDxvNiT7GtMnJEle4IHyodoFgD2TYl1KmsNR2Qs/hB3DyuTslNjYNXbT
         9jihe6am310lMr8G6Gre3M5uD1wkkqg2UX7H/nbOuJv7Q6sf2SJ2ZUf06D3Rp9qu+XuH
         L5Bo1Gao4444M8Q2wvhlal/ApfIj6SRrOqDnqfgCsuay4QqRxBI/yn/J6Gr3iDQ1UyTW
         +N8Vo3U8iNJF+nwCTfVanw0/u5MBqzWZIqXuNTme5ISy0f1AzIDeKWutWUklWzJKS0Jy
         m37MZhcH3hScEcC1DuUAusmlhmofEGT33PnyFxsNMgecsWqpdmGYxeVm6MAnIEvxFJ6w
         9Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779026064; x=1779630864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCmNoyXACxi7HeEYBB30N/6mk1BYNcK6sHffQdI0OFI=;
        b=AlV/43dI7zo+7agpa7BZ5lftEWYUnQjKmbH2btzXuWm5nZJbslGNK3bTinGkNuN2gu
         zOEHme2Nw5zLDBMUNp2YcTBg75gZOJxPQb7KMsqSERNRfzuBejG2rChSvVRWQJV0/bWQ
         lsd5PvU8wpaRjve+AjREuQXI4etndytsEbLNnf4NE2IleV0S3YIquKts92uU4wdFMjOS
         WIWxzhpJX3jy3ZoB4VM3JTvqHVme+qiMlZeGS+7Xb9JmtLyblWd+NZZB5CVC6pc139oz
         4Ci/O6zAuh1fn+EH5hB7Se5td6MExF3gp31S/OXimoQtesUdtBuDfJyqBkfoPYhGgA3j
         LL6g==
X-Forwarded-Encrypted: i=1; AFNElJ9dMvVBNMc7kEBvBvJnjOuKAK9ohwa4CPxYDqtegOkksgw5BEGviFhYsIau4u6cX0U9wrcsQMBBlGhSHj4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyujCMWIBUEO7ktfh29i9IL9IcWm3W37xusCjndqnwK3ivodmC8
	0eGw9CV67zQ0HrcMhH6JFAXqDnKuEywdvFZ9G6J6omTvYqJelJl0ghz2
X-Gm-Gg: Acq92OFixYgoQmnuD+BFFiTF7STOQOzsLdVLocA74eednwIgAo51pLIPlNKijZjUQsb
	GtZyoyFRi7kjaEbFouFckxc7Jr3zkXLUNWgA9o879tI3XUIo7Zo5cngR+9vXLBhmLu1oqGVu83m
	5woYKNPKXoMJ52QP6eIuGshyM5NGg0fxxQNgHENoc09auryEWqPIgsxYG3klTkiVHY2BnujBSzm
	12Xwc7NsfsUNiNj7b7QyCgE2cKlqDLTbzWxAMa2I7G/Hqk8zvRwB/gqHn+wgwcOygL67UrcOOF7
	4OKUcJAgDT+PpCVpRVHdJV24k/GSviUGNS3fqlBA8jOfgqpZwo+vwpHaH2TM6usKqwQuxf+KwZ8
	OoDiTAyf0V4Y+ppAVXmKtpva6FG6xtL9NrwmwYBpo349+spEFz4nZCuNLZNJcW48xP6HFWt/FjB
	H2S58SEZI6HLyIdM3nbMapZiZJ4wTvQkboJBtwcjkQd0gbSN9/M8Th+Ni74cHLJ7p+Abc2hfpDP
	XoOMtfdiS/osw==
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48fe5388407mr154115835e9.12.1779026064317;
        Sun, 17 May 2026 06:54:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm196019465e9.0.2026.05.17.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:54:24 -0700 (PDT)
Date: Sun, 17 May 2026 14:54:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, Kexy
 Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
Message-ID: <20260517145421.2d1ac77c@pumpkin>
In-Reply-To: <20260517041423.71243-1-jeffbai@aosc.io>
References: <20260517041423.71243-1-jeffbai@aosc.io>
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

On Sun, 17 May 2026 12:14:21 +0800
Mingcong Bai <jeffbai@aosc.io> wrote:

> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> warnings:
>=20
>   ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=E2=80=
=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef]
>      59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
>         |
>=20
> Cc: stable@vger.kernel.org
> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp@i=
ntel.com/
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/includ=
e/asm/sfp-machine.h
> index 8b957aabb826d..db8525605c026 100644
> --- a/arch/powerpc/include/asm/sfp-machine.h
> +++ b/arch/powerpc/include/asm/sfp-machine.h
> @@ -319,10 +319,12 @@
>  #define abort()								\
>  	return 0
> =20
> -#ifdef __BIG_ENDIAN
> +#ifdef __BIG_ENDIAN__
>  #define __BYTE_ORDER __BIG_ENDIAN
> +#define __LITTLE_ENDIAN 0
>  #else
>  #define __BYTE_ORDER __LITTLE_ENDIAN
> +#define __BIG_ENDIAN 0
>  #endif

I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or =
4321.
(apart from pdp11's 2143).

-- David

> =20
>  /* Exception flags. */


