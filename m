Return-Path: <mmeswani@utep.edu>
Received: from itdsrvmail02.utep.edu (itdsrvmail02.utep.edu [129.108.0.88])
	by ozlabs.org (Postfix) with ESMTP id B139367A05
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 09:17:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C673BE.BBC444DC"
Subject: RE: Information for setting up SMT related parameters on linux 2.6.16
	on POWER5
Date: Tue, 9 May 2006 17:17:25 -0600
Message-ID: <C26C730943E01145B4F89E37FE0A022002BBC74D@itdsrvmail02.utep.edu>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
	<445BE729.80903@am.sony.com>
	<C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
	<1147118619.8664.44.camel@localhost.localdomain>
	<18583972-9E29-4B52-BF2E-53102F1794EB@kernel.crashing.org>
From: "Meswani, Mitesh" <mmeswani@utep.edu>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	<will_schmidt@vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann%ibmde.RSCS@BLDVMB.POK.IBM.COM>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C673BE.BBC444DC
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks guys=20
=20
That answered so many of my questions.=20
=20
If I were to use these macros from user space, would they remain set =
until next reboot or change ? POWER5 allows priorities 2 through 4 for =
user apps, so considering this, and the fact that the normal prioirity =
is level 4, if a user app resets it to say 2 and then finishes without =
changing it back to 4 , would all the subsequent user apps run at the =
new level 2. I wonder what I am saying even makes sense, because the =
kernel internally throttles the priority for various sections of the =
kernel code and it may even overwrite it.=20
=20
=20
On a slightly unrelated note, I appended some boot parameters like =
smt-enabled=3Don/off to /etc/lilo.conf and unfortunately I am not able =
to see any effect and it boots the same way. I am switching from the AIX =
world so I maybe doing something dumb, please point out if I am !  This =
kind of seems to effect the bind processor calls using sys_setaffinity =
when there are 4 logical processors 0-3 on two physical processors, bind =
only allows me to set affinity to either cpu 0 or 2, this seems weird to =
me because my system is booting with two logical cpus and then I set =
online bit to 1 to turn the remaining on, thereafter I try binding and =
havent been very successful.=20
=20
=20
Thanks for all your replies.=20
=20
=20
=20

Mitesh R. Meswani=20
Ph.D. Candidate=20
Research Associate, PLS2 Group
Room 106 F, Department of Computer Science
The University of Texas at El Paso,=20
El Paso, Texas 79968
Tel: 915 747 8012 (O)
Email: mmeswani@utep.edu

________________________________

From: Segher Boessenkool [mailto:segher@kernel.crashing.org]
Sent: Mon 5/8/2006 5:04 PM
To: will_schmidt@vnet.ibm.com
Cc: Meswani, Mitesh; linuxppc-dev@ozlabs.org; Arnd Bergmann; =
linux-kernel@vger.kernel.org; cbe-oss-dev@ozlabs.org
Subject: Re: Information for setting up SMT related parameters on linux =
2.6.16 on POWER5



> the HMT_* macros are telling firmware that "this processor thread=20
> should
> run at this priority".  Typically used when we're waiting on a=20
> spinlock.
> I.e. When we are waiting on a spinlock, we hit the HMT_low macro to=20
> drop
> our threads priority, allowing the other thread to use those extra
> cycles finish it's stuff quicker, and maybe even release the lock=20
> we're
> waiting for.          HMT_* is all within the kernel though, no=20
> exposure
> to userspace apps.

Actually, those macros translate straight into a single machine insn.
No firmware is involved.  See include/asm-powerpc/processor.h.  For
example:

#define HMT_very_low()   asm volatile("or 31,31,31   # very low=20
priority")

You can use those same macros from user space, although it is CPU
implementation dependent which priorities you can actually set (you
probably can do low and medium priority).


Segher




------_=_NextPart_001_01C673BE.BBC444DC
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">=0A=
<TITLE>Re: Information for setting up SMT related parameters on linux =
2.6.16 on POWER5</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText63025 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Thanks guys =
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>That answered so many of my =
questions. =0A=
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>If I were to use these macros =
from user =0A=
space, would they remain set until next reboot or change ? POWER5 allows =0A=
priorities 2 through 4 for user apps, so considering this, and the fact =
that the =0A=
normal prioirity is level 4, if a user app resets it to say 2 and then =
finishes =0A=
without changing it back to 4 , would all the subsequent user apps run =
at the =0A=
new level 2. I wonder what I am saying even makes sense, because the =
kernel =0A=
internally throttles the priority for various sections of the kernel =
code and it =0A=
may even overwrite it. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>On a slightly unrelated note, =
I appended =0A=
some boot parameters like smt-enabled=3Don/off to /etc/lilo.conf and =
unfortunately =0A=
I am not able to see any effect and it boots the same way. I am =
switching from =0A=
the AIX world so I maybe doing something dumb, please point out if I am =
!&nbsp; =0A=
This kind of seems to effect the bind processor calls using =
sys_setaffinity when =0A=
there are 4 logical processors 0-3 on two physical processors, bind only =
allows =0A=
me to set affinity to either cpu 0 or 2, this seems weird to me because =
my =0A=
system is booting with two logical cpus and then I set online bit to 1 =
to turn =0A=
the remaining on, thereafter&nbsp;I try binding and havent been very =
successful. =0A=
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks for all your replies. =
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV></DIV>=0A=
<DIV id=3DidSignature38110 dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><BR>Mitesh R.&nbsp;Meswani <BR>Ph.D. Candidate </DIV>=0A=
<DIV>Research Associate, PLS2 Group</DIV>=0A=
<DIV>Room 106 F, Department of Computer Science</DIV>=0A=
<DIV>The University of Texas at El Paso, </DIV>=0A=
<DIV>El Paso, Texas 79968<BR>Tel: 915 747 8012 (O)</DIV>=0A=
<DIV>Email: mmeswani@utep.edu</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Segher Boessenkool =0A=
[mailto:segher@kernel.crashing.org]<BR><B>Sent:</B> Mon 5/8/2006 5:04 =0A=
PM<BR><B>To:</B> will_schmidt@vnet.ibm.com<BR><B>Cc:</B> Meswani, =
Mitesh; =0A=
linuxppc-dev@ozlabs.org; Arnd Bergmann; linux-kernel@vger.kernel.org; =0A=
cbe-oss-dev@ozlabs.org<BR><B>Subject:</B> Re: Information for setting up =
SMT =0A=
related parameters on linux 2.6.16 on POWER5<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>&gt; the HMT_* macros are telling firmware that "this =
processor =0A=
thread&nbsp;<BR>&gt; should<BR>&gt; run at this priority".&nbsp; =
Typically used =0A=
when we're waiting on a&nbsp;<BR>&gt; spinlock.<BR>&gt; I.e. When we are =
waiting =0A=
on a spinlock, we hit the HMT_low macro to&nbsp;<BR>&gt; drop<BR>&gt; =
our =0A=
threads priority, allowing the other thread to use those extra<BR>&gt; =
cycles =0A=
finish it's stuff quicker, and maybe even release the lock&nbsp;<BR>&gt; =0A=
we're<BR>&gt; waiting =
for.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
HMT_* is all within the kernel though, no&nbsp;<BR>&gt; exposure<BR>&gt; =
to =0A=
userspace apps.<BR><BR>Actually, those macros translate straight into a =
single =0A=
machine insn.<BR>No firmware is involved.&nbsp; See =0A=
include/asm-powerpc/processor.h.&nbsp; For<BR>example:<BR><BR>#define =0A=
HMT_very_low()&nbsp;&nbsp; asm volatile("or 31,31,31&nbsp;&nbsp; # very =0A=
low&nbsp;<BR>priority")<BR><BR>You can use those same macros from user =
space, =0A=
although it is CPU<BR>implementation dependent which priorities you can =
actually =0A=
set (you<BR>probably can do low and medium =0A=
priority).<BR><BR><BR>Segher<BR><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C673BE.BBC444DC--
