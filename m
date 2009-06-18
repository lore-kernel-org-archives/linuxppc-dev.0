Return-Path: <fabidi@ultsol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9BCC5B71D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 06:59:45 +1000 (EST)
Received: from ultsol.com (unknown [216.117.139.109])
	by ozlabs.org (Postfix) with ESMTP id BE5D1DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 06:59:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9F054.1C91C81F"
Subject: Problem with memcpy on ppc8536
Date: Thu, 18 Jun 2009 16:33:53 -0400
Message-ID: <71DEA556544D7A4F9C6848402D8184340C4A13@usi01.ultsol.local>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9F054.1C91C81F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,=20

I am trying to debug a crash during memcpy while copying data from the
FCM buffer of an mpc8536 to the ddr ram. I debugged memcpy enough
through my BDI3000 to see that the entire contents of the fcm buffer I
want moved are actually moved off to memory location I specify. The
crash comes after it memcpy finishes copying and performs the
instruction "2: cmplwi 0,r5,4":=20

memcpy:=20
rlwinm. r7,r5,32-3,3,31 /* r0 =3D r5 >> 3 */=20
addi r6,r3,-4=20
addi r4,r4,-4=20
beq 2f /* if less than 8 bytes to do */=20
andi. r0,r6,3 /* get dest word aligned */=20
mtctr r7=20
bne 5f=20
1: lwz r7,4(r4)=20
lwzu r8,8(r4)=20
stw r7,4(r6)=20
stwu r8,8(r6)=20
bdnz 1b=20
andi. r5,r5,7=20
2: cmplwi 0,r5,4=20

contents of r5 are 0x0 showing that the entire 0x1000 size transfer I
specified correctly finished. At this point I can check the memory
contents through my BDI and verify all the data is in the ddr as I
expect. Now the strange thing happens, if I execute the "cmplwi 0,r5,4"
the program takes an exception and eventually gets struck at exception
vector 0x700 which I saw from start.S is an "Alignment" exception. I am
not sure what this exception means, can someone help me understand what
is happening?=20

Does this exception somehow mean that memcpy did not move all the data?
Does memcpy expect contents of r5 to be 4 and not 0 when it hits the
cmplwi instruction?=20


Fahd Abidi
Product Manager - Technical Tools and Development
Ultimate Solutions, Inc.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Your Single Source for Professional Development Tools and Embedded
Solutions
Ph: 978-455-3383 x255
Fx: 978-926-3091
Email: fabidi@ultsol.com
Visit: http://www.ultsol.com <http://www.ultsol.com/> =20
=20

------_=_NextPart_001_01C9F054.1C91C81F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18783"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial>
<P><SPAN id=3D_ctl0_dgMessages__ctl2_lblPost>Hello, <BR><BR>I am trying =
to debug a=20
crash during memcpy while copying data from the FCM buffer of an mpc8536 =
to the=20
ddr ram. I debugged memcpy enough through my BDI3000 to see that the =
entire=20
contents of the fcm buffer I want moved are actually moved off to memory =

location I specify. The crash comes after it memcpy finishes copying and =

performs the instruction "2: cmplwi 0,r5,4": <BR><BR>memcpy: <BR>rlwinm. =

r7,r5,32-3,3,<WBR></WBR>31 /* r0 =3D r5 &gt;&gt; 3 */ <BR>addi r6,r3,-4 =
<BR>addi=20
r4,r4,-4 <BR>beq 2f /* if less than 8 bytes to do */ <BR>andi. r0,r6,3 =
/* get=20
dest word aligned */ <BR>mtctr r7 <BR>bne 5f <BR>1: lwz r7,4(r4) =
<BR>lwzu=20
r8,8(r4) <BR>stw r7,4(r6) <BR>stwu r8,8(r6) <BR>bdnz 1b <BR>andi. =
r5,r5,7 <BR>2:=20
cmplwi 0,r5,4 <BR><BR>contents of r5 are 0x0 showing that the entire =
0x1000 size=20
transfer I specified correctly finished. At this point I can check the =
memory=20
contents through my BDI and verify all the data is in the ddr as I =
expect. Now=20
the strange thing happens, if I execute the "cmplwi 0,r5,4" the program =
takes an=20
exception and eventually gets struck at exception vector 0x700 which I =
saw from=20
start.S is an "Alignment" exception. I am not sure what this exception =
means,=20
can someone help me understand what is happening? <BR><BR>Does this =
exception=20
somehow mean that memcpy did not move all the data? Does memcpy expect =
contents=20
of r5 to be 4 and not 0 when it hits the cmplwi instruction?=20
<BR></SPAN></FONT></P></DIV>
<DIV align=3Dleft><FONT size=3D2 face=3DArial><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Fahd =
Abidi<BR>Product=20
Manager - Technical Tools and <SPAN=20
lang=3DEN>Development</SPAN></SPAN></FONT></DIV>
<DIV align=3Dleft><FONT size=3D2 face=3DArial><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Ultimate =
Solutions,=20
Inc.<BR></SPAN><SPAN style=3D"COLOR: #0080c0; FONT-SIZE: 10pt"><FONT=20
face=3D"Times New =
Roman">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN><SPAN=20
style=3D"COLOR: teal; FONT-SIZE: 10pt"><BR></SPAN><EM><B><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Your Single =
Source=20
for Professional Development Tools and Embedded=20
Solutions</SPAN></B></EM><B><I><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: =
10pt"><BR></SPAN></I></B><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt">Ph: =
978-455-3383=20
x255<BR>Fx: 978-926-3091<BR>Email: fabidi@ultsol.com<BR>Visit: </SPAN><A =

title=3Dblocked::http://www.ultsol.com/ =
href=3D"http://www.ultsol.com/"><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"=20
title=3Dblocked::http://www.ultsol.com/><FONT=20
color=3D#800080>http://www.ultsol.com</FONT></SPAN></A><SPAN=20
style=3D"FONT-FAMILY: 'Arial','sans-serif'; FONT-SIZE: 10pt"> =
</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C9F054.1C91C81F--
