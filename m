Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id EA76C67B76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 07:13:00 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7ALCxIT022498
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Aug 2006 14:12:59 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k7ALCwHm027428
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 14:12:58 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BCC1.C136E1E3"
Subject: kernel panic: BUG in cascade at kernel/timer.c
Date: Thu, 10 Aug 2006 14:12:58 -0700
Message-ID: <F795765B112E7344AF36AA9112796415019ED348@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C6BCC1.C136E1E3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
We have developed our own custom board based on MPC8541 board running
linux 2.6.11
During stress testing the system we get following kernel panic which
related to timer cascase.
Any hints greatly apprieciated. Many thanks in advance:
=20
kernel BUG in cascade at kernel/timer.c:416!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT=20
NIP: C0023AB4 LR: C0023CC8 SP: C02DDDF0 REGS: c02ddd40 TRAP: 0700
Tainted: P   =20
MSR: 00021200 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK =3D c02bb730[0] 'swapper' THREAD: c02dc000
Last syscall: 120=20

File timer.c line 416 :
    401 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
    402 {
    403         /* cascade all the timers from tv up one level */
    404         struct list_head *head, *curr;
    405=20
    406         head =3D tv->vec + index;
    407         curr =3D head->next;
    408         /*
    409          * We are removing _all_ timers from the list, so we
don't  have
         to
    410          * detach them individually, just clear the list
afterwards.
    411          */=20
    412         while (curr !=3D head) {
    413                 struct timer_list *tmp;
    414        =20
    415                 tmp =3D list_entry(curr, struct timer_list,
entry);
    416                 BUG_ON(tmp->base !=3D base);
    417                 curr =3D curr->next;
    418                 internal_add_timer(base, tmp);
    419         }
    420         INIT_LIST_HEAD(head);
    421=20
    422         return index;

=20
Regards,
Bizhan

------_=_NextPart_001_01C6BCC1.C136E1E3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006>We =
have developed=20
our own custom board based on MPC8541 board running linux=20
2.6.11</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006>During =
stress=20
testing the system we get following kernel panic which related to timer=20
cascase.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006>Any =
hints greatly=20
apprieciated. Many thanks in advance:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D971390621-10082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006><FONT=20
face=3DCourier>kernel BUG in cascade at kernel/timer.c:416!<BR>Oops: =
Exception in=20
kernel mode, sig: 5 [#1]<BR>PREEMPT <BR>NIP: C0023AB4 LR: C0023CC8 SP: =
C02DDDF0=20
REGS: c02ddd40 TRAP: 0700&nbsp;&nbsp;&nbsp; Tainted: P&nbsp;&nbsp;&nbsp; =

<BR>MSR: 00021200 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00<BR>TASK =3D =
c02bb730[0]=20
'swapper' THREAD: c02dc000<BR>Last syscall: 120 =
</FONT><BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D971390621-10082006>File =
timer.c line=20
416 :</SPAN></FONT></DIV>
<DIV><FONT size=3D2><SPAN class=3D971390621-10082006>
<DIV><FONT size=3D+0><SPAN class=3D178042520-10082006><FONT face=3DArial =

size=3D2>&nbsp;&nbsp;&nbsp; 401 static int cascade(tvec_base_t *base, =
tvec_t *tv,=20
int index)<BR>&nbsp;&nbsp;&nbsp; 402 {<BR>&nbsp;&nbsp;&nbsp;=20
403&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cascade all the =
timers=20
from tv up one level */<BR>&nbsp;&nbsp;&nbsp;=20
404&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head =
*head,=20
*curr;<BR>&nbsp;&nbsp;&nbsp; 405 <BR>&nbsp;&nbsp;&nbsp;=20
406&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; head =3D tv-&gt;vec =
+=20
index;<BR>&nbsp;&nbsp;&nbsp; =
407&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
curr =3D head-&gt;next;<BR>&nbsp;&nbsp;&nbsp;=20
408&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/*<BR>&nbsp;&nbsp;&nbsp;=20
409&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * We are =
removing=20
_all_ timers from the list, so we don't&nbsp;=20
have<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
to<BR>&nbsp;&nbsp;&nbsp;=20
410&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * detach them=20
individually, just clear the list afterwards.<BR>&nbsp;&nbsp;&nbsp;=20
411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=20
<BR>&nbsp;&nbsp;&nbsp; =
412&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while=20
(curr !=3D head) {<BR>&nbsp;&nbsp;&nbsp;=20
413&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
struct timer_list *tmp;<BR>&nbsp;&nbsp;&nbsp;=20
414&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>&nbsp;&nbsp;&nbsp;=20
415&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
tmp =3D list_entry(curr, struct timer_list, =
entry);<BR>&nbsp;&nbsp;&nbsp;=20
416&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
BUG_ON(tmp-&gt;base !=3D base);<BR>&nbsp;&nbsp;&nbsp;=20
417&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
curr =3D curr-&gt;next;<BR>&nbsp;&nbsp;&nbsp;=20
418&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
internal_add_timer(base, tmp);<BR>&nbsp;&nbsp;&nbsp;=20
419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>&nbsp;&nbsp;&nbsp;=20
420&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
INIT_LIST_HEAD(head);<BR>&nbsp;&nbsp;&nbsp; 421 <BR>&nbsp;&nbsp;&nbsp;=20
422&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
index;<BR></FONT></SPAN></FONT></DIV>
<DIV><FONT size=3D+0><SPAN class=3D178042520-10082006><FONT face=3DArial =

size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><SPAN class=3D178042520-10082006><SPAN=20
class=3D971390621-10082006>Regards,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial><SPAN class=3D178042520-10082006><SPAN=20
class=3D971390621-10082006>Bizhan</SPAN></SPAN></FONT></DIV></DIV></SPAN>=
</FONT></BODY></HTML>

------_=_NextPart_001_01C6BCC1.C136E1E3--
