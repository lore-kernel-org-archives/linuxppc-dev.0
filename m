Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9CCF0B7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 03:30:34 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id D61B9DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 03:30:33 +1000 (EST)
Received: by gxk6 with SMTP id 6so1925761gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 10:30:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243454441.3489.1@antares>
References: <1243454441.3489.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 11:30:11 -0600
Message-ID: <fa686aa40906111030h5cebcbd6xeee76561601cf41a@mail.gmail.com>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 2:00 PM, Albrecht Dre=DF<albrecht.dress@arcor.de> w=
rote:
> This trivial patch changes memcpy_(to|from)io as to transfer as many 32-b=
it
> words as possible in 32-bit accesses (in the current solution, the last
> 32-bit word was transferred as 4 byte accesses).
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>
> diff -urpN -X linux-2.6.29.1.orig/Documentation/dontdiff
> linux-2.6.29.1.orig/arch/powerpc/kernel/io.c
> linux-2.6.29.1/arch/powerpc/kernel/io.c
> --- linux-2.6.29.1.orig/arch/powerpc/kernel/io.c =A0 =A0 =A0 =A02009-04-0=
2
> 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/arch/powerpc/kernel/io.c =A0 =A0 2009-05-27
> 11:36:09.000000000 +0200
> @@ -161,7 +161,7 @@ void _memcpy_fromio(void *dest, const vo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dest++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n--;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 while(n > 4) {
> + =A0 =A0 =A0 while(n >=3D 4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*((u32 *)dest) =3D *((volatile u32 *)vsrc)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eieio();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vsrc +=3D 4;
> @@ -190,7 +190,7 @@ void _memcpy_toio(volatile void __iomem
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdest++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n--;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 while(n > 4) {
> + =A0 =A0 =A0 while(n >=3D 4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*((volatile u32 *)vdest) =3D *((volatile u=
32 *)src);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0src +=3D 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdest +=3D 4;
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
