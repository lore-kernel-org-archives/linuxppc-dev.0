Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 201871007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 07:22:09 +1100 (EST)
Date: Mon, 25 Jan 2010 21:21:57 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery
To: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <20100125040653.GS10014@trinity.fluff.org> (from
	ben-linux@fluff.org on Mon Jan 25 05:06:53 2010)
Message-Id: <1264450925.2315.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-NgTbUQH8tRWQ060ketV7"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-NgTbUQH8tRWQ060ketV7
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.01.10 05:06 schrieb(en) Ben Dooks:
> On Fri, Jan 22, 2010 at 09:17:55PM +0100, Albrecht Dre=DF wrote:
>> Improve the recovery of the MPC5200B's I2C bus from errors like bus hang=
s.
>=20
> This is very sparse comapred to the large comment below the --- line, may=
be some more description should be living up here.

Hmm, that was my interpretation of #15 in Documentation/SubmittingPatches..=
. ;-)  Maybe it should read

<snip>
Improve the recovery of the MPC5200B's I2C bus from errors like bus hangs. =
 This includes making the bus timeout configurable, a better detection of c=
ases where the bus has to be "fixed" after a timeout, and a more thorough f=
ixup sequence.
</snip>

> Is thios a candidate for an -rc or should it be left to merge window?

Well, basically it was a rfc.  I apparently need it on my 5200B board, but =
I hoped to get some more insight from the Freescale/I2C gurus (see "open qu=
estions" in the post).  Thus merge window, IMHO...

Thanks, Albrecht.

>=20
> > Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> >
> > ---
> >
> > This patch introduces several improvements to the MPC5200B's I2C driver
> > as to improve the recovery from error conditions I encountered when
> > testing a custom board with several I2C devices attached (eeprom, io
> > expander, rtc, sensors).  The error conditions included cases where the
> > bus if logic of one slave apparently went south, blocking the bus
> > completely.
> >
> > My fixes include:
> > 1. make the bus timeout configurable in fsl_i2c_probe(); the default of
> >    one second is *way* too long for my use case;
> > 2. if a timeout condition occurs in mpc_xfer(), mpc_i2c_fixup() the bus
> >    if *any* of the CF, BB and RXAK flags in the MSR is 1.  I actually
> >    saw different combinations with hangs, not only all three set;
> > 3. improve the fixup procedure by calculating the timing needed from th=
e
> >    real (configured) bus clock, calculated in mpc_i2c_setclock_52xx().
> >    Furthermore, I issue 9 instead of one cycle, as I experienced cases
> >    where the single one is not enough (found this tip in a forum).  As =
a
> >    side effect, the new scheme needs only 81us @375kHz bus clock instea=
d
> >    of 150us.  I recorded waveforms for 18.4kHz, 85.9kHz and 375kHz, all
> >    looking fine, which I can provide if anyone is interested.
> >
> > Open questions:
> > - is the approach correct at all, in particular the interpretation of
> >   the flags (#2)?
> > - could this code also be used on non-5200 processors?
> >
> > --- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c	2009-12-03 04:51:21.=
000000000 +0100
> > +++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c	2010-01-22 16:05:13.00000=
0000 +0100
[snip]

--=-NgTbUQH8tRWQ060ketV7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLXf1tn/9unNAn/9ERAt2cAJ9b2bt+BiRLEIO9C8E+7NhzcKdR4QCgu9Lv
pg6d4FlaItCwklfm5elFqQ0=
=FzKC
-----END PGP SIGNATURE-----

--=-NgTbUQH8tRWQ060ketV7--
