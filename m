Return-Path: <vimal.newwork@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BEE6CB7B98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:17:31 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 219A1DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:17:30 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so272322qwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 22:17:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820153644.631dbd7b@lappy.seanm.ca>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<4A8C87E6.6070702@amcc.com> <20090820003851.1a532444@lappy.seanm.ca>
	<200908200701.21076.sr@denx.de>
	<20090820153644.631dbd7b@lappy.seanm.ca>
From: vimal singh <vimal.newwork@gmail.com>
Date: Fri, 21 Aug 2009 10:47:09 +0530
Message-ID: <ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
Subject: Re: [U-Boot] NAND ECC Error with wrong SMC ording bug
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>, Feng Kan <fkan@amcc.com>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>

> With the current ndfc code, the error correction gets the bits wrong.
> Switching it back to the original way and the correction is correct.
>
> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> index 89bf85a..497e175 100644
> --- a/drivers/mtd/nand/ndfc.c
> +++ b/drivers/mtd/nand/ndfc.c
> @@ -101,9 +101,8 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
>
> =A0 =A0 =A0 =A0wmb();
> =A0 =A0 =A0 =A0ecc =3D in_be32(ndfc->ndfcbase + NDFC_ECC);
> - =A0 =A0 =A0 /* The NDFC uses Smart Media (SMC) bytes order */
> - =A0 =A0 =A0 ecc_code[0] =3D p[2];
> - =A0 =A0 =A0 ecc_code[1] =3D p[1];
> + =A0 =A0 =A0 ecc_code[0] =3D p[1];
> + =A0 =A0 =A0 ecc_code[1] =3D p[2];
> =A0 =A0 =A0 =A0ecc_code[2] =3D p[3];
>
> =A0 =A0 =A0 =A0return 0;
>
> Does anybody see a problem with my method of reproducing the bug? This
> bug is deadly for our customers. I don't want to make the change unless
> it is absolutely necessary..

Just one question: did you enabled MTD_NAND_ECC_SMC in configs?

-vimal

>
> Cheers,
> =A0 Sean
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>
