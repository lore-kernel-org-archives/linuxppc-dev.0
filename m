Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 890C2DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 08:43:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C8C3.8F53F9E2"
Subject: RE: Linuxppc-embedded Digest, Vol 35, Issue 33
Date: Tue, 17 Jul 2007 15:41:05 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D78D7FAF@corpexc01.corp.networkrobots.com>
In-Reply-To: <e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
	<469B9825.6070507@freescale.com>
	<e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: "suresh suresh" <sureshtang@gmail.com>,
	"Scott Wood" <scottwood@freescale.com>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C8C3.8F53F9E2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Well!... you can manage any way you want.

=20

1) You can store the virtual address in the DpRAM, and convert to
physical (should I say DMA mapped address) and then pass it on to the
device under consideration here.

=20

2) Other way would be... store the physical address in DpRAM. Use that
address for the device, and convert to virtual before you use it in the
code.

=20

My preference is for first option.

=20

- Siva

=20

=20

________________________________

From: suresh suresh [mailto:sureshtang@gmail.com]=20
Sent: Monday, July 16, 2007 10:59 PM
To: Scott Wood
Cc: Siva Prasad; linuxppc-embedded@ozlabs.org
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 33

=20

Thanks....

MPC8280 has internal memory space which contains Dualport(Dp) RAM. In
the DpRAM we allocate some tables and these has to store pointer of the
buffers which are allocated in external memory. Core will use this
pointer to access the buffers, basically these buffers are used for DMA.

Using IMMR register we can get physical address of the internal memory.
Now can I store the address return by the kmalloc() function? or I
should convert it into physical?

Please help me how to resove this address translation.


Regards,
Suresh

On 7/16/07, Scott Wood <scottwood@freescale.com> wrote:

Siva Prasad wrote:
> It returns kernel virtual address. If you use this buffer space for
DMA,
> please use appropriate flags. You may use __pa(address) or
> virt_to_phys() to convert virtual to physical.=20

No, you may not -- physical and DMA addresses are not always identical.
  Use the DMA mapping API.

-Scott

=20


------_=_NextPart_001_01C7C8C3.8F53F9E2
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
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Well!... you can manage any way you =
want.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>1) You can store the virtual =
address in
the DpRAM, and convert to physical (should I say DMA mapped address) and =
then
pass it on to the device under consideration =
here.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>2) Other way would be&#8230; store =
the
physical address in DpRAM. Use that address for the device, and convert =
to
virtual before you use it in the code.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>My preference is for first =
option.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>- Siva<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
suresh suresh
[mailto:sureshtang@gmail.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, July 16, =
2007 10:59
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Scott Wood<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> Siva Prasad;
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: =
Linuxppc-embedded
Digest, Vol 35, Issue 33</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Thanks....<br>
<br>
MPC8280 has internal memory space which contains Dualport(Dp) RAM. In =
the DpRAM
we allocate some tables and these has to store pointer of the buffers =
which are
allocated in external memory. Core will use this pointer to access the =
buffers,
basically these buffers are used for DMA.<br>
<br>
Using IMMR register we can get physical address of the internal memory. =
Now can
I store the address return by the kmalloc() function? or I should =
convert it
into physical?<br>
<br>
Please help me how to resove this address translation.<br>
<br>
<br>
Regards,<br>
Suresh<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><span class=3Dgmailquote><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>On 7/16/07, <b><span =
style=3D'font-weight:bold'>Scott
Wood</span></b> &lt;<a =
href=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;
wrote:</span></font></span><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Siva Prasad =
wrote:<br>
&gt; It returns kernel virtual address. If you use this buffer space for =
DMA,<br>
&gt; please use appropriate flags. You may use __pa(address) or<br>
&gt; virt_to_phys() to convert virtual to physical. <br>
<br>
No, you may not -- physical and DMA addresses are not always =
identical.<br>
&nbsp;&nbsp;Use the DMA mapping API.<br>
<br>
-Scott<o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7C8C3.8F53F9E2--
