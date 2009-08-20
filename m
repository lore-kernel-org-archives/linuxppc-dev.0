Return-Path: <vgallard@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2AC5B7B8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 09:06:57 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3C922DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 09:06:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [U-Boot] NAND  ECC Error with wrong SMC ording bug
Date: Thu, 20 Aug 2009 15:56:37 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D606E24FE8@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20090820153644.631dbd7b@lappy.seanm.ca>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com><4A8C87E6.6070702@amcc.com><20090820003851.1a532444@lappy.seanm.ca><200908200701.21076.sr@denx.de>
	<20090820153644.631dbd7b@lappy.seanm.ca>
From: "Victor Gallardo" <vgallard@amcc.com>
To: "Sean MacLennan" <smaclennan@pikatech.com>,
	"Stefan Roese" <sr@denx.de>
Cc: Prodyut Hazarika <phazarika@amcc.com>, u-boot@lists.denx.de,
	Feng Kan <fkan@amcc.com>, linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sean,

The change is necessary in both Linux and u-boot. Without this change =
customer are seeing the problem.

Best Regards,

Victor Gallardo

> -----Original Message-----
> From: linuxppc-dev-bounces+vgallardo=3Damcc.com@lists.ozlabs.org =
[mailto:linuxppc-dev-
> bounces+vgallardo=3Damcc.com@lists.ozlabs.org] On Behalf Of Sean =
MacLennan
> Sent: Thursday, August 20, 2009 12:37 PM
> To: Stefan Roese
> Cc: u-boot@lists.denx.de; Feng Kan; linux-mtd@lists.infradead.org; =
linuxppc-dev@ozlabs.org
> Subject: Re: [U-Boot] NAND ECC Error with wrong SMC ording bug
>=20
> On Thu, 20 Aug 2009 07:01:21 +0200
> Stefan Roese <sr@denx.de> wrote:
>=20
> > On Thursday 20 August 2009 06:38:51 Sean MacLennan wrote:
> > > > I see other boards using SMC as well, can someone comment on the
> > > > change I am proposing.
> > > > Should I change the correction algorithm or the calculate
> > > > function? If the later is preferred
> > > > it would mean the change must be pushed in both U-Boot and =
Linux.
> > >
> > > Odds are the calculate function is wrong. The correction algo is
> > > used by many nand drivers, I *assume* it is correct. The calculate
> > > function was set to agree with u-boot (1.3.0).
> >
> > Yes, it seems that you changed the order in the calculation function
> > while reworking the NDFC driver for arch/powerpc. So we should
> > probably change this order back to the original version. And change
> > it in U-Boot as well.
> >
> > BTW: I didn't see any problems with ECC so far with the current =
code.
> > Feng, how did you spot this problem?
>=20
> Ok, I think I have reproduced the problem programmatically. Basically,
> I force a one bit error with the following patch:
>=20
> diff --git a/drivers/mtd/nand/nand_base.c =
b/drivers/mtd/nand/nand_base.c
> index 8c21b89..91dd5b4 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -1628,11 +1628,22 @@ static void nand_write_page_hwecc(struct =
mtd_info *mtd, struct nand_chip
> *chip,
>  	uint8_t *ecc_calc =3D chip->buffers->ecccalc;
>  	const uint8_t *p =3D buf;
>  	uint32_t *eccpos =3D chip->ecc.layout->eccpos;
> +	static int count;
>=20
>  	for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsize) =
{
>  		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
> -		chip->write_buf(mtd, p, eccsize);
> -		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> +		if (count =3D=3D 0) {
> +			count =3D 1;
> +			printk("Corrupt one bit: %08x =3D> %08x\n",
> +			       *p, *p ^ 8);
> +			*(uint8_t *)p ^=3D 8;
> +			chip->write_buf(mtd, p, eccsize);
> +			*(uint8_t *)p ^=3D 8;
> +			nand_calculate_ecc(mtd, p, &ecc_calc[i]);
> +		} else {
> +			chip->write_buf(mtd, p, eccsize);
> +			chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> +		}
>  	}
>=20
>  	for (i =3D 0; i < chip->ecc.total; i++)
>=20
> Basically I write a one bit error to the NAND, but calculate with the
> correct bit. This assumes nand_calculate_ecc is correct.
>=20
> I then added debugs to the correction to make sure it corrected
> properly:
>=20
> diff --git a/drivers/mtd/nand/nand_ecc.c b/drivers/mtd/nand/nand_ecc.c
> index c0cb87d..57dcaa1 100644
> --- a/drivers/mtd/nand/nand_ecc.c
> +++ b/drivers/mtd/nand/nand_ecc.c
> @@ -483,14 +483,20 @@ int nand_correct_data(struct mtd_info *mtd, =
unsigned char *buf,
>  			byte_addr =3D (addressbits[b2 & 0x3] << 8) +
>  				    (addressbits[b1] << 4) + addressbits[b0];
>  		bit_addr =3D addressbits[b2 >> 2];
> +
> +		printk("Single bit error: correct %08x =3D> %08x\n",
> +		       buf[byte_addr], buf[byte_addr] ^ (1 << bit_addr));
> +
>  		/* flip the bit */
>  		buf[byte_addr] ^=3D (1 << bit_addr);
>  		return 1;
>=20
>  	}
>  	/* count nr of bits; use table lookup, faster than calculating it */
> -	if ((bitsperbyte[b0] + bitsperbyte[b1] + bitsperbyte[b2]) =3D=3D 1)
> +	if ((bitsperbyte[b0] + bitsperbyte[b1] + bitsperbyte[b2]) =3D=3D 1) =
{
> +		printk("ECC DATA BAD\n"); // SAM DBG
>  		return 1;	/* error in ecc data; no action needed */
> +	}
>=20
>  	printk(KERN_ERR "uncorrectable error : ");
>  	return -1;
>=20
> With the current ndfc code, the error correction gets the bits wrong.
> Switching it back to the original way and the correction is correct.
>=20
> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> index 89bf85a..497e175 100644
> --- a/drivers/mtd/nand/ndfc.c
> +++ b/drivers/mtd/nand/ndfc.c
> @@ -101,9 +101,8 @@ static int ndfc_calculate_ecc(struct mtd_info =
*mtd,
>=20
>  	wmb();
>  	ecc =3D in_be32(ndfc->ndfcbase + NDFC_ECC);
> -	/* The NDFC uses Smart Media (SMC) bytes order */
> -	ecc_code[0] =3D p[2];
> -	ecc_code[1] =3D p[1];
> +	ecc_code[0] =3D p[1];
> +	ecc_code[1] =3D p[2];
>  	ecc_code[2] =3D p[3];
>=20
>  	return 0;
>=20
> Does anybody see a problem with my method of reproducing the bug? This
> bug is deadly for our customers. I don't want to make the change =
unless
> it is absolutely necessary.
>=20
> Cheers,
>    Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
