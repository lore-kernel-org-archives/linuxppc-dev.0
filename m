Return-Path: <michael@ellerman.id.au>
Subject: Re: "event-scan failed" logflood
From: Michael Ellerman <michael@ellerman.id.au>
To: nello martuscielli <ppc.addon@gmail.com>
In-Reply-To: <loom.20100518T182547-195@post.gmane.org>
References: <20100513111603.3352.qmail@kosh.dhis.org>
	<1273786104.21352.190.camel@pasglop>
	<loom.20100517T145602-17@post.gmane.org>
	<1274185991.26143.1.camel@concordia>
	<loom.20100518T182547-195@post.gmane.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-YoutYKJJDmBYrVYinmpJ"
Date: Wed, 19 May 2010 11:39:22 +1000
Message-ID: <1274233162.29980.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-YoutYKJJDmBYrVYinmpJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-18 at 16:30 +0000, nello martuscielli wrote:
> Michael Ellerman <michael <at> ellerman.id.au> writes:
>=20
> _omissis__
> > >=20
> > > hi, is there available that patch?
> > > With the fresh new 2.6.34 the logflood problem is still present.
> >=20
> > You could try this, completely untested:
> >=20
> > diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> > index 4190eae..fd68bed 100644
> > --- a/arch/powerpc/kernel/rtasd.c
> > +++ b/arch/powerpc/kernel/rtasd.c
> > @@ -490,6 +490,12 @@ static int __init rtas_init(void)
> >                 return -ENODEV;
> >         }
> >=20
> > +       if (!rtas_event_scan_rate) {
> > +               /* Broken firmware: take a rate of zero to mean don't s=
can */
> > +               printk(KERN_DEBUG "rtasd: scan rate is 0, not scanning\=
n");
> > +               return 0;
> > +       }
> > +
> >         /* Make room for the sequence number */
> >         rtas_error_log_max =3D rtas_get_error_log_max();
> >         rtas_error_log_buffer_max =3D rtas_error_log_max + sizeof(int);
> >=20
>=20
>=20
> hi Michael, thanks for pointing me to that patch, now my Pegasos2 G4 seem=
s to
> work fine.

Great. Can I add Tested-by you?

> Anyway i got these dumps caused by mv643xx_eth:
>=20
>=20
> [...]
> sysfs: cannot create duplicate filename '/class/mdio_bus/0'
> ------------[ cut here ]------------
> Badness at fs/sysfs/dir.c:451
> NIP: c00efc70 LR: c00efc70 CTR: 00000000
> REGS: ef117c70 TRAP: 0700   Not tainted  (2.6.34)
> MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22002488  XER: 00000000
> TASK =3D ef110630[80] 'modprobe' THREAD: ef116000
> GPR00: c00efc70 ef117d20 ef110630 00000042 c0009480 00000000 00134ac8 000=
00000
> GPR08: 00000000 00000000 22002482 10000002 ffffffff 10023ab8 00000000 000=
00000
> GPR16: 00000000 107db0b0 00000000 107db088 10005558 00000003 107db324 107=
db008
> GPR24: 10005558 00000000 0000a9ce fffffffe ef117d48 ef0a4300 efb87000 fff=
fffef
> NIP [c00efc70] sysfs_add_one+0x88/0xb8
> LR [c00efc70] sysfs_add_one+0x88/0xb8
> Call Trace:
> [ef117d20] [c00efc70] sysfs_add_one+0x88/0xb8 (unreliable)
> [ef117d40] [c00f0d9c] sysfs_do_create_link+0x104/0x1ac
> [ef117d70] [c026b238] device_add+0x1c8/0x534
> [ef117db0] [c02b2e40] mdiobus_register+0xb4/0x1d8
> [ef117de0] [f222c510] mv643xx_eth_shared_probe+0x14c/0x420 [mv643xx_eth]

Can't really help with that, looks like it's trying to register the same
mdio bus twice?

cheers

--=-YoutYKJJDmBYrVYinmpJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvzQUoACgkQdSjSd0sB4dJIHwCeP9XRxHLo0Qoib5+EDsEmUXU3
mgoAnRZZSS2d+UwxhDdZWqQc/ZqPE39e
=/7os
-----END PGP SIGNATURE-----

--=-YoutYKJJDmBYrVYinmpJ--
