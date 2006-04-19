Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 532C0679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 22:58:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C663B0.F47D3D04"
Subject: kernel access of bad area, sig: 11 ( mpc852t)
Date: Wed, 19 Apr 2006 08:58:35 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD432D423@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
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

------_=_NextPart_001_01C663B0.F47D3D04
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>>> Hi,
>>> Im having problem porting linux kernel 2.4.21 to our mpc852T custom
>>> board.The kernel
>>> panics randomly with sig 11.
>>> The board boots up fine and we also get to the prompt.When we open
3-4
>>> telnet sessions
>>> and try to run some command the kernel panics.This is completely
>>> random.Sometimes it
>>> even panics before opening the telnet session.
>>>

>>> <oops dump snipped>
>>>
>>You almost certainly have SDRAM problems.  If you have thoroughly
checked
>>out the
>>complete address range statically, remember that burst accesses will
not
>>occur until the
>>cache is turned on, so your problem may be with bursting.  But you can
also
>>have severe
>>problems like a missing address line and linux still run for a few
seconds.
>>
>>Mark Chambers

>We've checked the SDRAM. The timings (UPM) look fine. The problem
>however is that linux does not hang until after a few processes are
>started.
>If we boot to linux and leave it as it is, everything is fine and the
>board remains working. However each time a few processes (4-5 telnet
>sessions for eg.) are started the system either panics or hangs (goes
>dead).

>Thanks in advance,
>Akshay

We have been experiencing this same issue with random boards in
production. The exact same version of software will run for months on
other instances of the exact same board design, but a few percent get
'random' trap 300s. When they do occur, it's only after Linux has booted
and address translation and caching are turned on. Examining the oops-es
and memory shows that some location in SDRAM has a bogus value, but I
don't have the tools to trace back how it got that way.

I have ported a rigorous moving-inversions memory test into our
firmware, and have run it extensively across the entire SDRAM address
space (the test code executes from flash). I have let this test run
continuously for hours and hours, but never found a memory problem.
Unfortunately, I do not have test software that enables the MMU address
translation or caching, so as Mark said, I can't test memory using
bursting. Our hardware engineers have reviewed the designs very
carefully and are quite confident that there is plenty of margin in the
memory timing. Signal quality has also been carefully checked.

Our manufacturing people have replaced the CPU on some of these boards,
and the problem went away.

If anyone else on the mailing list has experienced this issue, or has
developed a virtual address memory test, please let us know.

Ken Poole
=20

=20

------_=_NextPart_001_01C663B0.F47D3D04
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>kernel access of bad area, sig: 11 ( mpc852t)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> Hi,</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> Im having problem porting linux kernel 2.4.21 to =
our mpc852T custom</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> board.The kernel</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> panics randomly with sig 11.</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> The board boots up fine and we also get to the =
prompt.When we open 3-4</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> telnet sessions</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> and try to run some command the kernel panics.This =
is completely</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> random.Sometimes it</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New"> even panics before opening the telnet =
session.</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;&gt;&gt;</FONT></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;&gt;&gt; &lt;oops dump snipped&gt;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;&gt;&gt;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">You almost certainly have SDRAM problems.&nbsp; If =
you have thoroughly checked</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">out the</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">complete address range statically, remember that =
burst accesses will not</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">occur until the</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">cache is turned on, so your problem may be with =
bursting.&nbsp; But you can also</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">have severe</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">problems like a missing address line and linux =
still run for a few seconds.</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Courier New">Mark Chambers</FONT></I></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;We've checked the SDRAM. The timings (UPM) look fine. The =
problem</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;however is that linux does not hang until after a few processes =
are</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;started.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;If we boot to linux and leave it as it is, everything is fine =
and the</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;board remains working. However each time a few processes (4-5 =
telnet</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;sessions for eg.) are started the system either panics or hangs =
(goes</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;dead).</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;Thanks in advance,</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;Akshay</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">We =
have been experiencing this same issue with random boards in production. =
The exact same version of software will run for months on other =
instances of the exact same board design, but a few percent get =
&#8216;random&#8217; trap 300s. When they do occur, it&#8217;s only =
after Linux has booted and address translation and caching are turned =
on. Examining the oops-es and memory shows that some location in SDRAM =
has a bogus value, but I don&#8217;t have the tools to trace back how it =
got that way.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I =
have ported a rigorous moving-inversions memory test into our firmware, =
and have run it extensively across the entire SDRAM address space (the =
test code executes from flash). I have let this test run continuously =
for hours and hours, but never found a memory problem. Unfortunately, I =
do not have test software that enables the MMU address translation or =
caching, so as Mark said, I can&#8217;t test memory using bursting. Our =
hardware engineers have reviewed the designs very carefully and are =
quite confident that there is plenty of margin in the memory timing. =
Signal quality has also been carefully checked.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Our =
manufacturing people have replaced the CPU on some of these boards, and =
the problem went away.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">If =
anyone else on the mailing list has experienced this issue, or has =
developed a virtual address memory test, please let us =
know.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Ken =
Poole</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us">&nbsp;</SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C663B0.F47D3D04--
