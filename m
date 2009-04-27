Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id 96A62DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:18:42 +1000 (EST)
Received: from antares (xdsl-87-79-140-160.netcologne.de [87.79.140.160])
	by smtp3.netcologne.de (Postfix) with ESMTP id 15CA867AE3
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 19:18:40 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id D0385BA03B
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 19:18:39 +0200 (CEST)
Date: Mon, 27 Apr 2009 19:18:31 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: How to use Localbus on 5200B w/ 2.6.29.1
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1240852719.3495.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-uhjNRF9xdH87IOdS4FPq"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-uhjNRF9xdH87IOdS4FPq
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a question about the definition of the localbus on the Freescale =20
5200B (I'm testing with the Lite5200B board) with Kernel 2.6.29.1 which =20
I could not figure out with the docs and the list archives...

When I use 'compatible =3D "fsl,mpc5200b-lpb";' in the dts file, the =20
localbus and any nodes below it don't show up in /sys/devices.

When I use the following (top-level, not under the soc node) in the dts =20
file

<snip>
localbus {
	compatible =3D "fsl,lpb";
	#address-cells =3D <2>;
	#size-cells =3D <1>;
	reg =3D <0xf0000300 0x32>;
	ranges =3D < 0 0 0xfc000000 0x02000000
		   3 0 0xf0020000 0x00010000 >;
	flash@0,0 {
		compatible =3D "cfi-flash";
		reg =3D <0 0x0 0x2000000>;	// 32 MB
		bank-width =3D <1>;		// width in bytes of =20
the flash bank
		device-width =3D <1>;		// one devices on each =20
bank
		#size-cells =3D <1>;
		#address-cells =3D <1>;
	};

	mydev@3,0 {
		compatible =3D "mydev";
		reg =3D <0 0x0 0x100>;		// 256 Bytes, 32 used
		interrupts =3D <1 3 2>;		// todo - level?
		interrupt-parent =3D <&mpc5200_pic>;
	};
};
</snip>

I see in /sys/devices

<snip>
# ls -al /sys/devices/
drwxr-xr-x    7 0        0               0 Jan  1 00:00 .
drwxr-xr-x   11 0        0               0 Jan  1 00:00 ..
drwxr-xr-x   31 0        0               0 Jan  1 00:00 f0000000.soc5200
drwxr-xr-x    4 0        0               0 Jan  1 00:00 =20
f0000300.localbus
drwxr-xr-x    2 0        0               0 Jan  1 00:00 platform
drwxr-xr-x    5 0        0               0 Jan  1 00:00 system
drwxr-xr-x    8 0        0               0 Jan  1 00:00 virtual
</snip>

Does this mean that the documentation (and some existing dts files) are =20
inaccurate?  What is the proper way to specify the localbus (or, in =20
particular, it's child nodes) on the 5200B?

In /sys/devices/f0000300.localbus, I see

<snip>
# ls -al /sys/devices/f0000300.localbus/
drwxr-xr-x    4 0        0               0 Jan  1 00:00 .
drwxr-xr-x    7 0        0               0 Jan  1 00:00 ..
-r--r--r--    1 0        0            4096 Jan  1 00:00 devspec
drwxr-xr-x    2 0        0               0 Jan  1 00:00 fc000000.flash
drwxr-xr-x    2 0        0               0 Jan  1 00:00 fc000000.mydev
-r--r--r--    1 0        0            4096 Jan  1 00:00 modalias
-r--r--r--    1 0        0            4096 Jan  1 00:00 name
lrwxrwxrwx    1 0        0               0 Jan  1 00:00 subsystem -> =20
../../bus/of_platform
-rw-r--r--    1 0        0            4096 Jan  1 00:00 uevent
</snip>

which is also confusing, as both devices appear to have the same =20
address?  Any idea what goes wrong here?

The flash device itself (mydev isn't present yet...) also doesn't work =20
although mtd is enabled, but that's probably a different problem.

Any help would be really welcome!

Thanks in advance,
Albrecht.

--=-uhjNRF9xdH87IOdS4FPq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBJ9ejvn/9unNAn/9ERAn6mAKCeApprI2pyeuyWmReKx609axzB/ACeNMuE
bqEo1QDvyW4o5/cP6K20LBY=
=Aljk
-----END PGP SIGNATURE-----

--=-uhjNRF9xdH87IOdS4FPq--
