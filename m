Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 31D28B7E9A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 05:45:48 +1100 (EST)
Date: Thu, 18 Feb 2010 19:45:29 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFC412BED7.5D5934A3-ONC12576CE.005D5F44-C12576CE.005EBE55@transmode.se>
	(from joakim.tjernlund@transmode.se on Thu Feb 18 18:14:51 2010)
Message-Id: <1266518744.5877.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-0wrqLKuUL/pP+nxhdEa7"
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	ben-linux@fluff.org, iws@ovro.caltech.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-0wrqLKuUL/pP+nxhdEa7
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joakim:

Am 18.02.10 18:14 schrieb(en) Joakim Tjernlund:
> > [snip]
> > > >   static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> > > >   {
> > > > -   writeccr(i2c, 0);
> > > > -   udelay(30);
> > > > -   writeccr(i2c, CCR_MEN);
> > > > -   udelay(30);
> > > > -   writeccr(i2c, CCR_MSTA | CCR_MTX);
> > > > -   udelay(30);
> > > > -   writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > > > -   udelay(30);
> > > > -   writeccr(i2c, CCR_MEN);
> > > > -   udelay(30);
> > > > +   int k;
> > > > +   u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> > > > +
> > > > +   if (delay_val < 2)
> > > > +      delay_val =3D 2;
> > > > +
> > > > +   for (k =3D 9; k; k--) {
> > > > +      writeccr(i2c, 0);
> > > > +      writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > > > +      udelay(delay_val);
> > > > +      writeccr(i2c, CCR_MEN);
> > > > +      udelay(delay_val << 1);
> > > > +   }
> > > >   }
> > >
>>> I am curious, didn't old method work with by just wrapping a for(k=3D9;=
 k; k--) around it? How did the wave form look?
> >
>> Sure does that work!  The waveform was somewhat "streched", mainly due t=
o the delays between some of the writeccr() calls which don't change the sd=
a/scl lines.  Unfortunately I didn't take shots from the scope.
>=20
> Yeah, the long delays has to go. So the wave form was the same but more s=
tretched in time? I ask because I don't understand the writeccr(i2c, CCR_MS=
TA | CCR_MTX); is supposed to do.

Afaict, this is really a no-op.  The '5200 user's manual says about MEN

<snip>
* 0 module is reset and disabled. This is the Power-ON reset. When low the =
interface is held in reset, but registers can still be accessed.
* 1 I2C module is enabled. Bit must be set before other CR bits have any ef=
fect.
</snip>

The change in the MSTA is needed -with the proper delays- as to generate th=
e START and STOP conditions.

Unfortunately, the data sheet is not very clear (or my English too bad), bu=
t reading it *after* seeing the signals on the scope, I can at least guess =
what they mean :-/

Thus, the old code will probably produce SDA and SCL held high for ~90us, t=
hen a SDA/SCL low for ~30us (plus/minus the delays the hw adds internally a=
ccording to the clock setting), and then a ~30us SDA/SCL high.  It is not p=
ossible to get the necessary delays from the data sheet, but as I said I em=
pirically verified some cases to be safe.

> The old code only works when the device is stuck at the last bit. To cope=
 with any bit (worst case is the first bit) you need 9 cycles, 8 bits + ack=
 =3D 9
>=20
> Just toggling the clock 9 cycles should unlock any slave stuck in a read =
operation. To unlock slaves stuck in a write operation you also need to gen=
erate a START in every cycle too.

Yes, of course...  this was the initial motivation of the patch, as I *have=
* a slave which sometimes needs more than one cycle!

> As far as I can tell your patch does all of the above so
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Thanks a lot again for your time, and your helpful comments!

Best, Albrecht.

--=-0wrqLKuUL/pP+nxhdEa7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLfYrYn/9unNAn/9ERAuh5AKDFPpNTEl7JNr1E6kZhs9tbtea4mgCgqNew
XhKsE/T+zkSt9YijWZZdWR0=
=iQcW
-----END PGP SIGNATURE-----

--=-0wrqLKuUL/pP+nxhdEa7--
