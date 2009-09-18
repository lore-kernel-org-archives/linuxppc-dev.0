Return-Path: <Sylvain.Cote@verint.com>
Received: from exprod7og124.obsmtp.com (exprod7og124.obsmtp.com [64.18.2.26])
	by ozlabs.org (Postfix) with SMTP id 01B93B7B7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Sep 2009 01:59:25 +1000 (EST)
From: "Cote, Sylvain" <Sylvain.Cote@verint.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 18 Sep 2009 11:50:24 -0400
Subject: PPC_4xx synopsy USB driver
Message-ID: <579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37@ATLMBX.verint.corp.verintsystems.com>
Content-Type: multipart/alternative;
	boundary="_000_579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37ATLMBXverin_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37ATLMBXverin_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying the new USB dwc-otg Synopsys driver on my powerpc 405ex board. =
 I am using the kernel 2.6.30.3 from denx git (head 2.6.30 stable 2009-09-0=
4 snapshot).  Previously I was using the USB driver from 2.6.25 kernel.  Th=
e driver was unstable and was only working when I enabled some debug prints=
.

I am moving to the new kernel to get improvement on that USB driver. Howeve=
r, I have some problems with it.  My problem is that probe function is neve=
r called (dwc_otg_driver_probe).  The driver init call is done and I can se=
e the debug print "dwc_otg: version 2.60a 22-NOV-2006" but no more call (n.=
b. I enabled all debug print).  Initialisation is done in probe function, s=
o, my usb dwc_otg controller is not initialized.  In theory, when module is=
 inserted, init is called (dwc_otg_driver_init).  This init call, register =
the driver (platform_driver_register) and, in this registration, configured=
 the probe function to call (dwc_otg_driver_probe).  But as I said, probe i=
s never called.

First, in my setup, I want to use USB in host mode.

My usb-otg portion of my dts file is:

USBOTG0: usbotg@ef6c0000 {
                                    compatible =3D "amcc,usb-otg-405ex", "a=
mcc,usb-otg";
                                    reg =3D <0xef6c0000 0x10000>;
                                    interrupt-parent =3D <&USBOTG0>;
                                    interrupts =3D <0 1 2>;
                                    #interrupt-cells =3D <1>;
                                    #address-cells =3D <0>;
                                    #size-cells =3D <0>;
                                    interrupt-map =3D </* USB-OTG */ 0 &UIC=
2 0x1e 4
                                                             /* HIGH-POWER =
*/ 1 &UIC1 0x1a 8
                                                             /* DMA */ 2 &U=
IC0 0xc 4>;
                                    interrupt-map-mask =3D <0xffffffff>;
                        };

My USB potion of my kernel config (menuconfig)

Support for host-side USB -> y
USB announce new devices --> y
USB device filesystem --> y
USB device class-devices --> y
USB dynamic USB minor allocation --> y

USB mass storage support --> y

USB gadget support --> y
            Maximum VBUS power usage =3D 500
            Synopsys DWC OTG controller
            Synopsys DWC OTG internal DMA mode --> y
            USB gadget --> M
            gadget zero --> M
            Ethernet Gadget --> M
            RNDIS support --> y

Any help will be appreciated

Thank you,

Sylvain

This electronic message may contain proprietary and confidential informat=
ion of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
--_000_579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37ATLMBXverin_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
-->
</style>

</head>

<body lang=3DEN-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am trying the new USB dwc-otg Synopsys driver on my po=
werpc
405ex board. &nbsp;I am using the kernel 2.6.30.3 from denx git (head 2.6.3=
0
stable 2009-09-04 snapshot).&nbsp; Previously I was using the USB driver fr=
om
2.6.25 kernel.&nbsp; The driver was unstable and was only working when I
enabled some debug prints. &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am moving to the new kernel to get improvement on that=
 USB
driver. However, I have some problems with it.&nbsp; My problem is that pro=
be
function is never called (dwc_otg_driver_probe). &nbsp;The driver init call=
 is
done and I can see the debug print &#8220;dwc_otg: version 2.60a 22-NOV-200=
6&#8221;
but no more call (n.b. I enabled all debug print).&nbsp; Initialisation is =
done
in probe function, so, my usb dwc_otg controller is not initialized.&nbsp; =
In
theory, when module is inserted, init is called (dwc_otg_driver_init). &nbs=
p;This
init call, register the driver (platform_driver_register) and, in this
registration, configured the probe function to call (dwc_otg_driver_probe).=
 &nbsp;But
as I said, probe is never called.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>First, in my setup, I want to use USB in host mode. <o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>My usb-otg portion of my dts file is:<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>USBOTG0: usbotg@ef6c0000 {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; compatible
=3D &quot;amcc,usb-otg-405ex&quot;, &quot;amcc,usb-otg&quot;;<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; reg
=3D &lt;0xef6c0000 0x10000&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; interrupt-parent
=3D &lt;&amp;USBOTG0&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; interrupts
=3D &lt;0 1 2&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; #interrupt-cells
=3D &lt;1&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; #address-cells
=3D &lt;0&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; #size-cells
=3D &lt;0&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; interrupt-map
=3D &lt;/* USB-OTG */ 0 &amp;UIC2 0x1e 4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
/*
HIGH-POWER */ 1 &amp;UIC1 0x1a 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;/*
DMA */ 2 &amp;UIC0 0xc 4&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; interrupt-map-mask
=3D &lt;0xffffffff&gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; };<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>My USB potion of my kernel config (menuconfig)<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Support for host-side USB &#8211;</span></font><font siz=
e=3D2
face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:Arial=
'>&gt; y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB announce new devices </span></font><font size=
=3D2
face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:W=
ingdings'>&agrave;</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB device filesystem </span></font><font size=3D=
2
face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:W=
ingdings'>&agrave;</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB device class-devices </span></font><font size=
=3D2
face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:W=
ingdings'>&agrave;</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB dynamic USB minor allocation </span></font><f=
ont
size=3D2 face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font=
-family:
Wingdings'>&agrave;</span></font><font size=3D2 face=3DArial><span lang=3DE=
N-US
style=3D'font-size:10.0pt;font-family:Arial'> y<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB mass storage support </span></font><font size=
=3D2
face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:W=
ingdings'>&agrave;</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>USB gadget support </span></font><font size=3D2
face=3DWingdings><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:W=
ingdings'>&agrave;</span></font><font
size=3D2 face=3DArial><span lang=3DEN-US style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Maximum
VBUS power usage =3D 500<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Synopsys
DWC OTG controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3DArial><span lang=3DFR style=3D'font-size:10.0pt;font-family=
:Arial'>Synopsys
DWC OTG internal DMA mode </span></font><font size=3D2 face=3DWingdings><sp=
an
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Wingdings'>&agrave;</spa=
n></font><font
size=3D2 face=3DArial><span lang=3DFR style=3D'font-size:10.0pt;font-family=
:Arial'> y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; USB
gadget </span></font><font size=3D2 face=3DWingdings><span lang=3DFR
style=3D'font-size:10.0pt;font-family:Wingdings'>&agrave;</span></font><fon=
t
size=3D2 face=3DArial><span lang=3DFR style=3D'font-size:10.0pt;font-family=
:Arial'> M<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gadget
zero </span></font><font size=3D2 face=3DWingdings><span lang=3DFR style=3D=
'font-size:
10.0pt;font-family:Wingdings'>&agrave;</span></font><font size=3D2 face=3DA=
rial><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'> M<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Ethernet
Gadget </span></font><font size=3D2 face=3DWingdings><span lang=3DFR
style=3D'font-size:10.0pt;font-family:Wingdings'>&agrave;</span></font><fon=
t
size=3D2 face=3DArial><span lang=3DFR style=3D'font-size:10.0pt;font-family=
:Arial'> M<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RNDIS
support </span></font><font size=3D2 face=3DWingdings><span lang=3DFR
style=3D'font-size:10.0pt;font-family:Wingdings'>&agrave;</span></font><fon=
t
size=3D2 face=3DArial><span lang=3DFR style=3D'font-size:10.0pt;font-family=
:Arial'> y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>Any help will be appreciated<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>Thank you,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>Sylvain<o:p></o:p></span></font></p>

</div>

</body>

</html>

<pre>This electronic message may contain proprietary and confidential inf=
ormation of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
--_000_579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37ATLMBXverin_--
