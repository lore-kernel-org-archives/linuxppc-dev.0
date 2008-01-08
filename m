Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7AB94DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:36:59 +1100 (EST)
Date: Tue, 8 Jan 2008 17:36:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c-ibm_iic driver - new patch
Message-Id: <20080108173636.73db1623.sfr@canb.auug.org.au>
In-Reply-To: <4783108B.6070308@pikatech.com>
References: <477EF225.4070505@pikatech.com> <200801051354.11202.arnd@arndb.de>
	<477FCE21.9080808@pikatech.com> <200801052018.22954.arnd@arndb.de>
	<20080106001238.GI4326@localhost.localdomain>
	<4782D9E0.4070600@pikatech.com>
	<20080108155240.503ca3ab.sfr@canb.auug.org.au>
	<4783108B.6070308@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_17_36_39_+1100_M+nUzwIWbQ+fzZIJ"
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

--Signature=_Tue__8_Jan_2008_17_36_39_+1100_M+nUzwIWbQ+fzZIJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jan 2008 00:56:27 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> Stephen Rothwell wrote:
> >
> > On Mon, 07 Jan 2008 21:03:12 -0500 Sean MacLennan <smaclennan@pikatech.=
com> wrote:
> >  =20
> > Please don't post patches as attachments.
> =20
> Ok.

Unfortunately, you are using thunderbird and so the patch is now wrapped.
There is a workaround, see Documentation/email-clients.txt.

> > Please split the assignments from the tests.  Here and elsewhere.
> >  =20
> I made the changes in my code. I am trying to leave the original code as=
=20
> much as possible.

Thats all we ask.

> >> +	} else {
> >> +		if (dev->irq !=3D NO_IRQ){
> >> +		    iic_interrupt_mode(dev, 0);
> >> +		    free_irq(dev->irq, dev);
> >> +		}
> >> +		iounmap(dev->vaddr);
> >> +		kfree(dev);
> >>    =20
> >
> > Should these last two be after the below brace?
> >
> >  =20
> I'm not really qualified to answer, but I will anyway ;) I assume the=20
> original author is basically saying if he cannot delete the adapter, it=20
> is unsafe to free the memory since the i2c code may still use it. If I=20
> have read that right, then I agree.

OK, I can see that this is a "that should not happen" condition.

> +    if (iic_force_poll)
> +        dev->irq =3D NO_IRQ;
> +    else if ((dev->irq =3D irq_of_parse_and_map(np, 0)) =3D=3D NO_IRQ)

You missed this one.

Overall looks better, except all your indentation is now 4 spaces. We use
a TAB character for each level of indentation and you should be able to
set your editor to *display* the TABs as 4 places if that is what you like.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_17_36_39_+1100_M+nUzwIWbQ+fzZIJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgxn/TgG2atn1QN8RAtBIAKCHg2NFGf8p5JVvmVaWz2lQ55PbcgCgluVs
hl45GZLTvs7hgHi57j5Swck=
=2rDD
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_17_36_39_+1100_M+nUzwIWbQ+fzZIJ--
