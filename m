Return-Path: <s104259@yahoo.it>
Date: Wed, 3 Sep 2008 14:10:56 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Boot 2.6.26 (or similar) on mpc5200 using powerpc
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1086330714-1220451056=:58253"
Message-ID: <135716.58253.qm@web23107.mail.ird.yahoo.com>
Reply-To: s104259@yahoo.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1086330714-1220451056=:58253
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi.

Does anyone boots on mpc5200 board, the linux kernel 2.6.26 (or .24 .25) us=
ing ARCH=3Dpowerpc?

Looking on web i known that it's very different from ppc mode and the right=
 procedure to follow is:

1 - make lite5200b_defconfig ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-g=
nu-
2 - make cuImage.lite5200b ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu=
-

The output of second command is:
...
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/linux/version.h
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/linux/utsrelease.h
=C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/linux/compile.h
=C2=A0 CALL=C2=A0=C2=A0=C2=A0 arch/powerpc/kernel/systbl_chk.sh
=C2=A0 CALL=C2=A0=C2=A0=C2=A0 arch/powerpc/kernel/prom_init_check.sh
arch/powerpc/boot/dtc -O dtb -o arch/powerpc/boot/lite5200b.dtb -b 0=C2=A0 =
/home/asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/boot/dts/lite5200b.dts
DTC: dts->dtb=C2=A0 on file "/home/asimmini/Scrivania/linux-2.6.26.3/arch/p=
owerpc/boot/dts/lite5200b.dts"
=C2=A0 WRAP=C2=A0=C2=A0=C2=A0 arch/powerpc/boot/cuImage.lite5200b
Image Name:=C2=A0=C2=A0 Linux-2.6.26.3
Created:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Wed Sep=C2=A0 3 15:56:16 2008
Image Type:=C2=A0=C2=A0 PowerPC Linux Kernel Image (gzip compressed)
Data Size:=C2=A0=C2=A0=C2=A0 1597696 Bytes =3D 1560.25 kB =3D 1.52 MB
Load Address: 0x00400000
Entry Point:=C2=A0 0x00400550
rm arch/powerpc/boot/lite5200b.dtb=20

But, at this point, if i crosscompile in ppc mode i had to modify the Load =
Address wiht the mkimage tool because the SDRAM at the Bootloader time star=
ts from 0xF8000000, while the uImage has a Load Address and Entry Point at =
0x00000000.=20
What should i do in powerpc mode??


However, on web i saw that to boot the board it's necessary to load the cuI=
mage and rootfs.uimage on the board with:
=3D> usb start
=3D> usb scan
=3D> fatload usb 0 0x03000000 cuImage.lite5200b
=3D> fatload usb 0 0x04000000 rootfs.uimage
=3D> bootm 0x03000000 0x04000000

Does anyone solves this problem?

Thank you in advance.
=0A=0A__________________________________________________=0ADo You Yahoo!?=
=0APoco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tan=
to spazio gratuito per i tuoi file e i messaggi =0Ahttp://mail.yahoo.it 
--0-1086330714-1220451056=:58253
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi.<br><br>Does anyone boots on mpc5200 board=
, the linux kernel 2.6.26 (or .24 .25) using ARCH=3Dpowerpc?<br><br>Looking=
 on web i known that it's very different from ppc mode and the right proced=
ure to follow is:<br><br>1 - make lite5200b_defconfig ARCH=3Dpowerpc CROSS_=
COMPILE=3Dpowerpc-linux-gnu-<br>2 - make cuImage.lite5200b ARCH=3Dpowerpc C=
ROSS_COMPILE=3Dpowerpc-linux-gnu-<br><br>The output of second command is:<b=
r>...<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&nbs=
p; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<br>&nbsp; CALL&nb=
sp;&nbsp;&nbsp; scripts/checksyscalls.sh<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nb=
sp; include/linux/compile.h<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; arch/powerpc/k=
ernel/systbl_chk.sh<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; arch/powerpc/kernel/pr=
om_init_check.sh<br>arch/powerpc/boot/dtc -O dtb -o arch/powerpc/boot/lite5=
200b.dtb -b
 0&nbsp; /home/asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/boot/dts/lite=
5200b.dts<br>DTC: dts-&gt;dtb&nbsp; on file "/home/asimmini/Scrivania/linux=
-2.6.26.3/arch/powerpc/boot/dts/lite5200b.dts"<br>&nbsp; WRAP&nbsp;&nbsp;&n=
bsp; arch/powerpc/boot/cuImage.lite5200b<br>Image Name:&nbsp;&nbsp; Linux-2=
.6.26.3<br>Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wed Sep&nbsp; 3 15:56:16 =
2008<br>Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed=
)<br>Data Size:&nbsp;&nbsp;&nbsp; 1597696 Bytes =3D 1560.25 kB =3D 1.52 MB<=
br>Load Address: 0x00400000<br>Entry Point:&nbsp; 0x00400550<br>rm arch/pow=
erpc/boot/lite5200b.dtb<span style=3D"font-family: monospace;"> <br><br></s=
pan>But, at this point, if i crosscompile in ppc mode i had to modify the L=
oad Address wiht the <b>mkimage</b> tool because the SDRAM at the Bootloade=
r time starts from 0xF8000000, while the <b>uImage</b> has a Load Address a=
nd Entry Point at 0x00000000.<span style=3D"font-family: monospace;">
 <br>What should i do </span><span style=3D"font-family: monospace;">in pow=
erpc mode?</span><span style=3D"font-family: monospace;">?<br><br><br></spa=
n>However, on web i saw that to boot the board it's necessary to load the c=
uImage and rootfs.uimage on the board with:<span style=3D"font-family: mono=
space;"><br></span>=3D&gt; usb start<span style=3D"font-family: monospace;"=
><br></span>=3D&gt; usb scan<span style=3D"font-family: monospace;"><br></s=
pan>=3D&gt; fatload usb 0 0x03000000 cuImage.lite5200b<span style=3D"font-f=
amily: monospace;"><br></span>=3D&gt; fatload usb 0 0x04000000 rootfs.uimag=
e<br>=3D&gt; bootm 0x03000000 0x04000000<br><br>Does anyone solves this pro=
blem?<br><br>Thank you in advance.<br></td></tr></table><br>_______________=
___________________________________<br>Do You Yahoo!?<br>Poco spazio e tant=
o spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito pe=
r i tuoi file e i messaggi <br>http://mail.yahoo.it 
--0-1086330714-1220451056=:58253--
