Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 2F260DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 06:09:26 +1100 (EST)
Received: from antares (xdsl-78-34-234-207.netcologne.de [78.34.234.207])
	by smtp4.netcologne.de (Postfix) with ESMTP id 9DF19DA9AE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 19:44:36 +0100 (CET)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 30274BA629
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 19:44:36 +0100 (CET)
Date: Thu, 26 Mar 2009 19:44:26 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Q: define i2c nodes in device tree?
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1238093075.5262.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-uvHnmspbTOzLpAg+sYFx"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-uvHnmspbTOzLpAg+sYFx
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have some probably dumb questions regarding the definition of i2c =20
slaves in the of device tree file...

My test system is a lite5200b board to which I attached two pca8575 io =20
expander chips at i2c addresses 0x20 and 0x21.  Using the stock kernel =20
2.6.29, I added the driver from the GPIO section, but I couldn't figure =20
out how to add them to the dts file.  I tried e.g.

<snip>
i2c@3d40 {
	[...]
         compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
         [...]

         gpio@20 {
                 compatible =3D "pcf857x";
                 device_type =3D "gpio";
                 reg =3D <0x20 1>;
	};
};
</snip>

and some other like "gpio-controller" instead of "gpio" but (surprise) =20
it doesn't work - dmesg says that the driver is registered, but nothing =20
else shows up.  Unfortunately, I couldn't find documentation about the =20
naming conventions of the i2c child nodes.

As I actually want to use the chips as parallel io (not separate =20
gpio's) and thus would need to write my own driver I wonder if I really =20
have to declare it in the device tree?  Would the simple way -just load =20
the kernel module as with arm/intel- also work?  Would it be possible =20
to use additional resources like an interrupt pin on the '5200 without =20
the device tree?

Any information about a proper approach would be really helpful!

Thanks in advance, Albrecht.

--=-uvHnmspbTOzLpAg+sYFx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBJy80Tn/9unNAn/9ERAhjeAJ9BgZ/MZNiePRqdCIfanE/cRRzkYQCfZPCy
DFxI7Xdl1DDkBJupvh+B+hM=
=Jx6N
-----END PGP SIGNATURE-----

--=-uvHnmspbTOzLpAg+sYFx--
