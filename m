Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id C1E9667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 22:53:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Thu, 31 Mar 2005 07:53:04 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB9205376@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Atit_Shah" <Atit_Shah@Satyam.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Linux crashes during memory mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 	I do not have any problem with the functioning of U-Boot but
Linux crashes after      =20
> printing "Uncompressing Kernel ... OK" and then it seems that nothing
is happening.

Do you have the SYPCR(serial watch dog timer) disabled?

=09


>	3. The memory map of the VPN Board (MY BOARD) is as folllows:=20
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>	Memory Region            Size
Address Range                        =20
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>	SDRAM                    32MByte                      0000_0000
-- 01FF_FFFF                 =20
>	Flash                    32MByte                      FF00_0000
-- FFFF_FFFF  =20

Have you done a full test to make sure your RAM is correctly mapped?

	 =20

>	This is what the console log buffer has shown:=20
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>	md 0x00177e34=20
>
>	00177e34: 3c363e6d 73746172 743d303c 363e6d73
<6>mstart=3D0<6>ms=20
>	00177e44: 697a653d 303c363e 66737461 72743d30
ize=3D0<6>fstart=3D0=20
>	00177e54: 3c363e66 73697a65 3d303c36 3e696d6d
<6>fsize=3D0<6>imm=20
>	00177e64: 723d303c 363e626f 74666c61 673d303c
r=3D0<6>botflag=3D0<=20
>	00177e74: 363e6970 6164643d 303c363e 65616464
6>ipadd=3D0<6>eadd=20
>	00177e84: 3d633031 35303032 383c363e 65737065
=3Dc0150028<6>espe=20
>	00177e94: 643d303c 363e696e 6974663d 303c363e
d=3D0<6>initf=3D0<6>=20
>	00177ea4: 62757366 3d303c36 3e63706d 663d303c
busf=3D0<6>cpmf=3D0<=20
>	00177eb4: 363e6272 67663d30 3c363e73 6363663d
6>brgf=3D0<6>sccf=3D=20
>	00177ec4: 303c363e 76636f3d 303c363e 62617564
0<6>vco=3D0<6>baud=20
>	00177ed4: 3d304f6f 70733a20 6b65726e 656c2061    =3D0Oops: kernel
a=20
=09
These values do not look correct.  Everything is zero.
