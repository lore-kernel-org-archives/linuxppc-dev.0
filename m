Return-Path: <mmeswani@utep.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67BA3.DAFC95B0"
Subject: RE: Information for setting up SMT related parameters on linux 2.6.16
	on POWER5
Date: Fri, 19 May 2006 18:25:11 -0600
Message-ID: <C26C730943E01145B4F89E37FE0A022002BBC76F@itdsrvmail02.utep.edu>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
	<445BE729.80903@am.sony.com>
	<C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
	<1147118619.8664.44.camel@localhost.localdomain>
	<18583972-9E29-4B52-BF2E-53102F1794EB@kernel.crashing.org>
From: "Meswani, Mitesh" <mmeswani@utep.edu>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	<will_schmidt@vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann%ibmde.RSCS@BLDVMB.POK.IBM.COM>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C67BA3.DAFC95B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Segher and Will=20
=20
I tried using these macros on some applications and they dont seem to =
have any effect. I am running everything as root, and have been using =
bind processor commands to ensure that a task is assigned to a logical =
cpu. Since I am running SPEC CPU benchmarks I was exepecting to see a =
difference in run times, CPI when running two seperate SPEC apps on SMT =
threads.=20
=20
Is there some thing else I need to do to make sure that the processor =
takes the hint to "lower the HMT priority " , I am executing them from a =
regular shell which I assume has user level priority.=20
=20
=20
Thanks
Mitesh=20
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




------_=_NextPart_001_01C67BA3.DAFC95B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: Information for setting up SMT related =
parameters on linux 2.6.16 on POWER5</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.5296.0" name=3DGENERATOR><BASE href=3DHEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText9297 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello Segher =
and Will </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I tried using these macros on =
some applications and they dont seem to have any effect. I am running =
everything as root, and have been using bind processor commands to =
ensure that a task is assigned to a logical cpu. Since I am running SPEC =
CPU benchmarks I was exepecting to see a difference in run times, CPI =
when running two seperate SPEC apps on SMT threads. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Is there some thing else I =
need to do to make sure that the processor takes the hint to "lower the =
HMT priority " , I am executing them from a regular shell which I assume =
has user level priority. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Mitesh </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV></DIV>=0A=
<DIV id=3DidSignature53388 dir=3Dltr><FONT face=3DArial color=3D#000000 =
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
<FONT face=3DTahoma size=3D2><B>From:</B> Segher Boessenkool =
[mailto:segher@kernel.crashing.org]<BR><B>Sent:</B> Mon 5/8/2006 5:04 =
PM<BR><B>To:</B> will_schmidt@vnet.ibm.com<BR><B>Cc:</B> Meswani, =
Mitesh; linuxppc-dev@ozlabs.org; Arnd Bergmann; =
linux-kernel@vger.kernel.org; cbe-oss-dev@ozlabs.org<BR><B>Subject:</B> =
Re: Information for setting up SMT related parameters on linux 2.6.16 on =
POWER5<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>&gt; the HMT_* macros are telling firmware that "this =
processor thread&nbsp;<BR>&gt; should<BR>&gt; run at this =
priority".&nbsp; Typically used when we're waiting on a&nbsp;<BR>&gt; =
spinlock.<BR>&gt; I.e. When we are waiting on a spinlock, we hit the =
HMT_low macro to&nbsp;<BR>&gt; drop<BR>&gt; our threads priority, =
allowing the other thread to use those extra<BR>&gt; cycles finish it's =
stuff quicker, and maybe even release the lock&nbsp;<BR>&gt; =
we're<BR>&gt; waiting =
for.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HMT_* is all =
within the kernel though, no&nbsp;<BR>&gt; exposure<BR>&gt; to userspace =
apps.<BR><BR>Actually, those macros translate straight into a single =
machine insn.<BR>No firmware is involved.&nbsp; See =
include/asm-powerpc/processor.h.&nbsp; For<BR>example:<BR><BR>#define =
HMT_very_low()&nbsp;&nbsp; asm volatile("or 31,31,31&nbsp;&nbsp; # very =
low&nbsp;<BR>priority")<BR><BR>You can use those same macros from user =
space, although it is CPU<BR>implementation dependent which priorities =
you can actually set (you<BR>probably can do low and medium =
priority).<BR><BR><BR>Segher<BR><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C67BA3.DAFC95B0--
