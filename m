Return-Path: <dadair@ariodata.com>
Received: from orion.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id 0955A2BDDD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 03:56:45 +1000 (EST)
Date: Thu, 23 Sep 2004 10:46:51 -0700
Message-ID: <F152162DB1B0D2458EA395AD074DE1C468CA04@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4A195.4EE53FE4"
From: "David Adair" <dadair@ariodata.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Is anyone using Critical Interrupts on PPC440 in 2.4 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4A195.4EE53FE4
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Sorry if this has been covered before - I for one could make use of that
old list tarball if it were available.

=20

I am interested in using the interrupts controlled by MSR[CE],
specifically to help debug Watchdog timeout and PCI hang issues and
perhaps ultimately recover from them somehow.  While I am able to
achieve some level of operation a quick browse of 2.6.8 makes me very
nervous that I may be re-inventing the wheel because it now includes the
code to properly load a 32 bit MSR_KERNEL setting but does not appear to
actually use either of the MSR[CE] controlled vectors (Watchdog,
CriticalInput).

=20

- Are there patches available that somehow use either Critical Input or
Watchdog for something other than "unknown?"  I would not want to do
anything that conflicts too badly with some low-latency interrupt scheme
for instance.

=20

- Has a back-port of the updated 32 bit MSR_KERNEL handling to 2.4 been
done already?  I did this before realizing it was already done in 2.6.

=20

- Is there any version that has normal IRQ handling smart enough to
leave critical interrupts alone?  I had to resort to the rather ugly
trick of registering a dummy handler on IRQ 31 (UIC1 CI cascade) to keep
it from getting disabled.

=20

- Has anyone ever considered a patch that replaces the normal HW
exception handling with an immediate panic?  For an embedded system
continuing to run after one or more user space processes has been
terminated does not seem to be an optimal behavior.

=20

- Are patches being accepted for 2.4, or is everything 2.6 now?

=20

What I am up to:

=20

Situation:

=20

The board I am working on is subject to random re-boots due to Watchdog
timeouts.  Some of these are due to driver bugs (500mS udelay's, waiting
forever for stuff that never happens etc), and others are due to PCI
devices that insist on claiming split transactions and then waiting
several seconds before responding.  These situations are of course very
rare and almost impossible to duplicate so a JTAG debugger is out of the
question.

=20

Proposed solution:

=20

Install an interrupt hander that captures the register dump and stack
trace whenever a watchdog or PCI error occurs.  Since there is no choice
for the watchdog and the PCI errors could happen during interrupt top
halves or with interrupts disabled both situations pretty much require
the use of Critical Exceptions.

=20

The PCI error capture is not completely redundant because some of my
boards have a bridge that can be configured to time out and abort the
offending transactions.  Doing this without the handler however just
makes my problems harder to debug by allowing the driver to continue for
who knows how long before crashing.

=20

For now I just capture the trace and then panic the kernel (cheap and
easy HA solution) to "recover".  Longer term I may try to develop a
mechanism to allow drivers to register for some sort of notification and
recover more gracefully.

=20

David

=20


------_=_NextPart_001_01C4A195.4EE53FE4
Content-Type: text/html;
	charset="US-ASCII"
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
font-family:Arial'>Sorry if this has been covered before &#8211; I for =
one
could make use of that old list tarball if it were =
available.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am interested in using the interrupts controlled by
MSR[CE], specifically to help debug Watchdog timeout and PCI hang issues =
and
perhaps ultimately recover from them somehow.&nbsp; While I am able to =
achieve
some level of operation a quick browse of 2.6.8 makes me very nervous =
that I
may be re-inventing the wheel because it now includes the code to =
properly load
a 32 bit MSR_KERNEL setting but does not appear to actually use either =
of the
MSR[CE] controlled vectors (Watchdog, =
CriticalInput).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- Are there patches available that somehow use either
Critical Input or Watchdog for something other than =
&#8220;unknown?&#8221;&nbsp;
I would not want to do anything that conflicts too badly with some =
low-latency
interrupt scheme for instance.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- Has a back-port of the updated 32 bit MSR_KERNEL =
handling
to 2.4 been done already? &nbsp;I did this before realizing it was =
already done
in 2.6.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- Is there any version that has normal IRQ handling =
smart
enough to leave critical interrupts alone?&nbsp; I had to resort to the =
rather
ugly trick of registering a dummy handler on IRQ 31 (UIC1 CI cascade) to =
keep
it from getting disabled.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- Has anyone ever considered a patch that replaces =
the
normal HW exception handling with an immediate panic?&nbsp; For an =
embedded
system continuing to run after one or more user space processes has been
terminated does not seem to be an optimal =
behavior.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- Are patches being accepted for 2.4, or is =
everything 2.6
now?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What I am up to:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Situation:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The board I am working on is subject to random =
re-boots due
to Watchdog timeouts.&nbsp; Some of these are due to driver bugs (500mS =
udelay&#8217;s,
waiting forever for stuff that never happens etc), and others are due to =
PCI
devices that insist on claiming split transactions and then waiting =
several
seconds before responding.&nbsp; These situations are of course very =
rare and
almost impossible to duplicate so a JTAG debugger is out of the =
question.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Proposed solution:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Install an interrupt hander that captures the =
register dump
and stack trace whenever a watchdog or PCI error occurs.&nbsp; Since =
there is
no choice for the watchdog and the PCI errors could happen during =
interrupt top
halves or with interrupts disabled both situations pretty much require =
the use
of Critical Exceptions.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The PCI error capture is not completely redundant =
because
some of my boards have a bridge that can be configured to time out and =
abort
the offending transactions.&nbsp; Doing this without the handler however =
just
makes my problems harder to debug by allowing the driver to continue for =
who
knows how long before crashing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>For now I just capture the trace and then panic the =
kernel
(cheap and easy HA solution) to &#8220;recover&#8221;.&nbsp; Longer term =
I may
try to develop a mechanism to allow drivers to register for some sort of
notification and recover more gracefully.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>David<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4A195.4EE53FE4--
