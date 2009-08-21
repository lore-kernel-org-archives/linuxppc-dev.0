Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DDA05B7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:27:39 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18BD9DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:27:37 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] NAND ECC Error with wrong SMC ording bug
Date: Fri, 21 Aug 2009 08:27:13 +0200
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<20090820153644.631dbd7b@lappy.seanm.ca>
	<ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
In-Reply-To: <ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908210827.13700.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	vimal singh <vimal.newwork@gmail.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 August 2009 07:17:09 vimal singh wrote:
> > diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> > index 89bf85a..497e175 100644
> > --- a/drivers/mtd/nand/ndfc.c
> > +++ b/drivers/mtd/nand/ndfc.c
> > @@ -101,9 +101,8 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
> >
> >        wmb();
> >        ecc = in_be32(ndfc->ndfcbase + NDFC_ECC);
> > -       /* The NDFC uses Smart Media (SMC) bytes order */
> > -       ecc_code[0] = p[2];
> > -       ecc_code[1] = p[1];
> > +       ecc_code[0] = p[1];
> > +       ecc_code[1] = p[2];
> >        ecc_code[2] = p[3];
> >
> >        return 0;
> >
> > Does anybody see a problem with my method of reproducing the bug? This
> > bug is deadly for our customers. I don't want to make the change unless
> > it is absolutely necessary..
>
> Just one question: did you enabled MTD_NAND_ECC_SMC in configs?

Yes, MTD_NAND_ECC_SMC is selected via Kconfig for this driver.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
