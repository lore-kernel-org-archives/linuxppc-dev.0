Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E608B679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 03:58:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BB14.4CE2C4F9"
Subject: RE: Xilinx hard TEMAC
Date: Tue, 8 Aug 2006 11:58:42 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C02BC32B4@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: <dhlii@comcast.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6BB14.4CE2C4F9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David,

=20

Could you send a system.mhs file from the EDK project you're using so I
can get a bearing on what exactly you have in the hardware?  I didn't
think the LL TEMAC could be used without the DMA engine (CDMAC), which
is where the interrupts come from in the Linux/VxWorks drivers I've seen
for this core.

=20

-Rick

=20

________________________________

From: David H. Lynch Jr. [mailto:dhlii@dlasys.net]=20
Sent: Saturday, July 29, 2006 7:09 PM
To: Rick Moleres
Cc: linuxppc-embedded
Subject: Re: Xilinx hard TEMAC

=20

Rick Moleres wrote:=20

=20
That is the correct distinction between "soft" and "hard".  Just know
that in this case the "soft" TEMAC (whether LL TEMAC or PLB TEMAC) uses
the "hard" TEMAC, and the "hard" TEMAC by itself is not that useful.
 =20

    First, thanks, your remarks have been enormously helpful.

    I have successfully put together a Driver for the TEMAC currently
used in the Pico E-12.
   =20
    I am still having some difficulty corresponding this TEMAC
implimentation to any of Xilinx's documentation.
    It is Exactly the TEMAC supported by the Xilinx uCOSII Treck Web
Server application.
    It seems to be extremely minimal. Basically a DCR interface for most
things that closely matches the GSRD documents.
    and TX and RX FIFO's that I can't seem to find documented anywhere,
but I have working based on the Treck WebServer code.

    I am have two remaining problems and then I am done.
   =20
       The first is I am currently doing polled I/O. The transmits
happen as they are requested and the receives are picked up ona a timer
interrupt.
    But I am dropping about 50% or more of the receives. I will work
that out myself eventually.

       The second is that this driver will serve as the basis for a
driver in other Pico supported OS's. Some of which have no means of
doing Polled Receives.
       And I can not get interrupts working. Since my hardware does nto
match anything perfectly - except that Treck Webserver application and
that does not do interrupts.
    I am reading all the Xilinx TEMAC Documents and the GSRD documents
reference an IRENABLE register and an IRSTATUS register, I cobbled
something together=20
    assuming that they were access much as the other DCR registers in
that block and I assumed the bits in IRSTATUS and IRENABLE matched the
definitions of those=20
    in larger TEMAC implimentations. It appeared after I enabled TX and
RX complete interrupts that when I have received data available the
IRSTATUS register has the=20
    Bit set for an Rx interrupt. All fine - except that no interrupt
actually occurs.
    I can force interrupts from the PHY using the same IRQ so the IRQ is
connected correctly and programmed correctly. Other TEMAC
implimentations seem to have a GIE - Global Interrupt enable
    Bit, but I do not have a clue where to look here. What I could get
out of the Xilinx Webset GSRD seems to be a Linux driver that uses the
DMA unit and that generates its own interrupts.
    I don't think I have the DMA in my bit image.

    Anyway any clues as to where I can find some useful docs on
Interrupt handling for the LL_TEMAC that is used by the uCOSII WebServer
application ?














Thereis a Linux driver for the LL_TEMAC that comes with GSRD, but my
 =20
group's efforts go toward the PLB_TEMAC as that is the EDK IP we want to
 =20
promote and whose drivers we'd like to see in kernel.org.
=20
You should be able to go to http://www.xilinx.com/gsrd to get the GSRD
design, and inside of that design somewhere you'll find a Linux 2.4
driver for the LL TEMAC.
 =20
=20
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
 =20






--=20
Dave Lynch                                                 DLA Systems
Software Development:                                   Embedded Linux
717.627.3770            dhlii@dlasys.net          http://www.dlasys.net
fax: 1.253.369.9244                                Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.
=20
"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein

------_=_NextPart_001_01C6BB14.4CE2C4F9
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	color:black;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>David,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Could you send a system.mhs file =
from the
EDK project you&#8217;re using so I can get a bearing on what exactly =
you have
in the hardware? &nbsp;I didn&#8217;t think the LL TEMAC could be used =
without the
DMA engine (CDMAC), which is where the interrupts come from in the
Linux/VxWorks drivers I&#8217;ve seen for this =
core.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-Rick<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
color:windowtext'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><b><font size=3D2 =
color=3Dblack
face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma;color:windowtext;
font-weight:bold'>From:</span></font></b><font size=3D2 color=3Dblack =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma;color:windowtext'> David H. =
Lynch
Jr. [mailto:dhlii@dlasys.net] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Saturday, July 29, =
2006 7:09
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Rick Moleres<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> linuxppc-embedded<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Xilinx hard =
TEMAC</span></font><font
color=3Dblack><span =
style=3D'color:windowtext'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Rick Moleres =
wrote: <o:p></o:p></span></font></p>

<pre style=3D'margin-left:.5in' wrap=3D""><font size=3D2 color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>That is the correct distinction between =
&quot;soft&quot; and &quot;hard&quot;.&nbsp; Just =
know<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>that in this case the &quot;soft&quot; TEMAC =
(whether LL TEMAC or PLB TEMAC) uses<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>the &quot;hard&quot; TEMAC, and the =
&quot;hard&quot; TEMAC by itself is not that =
useful.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&nbsp; <o:p></o:p></span></font></pre>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp; First,
thanks, your remarks have been enormously helpful.<br>
<br>
&nbsp;&nbsp;&nbsp; I have successfully put together a Driver for the =
TEMAC
currently used in the Pico E-12.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; I am still having some difficulty corresponding this =
TEMAC
implimentation to any of Xilinx's documentation.<br>
&nbsp;&nbsp;&nbsp; It is Exactly the TEMAC supported by the Xilinx =
uCOSII Treck
Web Server application.<br>
&nbsp;&nbsp;&nbsp; It seems to be extremely minimal. Basically a DCR =
interface
for most things that closely matches the GSRD documents.<br>
&nbsp;&nbsp;&nbsp; and TX and RX FIFO's that I can't seem to find =
documented
anywhere, but I have working based on the Treck WebServer code.<br>
<br>
&nbsp;&nbsp;&nbsp; I am have two remaining problems and then I am =
done.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The first is I am currently doing polled =
I/O.
The transmits happen as they are requested and the receives are picked =
up ona a
timer interrupt.<br>
&nbsp;&nbsp;&nbsp; But I am dropping about 50% or more of the receives. =
I will
work that out myself eventually.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The second is that this driver will =
serve as
the basis for a driver in other Pico supported OS's. Some of which have =
no
means of doing Polled Receives.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; And I can not get interrupts working. =
Since my
hardware does nto match anything perfectly - except that Treck Webserver
application and that does not do interrupts.<br>
&nbsp;&nbsp;&nbsp; I am reading all the Xilinx TEMAC Documents and the =
GSRD
documents reference an IRENABLE register and an IRSTATUS register, I =
cobbled
something together <br>
&nbsp;&nbsp;&nbsp; assuming that they were access much as the other DCR
registers in that block and I assumed the bits in IRSTATUS and IRENABLE =
matched
the definitions of those <br>
&nbsp;&nbsp;&nbsp; in larger TEMAC implimentations. It appeared after I =
enabled
TX and RX complete interrupts that when I have received data available =
the
IRSTATUS register has the <br>
&nbsp;&nbsp;&nbsp; Bit set for an Rx interrupt. All fine - except that =
no
interrupt actually occurs.<br>
&nbsp;&nbsp;&nbsp; I can force interrupts from the PHY using the same =
IRQ so
the IRQ is connected correctly and programmed correctly. Other TEMAC
implimentations seem to have a GIE - Global Interrupt enable<br>
&nbsp;&nbsp;&nbsp; Bit, but I do not have a clue where to look here. =
What I
could get out of the Xilinx Webset GSRD seems to be a Linux driver that =
uses
the DMA unit and that generates its own interrupts.<br>
&nbsp;&nbsp;&nbsp; I don't think I have the DMA in my bit image.<br>
<br>
&nbsp;&nbsp;&nbsp; Anyway any clues as to where I can find some useful =
docs on
Interrupt handling for the LL_TEMAC that is used by the uCOSII WebServer
application ?<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<o:p></o:p></span></font></p>

<pre style=3D'margin-left:.5in' wrap=3D""><font size=3D2 color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt'>Thereis a Linux =
driver for the LL_TEMAC that comes with GSRD, but =
my<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&nbsp; <o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in' wrap=3D""><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>group's efforts go toward the PLB_TEMAC as =
that is the EDK IP we want to<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&nbsp; <o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in' wrap=3D""><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>promote and whose drivers we'd like to see in =
kernel.org.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>You should be able to go to <a
href=3D"http://www.xilinx.com/gsrd">http://www.xilinx.com/gsrd</a> to =
get the GSRD<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>design, and inside of that design somewhere =
you'll find a Linux 2.4<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>driver for the LL =
TEMAC.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&nbsp; <o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in' wrap=3D""><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>______________________________________________=
_<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Linuxppc-embedded mailing =
list<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'><a =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org=
</a><o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'><a
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</a><o:p></o:p></span></font><=
/pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&nbsp; <o:p></o:p></span></font></pre>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
color=3Dblack
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<pre style=3D'margin-left:.5in'><font size=3D2 color=3Dblack =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>-- <o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Dave Lynch =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;DLA =
Systems<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Software Development:&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Embedded =
Linux<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>717.627.3770 &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
href=3D"mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<a
href=3D"http://www.dlasys.net">http://www.dlasys.net</a><o:p></o:p></span=
></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>fax: 1.253.369.9244 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cell: =
1.717.587.7774<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Over 25 years' experience in platforms, =
languages, and technologies too numerous to =
list.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>&quot;Any intelligent fool can make things =
bigger and more complex... It takes a touch of genius - and a lot of =
courage to move in the opposite =
direction.&quot;<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Albert =
Einstein<o:p></o:p></span></font></pre></div>

</body>

</html>

------_=_NextPart_001_01C6BB14.4CE2C4F9--
