Return-Path: <linuxppc-dev+bounces-18129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECF1106ACDC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWxgM3wfgz3cHH;
	Fri, 13 Mar 2026 05:57:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773341823;
	cv=none; b=dKZkW1rF0wPRccTSXuaN+7PrjmMnNGaHyN3bdUF0auqxVy8Q/xCT5aWsBVt3mGJNpeRK/FvBW/a0A3eYD7hHati6iQxfjTcQTsNZP98zT+mHvrLongUZei/5aa/nSawPqWejmVsfopZIot6g9HblGD71j/OejvPEMKl5v6TV2hASmDVFwhwmpcw6BI0jnTxzmIuHdoritpx0AnA32FQLtG8JK+y4dODJ/tPToiqq/cUVNbFBoKfSDbqvDhLzgr148vvVytxZN1mwz2aP9cgz8oSFpbcb8CWlQgiVEo3xJ70RWIZBdVi3bvBuq2l3LPDpuzUoOBNb4gTdw3UT1ipHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773341823; c=relaxed/relaxed;
	bh=SBh5+9ZowpcuOJTob06IkV+7nM5VIRsXEM4MdYA0U80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmiXsVimjOkdjV/do/8vAFbgubEDGCe1CJmIZVP8BXq8lwboau0JV3TMYKah2xc8W7/XYygyNyuvlRiSraTVTP+ABlXN+eioK3OW6zda6qB8pbCmKf7zDcjXNYa0K3Zwrb0++PWW7a2xKcRuGujhBcNaLKC3HJCCkpXjQWwN54x76s/QHdLYnVVV4act+VJKP1QffFHG4IFxU1rkU92yYSa0Mlz+ajLeoTNadZJwYrXJDLRwUCuWftDx1+QrPgYzq1b3ip6KE0lMmix2fLdUD43EEQgFHpb4bz7tCYTDFRnhlRYh8c+4xQT1hsydyFoZy6kb9e9YXbLyRuOZThf48Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bm97h8X0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bm97h8X0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWxgJ6cCbz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 05:56:59 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-439d8df7620so1032502f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773341815; x=1773946615; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBh5+9ZowpcuOJTob06IkV+7nM5VIRsXEM4MdYA0U80=;
        b=bm97h8X07YRuMkZ7flZbl52oSCCy4YEMoiDWceed1GW67ReCXMZCF4xMxiFIkhFbHX
         ywwuSgqcMyq/4l7xcQ7dDDwL8ZbDOgO7z5g0v1+TeaGkVJvoG6iV2NIu6BEc5qJSHr2b
         wLFHowMMgc99jeRuh66mXXje6+XsLntd7hWl1183P8q5M9CyJ2eD1FqqP0BcNjiO7LGO
         0BioUAi4Pb7m6Xsq+iDgB3Nt7Ok1CkroxCN87KimPxNq+2kjw3R+1PmDVn2t4Of7se6O
         xsvGQOqXQAdW7GJro7XZmh2XFRH/7yPuwAnhaOnm8VQ/iY4yrkf/1hpydqxwU0Sjeof4
         Y78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341815; x=1773946615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBh5+9ZowpcuOJTob06IkV+7nM5VIRsXEM4MdYA0U80=;
        b=fE9+w8t7p9BfX7McQTknEr4+uVJ8J5+pw6dX6wcggcDcs1HfBmQ80zHQfSZjKlfDUv
         VqFkxtn/IQeIC2eMhnM2e4aHPSQrkuIiEGd/1fTuer2S6tGFVQeM55TeFLP8yVGpJVPN
         Y01I7DACYbTnALyKrP0NRmdFs505Yib3LYrCpOt7ao0D74TPM27qkjSKnkY1tXyLkUfX
         85Tre8/BPYUnRLRnmHQbEytNQ6yUTqq3TFDWO8g3LmdTf6D8aPzcn8TyIztWbYP+NYKo
         iMkf+6lWd2dlqyLRZhwSVwivlusR6GkJ7qHuMJviqeywGgzOCflty1lzewY6fsvyZcB9
         rR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQtehOBcbxaZos7Ig/5Sdjgvm5od1VO/Han9uhp5IhW6dr27i1fzWBJv0EX1bvlF5nngECWNzMUgBCELQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywz4yieQCoErxVGxm0CoZ9+fe4Kr8llCYikKOo5qTp7jWu6vDa1
	62oFfNNoZcrON6LRaoVDazXLIWEIGMVKWcSgh7je96M1UyI80hWSor8g
X-Gm-Gg: ATEYQzyTr7k+i5uk+z5GKWHWodJXTUFIQJrU9dIS0A/UwzWm9ZPqlPEKhYvmrLc1MIO
	5KlrY/aSSTQkydadCgj+GcPfaPJllxIDV+qI8LGY7+fTrduw5nlqDjWkRNrt3tSIVybmQ0ZN2/X
	CiGUEHbnUS8k0KyVOqphfjy/3J2/G++Yby130djb26FO823wH7cEVVxd+DZ8M5AYNK88FEvah97
	eBi2ymw18S8LAXu1htmuWIivwhy7vY8VQulQBSbymXH4CPdHygDEPH38cTnR2rQIe1qQQS+7Q53
	0b/kZuBYsZkjgeFj+Eo6D7F315jhrAJxgRIrtHmBabTBGJv0rhlte5sDWzUIlex9wrat8c4QS5+
	fIvz6C2297nZ/gZkprFV4G0H9f1sbqn19R+D8G0X2pv27ZC7yCHkvG7+gpR+s+TrgDpNNRQ6EYt
	u2bIUJ572AN/HByWyJTLdUu/Sxv8P2YTybZdtpAUYt/xsgUWl7lNoX0e0SekUL5tWBMcgqHtWzz
	3A=
X-Received: by 2002:a05:6000:2882:b0:439:b636:1fa4 with SMTP id ffacd0b85a97d-43a04dcbd70mr1416178f8f.48.1773341814743;
        Thu, 12 Mar 2026 11:56:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bb90sm11133374f8f.19.2026.03.12.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:56:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:56:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Vaibhav Jain
 <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Suppress false positive
 -Wmaybe-uninitialized with GCC 15
Message-ID: <20260312185653.3b8570a9@pumpkin>
In-Reply-To: <20260312123856.65bb5484-2e-amachhiw@linux.ibm.com>
References: <20260310101519.67157-1-amachhiw@linux.ibm.com>
	<3f26916b-5a1f-40b0-9c47-8b53e066e08c@kernel.org>
	<20260312123856.65bb5484-2e-amachhiw@linux.ibm.com>
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

On Thu, 12 Mar 2026 13:16:26 +0000
Amit Machhiwal <amachhiw@linux.ibm.com> wrote:

> Hi Christhophe,
>=20
> Thanks for looking at the patch. Please find my comments inline:j
>=20
> On 2026/03/10 11:54 AM, Christophe Leroy (CS GROUP) wrote:
> >=20
> >=20
> > Le 10/03/2026 =C3=A0 11:15, Amit Machhiwal a =C3=A9crit=C2=A0: =20
> > > GCC 15 reports the below false positive '-Wmaybe-uninitialized' warni=
ng
> > > in vphn_unpack_associativity() when building the powerpc selftests.
> > >=20
> > >    # make -C tools/testing/selftests TARGETS=3D"powerpc"
> > >    [...]
> > >      CC       test-vphn
> > >    In file included from test-vphn.c:3:
> > >    In function =E2=80=98vphn_unpack_associativity=E2=80=99,
> > >        inlined from =E2=80=98test_one=E2=80=99 at test-vphn.c:371:2,
> > >        inlined from =E2=80=98test_vphn=E2=80=99 at test-vphn.c:399:9:
> > >    test-vphn.c:10:33: error: =E2=80=98be_packed=E2=80=99 may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
> > >       10 | #define be16_to_cpup(x)         bswap_16(*x)
> > >          |                                 ^~~~~~~~
> > >    vphn.c:42:27: note: in expansion of macro =E2=80=98be16_to_cpup=E2=
=80=99
> > >       42 |                 u16 new =3D be16_to_cpup(field++);
> > >          |                           ^~~~~~~~~~~~
> > >    In file included from test-vphn.c:19:
> > >    vphn.c: In function =E2=80=98test_vphn=E2=80=99:
> > >    vphn.c:27:16: note: =E2=80=98be_packed=E2=80=99 declared here
> > >       27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
> > >          |                ^~~~~~~~~
> > >    cc1: all warnings being treated as errors
> > >=20
> > > When vphn_unpack_associativity() is called from hcall_vphn(), this er=
ror
> > > is not seen during compilation because GCC 15 seems to consider 'retb=
uf'
> > > always populated from the hypervisor which is eventually referred by
> > > 'be_packed'. However, GCC 15's dataflow analysis can=E2=80=99t prove =
the same
> > > before the first dereference when vphn_unpack_associativity() is call=
ed
> > > from test_one() with pre-initialized array of 'struct test'. This
> > > results in a false positive warning which is promoted to an error und=
er
> > > '-Werror'. This problem is not seen when the compilation is performed
> > > with GCC 13 and 14.
> > >=20
> > > Suppress the warning locally around the offending statement when
> > > building with GCC 15 using a diagnostic pragma. This keeps the build
> > > working while limiting the scope of the suppression to the specific
> > > statement that triggers the false positive. An issue [1] has also been
> > > created on GCC bugzilla. =20
> >=20
> > Usually when we get this kind of warning this is because the code is too
> > complex. We should try to make it more obvious instead of just hiding t=
he
> > warning. =20
>=20
> The real issue here is that GCC 15 emits '-Wmaybe-uninitialized' due to
> type punning between __be64[] and __b16* when accessing the buffer via
> be16_to_cpup(). The underlying object is fully initialized but GCC 15
> fails to track the aliasing due to the strict aliasing violation here.

Nope, I think it is tracking it correctly.
The writes to be_packed[] are of 64bit values.
The only reads of that memory are 16bit ones through field[].
With 'strict aliasing' the compiler doesn't have to order those accesses.
Indeed, it is allowed to completely optimise away the first loop.

If you cast to 'unsigned char *' then the accesses do have to be ordered.
gcc will also treat accesses to different members of a union as being order=
ed
(the C stand doesn't require this, IIRC s/union/struct/ is valid).

	David=20

> Please refer [1] and [2].
>=20
> The selftest compiles fine with '-fno-strict-aliasing'. I see that when
> we build vphn.c while compiling the kernel, the top level Makefile
> includes '-fno-strict-aliasing' flag always.
>=20
> So, I believe the same flag should be used to build vphn tests when
> compiling vphn.c via the selftests. I'll send the v2 to achieve this
> thus avoiding the compilation failure.
>=20
> Please let me know you have different thoughts.
>=20
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124427=20
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99768
>=20
> ~Amit
>=20
> >=20
> > Here the for loop is a bit misleading.
> >  =20
> > >=20
> > > [1] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgcc.gnu.org%2Fbugzilla%2Fshow_bug.cgi%3Fid%3D124427&data=3D05%7C02%7Cchr=
istophe.leroy%40csgroup.eu%7C06a4d55b55f24c5cf00208de7e8e3676%7C8b87af7d864=
74dc78df45f69a2011bb5%7C0%7C0%7C639087346428583316%7CUnknown%7CTWFpbGZsb3d8=
eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI=
sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DxEfO94N6IfGYhmmapNFduv3OrMarxpjTpZR6=
B38uR1s%3D&reserved=3D0
> > >=20
> > > Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
> > > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > > ---
> > >   arch/powerpc/platforms/pseries/vphn.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/arch/powerpc/platforms/pseries/vphn.c b/arch/powerpc/pla=
tforms/pseries/vphn.c
> > > index 3f85ece3c872..9bc891143fec 100644
> > > --- a/arch/powerpc/platforms/pseries/vphn.c
> > > +++ b/arch/powerpc/platforms/pseries/vphn.c
> > > @@ -39,7 +39,22 @@ static int vphn_unpack_associativity(const long *p=
acked, __be32 *unpacked)
> > >   		be_packed[i] =3D cpu_to_be64(packed[i]);
> > >   	for (i =3D 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> > > +/*
> > > + * When this function is called from hcall_vphn(), GCC 15 seems to c=
onsider
> > > + * 'retbuf' always populated from the hypervisor which is eventually=
 referred by
> > > + * 'be_packed'. However, GCC 15's dataflow analysis can=E2=80=99t pr=
ove the same before
> > > + * the first dereference when this function is called from test_one(=
) with
> > > + * pre-initialized array of 'struct test'. This results in a false p=
ositive
> > > + * '-Wmaybe-uninitialized' warning which is promoted to an error und=
er
> > > + * '-Werror'. This problem is not seen when the compilation is perfo=
rmed with
> > > + * older GCC versions.
> > > + */
> > > +#pragma GCC diagnostic push
> > > +#if defined(__GNUC__) && __GNUC__ >=3D 15
> > > +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> > > +#endif
> > >   		u16 new =3D be16_to_cpup(field++);
> > > +#pragma GCC diagnostic pop
> > >   		if (is_32bit) {
> > >   			/*
> > >=20
> > > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681 =20
> >  =20
>=20


