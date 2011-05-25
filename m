Return-Path: <Andrew_Gabbasov@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F0450B6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 23:12:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC1AD5.82854CB0"
Subject: Booting p4080ds on non-0 cpu
Date: Wed, 25 May 2011 13:16:00 +0100
Message-ID: <DBDC8B5977CFF7429A9DBC6C51C7ADE701E81C39@EU1-MAIL.mgc.mentorg.com>
References: <DBDC8B5977CFF7429A9DBC6C51C7ADE701E81C32@EU1-MAIL.mgc.mentorg.com>
From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
To: "Matthew Mcclintock - Freescale" <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC1AD5.82854CB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Matthew,
=20
You have made a patch "powerpc/fsl_booke: Add support to boot from core =
other than 0" some time ago, so you probably worked with booting the =
kernel on a cpu subset, particularly on the core other than 0.
=20
Could you please describe any details how you ran the kernel from u-boot =
on a non-0 cpu?
=20
I have a problem trying to boot linux on p4080ds platform on any non-0 =
cpu (as a first step to running AMP or mixed AMP/SMP configuration). I'm =
trying to run 2.6.34.6 kernel with some Freescale patches in SMP =
configuration with full original device tree and device tree with some =
cpu nodes removed. I'm using the u-boot script, shown at the bottom of =
this message.
=20
If I run "bootm go" after the script commands (thus running the kernel =
on cpu 0), the kernel runs fine.
=20
When I'm trying to run the SMP kernel with full device tree on cpu 1 =
using the following commands after the script:
  fdt boot 1
  cpu 1 release 0 1 c00000 -
the kernel begins to run, but soon crashes. Possible reasons are: =
"Unrecoverable FP Unavailable Exception", at nearly random place; memory =
allocation errors somewhere in DPAA code and then segmentation fault =
(sig 11); unknown exception (sig 4). Sometimes it doesn't even show =
anything on the console (too early exception?), but sometimes it boots =
successfully up to the shell prompt.
=20
When I'm trying to run the SMP kernel with the device tree with cpu 0 =
stripped out (commented out the whole cpu0 node and all properties =
referring to it with &cpu0), using the following commands after the =
script:
  fdt boot 1
  cpu 1 release 0 0 c00000 -
  [Note the difference in the parameter to 'cpu 1 release' command,
    it should be a logical cpu number, which is different]
the result is almost the same, the kernel crashes too. The reasons are =
similar to the above, with more often "Unrecoverable FP Unavailable =
Exception".
=20
Can you give any advise why can this happen, and what I could be doing =
wrong?
=20
Thanks in advance,
=20
Best regards,
Andrew
=20
setenv kernel_base 00000000
setenv kernel_size 30000000
# Helper variables
setenv kernel_load_offset 01000000
setenv dtb_load_offset    00c00000
setexpr kernel_load_addr $kernel_base + $kernel_load_offset
setexpr dtb_load_addr    $kernel_base + $dtb_load_offset
tftp $kernel_load_addr $tftpdir/uImage-p4080ds.bin
tftp $dtb_load_addr    $tftpdir/uImage-p4080ds.dtb
setenv bootargs root=3D/dev/nfs rw =
nfsroot=3D$serverip:/tftpboot/$tftpdir/rootfs-4080ds ip=3Ddhcp =
console=3DttyS0,115200 debug
setenv bootm_low  $kernel_base
setenv bootm_size $kernel_size
interrupts off
bootm start $kernel_load_addr - $dtb_load_addr
bootm loados
bootm fdt
fdt boardsetup
fdt chosen
bootm prep
# cpu 1 release $kernel_base - $dtb_load_addr -
=20
=20

------_=_NextPart_001_01CC1AD5.82854CB0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2838" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText76845 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri>Hello Matthew,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri>You have made a patch =
"powerpc/fsl_booke:&nbsp;Add&nbsp;support&nbsp;to&nbsp;boot&nbsp;from&nbs=
p;core&nbsp;other&nbsp;than&nbsp;0" some time ago, so you probably =
worked with booting the kernel on a cpu subset, particularly on the core =
other than 0.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri>Could you please describe any =
details how you ran the kernel from u-boot on a non-0 cpu?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DCalibri>I have a problem trying to boot =
linux on p4080ds platform on any non-0 cpu (as a first step to running =
AMP or mixed AMP/SMP configuration). </FONT><FONT face=3DCalibri>I'm =
trying to run 2.6.34.6 kernel with some Freescale patches in SMP =
configuration with</FONT><FONT face=3DCalibri> full original device tree =
and device tree with some cpu nodes removed. I'm using the u-boot =
script, shown at the bottom of this message.</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>If I run "bootm go" after the script commands =
(thus running the kernel on cpu 0), the kernel runs fine.</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>When I'm trying to run the SMP kernel with =
full device tree on cpu 1 using the following commands after the =
script:</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp; fdt boot 1</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp; cpu 1 release 0 1 c00000 -</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>the kernel begins to run, but soon crashes. =
Possible reasons are:&nbsp;"Unrecoverable FP Unavailable Exception", at =
nearly random place;&nbsp;memory allocation errors somewhere in =
DPAA&nbsp;code and then segmentation fault (sig 11); unknown exception =
(sig 4).&nbsp;Sometimes it doesn't even show anything on the console =
(too early exception?), but sometimes it boots successfully up to the =
shell prompt.</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>When I'm trying to run the SMP kernel with the =
device tree with cpu 0 stripped out (commented out the whole cpu0 node =
and all properties referring to it with &amp;cpu0), using the following =
commands after the script:</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp; fdt boot 1</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp; cpu 1 release 0 0 c00000 -</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp; [Note the difference in the parameter =
to 'cpu 1 release' command,</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>&nbsp;&nbsp;&nbsp; it should be a logical cpu =
number, which is different]</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>the result is almost the same, the kernel =
crashes too. The reasons are similar to the above, with more often =
"Unrecoverable FP Unavailable Exception".</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>Can you give any advise why can this happen, =
and what I could be doing wrong?</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>Thanks in advance,</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri>Best regards,</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri>Andrew</FONT></DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2>setenv kernel_base =
00000000<BR>setenv kernel_size 30000000</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2># Helper variables<BR>setenv =
kernel_load_offset 01000000<BR>setenv dtb_load_offset&nbsp;&nbsp;&nbsp; =
00c00000</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2>setexpr kernel_load_addr =
$kernel_base + $kernel_load_offset<BR>setexpr =
dtb_load_addr&nbsp;&nbsp;&nbsp; $kernel_base + =
$dtb_load_offset</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2>tftp $kernel_load_addr =
$tftpdir/uImage-p4080ds.bin<BR>tftp $dtb_load_addr&nbsp;&nbsp;&nbsp; =
$tftpdir/uImage-p4080ds.dtb</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2>setenv bootargs root=3D/dev/nfs =
rw nfsroot=3D$serverip:/tftpboot/$tftpdir/rootfs-4080ds ip=3Ddhcp =
console=3DttyS0,115200 debug<BR>setenv bootm_low&nbsp; =
$kernel_base<BR>setenv bootm_size $kernel_size<BR>interrupts =
off<BR>bootm start $kernel_load_addr - $dtb_load_addr<BR>bootm =
loados<BR>bootm fdt<BR>fdt boardsetup<BR>fdt chosen<BR>bootm =
prep</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2># cpu 1 release $kernel_base - =
$dtb_load_addr -</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DCalibri></FONT>&nbsp;</DIV></DIV></BODY></HTML>
------_=_NextPart_001_01CC1AD5.82854CB0--
