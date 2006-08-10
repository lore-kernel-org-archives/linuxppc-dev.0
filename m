Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 9CAA867B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 03:14:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BCA0.7E3EFC59"
Subject: Debugging with no serial port
Date: Thu, 10 Aug 2006 10:14:53 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105FD10D3@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6BCA0.7E3EFC59
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This may be more of a question for GDB folks...but I'll post it here
because it relates to embedded systems as well.
=20
I'm trying to validate some signal processing software on an embedded
Virtex4 PowerPC 405.  Basically, the validation consists of calling
functions and looking at their outputs.  Over time, there are several
thousand numbers to look at, so manually looking at each number at a
break point would be very time consuming (to put it mildly).
=20
The normal way I would go about doing this is to print out the data
(e.g. to a serial port) and post-process the data somewhere else.  But
on this particular target, I don't have a serial port.  So I thought
about using GDB's breakpoint command list feature.  When the software
has data it wants to print out, it calls a function "log_stuff".  I then
set a breakpoint and command list in the "log_stuff" function, which
writes out the variables I'm interested in checking out to a file named
outputfile.bin.  E.g. the following command file does this:
=20
break log_stuff
commands
   silent
   if (variable_logging_enabled)
      append value outputfile.bin stuff1_variable
      append value outputfile.bin stuff2_variable
   end
   cont
end
=20
The problem I have with this approach is that GDB doesn't finish writing
out everything before it continues executing the program, so a backlog
develops.  So my first question would be, is there some GDB "flush" like
command I could run before the cont statement?
=20
Second question would be - is there an easier way to accomplish what I'm
trying to do, which is basically emulate a serial port with GDB.
=20
Tim
=20

------_=_NextPart_001_01C6BCA0.7E3EFC59
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>This may be more of a question for GDB =
folks...but I'll=20
post it here because it relates to embedded systems as =
well.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I'm trying to validate some signal processing =
software on=20
an embedded Virtex4 PowerPC 405.&nbsp; Basically, the validation =
consists of=20
calling functions and looking at their outputs.&nbsp; Over time, there =
are=20
several thousand numbers to look at, so manually looking at each number =
at a=20
break point would be very time consuming (to put it =
mildly).</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The normal way I would go about doing this is =
to print out=20
the data (e.g. to a serial port) and post-process the data somewhere =
else.&nbsp;=20
But on this particular target, I don't have a serial port.&nbsp; So I =
thought=20
about using GDB's breakpoint command list feature.&nbsp; When the =
software has=20
data it wants to print out, it calls a function "log_stuff".&nbsp; I =
then set a=20
breakpoint and command list in the "log_stuff" function, which writes =
out the=20
variables I'm interested in checking out to a file named =
outputfile.bin.&nbsp;=20
E.g. the&nbsp;following command file does this:</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
size=3D2>break=20
log_stuff<BR>commands<BR>&nbsp;&nbsp; silent<BR>&nbsp;&nbsp; if=20
(variable_logging_enabled)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append =
value=20
outputfile.bin stuff1_variable</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append value outputfile.bin=20
stuff2_variable<BR>&nbsp;&nbsp; end<BR>&nbsp;&nbsp;=20
cont<BR>end</DIV></FONT></SPAN>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D947103416-10082006></SPAN><SPAN=20
class=3D947103416-10082006><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The problem I have with this approach is that =
GDB doesn't=20
finish writing out everything before it continues executing the program, =
so a=20
backlog develops.&nbsp; So my first question would be, is there some GDB =
"flush"=20
like command I could run before the cont statement?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Second question would be - is there an easier =
way to=20
accomplish what I'm trying to do, which is basically emulate a serial =
port with=20
GDB.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Tim</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D947103416-10082006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6BCA0.7E3EFC59--
