Return-Path: <michael@ellerman.id.au>
Subject: Re: Bootlog bug?
From: Michael Ellerman <michael@ellerman.id.au>
To: ron_madrid@sbcglobal.net
In-Reply-To: <736813.1073.qm@web83507.mail.sp1.yahoo.com>
References: <736813.1073.qm@web83507.mail.sp1.yahoo.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-PgF9NOpRqdLECqYfcXbZ"
Date: Fri, 27 Mar 2009 09:51:27 +1100
Message-Id: <1238107887.15460.3.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PgF9NOpRqdLECqYfcXbZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-03-26 at 11:25 -0700, Ron Madrid wrote:
> I have a little problem with my boot messages.  I'm not sure what this
> is, but does anyone have any ideas as to what it could be or what
> further information I could give to help track this down.  As of now
> this is not manifesting itself, but I don't know what it might do.

You have ended up with a duplicate device, or duplicate device _name_,
somehow.

This is the warn:

WARN(ret =3D=3D -EEXIST, KERN_WARNING "sysfs: duplicate filename '%s' "
                       "can not be created\n", sd->s_name);

Turning on verbose bug info would show you the name.

cheers

> ------------[ cut here ]------------
> Badness at c00bdebc [verbose debug info unavailable]
> NIP: c00bdebc LR: c00bdea4 CTR: 00000000
> REGS: c7827d90 TRAP: 0700   Not tainted  (2.6.27)
> MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER: 20000000
> TASK =3D c7816400[1] 'swapper' THREAD: c7826000
> GPR00: c00bdea4 c7827e40 c7816400 ffffffef c7800dcc c7800afc c7811540 000=
00000
> GPR08: 000001e0 c03c0000 00000040 00000000 82044048 10101400 07ffb000 000=
00000
> GPR16: 07ff0350 07ff59b4 00000000 00000000 00000000 c03ac84c c03ac820 c78=
57210
> GPR24: 00000000 00000000 00000000 00000001 c7811540 fffffffe c78b4480 c78=
27e58
> NIP [c00bdebc] sysfs_add_one+0x28/0x30
> LR [c00bdea4] sysfs_add_one+0x10/0x30
> Call Trace:
> [c7827e40] [c00bdea4] sysfs_add_one+0x10/0x30 (unreliable)
> [c7827e50] [c00bf12c] sysfs_do_create_link+0xac/0x15c
> [c7827e80] [c01a09b4] bus_add_device+0xf4/0x190
> [c7827ea0] [c019f1a0] device_add+0x38c/0x5c8
> [c7827ef0] [c0225db4] of_device_register+0x24/0x34
> [c7827f00] [c0009844] of_platform_device_create+0x44/0x74
> [c7827f10] [c00098ec] of_platform_bus_create+0x78/0xc8
> [c7827f30] [c0009a5c] of_platform_bus_probe+0x120/0x150
> [c7827f50] [c037a3e4] __machine_initcall_mpc831x_rdb_declare_of_platform_=
devices+0x4c/0x60
> [c7827f60] [c0003874] do_one_initcall+0x38/0x188
> [c7827fd0] [c036917c] kernel_init+0x88/0xf4
> [c7827ff0] [c0011b10] kernel_thread+0x44/0x60

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PgF9NOpRqdLECqYfcXbZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknMBu8ACgkQdSjSd0sB4dLTTgCglY0tkysG+bEACjKN/3z7iKfr
qtoAnic/jyjS0J9STY+leVVofJkcGtso
=nANt
-----END PGP SIGNATURE-----

--=-PgF9NOpRqdLECqYfcXbZ--
