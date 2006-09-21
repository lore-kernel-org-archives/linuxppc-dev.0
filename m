Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4691867B78
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 16:27:22 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8L7l3h4000471
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 01:47:03 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8L6RHPU008793
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 01:27:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD46.FBAA8F2E"
Subject: RE: Hang with isync
Date: Thu, 21 Sep 2006 14:27:14 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C018@zch01exm21.fsl.freescale.net>
In-Reply-To: <d6dada100609202317s8037f73o624015ac37402c2d@mail.gmail.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Manoj Sharma" <manoj.shar@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DD46.FBAA8F2E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

First, you must make sure if it really happen at watchdog timer
exception.
if it is, you need select one suitable way to fix it.
Second, I don't believe the sync-isync instructions make it happen.
you can try the 2.6, I don't know if 2.6 kernel can resolve your
problem.
=20
-Dave



________________________________

	Dave, watchdog timeout is around one second and no cpu activity
for that long is something wrong. Is it ok to disable it to hide the
problem lying somewhere else? Do you think it can be because of
sync-isync instructions and moving to 2.6 might resolve it?

	=20
	On 9/20/06, Liu Dave-r63238 <DaveLiu@freescale.com> wrote:=20

	=09

		No MSR is 00029030 and user mode bit is not set here.
	=09
		I had missed it in the prev mail:
	=09
		=05NIP: C0005DA4 XER: 20000000 LR: C0004FE4 SP: C01F3000=05
REGS: c01eff30 TRAP: 1020    Not tainted=20
		MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=20
		TASK =3D c01f1080[0] 'swapper' Last syscall: 120
		last math 00000000 last altivec 00000000
		=05PLB0: bear=3D 0x08000000 acr=3D   0xbb000000 besr=3D
0x00000000
		=20
		Dave>I notice that MSR and TRAP, MSR is 00029030- the
critical interrupt enable.
		Dave>TRAP is 1020. --WatchDog timer exception is
happening
		Dave>You can disable the MSR[CE] bit to no critical
exception or disable the WD timer
	=09

		=20

			On 9/20/06, Linas Vepstas <linas@austin.ibm.com
> wrote:=20

				On Thu, Sep 21, 2006 at 08:38:13AM
+1000, Benjamin Herrenschmidt wrote:
				> On Wed, 2006-09-20 at 15:31 -0700,
Manoj Sharma wrote:=20
				> > This is the stack trace.
				> >
				> > Registers:
				> > GPR00: 00069030=20
			=09
				This is the MSR and it has the user-mode
bit set, which is surely wrong.
				This is not how one gets to user space.=20
			=09
				00048000
			=09
				The MSR had this or'ed into it, which is
setting the user-mode bit.
				Surely that's wrong.=20
			=09
				--linas
			=09




------_=_NextPart_001_01C6DD46.FBAA8F2E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006>First, you&nbsp;must make sure if it really =
happen=20
at&nbsp;watchdog timer exception.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006>if it is, you need select one =
suitable&nbsp;way to fix=20
it.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006>Second, I don't believe the sync-isync =
instructions=20
make it happen.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006>you can try the 2.6, I&nbsp;don't know if 2.6 =
kernel=20
can&nbsp;resolve your problem.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2><SPAN=20
class=3D878551906-21092006>-Dave</SPAN></FONT></DIV><FONT =
face=3D&#23435;&#20307; color=3D#0000ff=20
size=3D2></FONT><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  </DIV>
  <DIV></DIV>
  <DIV>Dave, watchdog timeout is around&nbsp;one second and no cpu =
activity for=20
  that long is something wrong. Is it ok to disable it to hide the =
problem lying=20
  somewhere else? Do you think it can&nbsp;be because of sync-isync=20
  instructions&nbsp;and moving to 2.6 might resolve it?</DIV>
  <DIV><BR>&nbsp;</DIV>
  <DIV><SPAN class=3Dgmail_quote>On 9/20/06, <B =
class=3Dgmail_sendername>Liu=20
  Dave-r63238</B> &lt;<A=20
  href=3D"mailto:DaveLiu@freescale.com">DaveLiu@freescale.com</A>&gt;=20
  wrote:</SPAN>=20
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">
    <DIV><SPAN class=3Dq><FONT face=3D&#23435;&#20307; color=3D#0000ff =
size=3D2></FONT><FONT face=3D&#23435;&#20307;=20
    color=3D#0000ff size=3D2></FONT>
    <DIV dir=3Dltr align=3Dleft><BR>No MSR is 00029030 and user mode bit =
is not set=20
    here.<BR><BR>I had missed it in the prev mail:<BR><BR>=05NIP: =
C0005DA4 XER:=20
    20000000 LR: C0004FE4 SP: C01F3000=05 REGS: c01eff30 TRAP:=20
    1020&nbsp;&nbsp;&nbsp; Not tainted <BR>MSR: 00029030 EE: 1 PR: 0 FP: =
0 ME: 1=20
    IR/DR: 11 <BR>TASK =3D c01f1080[0] 'swapper' Last syscall: =
120<BR>last math=20
    00000000 last altivec 00000000<BR>=05PLB0: bear=3D 0x08000000 =
acr=3D&nbsp;&nbsp;=20
    0xbb000000 besr=3D&nbsp; 0x00000000<BR><SPAN><FONT =
face=3D&#23435;&#20307; color=3D#0000ff=20
    size=3D2>&nbsp;</FONT></SPAN></DIV></SPAN>
    <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>Dave&gt;I=20
    notice that&nbsp;MSR and TRAP, MSR is =
00029030-&nbsp;the&nbsp;critical=20
    interrupt enable.</FONT></SPAN></DIV>
    <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3D&#23435;&#20307; =
color=3D#0000ff=20
    size=3D2>Dave&gt;TRAP is 1020. --WatchDog timer&nbsp;exception is=20
    happening</FONT></SPAN></DIV>
    <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>Dave&gt;You=20
    can disable the MSR[CE] bit to no critical exception or disable the =
WD=20
    timer</FONT></SPAN></DIV><SPAN class=3Dq>
    <DIV dir=3Dltr align=3Dleft><BR>&nbsp;</DIV>
    <BLOCKQUOTE=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff =
2px solid; MARGIN-RIGHT: 0px">
      <DIV><SPAN class=3Dgmail_quote>On 9/20/06, <B =
class=3Dgmail_sendername>Linas=20
      Vepstas</B> &lt;<A onclick=3D"return =
top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:linas@austin.ibm.com" =
target=3D_blank>linas@austin.ibm.com=20
      </A>&gt; wrote:</SPAN>=20
      <BLOCKQUOTE class=3Dgmail_quote=20
      style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; =
BORDER-LEFT: rgb(204,204,204) 1px solid">On=20
        Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt=20
        wrote:<BR>&gt; On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma =
wrote:=20
        <BR>&gt; &gt; This is the stack trace.<BR>&gt; &gt;<BR>&gt; &gt; =

        Registers:<BR>&gt; &gt; GPR00: 00069030 <BR><BR>This is the MSR =
and it=20
        has the user-mode bit set, which is surely wrong.<BR>This is not =
how one=20
        gets to user space. <BR><BR>00048000<BR><BR>The MSR had this =
or'ed into=20
        it, which is setting the user-mode bit.<BR>Surely that's wrong.=20
        =
<BR><BR>--linas<BR></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></SPAN></DIV></BLO=
CKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6DD46.FBAA8F2E--
