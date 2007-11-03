Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 1ACEEDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 14:40:19 +1100 (EST)
Message-ID: <394123578.13658@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: Stuart Hodgson <stuart@quadrics.com>
Subject: Re: GDB bdi2000 and mpc85xx
Date: Sat, 3 Nov 2007 11:40:17 +0800
References: <394028554.26200@lzu.edu.cn>
In-Reply-To: <394028554.26200@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart54282908.afRgL8PG6y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711031140.20213.wangbj@lzu.edu.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart54282908.afRgL8PG6y
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 03 November 2007 01:17:48, Stuart Hodgson wrote=EF=BC=9A
> Hi,
>
> I am attempting to get Kernel debugging working on our mpc8541 based
> board via a BDI2000. The various components in use are
>
> kernel - 2.6.19.2
> BDI firmware - 1.08
> U-Boot - 1.2.0
> ppc_85xx-gdb - from eldk4.1 (6.3.0.0-1.21_3rh)
>
>
> Kernel is configured with `-g` in CFLAGS and not with CONFIG_BDI_SWITCH,
> from the information I have read around the subject this seem to be
> correct. I also have `MMU  XLAT`, and `PTBASE 0xF0` set in by BDI
> configuration file. The default value for XLAT of `0xc0000000` matches
> the kernel our kernel config.
>
> Steps that I done so far
>
> 1. Power on BDI
> 2. Power on the board
> 3. BDI> reset run
> 4. Enter u-boot environment to stop linux booting immediately.
> 5. BDI> HALT
> 6. BDI> BREAK HARD
> 7. BDI> BI 0xc025a51c   (this is the address of start_kernel for my build)
> 8. BDI> GO
> 9. From U-boot prompt `bootm`, kernel is copied from flash and loading
> begins
> 10. Kernel does not halt at start_kernel and continues to the login
>
> If I attempt to break at an address later in the boot sequence, such as
> qmx19_ata_input_data (this is the area that I am trying to investigate)
> I get
>
> - TARGET: core #0 has entered debug mode
>
> So from here I attempt to connect to the BDI from gdb
>
> linux> cd ~/linux-2.6.19.2
> linux> ppc_85xx-gdb vmlimux
Most of the operation could be done within gdb

BDI> reset

powerpc-unknown-linux-gnu-gdb vmlinux
(gdb) target remote bdi:2001
(gdb) ^C
(gdb) b *0x12345678
(gdb) c
=2E..
> "
> GNU gdb Red Hat Linux (6.3.0.0-1.21_3rh)
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you
> are welcome to change it and/or distribute copies of it under certain
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for detail=
s.
> This GDB was configured as "--host=3Di386-redhat-linux --target=3Dppc-lin=
ux".
> The target architecture is set automatically (currently powerpc:603)
> "
>
> I noticed here that the last line does not match the e500 core I am
> using, but there does not seem to a change if I change this using `set
> architecture powerpc:e500`
>
>
> (gdb) tar rem <bdi_ip>:2001
> Remote debugging using <bdi_ip>:2001
> 0x00000000 in ?? ()

Which configuration file do you use for mpc85xx? probably is the config fil=
e=20
problem?

> What I don't understand here is why 0x00000000 is shown as the address,
> further on the BDI the following error is shown then the connection is ma=
de
>
> "
> *** MMU: address translation for 0x00000000 failed

> Stuart Hodgson
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Wang

=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022

--nextPart54282908.afRgL8PG6y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHK+2hIuIOr7tpgg0RAm0PAKCueMJpbJ4NiudBEI70a3GiyXXepgCgjOlN
JhlW1BcBBbaKhFmNH4V657g=
=J6oW
-----END PGP SIGNATURE-----

--nextPart54282908.afRgL8PG6y--
