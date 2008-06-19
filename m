Return-Path: <dbiswal@ciena.com>
Received: from hicks.ciena.com (hicks.ciena.com [63.118.34.22])
	by ozlabs.org (Postfix) with ESMTP id 94B02DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jun 2008 13:03:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/related; type="multipart/alternative";
	boundary="----_=_NextPart_001_01C8D1B7.A07E9BDB"
Subject: problem in MPC8358 HDLC controller
Date: Thu, 19 Jun 2008 08:23:10 +0530
Message-ID: <E83CE4EECC22CF41ACBE68D95143DA0102F0F641@inmxm02.ciena.com>
From: "Biswal, Debasish" <dbiswal@ciena.com>
To: <linuxppc-embedded@ozlabs.org.>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8D1B7.A07E9BDB
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C8D1B7.A07E9BDB"


------_=_NextPart_002_01C8D1B7.A07E9BDB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am developing a HDLC driver for the MPC8358 processor. This HDLC
driver will control the UCC(unified communication controller) 8 of the
MPC8358 core.  The problem I am facing is whenever I submit a packet to
the UCC8 HDLC controller to transmit my kernel crashes. It seems there
is a memory corruption happening since the crash point varies with each
iteration. The following is what I am doing=20

=20

1)       the GUMR register is configured(as per the user manual)=20

2)       The Tx and Rx bd ring memory is allocated from the system
memory(using kmalloc).

3)       In the HDLC PARAMETER RAM memory map the RBASE and TBASE
registers are filled by converting the virtual addresses of the Tx and
Rx bds to physical address.=20

4)       The parameter RAM is allocated from the qe memory from offset
0x3600 (as mentioned in ........

5)       There are two 16 bit registers in the parameter RAM memory base
named RIPTR and TIPTR( I am not sure if it needs to be filled, it is
currently initialized to 0x00000000).=20

a.       As per the PPC user manual, a 32 byte memory aligned on a 32
byte boundary should be allocated and its pointer to be stored in these
registers but since kmalloc returns a 32 bit pointer how can it be
written into a 16 bit register.

6)       If I do not set the T_R(transmit ready bit that instructs the
HDLC controller to transmit a packet) than my driver is ok(of course its
not trying to send the packet and after some time the queue gets full)
and the kernel doesn't crashes but if I set the T_R bit and the
application tries to send something using my hdlc driver, then the
kernel crashes.

=20

Any pointers towards finding what could be the possible reason of the
crash and how to debug the crash shall be highly appreciated.

=20

=20

 Regards,

Debasish Biswal

=20

Phone:+91-124-4340845

Fax: +91-124-4340555

Email: dbiswal@ciena.com

=20


------_=_NextPart_002_01C8D1B7.A07E9BDB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:306059707;
	mso-list-type:hybrid;
	mso-list-template-ids:-1972338468 1566857758 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:24.0pt;
	mso-level-number-position:left;
	margin-left:24.0pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:60.0pt;
	mso-level-number-position:left;
	margin-left:60.0pt;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I am developing a HDLC =
driver for
the MPC8358 processor. This HDLC driver will control the UCC(unified
communication controller) 8 of the MPC8358 core. &nbsp;The problem I am =
facing
is whenever I submit a packet to the UCC8 HDLC controller to transmit my =
kernel
crashes. It seems there is a memory corruption happening since the crash =
point
varies with each iteration. The following is what I am doing =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:6.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>the GUMR
register is configured(as per the user manual) =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>The Tx and
Rx bd ring memory is allocated from the system memory(using =
kmalloc).<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>3)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>In the HDLC
PARAMETER RAM memory map the RBASE and TBASE registers are filled by =
converting
the virtual addresses of the Tx and Rx bds to physical address. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>4)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>The parameter
RAM is allocated from the qe memory from offset 0x3600 (as mentioned in =
&#8230;&#8230;..<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>5)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>There are
two 16 bit registers in the parameter RAM memory base named RIPTR and =
TIPTR( I
am not sure if it needs to be filled, it is currently initialized to
0x00000000). <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:60.0pt;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>a.<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>As per the PPC
user manual, a 32 byte memory aligned on a 32 byte boundary should be =
allocated
and its pointer to be stored in these registers but since kmalloc =
returns a 32
bit pointer how can it be written into a 16 bit =
register.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:24.0pt;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>6)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>If I do not
set the T_R(transmit ready bit that instructs the HDLC controller to =
transmit a
packet) than my driver is ok(of course its not trying to send the packet =
and
after some time the queue gets full) and the kernel doesn&#8217;t =
crashes but
if I set the T_R bit and the application tries to send something using =
my hdlc
driver, then the kernel crashes.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any pointers towards finding what could be the =
possible
reason of the crash and how to debug the crash shall be highly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'>Regards,</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Debasish Biswal</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:black'><img width=3D91 height=3D29 =
id=3D"_x0000_i1025"
src=3D"cid:image001.gif@01C8D169.674D4E70" alt=3DCiena =
border=3D0><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:10.0pt;
font-family:Calibri'>Phone:+91-124-4340845</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:10.0pt;
font-family:Calibri'>Fax: +91-124-4340555</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:10.0pt;
font-family:Calibri'>Email: =
dbiswal@ciena.com</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C8D1B7.A07E9BDB--

------_=_NextPart_001_01C8D1B7.A07E9BDB
Content-Type: image/gif;
	name="image001.gif"
Content-Transfer-Encoding: base64
Content-ID: <image001.gif@01C8D169.674D4E70>
Content-Description: image001.gif
Content-Location: image001.gif

R0lGODlhWwAdALMPAPCYqdsAKOZNaf///+tzieEsTvfI0fvj6PW3w9kAHf3y9d4WOvra4P74+f3t
8P///yH5BAEAAA8ALAAAAABbAB0AAAT/8MlJq7046837+GAohgwAGGOqrmzrDtQrIkuSBISs7zw8
8Y5aYJhA9Y7IUGyHuA0DiVxy2lvqmk+olMp9WWWKgnNo7JpXX5mhMFwAznBVGoxAHOJ40RzU6DeQ
DgAEgwRlL34ufn0tcwgEbE8FAgB/BnWXKQcEC1A2NwJ3IIKEBHcGmwELBQAKIgyOApCpBQQIfyNf
DAJQWUQLDgNingu3IGtjWQkFoQOdngYAQk8JoKLCyEQBAgy4Px8G0r1twAJjC63G4eJRIJxZu+JQ
Arfl8ckF3EreDOrivwP1ngD74EBMLxvTCgx0N80emQ8BHcrT4y1iQ1/kkA0cQABZggUC/wQwXJCP
YTJsUN4ARLigJSdsJPVJGGBgHS0TggS0sjgwSK8CRgDcUBbK5BBaqJJJISCgloEDDg4gMJgFgcwH
HD0K2PjhTwOeHxCIs/oBAJECt4wu+2aS3QAFxUIcMKryQ4yIytCN+KrxQ8eEt/imbJes7sppW2iO
IjR1jFu7Ewo6TixCsECIjgWA+KusWFtDf4lIObDLk6d1iSkcoDpYheUh6PAW8Ds0JuFpZGkjHrAa
22mlV8NMXvE6QD6LCxxly/2hLfPQWrL2avroYOofyPPttUgW+sHkI5yHgB5F+G4QeK/P9K7M0ACv
6cM6xBfCAArxmyfP7VVG8nnIM9V0kLQ2BOSk0GFZAPCKUUeh0IBUu7yBn26i7ZfgZtZdhVk8pv3j
HRQMZgFSLAhJmMxzk5n3xAIFwgMcCEvMhZKIwIAjkT0IEWEibuMN9+FvLwJjxTE4/iMdhzfeUMoA
Ex4ZnYzrpALcVAh84cAmppl24HuonKYKAa+wkWUqApTx2Xi9SMGAmKcVgICL0QGwyhwHABDSnQVy
xdtiJ8wwSEgFahfWJXVw9QqhgsLSlC00EYpAPtxQEAEAOw==

------_=_NextPart_001_01C8D1B7.A07E9BDB--
