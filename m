Return-Path: <victorgallardo@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60672B7B8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:30:48 +1000 (EST)
Received: from web39805.mail.mud.yahoo.com (web39805.mail.mud.yahoo.com
	[209.191.106.66]) by ozlabs.org (Postfix) with SMTP id 95AB0DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:30:47 +1000 (EST)
Message-ID: <587603.70189.qm@web39805.mail.mud.yahoo.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<4A8C87E6.6070702@amcc.com>
	<20090820003851.1a532444@lappy.seanm.ca>
	<200908200701.21076.sr@denx.de>
	<20090820153644.631dbd7b@lappy.seanm.ca>
	<ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
Date: Thu, 20 Aug 2009 23:30:45 -0700 (PDT)
From: Victor Gallardo <victorgallardo@yahoo.com>
Subject: Re: [U-Boot] NAND ECC Error with wrong SMC ording bug
To: vimal singh <vimal.newwork@gmail.com>,
	Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hi Vimal,=0A=0A> > With the current ndfc code, the error correction gets th=
e bits wrong.=0A> > Switching it back to the original way and the correctio=
n is correct.=0A> >=0A> > diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mt=
d/nand/ndfc.c=0A> > index 89bf85a..497e175 100644=0A> > --- a/drivers/mtd/n=
and/ndfc.c=0A> > +++ b/drivers/mtd/nand/ndfc.c=0A> > @@ -101,9 +101,8 @@ st=
atic int ndfc_calculate_ecc(struct mtd_info *mtd,=0A> >=0A> > =A0 =A0 =A0 =
=A0wmb();=0A> > =A0 =A0 =A0 =A0ecc =3D in_be32(ndfc->ndfcbase + NDFC_ECC);=
=0A> > - =A0 =A0 =A0 /* The NDFC uses Smart Media (SMC) bytes order */=0A> =
> - =A0 =A0 =A0 ecc_code[0] =3D p[2];=0A> > - =A0 =A0 =A0 ecc_code[1] =3D p=
[1];=0A> > + =A0 =A0 =A0 ecc_code[0] =3D p[1];=0A> > + =A0 =A0 =A0 ecc_code=
[1] =3D p[2];=0A> > =A0 =A0 =A0 =A0ecc_code[2] =3D p[3];=0A> >=0A> > =A0 =
=A0 =A0 =A0return 0;=0A> >=0A> > Does anybody see a problem with my method =
of reproducing the bug? This=0A> > bug is deadly for our customers. I don't=
 want to make the change unless=0A> > it is absolutely necessary..=0A> =0A>=
 Just one question: did you enabled MTD_NAND_ECC_SMC in configs?=0A=0AYes, =
it was set.=0A=0ABest Regards,=0A=0AVictor Gallardo
