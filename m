Return-Path: <kho@belairnetworks.com>
Received: from mail.belairnetworks.com (mail.belairnetworks.com
	[142.46.200.253]) by ozlabs.org (Postfix) with ESMTP id C5AD1B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 07:59:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CBB9AC.65CBE502"
Subject: Setting GPIO to trigger interrupt on mpc85xx
Date: Fri, 21 Jan 2011 15:47:20 -0500
Message-ID: <92C536451C241244A14F3001819BF6688A5018@bnott05.belairnetworks.com>
From: "Kenny Ho" <kho@belairnetworks.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBB9AC.65CBE502
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am working on the fsl P1020rdb kit with the 2.6.32 linux kernel that
came with the kit and I am trying to get an GPIO to trigger an
interrupt.  I am fairly new and have been stumbling for quite a bit with
no success so I am hoping some of you experts out there can give me some
pointers.

=20

=20

=20

**What I have tried so far**:

=20

I am implementing the interrupt setup on my custom GPIO module during
its init.  I started following the information available in Linux Device
Drivers, Third Edition but it turns out to be out of date or
incompatible with the ppc platform.  (The device tree, the hwirq to virq
mapping... even though the number turns out to be the same for GPIO,
etc.)=20

=20

Initially I was only calling request_irq but I got ENOSYS.  That was
solved by calling irq_create_mapping but then the module init was stuck
at the request_irq (with the isr continuously being called.)  That was
resolved when I ended up using the device tree by calling
irq_of_parse_and_map and using set_irq_handler before calling
request_irq.   Now the module successfully init and I can see the isr
entry in /proc/interrupt but when I physically toggle my GPIO pin, the
handler set by set_irq_handler was being called continuously (and then
crash) while the isr set by request_irq was never called.=20

=20

Another thing I don't understand is that the /proc/interrupt entry say
the gpio interrupt is OpenPIC Level when the GPIO interrupt is suppose
to be edge only (either falling only or both.)  My dts interrupt entry
for the GPIO is <47 2>, which should indicates edge trigger right?

=20

=20

**My questions**:

What are the relationship between set_irq_handler, set_irq_type and
request_irq?  Are the first two supposed to be a replacement of the 3rd
or are they suppose to be used concurrently?

=20

What are the differences between the handler set by set_irq_handler and
the isr set by request_irq?  Which one is called first?  Or should only
one of them get set at all time?

=20

(I was reading
http://www.kernel.org/pub/linux/kernel/people/tglx/armirq/DocBook/index.
html but I am still very confused.)

=20

Which signals are those IRQ type referring to?  Are they referring to
the triggering signal (GPIO in my case) or the PIC signal to the cpu
core?

=20

What are the things I need to do in the IRQ handler/isr to terminate an
interrupt?  I know I need to clear the event register (which is GPIER in
my case) which I have done but that didn't stop the handler from getting
call again.  Must I also disable the interrupt?  For the isr set by
request_irq, I also return IRQ_HANDLED... is that sufficient?

=20

For the handler set by set_irq_handler, do I need to call other handler?
I noticed there are generic_handle_irq and handle_(level/edge,
etc)_irq... am I suppose to call those to terminate an interrupt?  I
also noticed there are eoi() and end() in desc->chip.  (I assume those
are for the PIC)... am I suppose to call those as well?

=20

=20

As you can see... I am very much confused and have lots of questions.
Any help from you folks is much appreciated.

=20

Regards,

Kenny Ho

=20

=20

=20


------_=_NextPart_001_01CBB9AC.65CBE502
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am working on the fsl P1020rdb kit with the 2.6.32 =
linux kernel
that came with the kit and I am trying to get an GPIO to trigger an =
interrupt. &nbsp;I
am fairly new and have been stumbling for quite a bit with no success so =
I am
hoping some of you experts out there can give me some =
pointers.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>**What I have tried so =
far**:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am implementing the interrupt setup on my custom =
GPIO
module during its init. &nbsp;I started following the information =
available in Linux
Device Drivers, Third Edition but it turns out to be out of date or
incompatible with the ppc platform. &nbsp;(The device tree, the hwirq to =
virq
mapping&#8230; even though the number turns out to be the same for GPIO, =
etc.) <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initially I was only calling request_irq but I got =
ENOSYS. &nbsp;That
was solved by calling irq_create_mapping but then the module init was =
stuck at the
request_irq (with the isr continuously being called.) &nbsp;That was =
resolved
when I ended up using the device tree by calling irq_of_parse_and_map =
and using
set_irq_handler before calling request_irq. &nbsp;&nbsp;Now the module
successfully init and I can see the isr entry in /proc/interrupt but =
when I physically
toggle my GPIO pin, the handler set by set_irq_handler was being called
continuously (and then crash) while the isr set by request_irq was never
called. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Another thing I don&#8217;t understand is that the
/proc/interrupt entry say the gpio interrupt is OpenPIC Level when the =
GPIO interrupt
is suppose to be edge only (either falling only or both.)&nbsp; My dts =
interrupt
entry for the GPIO is &lt;47 2&gt;, which should indicates edge trigger =
right?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>**My questions**:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What are the relationship between set_irq_handler,
set_irq_type and request_irq? &nbsp;Are the first two supposed to be a
replacement of the 3<sup>rd</sup> or are they suppose to be used =
concurrently?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What are the differences between the handler set by
set_irq_handler and the isr set by request_irq? &nbsp;Which one is =
called
first?&nbsp; Or should only one of them get set at all =
time?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(I was reading </span></font><a
href=3D"http://www.kernel.org/pub/linux/kernel/people/tglx/armirq/DocBook=
/index.html">http://www.kernel.org/pub/linux/kernel/people/tglx/armirq/Do=
cBook/index.html</a>
but I am still very confused.)<font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Which signals are those IRQ type referring to? =
&nbsp;Are
they referring to the triggering signal (GPIO in my case) or the PIC =
signal to
the cpu core?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What are the things I need to do in the IRQ =
handler/isr to
terminate an interrupt? &nbsp;I know I need to clear the event register =
(which
is GPIER in my case) which I have done but that didn&#8217;t stop the =
handler
from getting call again. &nbsp;Must I also disable the interrupt?&nbsp; =
For the
isr set by request_irq, I also return IRQ_HANDLED&#8230; is that =
sufficient?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>For the handler set by set_irq_handler, do I need to =
call
other handler? &nbsp;I noticed there are generic_handle_irq and
handle_(level/edge, etc)_irq&#8230; am I suppose to call those to =
terminate an
interrupt? &nbsp;I also noticed there are eoi() and end() in =
desc-&gt;chip. &nbsp;(I
assume those are for the PIC)&#8230; am I suppose to call those as =
well?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>As you can see&#8230; I am very much confused and =
have lots
of questions. &nbsp;Any help from you folks is much =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kenny Ho<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CBB9AC.65CBE502--
