Return-Path: <peterluan@truebroad.com>
Received: from mxvip35.hichina.com (mxvip35.hichina.com [218.106.248.85])
	by ozlabs.org (Postfix) with ESMTP id 95442DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 20:26:52 +1000 (EST)
From: "Peter Luan" <peterluan@truebroad.com>
To: <grant.likely@secretlab.ca>,
	<jacmet@sunsite.dk>
Subject: Re: Using Cypress EZ-Host on ML403/5
Date: Sat, 26 May 2007 18:20:01 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C79FC2.79D2D300"
Message-ID: <1180174808$27627$25143635@peterluan@truebroad.com>
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

------=_NextPart_000_0007_01C79FC2.79D2D300
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi First of all, I'm a beginner, so my questions may be funny .... sorry for
that. 

Any how your ideas are very valuable for me. I'm going to have the usb work
on ML403.

I have two questions about the usb on ml403 board.

 

1) In EDK9.1i, we can use the wizard to build a new design with usb. But I
found it's different from the reference design that xilinx provided for
edk8.1i. So which design should I choose? In datasheet of opb_epc, I found
that we should add the irq manually. So I added the irq and reset according
to xapp925. After that, I patched my linux kernel using the patch by Peter
Korsgaard. But when I pluged in the usb camera, it can't probe it. What
should I do additionally?

 

2) I can't find where to initialize the base registers and irq in the usb
driver for cy7c67300 provided by Peter Korsgaard. In the function
usb_c67x00_drv_probe, I found it called platform_get_resource(pdev,
IORESOURCE_MEM, 0). So I think I should add some register codes for usb like
uartlite or temac in virtex.c. I added the following codes:

 #ifdef XPAR_USB_0_BASEADDR

      [VIRTEX_USB_0] = {

           .name = "xilix_usb",

           .id = 0,

           .num_resource = 2,

           .resource = (struct resource[]) {

                 {

                      .start  = XPAR_USB_0_BASEADDR,

                      .end    = XPAR_USB_0_HIGHADDR,

                      .flags  = IORESOURCE_MEM,

                 },

                 {

                      .start  = XPAR_INTC_0_USB_0_VEC_ID,

                      .end    = XPAR_INTC_0_USB_0_VEC_ID,

                      .flags  = IORESOURCE_IRQ,

                 }

           }

      },

#endif

 

and define the following macro in xparameters_ml403.h.

 

#define XPAR_INTC_0_USB_0_VEC_ID XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR

#define XPAR_USB_0_BASEADDR XPAR_CYPRESS_USB_PRH0_BASEADDR

#define XPAR_USB_0_HIGHADDR XPAR_CYPRESS_USB_PRH0_HIGHADDR

 

After that, it still can't prob the usb device. So could you give me some
suggestion about making usb work on ml403?

 

Thank you very much!

 

Peter Luan


------=_NextPart_000_0007_01C79FC2.79D2D300
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:60.0pt 60.0pt 60.0pt 60.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>Hi First of all, I'm a beginner, so my =
questions may
be funny .... sorry for that. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>Any how your ideas are very valuable for me. =
I'm
going to have the usb work on ML403.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>I have two questions about the usb on ml403 =
board.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>1) In EDK9.1i, we can use the wizard to build =
a new
design with usb. But I found it's different from the reference design =
that
xilinx provided for edk8.1i. So which design should I choose? In =
datasheet of
opb_epc, I found that we should add the irq manually. So I added the irq =
and
reset according to xapp925. After that, I patched my linux kernel using =
the
patch by Peter Korsgaard. But when I pluged in the usb camera, it can't =
probe
it. What should I do additionally?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>2) I can't find where to initialize the base
registers and irq in the usb driver for cy<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"7" UnitName=3D"C" =
w:st=3D"on">7c</st1:chmetcnv>67300
provided by Peter Korsgaard. In the function usb_c67x00_drv_probe, I =
found it
called platform_get_resource(pdev, IORESOURCE_MEM, 0). So I think I =
should add
some register codes for usb like uartlite or temac in virtex.c. I added =
the
following codes:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;#ifdef =
XPAR_USB_0_BASEADDR<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VIRTEX_USB_0] =
=3D {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .name
=3D &quot;xilix_usb&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .id
=3D 0,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .num_resource
=3D 2,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .resource
=3D (struct resource[]) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .start&nbsp;
=3D XPAR_USB_0_BASEADDR,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .end&nbsp;&nbsp;&nbsp; =3D
XPAR_USB_0_HIGHADDR,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .flags&nbsp; =3D
IORESOURCE_MEM,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .start&nbsp;
=3D XPAR_INTC_0_USB_0_VEC_ID,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .end&nbsp;&nbsp;&nbsp; =3D
XPAR_INTC_0_USB_0_VEC_ID,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .flags&nbsp; =3D
IORESOURCE_IRQ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>#endif<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>and define the following macro in
xparameters_ml403.h.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>#define XPAR_INTC_0_USB_0_VEC_ID
XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>#define XPAR_USB_0_BASEADDR
XPAR_CYPRESS_USB_PRH0_BASEADDR<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>#define XPAR_USB_0_HIGHADDR
XPAR_CYPRESS_USB_PRH0_HIGHADDR<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>After that, it still can't prob the usb =
device. So
could you give me some suggestion about making usb work on =
ml403?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>Thank you very =
much!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D4 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
14.0pt;font-family:Arial'>Peter Luan<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0007_01C79FC2.79D2D300--
