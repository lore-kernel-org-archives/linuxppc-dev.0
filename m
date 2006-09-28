Return-Path: <benedikt@horos.benedikt-wildenhain.de>
Received: from ngc224.gerwinski.de (ngc224.gerwinski.de [213.133.98.203])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDB4C67BC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 02:49:24 +1000 (EST)
Received: from [84.60.56.89] (helo=localhost)
	by ngc224.gerwinski.de with esmtpsa (Exim 4.50 #1 (Debian))
	id 1GSyPh-0000yu-K8
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Sep 2006 18:07:14 +0200
Received: from benedikt by localhost with local (Exim 4.50) id 1GSyP8-0004dh-0d
	for linuxppc-embedded@ozlabs.org; Thu, 28 Sep 2006 18:06:30 +0200
Date: Thu, 28 Sep 2006 18:06:26 +0200
From: Benedikt Wildenhain <benedikt@benedikt-wildenhain.de>
To: linuxppc-embedded@ozlabs.org
Subject: Running Linux on Avnet's FX12 Evaluation Board
Message-ID: <20060928160624.GA13955@horos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to run a Linuxppc 2.4 kernel (20051021) on an IBM Powerpc
405, I have compiled it according to the instructions on
http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/uclinux_powerpc/#linuxp=
pc-2,
I load it into the ram using the Xilinx Microprocessor Debug (XMD)
Engine and try to run it, but it seems to have some trouble with the
memory:

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.30-pre1 (benedikt@horos) (gcc version 3.4.1) #41 =C4=B5a=
=EF=BF=BD- Sep 28 01:03:33 CEST 2006
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista=
=2Ecom)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 598.01 BogoMIPS
Memory: 30968k <4>Oops: kernel access of bad area, sig: 11
NIP: FFFFFFFC XER: 20000010 LR: FFFFFFFE SP: C0126580 REGS: c01264d0 TRAP: =
0400    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c01248d0[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: FFFFFFFE C0126580 C01248D0 C01248D0 00000000 00000001 C01249D0 00000=
048
GPR08: 00000048 00000000 00000000 00000017 C0140000 FFFFFFFF FFFFFFFF FFFFF=
FFF
GPR16: FFFFFFFF FFFFFFFF FFFFFFFF C012770C 00001032 00126600 C0000000 C013E=
1D0
GPR24: C013E8CC C0140000 C012770C C0140000 000001E6 00000001 00000000 C0124=
8D0
Call backtrace:
FFFFFFFE C001D664 C00044F4 C0002C80 00000000 C009582C C00958B4
C00138F0 C0013B94 C0013DDC C0136374 C0134374 C0002328
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..
loaded at:     00400000 004F01E0
board data at: 004ED138 004ED150
relocated to:  00405310 00405328
zimage at:     004058D5 004EC21E
avail ram:     004F1000 02000000

Do I have to set any memory positions or something like that manually?
I also tried to compile the Kernel with XMON support, but this also
failed:

/space/benedikt/crosstool/gcc-3.4.1-glibc-2.3.3/powerpc-405-linux-gnu/bin/p=
owerpc-405-linux-gnu-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic =
arch/ppc/kernel/head_4xx.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o arch/ppc/mm/=
mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/=
math-emu/math-emu.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o driv=
ers/net/net.o drivers/mtd/mtdlink.o drivers/macintosh/macintosh.o drivers/m=
edia/media.o \
        net/network.o \
        /space/benedikt/tfc/uclinux/linuxppc-2.4/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/xmon/x.o(.text+0x64): In function `xmon_map_scc':
/space/benedikt/tfc/uclinux/linuxppc-2.4/arch/ppc/xmon/start.c:218: undefin=
ed reference to `__sysrq_put_key_op'
make: *** [vmlinux] Error 1

--=20
GPG-Key 1024D/E32C4F4B | www.gnupg.org | http://enigmail.mozdev.org
Fingerprint =3D 9C03 86B5 CA59 F7A3 D976  AD2C 02D6 ED21 E32C 4F4B
Mit freundlichen Gruessen | Kun afablaj salutoj (www.esperanto.org)
May the tux be with you.  :wq 73

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFG/L/AtbtIeMsT0sRAluxAJ0cAMm6KNZ4U3jfrM7CPOiVyO7EqwCeOMqE
gdzjOJ/D6auaL79gT7yHzPA=
=7SnJ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
