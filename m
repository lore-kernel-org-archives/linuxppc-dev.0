Return-Path: <Bernie.Elayda@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C843EE.60072E90"
Subject: RE: [techfield] GPIO causing bus error
Date: Fri, 21 Dec 2007 08:27:26 -0800
Message-ID: <F25AAC0BD4AFCB4EBBA2F22FC65C07C8F76593@ala-mail02.corp.ad.wrs.com>
In-Reply-To: <AF1602CB2550CE4381C0C75118A7856B020C60D7@ala-mail02.corp.ad.wrs.com>
References: <AF1602CB2550CE4381C0C75118A7856B020C60D7@ala-mail02.corp.ad.wrs.com>
From: "Elayda, Bernardo (Bernie)" <Bernie.Elayda@windriver.com>
To: "+techfield" <techfield@windriver.com>,
	"Wyse, Chris" <chris.wyse@windriver.com>, <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>,
	"+linux-embedded" <linux-embedded@mail.wrs.com>,
	"+linux-eng" <linux-eng@mail.wrs.com>,
	"linux-kernel" <linux-kernel-pf@windriver.com>,
	"Wessel, Jason" <jason.wessel@windriver.com>, <support@amcc.com>
Cc: "Slimm, Rob" <robert.slimm@windriver.com>, "Read,
	Tricia" <tricia.read@windriver.com>, "Ayer,
	Charles" <Charlie.Ayer@windriver.com>, "Touron,
	Emmanuel" <emmanuel.touron@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C843EE.60072E90
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Chris,
=20
I'm going to look at this problem from the FPGA hardware level because I
used to work for one of the FPGA companies.
=20
I'm not familiar with your PPC440GX board, so some of my suggestions may
be difficult to implement or totally unreasonable, especially if it
requires soldering to an FPGA in a ball grid array or extermely fine
pitch pins.
=20
(1) You should capture the configuration sequence on FPGA's JTAG pins
using a logic analyzer in functional mode.
=20
In functional mode, you can capture an extermely long sequence of
configuration events.  Also, in the past, I've used this mode and found
that when the FPGA doesn't configure, usually there are too few or too
many clocks on the TCK line.
=20
(2) Sometimes, rarely, the FPGA design itself can cause a boot up
problem.
=20
Instead of using the real design, send a 'blank' design with no logic
implemented at all.  If this works, then it's the FPGA design itself
that is causing the boot problem.
=20
(3) When the boot process happens, what is the power sequence of the
FPGA?
=20
Most FPGA's out there like a nice smooth power profile that ramps up
quickly.  Check and see if the profile is quick and smooth vs. spikey
and erratic.  Also, sometimes configuration data gets sent before the
FPGA is ready to receive data.  Try delaying the sending of
configuration data by a millisecond or so.
=20
(4) Manually delay the configuration of the FPGA.
=20
In other words, let the system boot, but modify the code to allow the
FPGA to configure only after a button is pushed.  In theory, if the FPGA
power has properply initialized the FPGA, you could keep the system this
way forever until a 'button' is pushed to configure the FPGA.  if this
works, this tends to imply that there is a timing issue.  If it doesn't
work, it's possible that the FPGA's JTAG tap is actually in a state that
won't allow configuration to complete, such as non shift-dr or non
shift-ir state.
=20
(5) If your FPGA is using one of the SVF-based software configuration
methods via JTAG, make sure you are using the latest SVF player and
latest software for generating the FPGA bitstream.  The configuration
method may have changed.  The FPGA silicon you are using may be newer
than the configuration algorithm that has been implemented.
=20
I hope this helps!
=20
Regards,
Bernie Elayda
the ex-X guy

________________________________

From: owner-techfield@windriver.com
[mailto:owner-techfield@windriver.com] On Behalf Of Wyse, Chris
Sent: Friday, December 21, 2007 7:55 AM
To: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org; +techfield;
+linux-embedded; +linux-eng; linux-kernel; Wessel, Jason;
support@amcc.com
Cc: Touron, Emmanuel; Read, Tricia; Ayer, Charles; Slimm, Rob
Subject: [techfield] GPIO causing bus error


Hi,
=20
I'm having trouble with an unusual problem.  I'm working on relatively
new hardware, so it's possible that there could be a hardware issue
involved.=20
=20
I have an FPGA on my PPC440GX board that gets loaded via JTAG during the
kernel boot process (Linux 2.6.10).  It uses the 440GX GPIO lines to
send the necessary JTAG commands to the FPGA to perform the initial
load.  This process is USUALLY functional, but on some of the boards
(which we produce), the GPIO write fails with a bus error.  On the
boards that fail, it only occurs after a cold boot, and only if the
board has been powered off for a few minutes.  A quick hard reboot will
not generate the problem.  When I issue the failing write to the GPIO
lines, some of the SDRAM gets corrupted.  I don't appear to be taking
any interrupts that might have corrupted the RAM.
=20
I've checked the TLB entries, and it maps correctly to the PPC register
area.  Additionally, I can read and write to other registers using the
same TLB mapping WITHOUT any error.  I can also READ the GPIO lines
without an error - the error is only on the write.   I've checked the
SDR0_PFC0 bits to make sure everything is set properly (it is).  The bus
error indicates "PLB Timeout Error Status Master 2, Master 2 slave error
occurred" (Master 2 is the write-only data cache unit (DCU)) and "Write
Error Interrupt Master 2, Write error detected - master 2 interrupt
request is active".  I'm not sure why there would be any error in the
DCU, since the region I'm writing to is cache inhibited and guarded.
=20
If I issue a soft reset of the GPIO subsystem, I can read and write to
the GPIO lines again.
=20
The error does not occur on the first write to the GPIO.  I go through
the failing routine several times before it fails.  However, when it
fails, it consistently fails at the same spot, after the same number of
passes through the code.
=20
I'm using RGMII ethernet on EMAC2 (Group 4), but the GPIO lines that I'm
using are not the Trace/GPIO lines (26-31) so I believe that they should
work fine (and they usually do).  Also, the errata mentions that
SDR0_PFC0[G11E] has no effect - but I'm not using GPIO 11 anyway.
=20
Here are some relevant register values after the error:
=20
SDR0_PFC0 :     0x083FFE00
POB0_BESR0:     0x00008400
POB0_BEARH:     0x00000001
POB0_BEARL:     0x40000701
GPIO0_OR  :     0x000400C0
GPIO0_TCR :     0x00278AE0
GPIO0_ODR :     0x00000000
GPIO0_IR  :     0x00000000
=20
I've attached two log files, that contain most of the 440 registers, one
for before the error and one after.  In the log files, the bus error has
been cleared, so use the values shown above.
=20
I'm looking for some suggestions on what to try to debug/resolve this
issue.  I'm open to both hardware and software based suggestions.  Any
help would be greatly appreciated.
=20
=20
Chris Wyse
Senior Member of Technical Staff
Embedded Technologies
860-978-0849 cell/office
413-778-9101 fax
http://www.windriver.com <http://www.windriver.com/>=20
=20
=20

------_=_NextPart_001_01C843EE.60072E90
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hi Chris,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I'm going to look at this problem from the FPGA =
hardware=20
level because I used to work for one of the FPGA =
companies.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I'm not familiar with&nbsp;your PPC440GX board, =
so some of=20
my suggestions may be difficult to implement or totally unreasonable, =
especially=20
if it requires soldering to an FPGA in a ball grid array or extermely =
fine pitch=20
pins.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>(1) You should capture the configuration =
sequence on FPGA's=20
JTAG pins using a logic analyzer in functional mode.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>In functional mode, you can capture an =
extermely long=20
sequence of configuration events.&nbsp; Also, in the past, I've used =
this mode=20
and found that when the FPGA doesn't configure, usually there are too =
few or too=20
many clocks on the TCK line.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>(2) Sometimes, rarely, the FPGA design itself =
can cause a=20
boot up problem.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Instead of using the real design, send a =
'blank' design=20
with no logic implemented at all.&nbsp; If this works, then it's the =
FPGA design=20
itself that is causing the boot problem.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>(3) When the boot process happens, what is the =
power=20
sequence of the FPGA?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Most FPGA's out there like a nice smooth power =
profile that=20
ramps up quickly.&nbsp; Check and see if the profile is quick and smooth =
vs.=20
spikey and erratic.&nbsp; Also, sometimes configuration data gets sent =
before=20
the FPGA is ready to receive data.&nbsp; Try delaying the sending of=20
configuration data by a millisecond or so.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>(4) Manually delay the configuration of the=20
FPGA.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>In other words, let the system boot, but modify =
the code to=20
allow the FPGA to configure only after a button is pushed.&nbsp; In =
theory, if=20
the FPGA power has properply initialized the FPGA, you could keep the =
system=20
this way forever until a 'button' is pushed to configure the FPGA.&nbsp; =
if this=20
works, this tends to imply that there is a timing issue.&nbsp; If it =
doesn't=20
work, it's possible that the FPGA's JTAG tap is actually in a state that =
won't=20
allow configuration to complete, such as non shift-dr or non shift-ir=20
state.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>(5) If your FPGA is using one of the SVF-based =
software=20
configuration methods via JTAG, make sure you are using the latest SVF =
player=20
and latest software for generating the FPGA bitstream.&nbsp; The =
configuration=20
method may have changed.&nbsp; The FPGA silicon you are using may be =
newer than=20
the configuration algorithm that has been =
implemented.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I hope this helps!</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Regards,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Bernie Elayda</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D060240916-21122007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>the ex-X guy</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> owner-techfield@windriver.com=20
[mailto:owner-techfield@windriver.com] <B>On Behalf Of </B>Wyse,=20
Chris<BR><B>Sent:</B> Friday, December 21, 2007 7:55 AM<BR><B>To:</B>=20
linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org; +techfield;=20
+linux-embedded; +linux-eng; linux-kernel; Wessel, Jason;=20
support@amcc.com<BR><B>Cc:</B> Touron, Emmanuel; Read, Tricia; Ayer, =
Charles;=20
Slimm, Rob<BR><B>Subject:</B> [techfield] GPIO causing bus=20
error<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial =
size=3D2>I'm&nbsp;having=20
trouble with an unusual problem.&nbsp; I'm working on relatively new =
hardware,=20
so&nbsp;it's possible that there could be a hardware issue=20
involved.&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>I have =
an FPGA on my=20
PPC440GX board that gets loaded via JTAG during the kernel boot process =
(Linux=20
2.6.10).&nbsp; It uses the 440GX GPIO lines to send the necessary JTAG =
commands=20
to the FPGA to perform the initial load.&nbsp; This process is USUALLY=20
functional, but on some of the boards (which we produce), the GPIO write =
fails=20
with a bus error.&nbsp; On the boards that fail, it only occurs after a =
cold=20
boot, and only if the board has been powered off&nbsp;for a few =
minutes.&nbsp; A=20
quick hard reboot will not generate the problem.&nbsp; When I issue the=20
failing&nbsp;write to the GPIO lines, some of the SDRAM gets =
corrupted.&nbsp; I=20
don't appear to be taking any interrupts&nbsp;that might have corrupted =
the=20
RAM.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>I've =
checked the TLB=20
entries, and it maps correctly to the PPC register area.&nbsp; =
Additionally, I=20
can read and write to other registers using the same TLB mapping WITHOUT =
any=20
error.&nbsp; I can also READ the GPIO lines without an error - the error =
is only=20
on the write.&nbsp;&nbsp; I've checked the SDR0_PFC0 bits to make sure=20
everything is set properly (it is).&nbsp; The bus error indicates "PLB =
Timeout=20
Error Status Master 2, Master 2 slave error occurred" (Master 2 is the=20
write-only data cache unit (DCU)) and "Write Error Interrupt Master 2, =
Write=20
error detected - master 2 interrupt request is active".&nbsp; I'm not =
sure why=20
there would be any error in the DCU, since the region I'm writing to is =
cache=20
inhibited and guarded.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>If I =
issue a soft=20
reset of the GPIO subsystem, I can read and write to the GPIO lines=20
again.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>The =
error does not=20
occur on the first write to the GPIO.&nbsp; I go through the failing =
routine=20
several times before it fails.&nbsp; However, when it fails, it =
consistently=20
fails at the same spot, after the same number of passes through the=20
code.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>I'm =
using RGMII=20
ethernet on EMAC2 (Group 4), but the GPIO lines that I'm using are not =
the=20
Trace/GPIO lines (26-31) so I believe that they should work fine (and =
they=20
usually do).&nbsp; Also, the errata mentions that SDR0_PFC0[G11E] has no =
effect=20
- but I'm not using GPIO 11 anyway.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>Here =
are some=20
relevant register values after the error:</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New" =
size=3D2>SDR0_PFC0=20
:&nbsp;&nbsp;&nbsp;&nbsp; 0x083FFE00</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New"=20
size=3D2>POB0_BESR0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00008400</FONT></SPAN=
></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New"=20
size=3D2>POB0_BEARH:&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000001</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New"=20
size=3D2>POB0_BEARL:&nbsp;&nbsp;&nbsp;&nbsp; =
0x40000701</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New"=20
size=3D2>GPIO0_OR&nbsp;=20
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x000400C0</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New" =
size=3D2>GPIO0_TCR=20
:&nbsp;&nbsp;&nbsp;&nbsp; 0x00278AE0</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New" =
size=3D2>GPIO0_ODR=20
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00000000</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3D"Courier New"=20
size=3D2>GPIO0_IR&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>I've =
attached two=20
log files, that contain most of the 440 registers, one for before the =
error and=20
one after.&nbsp; In the log files, the bus error has been cleared, so =
use the=20
values shown above.</FONT></SPAN></DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D201052213-21122007><FONT face=3DArial size=3D2>I'm =
looking for some=20
suggestions on what to try to debug/resolve this issue.&nbsp; I'm open =
to both=20
hardware and software based suggestions.&nbsp; Any help would be greatly =

appreciated.</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT size=3D2>Chris Wyse</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>Senior Member of Technical =
Staff</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>Embedded Technologies</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>860-978-0849 cell/office</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2>413-778-9101 fax</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2><A=20
href=3D"http://www.windriver.com/">http://www.windriver.com</A></FONT></D=
IV>
<DIV align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C843EE.60072E90--
