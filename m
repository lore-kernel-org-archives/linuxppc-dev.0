Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 494D2DE19D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 23:51:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DA1B.729BA08B"
Subject: RE: How to debug a hung multi-core system....
Date: Thu, 21 May 2009 09:52:59 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110F53A79@EMPBEDEX.empirix.com>
In-Reply-To: <C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
	<C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	"Young, Andrew" <andrew.young@windriver.com>, "Brown,
	Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9DA1B.729BA08B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<see middle post>

=20

>> -----Original Message-----

>> From: Kumar Gala [mailto:galak@kernel.crashing.org]

>> Sent: Thursday, May 21, 2009 9:13 AM

>> To: Morrison, Tom

>> Cc: linuxppc-dev@ozlabs.org; Young, Andrew; Brown, Jeff

>> Subject: Re: How to debug a hung multi-core system....

>>=20

>>=20

>> On May 20, 2009, at 6:17 PM, Morrison, Tom wrote:

=20

[Morrison, Tom]=20

=20

<snip some verbose explanations>

 =20

>> >

>> >   Core 1 seems to be Idle loop - happily doing nothing

>> >        (and not servicing TCP and/or the console)...

>> >

>> >   Core 0 seems to be 'stuck' at the "InstructionStorage"

>> >        Exception. And it seems to be going 'nowhere' fast

>> >

>> > SRR0 seems to point to this same spot (0xc00006C0)

>> > SRR1 value is 0x00021200

>> >

>> > I am at a loss to see how the kernel (and/or our kernel BSP)

>> > cause this exception, and I am even more of a loss on figuring

>> > out an application could cause this exception...

>>=20

>> This is a bit odd as we shouldn't see an ISI from 0xc00006C0.

>>=20

>> Are you able to single step Core0?  Can you dump the contents of the

>> TLBs on Core0

=20

[Morrison, Tom]=20

=20

[Morrison, Tom]=20

=20

<snip some of verbose explanation>

=20

Yes, very odd...

=20

And I am able to get TLB entries from the core that is in=20

Instruction Storage Exception, I made

=20

[Morrison, Tom]=20

>BKM>tat

=20

Entry  EPN          RPN    TID  TMASK   WIMGE  TSIZ U0:3  X0:1   PID  TS
PROT SHEN   UR   UW   UX   SR   SW   SX  TIDZ VAL

=20

IT0  0000C000     00000000 00     000     0A     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

IT1  0000C000     00000000 00     000     0A     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

IT2  0000C000     00000000 00     000     0A     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

IT3  0000C000     00000000 00     000     0A     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

DT0  0011C000     00000000 00     000     06     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

DT1  D435C000     20000000 00     000     1E     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

DT2  0011C000     00000000 00     000     06     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

DT3  D435C000     20000000 00     000     1E     0     0     0     0
0    U    P    D    D    D    D    D    D    D    I=20

LT0  C0000000     00000000 00     0FF     04     9     0     0     0
0    P    P    E    E    D    E    E    D    D    V=20

LT1  D0000000     01000000 00     0FF     04     9     0     0     0
0    P    P    E    E    D    E    E    D    D    V=20

LT2  E0000000     02000000 00     0FF     04     9     0     0     0
0    P    P    E    E    D    E    E    D    D    V=20

LT3  39A40000     027FF700 0D     000     06     E     A     3     0
1    U    S    D    D    D    E    E    D    D    I=20

LT4  F924E000     7C054500 BA     000     0B     E     0     3     0
0    P    S    E    E    D    E    E    D    D    V=20

LT5  82A9F000     46664C00 FB     000     1A     F     4     2     0
0    U    S    E    E    D    D    E    D    D    I=20

LT6  80000000     1F000000 F2     0FF     1D     9     B     3     0
0    U    S    D    E    D    E    E    E    D    V=20

LT7  64000000     1F000000 B3     07F     02     8     B     0     0
1    U    S    D    E    D    D    E    E    D    V=20

LT8  E5BF1000     995EA900 96     000     0C     D     8     0     0
1    U    S    D    E    E    E    E    D    D    V=20

LT9  7F3BF000     C6DF7300 DF     000     15     1     2     3     0
1    U    S    E    D    D    E    E    E    D    I=20

LT10 917C7000     EEA67F00 7F     000     17     C     5     3     0
1    P    S    E    E    E    E    E    E    D    I=20

LT11 6B000000     F5700000 BC     03F     04     7     D     0     0
1    P    S    E    E    E    E    E    E    D    V=20

LT12 712DB000     F1B59100 2A     000     19     C     F     1     0
1    P    S    E    E    E    E    D    E    D    V=20

LT13 00000000     F0000000 7F     0FF     07     B     0     0     0
1    P    S    D    D    E    E    E    E    D    V=20

LT14 A3000000     FDD00000 C5     03F     16     7     E     3     0
1    P    S    E    E    E    D    D    E    D    V=20

LT15 F7F00000     B0B80000 82     00F     1F     5     F     0     0
1    P    P    E    E    D    D    D    D    D    V

=20

To answer your 2nd question - we have about 10 processes, and

about 60-70 threads total (30+ for the main processing process)...

=20

=20

>> > Anybody have any ideas - and/or ways to re-configure our

>> > setup to obtain more data? Or does this sound familiar to

>> > a bug somebody has already found in the kernel?

>> >

>> > We are even having trouble defining a test program that can

>> > cause (on purpose) the 'InstructionStorage' Exception (does

>> > anybody have an simple 'c' (or ppc assembly) program that

>> > causes this exception (so we can run in user application land

>> > and see if the symptoms are similar))?

>> >

>> > Thank you in advance for any / all help you can provide....

>> > because I am completely stumped on even how to proceed!

>>=20

>>=20

>> Is your application generating a lot of processes or have a lot of

>> concurrent processes on the 8572?

>>=20

>> - k


------_=_NextPart_001_01C9DA1B.729BA08B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>&lt;see middle =
post&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; -----Original Message-----<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; From: Kumar Gala =
[mailto:galak@kernel.crashing.org]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Sent: Thursday, May 21, 2009 9:13 =
AM<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; To: Morrison, Tom<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Cc: <st1:PersonName =
w:st=3D"on">linuxppc-dev@ozlabs.org</st1:PersonName>;
Young, Andrew; Brown, Jeff<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Subject: Re: How to debug a hung multi-core =
system....<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; On May 20, 2009, at 6:17 PM, Morrison, Tom =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'>[Morrison, Tom] <o:p></o:p></span></font></i></b></p>

<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'><o:p>&nbsp;</o:p></span></font></i></b></p>

<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'>&lt;snip some verbose =
explanations&gt;<o:p></o:p></span></font></i></b></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;&nbsp;&nbsp; Core 1 seems to be Idle loop - happily =
doing
nothing<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (and not =
servicing
TCP and/or the console)...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;&nbsp;&nbsp; Core 0 seems to be 'stuck' at the
&quot;InstructionStorage&quot;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exception. =
And it
seems to be going 'nowhere' fast<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;  SRR0 seems to point to this same spot =
(0xc00006C0)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;  SRR1 value is =
0x00021200<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; I am at a loss to see how the kernel (and/or our =
kernel
BSP)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; cause this exception, and I am even more of a loss =
on
figuring<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; out an application could cause this =
exception...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; This is a bit odd as we shouldn't see an ISI from =
0xc00006C0.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Are you able to single step Core0?&nbsp; Can you dump =
the
contents of the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; TLBs on Core0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'>[Morrison, Tom] <o:p></o:p></span></font></i></b></p>

<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'><o:p>&nbsp;</o:p></span></font></i></b></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>[Morrison, Tom] <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&lt;snip some of verbose =
explanation&gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Yes, very odd...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>And I am able to get TLB entries from the core that is in =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Instruction Storage Exception, I =
made<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'>[Morrison, Tom] <o:p></o:p></span></font></i></b></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>&gt;BKM&gt;tat<o:=
p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Entry&nbsp;
EPN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RPN&nbsp;&nbsp;&nbsp;
TID&nbsp; TMASK&nbsp;&nbsp; WIMGE&nbsp; TSIZ U0:3&nbsp; X0:1&nbsp;&nbsp;
PID&nbsp; TS&nbsp; PROT SHEN&nbsp;&nbsp; <st1:City =
w:st=3D"on">UR</st1:City>&nbsp;&nbsp;
UW&nbsp;&nbsp; UX&nbsp;&nbsp; SR&nbsp;&nbsp; <st1:place =
w:st=3D"on">SW&nbsp;&nbsp;
 SX</st1:place>&nbsp; TIDZ VAL<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>IT0&nbsp;
0000C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0A&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D =
&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>IT1&nbsp;
0000C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0A&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>IT2&nbsp;
0000C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0A&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp; &nbsp;&nbsp;D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>IT3&nbsp;
0000C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0A&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>DT0&nbsp;
0011C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 06&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp; &nbsp;D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>DT1&nbsp;
D435C000&nbsp;&nbsp;&nbsp;&nbsp; 20000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 1E&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>DT2&nbsp;
0011C000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 06&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>DT3&nbsp;
D435C000&nbsp;&nbsp;&nbsp;&nbsp; 20000000 00&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 1E&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT0&nbsp;
C0000000&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00&nbsp;&nbsp;&nbsp;&nbsp;
0FF&nbsp;&nbsp;&nbsp;&nbsp; 04&nbsp;&nbsp;&nbsp;&nbsp;
9&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT1&nbsp;
D0000000&nbsp;&nbsp;&nbsp;&nbsp; 01000000 00&nbsp;&nbsp;&nbsp;&nbsp;
0FF&nbsp;&nbsp;&nbsp;&nbsp; 04&nbsp;&nbsp;&nbsp;&nbsp;
9&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT2&nbsp;
E0000000&nbsp;&nbsp;&nbsp;&nbsp; 02000000 00&nbsp;&nbsp;&nbsp;&nbsp;
0FF&nbsp;&nbsp;&nbsp;&nbsp; 04&nbsp;&nbsp;&nbsp;&nbsp;
9&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT3&nbsp; =
39A40000&nbsp;&nbsp;&nbsp;&nbsp;
027FF700 0D&nbsp;&nbsp;&nbsp;&nbsp; 000&nbsp;&nbsp;&nbsp;&nbsp;
06&nbsp;&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp;&nbsp; =
A&nbsp;&nbsp;&nbsp;&nbsp;
3&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; =
U&nbsp;&nbsp;&nbsp;
S&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
I <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT4&nbsp;
F924E000&nbsp;&nbsp;&nbsp;&nbsp; 7C054500 BA&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0B&nbsp;&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT5&nbsp; =
82A9F000&nbsp; &nbsp;&nbsp;&nbsp;46664C00
FB&nbsp;&nbsp;&nbsp;&nbsp; 000&nbsp;&nbsp;&nbsp;&nbsp;
1A&nbsp;&nbsp;&nbsp;&nbsp; F&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;
2&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;
U&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; I <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT6&nbsp;
80000000&nbsp;&nbsp;&nbsp;&nbsp; 1F000000 F2&nbsp;&nbsp;&nbsp;&nbsp;
0FF&nbsp;&nbsp;&nbsp;&nbsp; 1D&nbsp;&nbsp;&nbsp;&nbsp;
9&nbsp;&nbsp;&nbsp;&nbsp; B&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT7&nbsp;
64000000&nbsp;&nbsp;&nbsp;&nbsp; 1F000000 B3&nbsp;&nbsp;&nbsp;&nbsp;
07F&nbsp;&nbsp;&nbsp;&nbsp; 02&nbsp;&nbsp;&nbsp;&nbsp;
8&nbsp;&nbsp;&nbsp;&nbsp; B&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT8&nbsp;
E5BF1000&nbsp;&nbsp;&nbsp;&nbsp; 995EA900 96&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 0C&nbsp;&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT9&nbsp;
7F3BF000&nbsp;&nbsp;&nbsp;&nbsp; C6DF7300 DF&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT10
917C7000&nbsp;&nbsp;&nbsp;&nbsp; EEA67F00 7F&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 17&nbsp;&nbsp;&nbsp;&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; I =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT11
6B000000&nbsp;&nbsp;&nbsp;&nbsp; F5700000 BC&nbsp;&nbsp;&nbsp;&nbsp;
03F&nbsp;&nbsp;&nbsp;&nbsp; 04&nbsp;&nbsp;&nbsp;&nbsp;
7&nbsp;&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT12
712DB000&nbsp;&nbsp;&nbsp;&nbsp; F1B59100 2A&nbsp;&nbsp;&nbsp;&nbsp;
000&nbsp;&nbsp;&nbsp;&nbsp; 19&nbsp;&nbsp;&nbsp;&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp; F&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT13 =
00000000&nbsp;&nbsp;&nbsp;&nbsp;
F0000000 7F&nbsp;&nbsp;&nbsp;&nbsp; 0FF&nbsp;&nbsp;&nbsp;&nbsp;
07&nbsp;&nbsp;&nbsp;&nbsp; B&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; =
P&nbsp;&nbsp;&nbsp;
S&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
V <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT14
A3000000&nbsp;&nbsp;&nbsp;&nbsp; FDD00000 C5&nbsp;&nbsp;&nbsp;&nbsp;
03F&nbsp;&nbsp;&nbsp;&nbsp; 16&nbsp;&nbsp;&nbsp;&nbsp;
7&nbsp;&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp;
E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; V =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>LT15 =
F7F00000&nbsp;&nbsp;&nbsp;&nbsp;
B0B80000 82&nbsp;&nbsp;&nbsp;&nbsp; 00F&nbsp;&nbsp;&nbsp;&nbsp;
1F&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp; =
F&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;
P&nbsp;&nbsp;&nbsp; P&nbsp;&nbsp;&nbsp; E&nbsp;&nbsp;&nbsp; =
E&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; D&nbsp;&nbsp;&nbsp; =
D&nbsp;&nbsp;&nbsp;
D&nbsp;&nbsp;&nbsp; V<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b><i><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy;font-weight:bold;
font-style:italic'><o:p>&nbsp;</o:p></span></font></i></b></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:navy'>T</span></font>o answer your <font
color=3Dnavy><span style=3D'color:navy'>2<sup>nd</sup> =
</span></font>question
&#8211; we have about 10 processes, and<o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>about 60-70 threads total (30+ for the main processing =
process)...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dnavy face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; Anybody have any ideas - and/or ways to =
re-configure our<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; setup to obtain more data? Or does this sound =
familiar to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; a bug somebody has already found in the =
kernel?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; We are even having trouble defining a test program =
that
can<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; cause (on purpose) the 'InstructionStorage' =
Exception
(does<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; anybody have an simple 'c' (or ppc assembly) =
program that<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; causes this exception (so we can run in user =
application
land<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; and see if the symptoms are =
similar))?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; Thank you in advance for any / all help you can
provide....<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; &gt; because I am completely stumped on even how to =
proceed!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Is your application generating a lot of processes or =
have a
lot of<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; concurrent processes on the =
8572?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; - k<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9DA1B.729BA08B--
