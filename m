Return-Path: <linuxppc-dev+bounces-21250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA13CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 18:43:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLL5Y5BJ5z2xqv;
	Thu, 21 May 2026 04:43:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779302593;
	cv=none; b=OHDpwU5pbH11J69zrBgGLLzxGcxLoNSOKnyv5XwYeSX1THrTzDLV00AutEXAHWWi0bbIu5Oi364YnYlvDAJt6hmIY2LGCF7Fy/C87m+ZArE2NcGUwi/9RTnYyJGwny+wr8v5Oo83mJnNjFuQ/2nVZ5XuLP7o3O7bJGvzqa5XPCDX3ck8Xr+H4g3Xbmdgh6CT5bH0p9W+OzFf3t+EkL4/WwTaSRLcHGAclIwm3UbUgA9WsN4A8FQPtHNWCoS9iNKpyciRR2TqmDDMYISFA07w+V23er/UF9AefOxKngI3NCWJfXzQFdWtSMY7JoIQ2Ir5nyiIEfsVvoTrgY/1r0fjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779302593; c=relaxed/relaxed;
	bh=whgB6y4RP4kwglDuYRFO52mBrV4vFUKUBeiqdJotODU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IirDSz8YRZ6uSoNxxqLu8XVXBKPX4VRJR4gKhkIJPeDDaK+k6cQ5AeeJjbaimN4+TlEVZWaBthALUqlZQpPjKAolQddztLvfhwj79Sp7Mo9JMcucMOrhYYsPgfCCN/QQDaKH3JMM13xGFJMchv5QUZn0+GIqPcIOBraJK5U2mViFwz8bfyi3FPoe/nJTVHFAN4w6gAFD0LErz+stsDOkUxkA7gCnPnPXTcr5Qe4eoYdStx+BZ60dOgWE/KyvyhlpoUKUgBMBv7rnXJ+CuYT9BSK9s8xvdHPTWIcBUXD4oGV0d3jScYmJ1nnzho/Mb8o16xabYQICNlt2LYTh4cg4wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LC18KF7G; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LC18KF7G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLL5W0kbsz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 04:43:09 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so25941515e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302585; x=1779907385; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whgB6y4RP4kwglDuYRFO52mBrV4vFUKUBeiqdJotODU=;
        b=LC18KF7GNWcyX6yRHwDunv03rOigF6YFyda9rxavlTcqBX1m5mCE8dvGpYSOFkbI5X
         7K/3cRhrmGtcwprUhb9Ysd0+rhQiOIreT/mOLNi9JhU6TTYZ5QbQsO5h6WO1Mx1rwsuc
         gF5TqxzTYsds9r3cAYXY0DuR4WmUzIU9rDbI8lPKjGV5GDVvIZiCWtdzRpi8YH9rjzrf
         dRHZcgH02bxA7JSXpTWxkR882vDJjrl3xMPc25AqAPFikhcraBCdtMmMvY/iNjNgaz8h
         TL0Rb5EZ0/OkUzSEh/NvOWz0aXdaJ6wb2eTrZgtAHdPNJoH+l9jhCfd6Ck4YumsXCq1O
         dTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302585; x=1779907385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whgB6y4RP4kwglDuYRFO52mBrV4vFUKUBeiqdJotODU=;
        b=VczO6nOIbODDfclHHIAROGBW7mBOi3ZHgCqDzDRsVWEqYeqizQr5RS7e5cUQaPL2XU
         gh+XumY1EKLLXYXHBUDDOrBvLanMqW7+59oMDZOjFceQY+x793YmIQlokui/YxMmPonV
         7YdpdGm37Xki5ql4e5YJGsRESyW0VBercTM+uoQiofuSrDky2IYVidb+y7Lni1gnZfSz
         TTgw0mlFGxEjWT1+bVSsCBHC4Zb8/kzJH65s86HvMBLvbEjBgk8N38qE6A7qjn+YxcnJ
         B9jlP8vdp8DJXuGnpDbCfHTL8ynr3/xBL0/T856Vmp11ZQO1SWf6B126q4CKNLzhzn2c
         F+TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jZPy91iGo8pXIpM5X4wIoep75Rrdw1N+wLhr9oir26S0ijQ+IjVEkwbGgepgS+SBuMXjuL8hlB40gS6k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzI01Op3Z/dbPBEMstaDlqSF5FFkCINC3fT6V2zu71wnbV//BH3
	u8WrdxSXhV7N8ajFNPVAfPLR7Yt+kjmm1vODLiA58xVyOZdnkQ3DeRB6
X-Gm-Gg: Acq92OFYMl+f6l6HOZ/HWkule8fuh6v5SilHxp/3KEGDaqWG4nsd6Cr+FbbTIKRidch
	JOqUEDWt0/rxW4jFNgfSPXU9k0LIYVl5Aj+cWQqeeUpHlwv3k5sQqzVRHsFnIIVXw6pXb86I3fR
	eH4bLUq2O7EiKGso5PCkmErSNJqd08sOe7LDKOOrmpgtCIAGF2SD0aLX1187kBR8k5PKqzvZXcv
	E1Sj/b8c4vq5LAUxXLm+5dErELghilXau3DW3e8Fsa3jidghlkkut62pIBLf2SK/GHrL1t/4vBB
	WS/ONnwIK4K8f2ancxZm4dNzdT6wAnDW6TEZPHlSw1QzcLYphbnVLUPtrzNkRuPVx1eJU2b6vCA
	oFKXswhFMjor7tGFmLofxGrTt9EXAY2Vk3I9WDen0+1LSHJSnyepXJd1PUi6e2hraFBQSppFv6U
	q3nh6Ue/WLiHW1U0c7fTeRTfq24gICndqSWjULiuljlfGz5GrKHwvXpto8VED20drj
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr386484735e9.31.1779302584904;
        Wed, 20 May 2026 11:43:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3f99csm16504725e9.6.2026.05.20.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:43:04 -0700 (PDT)
Date: Wed, 20 May 2026 19:43:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>, linux-kernel@vger.kernel.org, Xi Ruoyao
 <xry111@xry111.site>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
Message-ID: <20260520194301.06d96a5f@pumpkin>
In-Reply-To: <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
References: <20260517041423.71243-1-jeffbai@aosc.io>
	<20260517145421.2d1ac77c@pumpkin>
	<eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
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

On Wed, 20 May 2026 15:14:40 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 17/05/2026 =C3=A0 15:54, David Laight a =C3=A9crit=C2=A0:
> > On Sun, 17 May 2026 12:14:21 +0800
> > Mingcong Bai <jeffbai@aosc.io> wrote:
> >  =20
> >> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"=
),
> >> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> >> warnings:
> >>
> >>    ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=E2=
=80=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef]
> >>       59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
> >>          |
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.c=
om%2F&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C08977974fb1c495e9bd5=
08deb41bd275%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63914622876869373=
0%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO=
iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D4qGulR%2BL=
7i7inksEbEH9jNGZS8HG80uvm3I9IyYzZww%3D&reserved=3D0
> >> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> >> ---
> >>   arch/powerpc/include/asm/sfp-machine.h | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/inc=
lude/asm/sfp-machine.h
> >> index 8b957aabb826d..db8525605c026 100644
> >> --- a/arch/powerpc/include/asm/sfp-machine.h
> >> +++ b/arch/powerpc/include/asm/sfp-machine.h
> >> @@ -319,10 +319,12 @@
> >>   #define abort()								\
> >>   	return 0
> >>  =20
> >> -#ifdef __BIG_ENDIAN
> >> +#ifdef __BIG_ENDIAN__
> >>   #define __BYTE_ORDER __BIG_ENDIAN
> >> +#define __LITTLE_ENDIAN 0
> >>   #else
> >>   #define __BYTE_ORDER __LITTLE_ENDIAN
> >> +#define __BIG_ENDIAN 0
> >>   #endif =20
> >=20
> > I thought the expected/correct value for __BYTE_ORDER__ was either 1234=
 or 4321.
> > (apart from pdp11's 2143). =20
>=20
> That's the case, in include/linux/kconfig.h we have:
>=20
> #ifdef CONFIG_CPU_BIG_ENDIAN
> #define __BIG_ENDIAN 4321
> #else
> #define __LITTLE_ENDIAN 1234
> #endif
>=20
> But as far as I understand the problem is that math-emu expects=20
> __BIG_ENDIAN to be defined at all time as it has tests like:
>=20
> #if __BYTE_ORDER =3D=3D __BIG_ENDIAN

The gcc docs have (https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Mac=
ros.html):
    =20
__BYTE_ORDER__
__ORDER_LITTLE_ENDIAN__
__ORDER_BIG_ENDIAN__
__ORDER_PDP_ENDIAN__

    __BYTE_ORDER__ is defined to one of the values __ORDER_LITTLE_ENDIAN__,=
 __ORDER_BIG_ENDIAN__, or __ORDER_PDP_ENDIAN__ to reflect the layout of mul=
ti-byte and multi-word quantities in memory. If __BYTE_ORDER__ is equal to =
__ORDER_LITTLE_ENDIAN__ or __ORDER_BIG_ENDIAN__, then multi-byte and multi-=
word quantities are laid out identically: the byte (word) at the lowest add=
ress is the least significant or most significant byte (word) of the quanti=
ty, respectively. If __BYTE_ORDER__ is equal to __ORDER_PDP_ENDIAN__, then =
bytes in 16-bit words are laid out in a little-endian fashion, whereas the =
16-bit subwords of a 32-bit quantity are laid out in big-endian fashion.

    You should use these macros for testing like this:

    /* Test for a little-endian machine */
    #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__

The doc doesn't mention the value, but __ORDER_BIG_ENDIAN__ is 4321 (decima=
l).

So the math-emu code is neither following gcc's rules or the kernel ones.

Your change will break anything that currently does:
#ifdef __BIG_ENDIAN

Any change would have to be limited to code that is implementing math-emu.

-- David

>=20
> Christophe
>=20


