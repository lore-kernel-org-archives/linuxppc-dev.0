Return-Path: <B07263@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 600D6B7BBA
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 23:36:03 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAOCZiTq023953
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 05:35:55 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAOCZipC016663
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 06:35:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA6D02.A27AEFD8"
Subject: PMP hot plug issue in kernel
Date: Tue, 24 Nov 2009 18:05:41 +0530
Message-ID: <0BFAB844762735448F252416AE17AB5E0124ED35@zin33exm23.fsl.freescale.net>
From: "Bhartiya Anju-B07263" <B07263@freescale.com>
To: <linux-ide@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, "Chen, Eric" <YunBin.Chen@Honeywell.com>,
	Kalra Ashish-B00888 <B00888@freescale.com>, Ensheng.Huang@exar.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA6D02.A27AEFD8
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
Recently came across an issue which is decribed below.
=20
Setup: Port Multiplier with 2 HDD's connected to it; Port multiplier is
connected to a SATA port of the Host Controller.
=20
Test: HDD1 is mounted and using dd command a file of size 512MB is being
written on it.
Command: time sh -c "dd if=3D/dev/zero of=3D/mnt/hd/ddfile bs=3D1k
count=3D512000 && sync"
=20
While this command is running, if the second HDD on PMP is plugged out,
the R/W speed of the first HDD gets affected.
Please see the results of experiments on 2.6.31 kernel.
=20
Plug Out	 Plug in	 Normal=09
real    0m34.433s
user    0m0.932s
sys     0m21.352s	 real    0m23.726s
user    0m0.908s
sys     0m21.388s	 real    0m23.329s
user    0m1.132s
sys     0m20.968s=09
=20
The results are similiar with multiple Port Multipliers (Si3726, Si4726
and EXAR PMP) and multiple Host controllers (Si3132  and sata_fsl).
=20
As the behaviour with multiple Host controllers and Port Multipliers is
the same so this seems to be an issue with libata stack.
Is there already a patch for this issue? Any pointers or help to fix
this will be greatly appreciated.
=20
Best Regards,
Anju
Applications Engineer=20
Freescale Semiconductor

------_=_NextPart_001_01CA6D02.A27AEFD8
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3627" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D771454605-24112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D771454605-24112009>Recently came across=20
an issue which is decribed below.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D771454605-24112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D771454605-24112009>Setup:&nbsp;Port=20
Multiplier with 2 HDD's connected to it; Port multiplier is connected to =
a SATA=20
port of the Host Controller.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D771454605-24112009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009>Test: =
HDD1 is=20
mounted and using dd command a file of size 512MB is being written on=20
it.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D771454605-24112009>Command: <SPAN=20
lang=3DEN>time sh -c "dd if=3D/dev/zero of=3D/mnt/hd/ddfile bs=3D1k =
count=3D512000=20
&amp;&amp; sync"</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009><SPAN=20
lang=3DEN></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009><SPAN =
lang=3DEN>While=20
this command is running, if the second HDD on PMP is plugged out, the =
R/W speed=20
of the first HDD gets affected.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009><SPAN =
lang=3DEN>Please=20
see the results of experiments on&nbsp;2.6.31 =
kernel.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D771454605-24112009><SPAN=20
lang=3DEN></SPAN></SPAN></FONT>&nbsp;</DIV><FONT size=3D2><SPAN=20
class=3D771454605-24112009><SPAN lang=3DEN>
<DIV>
<TABLE style=3D"WIDTH: 388pt; BORDER-COLLAPSE: collapse" cellSpacing=3D0 =

cellPadding=3D0 width=3D518 border=3D0 x:str>
  <COLGROUP><FONT face=3DArial>
  <COL style=3D"WIDTH: 137pt; mso-width-source: userset; mso-width-alt: =
6692"=20
  width=3D183>
  <COL style=3D"WIDTH: 141pt; mso-width-source: userset; mso-width-alt: =
6875"=20
  width=3D188>
  <COL style=3D"WIDTH: 110pt; mso-width-source: userset; mso-width-alt: =
5376"=20
  width=3D147></FONT>
  <TBODY>
  <TR style=3D"HEIGHT: 12.75pt" height=3D17>
    <TD class=3Dxl22=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext 0.5pt solid; BORDER-LEFT: windowtext 0.5pt solid; WIDTH: =
137pt; BORDER-BOTTOM: windowtext 0.5pt solid; HEIGHT: 12.75pt; =
BACKGROUND-COLOR: transparent"=20
    width=3D183 height=3D17><FONT face=3DArial size=3D2><STRONG>Plug=20
      Out</STRONG></FONT></TD>
    <TD class=3Dxl22=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext 0.5pt solid; BORDER-LEFT: windowtext; WIDTH: 141pt; =
BORDER-BOTTOM: windowtext 0.5pt solid; BACKGROUND-COLOR: transparent"=20
    width=3D188><FONT face=3DArial size=3D2><STRONG>Plug =
in</STRONG></FONT></TD>
    <TD class=3Dxl22=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext 0.5pt solid; BORDER-LEFT: windowtext; WIDTH: 110pt; =
BORDER-BOTTOM: windowtext 0.5pt solid; BACKGROUND-COLOR: transparent"=20
    width=3D147><FONT face=3DArial =
size=3D2><STRONG>Normal</STRONG></FONT></TD></TR>
  <TR style=3D"HEIGHT: 42pt; mso-height-source: userset" height=3D56>
    <TD class=3Dxl23=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext; BORDER-LEFT: windowtext 0.5pt solid; WIDTH: 137pt; =
BORDER-BOTTOM: windowtext 0.5pt solid; HEIGHT: 42pt; BACKGROUND-COLOR: =
transparent"=20
    width=3D183 height=3D56><FONT face=3DArial =
size=3D2><STRONG>real<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m34.433s<BR>user<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m0.932s<BR>sys<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;=20
      </SPAN>0m21.352s</STRONG></FONT></TD>
    <TD class=3Dxl23=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext; BORDER-LEFT: windowtext; WIDTH: 141pt; BORDER-BOTTOM: =
windowtext 0.5pt solid; BACKGROUND-COLOR: transparent"=20
    width=3D188><FONT face=3DArial size=3D2><STRONG>real<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m23.726s<BR>user<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m0.908s<BR>sys<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;=20
      </SPAN>0m21.388s</STRONG></FONT></TD>
    <TD class=3Dxl23=20
    style=3D"BORDER-RIGHT: windowtext 0.5pt solid; BORDER-TOP: =
windowtext; BORDER-LEFT: windowtext; WIDTH: 110pt; BORDER-BOTTOM: =
windowtext 0.5pt solid; BACKGROUND-COLOR: transparent"=20
    width=3D147><STRONG><FONT face=3DArial size=3D2>real<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m23.329s<BR>user<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; =
</SPAN>0m1.132s<BR>sys<SPAN=20
      style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;=20
      </SPAN>0m20.968s</FONT></STRONG></TD></TR></TBODY></TABLE></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D771454605-24112009><FONT face=3DArial>The results are =
similiar=20
with multiple Port Multipliers (Si3726, Si4726 and EXAR PMP) and =
multiple Host=20
controllers (Si3132&nbsp;&nbsp;and sata_fsl).</FONT></SPAN></DIV>
<DIV><SPAN class=3D771454605-24112009><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D771454605-24112009><FONT face=3DArial>As the =
behaviour with=20
multiple Host controllers and Port Multipliers is the same so this seems =
to be=20
an issue with libata stack.</FONT></SPAN></DIV>
<DIV><SPAN class=3D771454605-24112009><FONT face=3DArial>Is there =
already a patch=20
for this issue? Any pointers or help to fix this will be greatly=20
appreciated.</FONT></SPAN></DIV>
<DIV><SPAN class=3D771454605-24112009><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV></SPAN></SPAN></FONT><FONT face=3DArial><FONT size=3D2>Best =
Regards<SPAN=20
class=3D771454605-24112009>,</SPAN></FONT></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Anju</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D771454605-24112009>Applications=20
Engineer </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D771454605-24112009>Freescale=20
Semiconductor</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01CA6D02.A27AEFD8--
