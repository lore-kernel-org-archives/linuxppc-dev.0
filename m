Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5A56B67B73
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 14:24:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8L4OqGq022559
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 21:24:52 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8L4OnvC029073
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 23:24:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD35.E021DF98"
Subject: RE: Hang with isync
Date: Thu, 21 Sep 2006 12:24:48 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516BFD7@zch01exm21.fsl.freescale.net>
In-Reply-To: <d6dada100609201759r5dd047d7y2b60684d9c4feaa8@mail.gmail.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Manoj Sharma" <manoj.shar@gmail.com>,
	"Linas Vepstas" <linas@austin.ibm.com>
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

------_=_NextPart_001_01C6DD35.E021DF98
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


No MSR is 00029030 and user mode bit is not set here.

I had missed it in the prev mail:

=05NIP: C0005DA4 XER: 20000000 LR: C0004FE4 SP: C01F3000=05 REGS: =
c01eff30
TRAP: 1020    Not tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=20
TASK =3D c01f1080[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
=05PLB0: bear=3D 0x08000000 acr=3D   0xbb000000 besr=3D  0x00000000
=20
Dave>I notice that MSR and TRAP, MSR is 00029030- the critical interrupt
enable.
Dave>TRAP is 1020. --WatchDog timer exception is happening
Dave>You can disable the MSR[CE] bit to no critical exception or disable
the WD timer

=20

	On 9/20/06, Linas Vepstas <linas@austin.ibm.com> wrote:=20

		On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin
Herrenschmidt wrote:
		> On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:
		> > This is the stack trace.
		> >
		> > Registers:
		> > GPR00: 00069030=20
	=09
		This is the MSR and it has the user-mode bit set, which
is surely wrong.
		This is not how one gets to user space.
	=09
		00048000
	=09
		The MSR had this or'ed into it, which is setting the
user-mode bit.
		Surely that's wrong.=20
	=09
		--linas
	=09



------_=_NextPart_001_01C6DD35.E021DF98
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY><FONT face=3D&#23435;&#20307; color=3D#0000ff =
size=3D2></FONT><FONT face=3D&#23435;&#20307; color=3D#0000ff=20
size=3D2></FONT>
<DIV dir=3Dltr align=3Dleft><BR>No MSR is 00029030 and user mode bit is =
not set=20
here.<BR><BR>I had missed it in the prev mail:<BR><BR>=05NIP: C0005DA4 =
XER:=20
20000000 LR: C0004FE4 SP: C01F3000=05 REGS: c01eff30 TRAP: =
1020&nbsp;&nbsp;&nbsp;=20
Not tainted<BR>MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 <BR>TASK =
=3D=20
c01f1080[0] 'swapper' Last syscall: 120<BR>last math 00000000 last =
altivec=20
00000000<BR>=05PLB0: bear=3D 0x08000000 acr=3D&nbsp;&nbsp; 0xbb000000 =
besr=3D&nbsp;=20
0x00000000<BR><SPAN class=3D459021904-21092006><FONT =
face=3D&#23435;&#20307; color=3D#0000ff=20
size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D459021904-21092006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Dave&gt;I notice that&nbsp;MSR and TRAP, MSR is =

00029030-&nbsp;the&nbsp;critical interrupt enable.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D459021904-21092006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Dave&gt;TRAP is 1020. --WatchDog =
timer&nbsp;exception is=20
happening</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D459021904-21092006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Dave&gt;You can disable the MSR[CE] bit to no =
critical=20
exception or disable the WD timer</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><BR>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV><SPAN class=3Dgmail_quote>On 9/20/06, <B =
class=3Dgmail_sendername>Linas=20
  Vepstas</B> &lt;<A=20
  href=3D"mailto:linas@austin.ibm.com">linas@austin.ibm.com</A>&gt; =
wrote:</SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">On=20
    Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt =
wrote:<BR>&gt;=20
    On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:<BR>&gt; &gt; =
This is=20
    the stack trace.<BR>&gt; &gt;<BR>&gt; &gt; Registers:<BR>&gt; &gt; =
GPR00:=20
    00069030 <BR><BR>This is the MSR and it has the user-mode bit set, =
which is=20
    surely wrong.<BR>This is not how one gets to user=20
    space.<BR><BR>00048000<BR><BR>The MSR had this or'ed into it, which =
is=20
    setting the user-mode bit.<BR>Surely that's wrong.=20
  <BR><BR>--linas<BR></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6DD35.E021DF98--
