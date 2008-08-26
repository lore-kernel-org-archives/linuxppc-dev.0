Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id 71178DE85B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 03:02:09 +1000 (EST)
Received: from antares (xdsl-87-78-252-224.netcologne.de [87.78.252.224])
	by smtp3.netcologne.de (Postfix) with ESMTP id C324C674AB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 19:02:06 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 7AEEBBA065
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 19:02:06 +0200 (CEST)
Date: Tue, 26 Aug 2008 19:01:59 +0200
From: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
Subject: Compile new kernel for 5200B w/ ELDK
To: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
Message-Id: <1219770125l.5709l.0l@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-BGDXFSTMGN/QIpVu8da0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-BGDXFSTMGN/QIpVu8da0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

please excuse a probably really dumb question about compiling a new =20
kernel for a Freescale 5200B using the ELDK 4.2...

I am playing with a Lite5200B eval board.  The software coming from =20
Freescale, including an older kernel (2.6.16.11-rt18), works fine.

I installed ELDK 4.2 on a FC box, and first compiled u-boot 1.3.4.  =20
Wrote it to flash, and it works nicely afaict.

Then I compiled the 2.6.24.2 kernel coming with the ELDK, using the =20
commands "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200_defconfig ;=
 =20
make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage".  The kernel loads, =20
decompresses, but then there is no output any more after "Uncompressing =20
Kernel Image ... OK".  The u-boot environment contains (quoted from =20
printenv) "bootargs=3Dconsole=3DttyPSC0,115200 root=3D/dev/mtdblock0 rw =20
rootfstype=3Djffs2 verbose" (and, again, the Freescale kernel is not =20
silent).

I found a message which stated that I should include

<snip>
         chosen {
                 linux,stdout-path =3D "/soc5200@f0000000/serial@2000";
	};
</snip>

in the file arch/powerpc/boot/dts/lite5200.dts.  Recompiled, but =20
without success.  I believe it's a minor tweak I need to add, but I =20
don't have a clue what.  Unfortunately neither the wiki nor Google gave =20
answers.  Can anyone enlighten me??

Thanks,
Albrecht.

--=-BGDXFSTMGN/QIpVu8da0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBItDcNn/9unNAn/9ERAoOQAJ9WRngM6IU9iVkQef9c7LtFSTpjugCfbkY1
EvGTIAmiAtpcZ4pq9v4Mvk8=
=cH5H
-----END PGP SIGNATURE-----

--=-BGDXFSTMGN/QIpVu8da0--
