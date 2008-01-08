Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5856CDDE3E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 15:52:52 +1100 (EST)
Date: Tue, 8 Jan 2008 15:52:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c-ibm_iic driver - new patch
Message-Id: <20080108155240.503ca3ab.sfr@canb.auug.org.au>
In-Reply-To: <4782D9E0.4070600@pikatech.com>
References: <477EF225.4070505@pikatech.com> <200801051354.11202.arnd@arndb.de>
	<477FCE21.9080808@pikatech.com> <200801052018.22954.arnd@arndb.de>
	<20080106001238.GI4326@localhost.localdomain>
	<4782D9E0.4070600@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_15_52_40_+1100_yaybGaNuTtAttHi1"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_15_52_40_+1100_yaybGaNuTtAttHi1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Mon, 07 Jan 2008 21:03:12 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>

Please don't post patches as attachments.

> +static int __devinit iic_probe(struct of_device *ofdev,
> +							   const struct of_device_id *match)

Indenting could be better.

> +{

> +	if (!(dev =3D kzalloc(sizeof(*dev), GFP_KERNEL))) {

Please split the assignments from the tests.  Here and elsewhere.

> +		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");

I am not sure that these messages are necessary and, even if so, not KERN_C=
RIT.

> +	if(iic_force_poll)

Space after "if"

> +	if (dev->irq !=3D NO_IRQ) {
	.
	.
> +	}
> +
> +	if (dev->irq =3D=3D NO_IRQ)

	else instead?

> +		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
> +			   dev->idx);
> +static int __devexit iic_remove(struct of_device *ofdev)
> +{
> +	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_get_drvdat=
a(&ofdev->dev);

Unnecessary cast.

> +	if (i2c_del_adapter(&dev->adap)){
> +		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
> +			dev->idx);

This is not a KERN_CRIT situation ...

> +		/* That's *very* bad, just shutdown IRQ ... */
> +		if (dev->irq >=3D 0){

What is that testing? For NO_IRQ as below?

> +		    iic_interrupt_mode(dev, 0);
> +		    free_irq(dev->irq, dev);
> +		    dev->irq =3D -1;

NO_IRQ?

> +		}
> +	} else {
> +		if (dev->irq !=3D NO_IRQ){
> +		    iic_interrupt_mode(dev, 0);
> +		    free_irq(dev->irq, dev);
> +		}
> +		iounmap(dev->vaddr);
> +		kfree(dev);

Should these last two be after the below brace?

> +	}
> +
> +	return 0;
> +}
> +
> +
> +static struct of_device_id ibm_iic_match[] =3D

This should be const.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_15_52_40_+1100_yaybGaNuTtAttHi1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgwGcTgG2atn1QN8RAuPBAKCSQGatOBkCRR2CiohHSEca4LBlKACgldxZ
kPNPtpttoc6nOB2RJtM98bo=
=Is5y
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_15_52_40_+1100_yaybGaNuTtAttHi1--
