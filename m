Return-Path: <Jorge.Ramirez-Ortiz@xerox.com>
Received: from wbmler2.mail.xerox.com (wbmler2.mail.xerox.com [13.13.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler2.mail.xerox.com",
	Issuer "wbmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B1492DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 00:34:07 +1000 (EST)
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l6HELM6l019831
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Jul 2007 10:21:22 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l6HELHpA010610
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Jul 2007 10:21:17 -0400
Received: from USA7061GW002.na.xerox.net (usa7061gw002.na.xerox.net
	[13.151.210.15])
	by wbmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l6HEL7pE010407
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Jul 2007 10:21:17 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C87D.BA0942A6"
Subject: Machine check exception. 2.6.20 powerpc tree. 
Date: Tue, 17 Jul 2007 15:21:18 +0100
Message-ID: <35786B99AB3FDC45A8215724617919730136DA91@gbrwgceumf01.eu.xerox.net>
From: "Ramirez-Ortiz, Jorge" <Jorge.Ramirez-Ortiz@xerox.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C87D.BA0942A6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Running our multithreaded application on ppc8548 (E500 core) generates a
machine check exception when trying to access some ASIC's registers
mapped on the PCI space (This application maps a PCI device to access
its registers)

=20

machine_check_exception: task my_process, MCSR=3D0x10008, =
NIP=3D0x10153530

Machine check in user mode.

Caused by (from MCSR=3D10008): Guarded Load or Cache-Inhibited stwcx.

Bus - Read Data Bus Error

=20

Here is the assembly dump of the region of code containing the offending
instruction in user-space, with SRR0 pointing us at 0x10153530 when the
exception is raised:

=20

0x10153528 <_ZN2vk7in_le32EPVKj+16>:    lwz     r0,8(r31)

0x1015352c <_ZN2vk7in_le32EPVKj+20>:    lwz     r9,8(r31)

0x10153530 <_ZN2vk7in_le32EPVKj+24>:    lwbrx   r0,0,r0

0x10153534 <_ZN2vk7in_le32EPVKj+28>:    twi     0,r0,0

0x10153538 <_ZN2vk7in_le32EPVKj+32>:    isync

=20

All this is fully reproducible, the offending code is repeatedly the
byte-reverse load within the (m)mapped PCI memory segment. The offset
within the segment may vary, even if most of the hits seem to be taken
when reading 0x20030-0x20034 offsets from 0x80000000 PCI address space
(which is mapped to the application via /dev/mem)

=20

/proc/pid/maps reports the following mappings to /dev/mem, with the
first one being an ASIC on the PCI space whose registers we are trying
to access, and the second one being system memory (this system memory is
out of kernel visibility...we use 'mem=3D256M' as a kernel =
parameter...):

=20

303a9000-304a9000 rw-s 80000000 00:0c 2087       /dev/mem

304a9000-404a9000 rw-s 10000000 00:0c 2087       /dev/mem

=20

Has anybody experienced something similar using a kernel based on a
2.6.20 powerpc tree?=20

=20

Many thanks

=20

jorge

=20

______________________________

Jorge Ramirez-Ortiz

=20

=20


------_=_NextPart_001_01C7C87D.BA0942A6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Courier New";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:navy;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Running our multithreaded application on =
ppc8548 (E500
core) generates a machine check exception when trying to access some =
ASIC&#8217;s
registers mapped on the PCI space (This application maps a PCI device to =
access
its registers)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:blue;font-style:italic'>machine_check_exc=
eption:
task my_process, MCSR=3D0x10008, =
NIP=3D0x10153530<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:blue;font-style:italic'>Machine check
in user mode.<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
lang=3DEN-US =
style=3D'font-size:10.0pt;color:blue;font-style:italic'>Caused by
(from MCSR=3D10008): <b><span style=3D'font-weight:bold'>Guarded Load or
Cache-Inhibited stwcx</span></b>.<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
lang=3DEN-US style=3D'font-size:10.0pt;color:blue;font-style:italic'>Bus =
- Read
Data Bus Error<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Here is the assembly dump of the region of =
code
containing the offending instruction in user-space, with SRR0 pointing =
us at
0x10153530 when the exception is raised:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>0x10153528
&lt;_ZN2vk7in_le32EPVKj+16&gt;:&nbsp;&nbsp;&nbsp; =
lwz&nbsp;&nbsp;&nbsp;&nbsp;
r0,8(r31)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>0x1015352c
&lt;_ZN2vk7in_le32EPVKj+20&gt;:&nbsp;&nbsp;&nbsp; =
lwz&nbsp;&nbsp;&nbsp;&nbsp;
r9,8(r31)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>0x10153530
&lt;_ZN2vk7in_le32EPVKj+24&gt;:&nbsp;&nbsp;&nbsp; lwbrx&nbsp;&nbsp; =
r0,0,r0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>0x10153534
&lt;_ZN2vk7in_le32EPVKj+28&gt;:&nbsp;&nbsp;&nbsp; =
twi&nbsp;&nbsp;&nbsp;&nbsp;
0,r0,0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>0x10153538
&lt;_ZN2vk7in_le32EPVKj+32&gt;:&nbsp;&nbsp;&nbsp; =
isync<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>All this is fully reproducible, the offending =
code is
repeatedly the byte-reverse load within the (m)mapped PCI memory =
segment. The offset
within the segment may vary, even if most of the hits seem to be taken =
when
reading 0x20030-0x20034 offsets from 0x80000000 PCI address space (which =
is
mapped to the application via /dev/mem)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>/proc/pid/maps reports the following mappings =
to
/dev/mem, with the first one being an ASIC on the PCI space whose =
registers we
are trying to access, and the second one being system memory (this =
system
memory is out of kernel visibility&#8230;we use &#8216;mem=3D256M&#8217; =
as a
kernel parameter...):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>303a9000-304a9000 rw-s 80000000 00:0c
2087&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/dev/mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>304a9000-404a9000 rw-s 10000000 00:0c
2087&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/dev/mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Has anybody experienced something similar =
using a
kernel based on a 2.6.20 powerpc tree? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Many thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
style=3D'font-size:
9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
style=3D'font-size:
9.0pt;font-family:Arial;color:navy'>jorge<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
style=3D'font-size:
9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D1 color=3D"#003366" =
face=3DArial><span
style=3D'font-size:7.5pt;font-family:Arial;color:#003366;font-weight:bold=
'>______________________________<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D1 color=3D"#003366" =
face=3DArial><span
style=3D'font-size:7.5pt;font-family:Arial;color:#003366;font-weight:bold=
'>Jorge
Ramirez-Ortiz<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;</span></font><font
face=3D"Times New Roman"><span style=3D'font-family:"Times New =
Roman"'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7C87D.BA0942A6--
