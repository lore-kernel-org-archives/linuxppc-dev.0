Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj5yn2QjTzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 23:32:17 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Balbir Singh' <bsingharora@gmail.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] powerpc/xmon: hdec is now 64bits
Date: Wed, 30 Aug 2017 13:32:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0069953@AcuExch.aculab.com>
References: <20170830002745.29526-1-bsingharora@gmail.com>
In-Reply-To: <20170830002745.29526-1-bsingharora@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh
> Sent: 30 August 2017 01:28
> ISA 300 defines hypervisor decrementer to be 64 bits in length.
> This patch extends the print format for all archs to be 64 bits
>=20
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/xmon/xmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 9e68f1d..1b26d53 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1749,7 +1749,7 @@ static void dump_206_sprs(void)
>=20
>  	printf("sdr1   =3D %.16lx  hdar  =3D %.16lx hdsisr =3D %.8x\n",
>  		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
> -	printf("hsrr0  =3D %.16lx hsrr1  =3D %.16lx hdec =3D %.8x\n",
> +	printf("hsrr0  =3D %.16lx hsrr1  =3D %.16lx hdec =3D %.16lx\n",
>  		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
>  	printf("lpcr   =3D %.16lx  pcr   =3D %.16lx lpidr =3D %.8x\n",
>  		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));

On the face of it the patch doesn't do what the commit message says.
Not only that it is really silly to print a 32bit value with 8 extra
leading zero digits.

Something more subtle was also wrong:
There were 3 mfspr() calls, 2 printed with %lx and one with %x.
That ought to generate a warning from gcc.

	David
