Return-Path: <sylvain.louchez@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 7577CDDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:33:16 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2325956wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 07:33:15 -0700 (PDT)
Message-ID: <49d0d82a.09038e0a.585d.348b@mx.google.com>
From: "sylvain louchez" <sylvain.louchez@gmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: using IRQ1 in mpc5121ads
Date: Mon, 30 Mar 2009 10:33:11 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01C9B122.EE172B30"
Reply-To: sylvain.louchez@g4apps.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C9B122.EE172B30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, I'm a newbie looking for where the documentation and implementation
model can be found.

 

My custom driver is looking for an interrupt notification from the kernel -
and it registers in the /proc/interrupts file as expected when installed,
i.e.

$insmod custom_driver.ko gps_irq=<n>

**Note - this part's OK, I see the instance in /proc/interrupts after I load
it**

 

On the hardware side the actual signal is a 1 Hz pulse (from GPS) routed to
IRQ1 through the board's CPLD. This is the only interrupt on IRQ_1 so we can
keep the logic simple i.e. on IRQ1 we can just jump to the service routine
in a custom driver.

 

I understand 2 things have to be done:

 

1. create an entry in the dts file; I think we've got this understood
through advice already received - for example the new interrupt entry can be
created in the dts file - something like:

 

gps@0 {      // there is no address so just make it 0

    compatible = "gps_interrupt";

    interrupts = <17 0x8>;         // 17 is irq1, 8 is level low, see
include/linux/irq.h for others

    interrupt-parent = < &ipic >;

};

 

2. but now we need to relate the actual interrupt to the virtual interrupt
called in the driver... by invoking the function irq_of_parse_and_map - but
we don't know how to do it - nor have we found how to do it in browsing
through the open source documentation

A secondary question: where to properly add this function call in the file
system?

 

Are we on the right track here? Is there sample/ tutorial code you could
point us to?

 

Thanks in advance for any pointers - documentation on these mechanisms,
sample code.

 

Sylvain Louchez

 


------=_NextPart_000_000F_01C9B122.EE172B30
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello, I&#8217;m a newbie looking for where the =
documentation
and implementation model can be =
found&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>My custom driver is looking for an interrupt =
notification
from the kernel - and it registers in the /proc/interrupts file as =
expected
when installed, i.e.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>$insmod custom_driver.ko =
gps_irq=3D&lt;n&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>**Note - this part's OK, I see the instance in
/proc/interrupts after I load it**<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>On the hardware side the actual signal is a 1 Hz =
pulse (from
GPS) routed to IRQ1 through the board's CPLD. This is the only interrupt =
on
IRQ_1 so we can keep the logic simple i.e. on IRQ1 we can just jump to =
the
service routine in a custom driver.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I understand 2 things have to be =
done:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1. create an entry in the dts file; I think we've got =
this
understood through advice already received - for example the new =
interrupt
entry can be created in the dts file - something =
like:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>gps@0 {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // there is no =
address so just make it 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;gps_interrupt&quot;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; interrupts =3D &lt;17 =
0x8&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 17 is irq1, =
8 is
level low, see include/linux/irq.h for =
others<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt; =
&amp;ipic &gt;;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2. but now we need to relate the actual interrupt to =
the
virtual interrupt called in the driver... by invoking the function
irq_of_parse_and_map - but we don't know how to do it - nor have we =
found how
to do it in browsing through the open source =
documentation<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>A secondary question: where to properly add this =
function
call in the file system?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Are we on the right track here? Is there sample/ =
tutorial
code you could point us to?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance for any pointers - documentation on =
these
mechanisms, sample code&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sylvain Louchez<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000F_01C9B122.EE172B30--
