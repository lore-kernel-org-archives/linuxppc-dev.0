Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 35070DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 09:09:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8EB84.AFF2D656"
Subject: Linux on V4FX100
Date: Mon, 21 Jul 2008 17:54:10 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5D4A@XMBIL132.northgrum.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8EB84.AFF2D656
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hopefully beating the bushes in many arenas will help me ellict some
responses.

I have a system on a V4FX100 that is using both PPC405s. Each system is
an exact clone of the other, with some minor variations like how the
other's memory controller is mapped in. (They both can't be mapped to
0x0 :P).

I have a Linux 2.6.22 image (arch/ppc) that I've built that will run on
one and not the other. And by not run, I mean it boots successfully,
gives me a console, I run the applications and then in some point in
time in the near future the system crashes, semi-gracefully. The kernel
crashes and prints out the crash, hence the gracefully part, but its
dead in the water. What can an application that doesn't interface with
any special kernel things do to cause the crash? The applications use
only 'normal' things, no specific drivers (that haven't been completely
tested ;).

If I use a different software load, it runs fine with no problems. In
fact, I currently use it for running and developing other software.

Has anyone seen anything similar when using both PPCs? From what I can
tell it looks like it may be related to timers, but that's only guessing
and inconclusive. I don't have any extra timers (plb/opb/xps_timer)
built into either system.

Thanks,
Mike

Here's the crash output:
Oops: kernel access of bad area, sig: 11 [#1]
NIP: c002c960 LR: c002c960 CTR: 00000000
REGS: c1363d90 TRAP: 0300   Not tainted  (2.6.22-rc2-default)
MSR: 00021030 <ME,IR,DR>  CR: 48002488  XER: 20000055
DAR: 0000029b, DSISR: 00800000
TASK =3D c102f7b0[496] 'mmngr.exe' THREAD: c1362000
GPR00: c002c960 c1363e40 c102f7b0 c1363eb0 c01dd9e8 00000000 00000001
00000001
GPR08: 00368044 00000001 c103c580 00000000 e7433f04 10030ea8 ffffffff
ffffffff
GPR16: 7f9d1a04 65786563 10080000 7ff907f0 00000001 00000000 7ff90808
100c09f0
GPR24: 10002830 10015068 c1363f18 c1363eb0 00000000 00000000 0000027b
c1363eb0
NIP [c002c960] __remove_hrtimer+0x3c/0x54
LR [c002c960] __remove_hrtimer+0x3c/0x54
Call Trace:
[c1363e40] [c002c960] __remove_hrtimer+0x3c/0x54 (unreliable)
[c1363e60] [c002c9d8] hrtimer_try_to_cancel+0x60/0x80
[c1363e70] [c002ca14] hrtimer_cancel+0x1c/0x3c
[c1363e80] [c0187af8] do_nanosleep+0x68/0xa4
[c1363ea0] [c002ce70] hrtimer_nanosleep+0x48/0x184
[c1363f10] [c002d044] sys_nanosleep+0x98/0xcc
[c1363f40] [c0002c30] ret_from_syscall+0x0/0x3c
Instruction dump:
90010024 7c9f2378 8004000c 7c7e1b78 7f801800 7cbd2b78 40be000c 480b0fed
907f000c 389f0008 7fc3f378 480b108d <93be0020> 80010024 bba10014
7c0803a6
Oops: kernel access of bad area, sig: 11 [#2]
NIP: c00093bc LR: c00093d0 CTR: c0077d9c
REGS: c01efef0 TRAP: 0300   Not tainted  (2.6.22-rc2-default)
MSR: 00029030 <EE,ME,IR,DR>  CR: 24000082  XER: 00000055
DAR: 00000027, DSISR: 00000000
TASK =3D c01db980[0] 'swapper' THREAD: c01ee000
GPR00: 00000000 c01effa0 c01db980 00000000 c00088d4 00000000 c020b414
00000000
GPR08: 00000002 c01ee028 28002448 00000010 8a2c8992 ffffffff ffffffff
ffffffff
GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff
GPR24: ffffffff ffffffff c0209000 c0200000 00000000 c01ee000 ffffffff
ffffffff
NIP [c00093bc] cpu_idle+0xc0/0xd8
LR [c00093d0] cpu_idle+0xd4/0xd8
Call Trace:
[c01effa0] [c00093d0] cpu_idle+0xd4/0xd8 (unreliable)
[c01effb0] [c0185f5c] rest_init+0x50/0x60
[c01effc0] [c01f09e4] start_kernel+0x2b4/0x2c8
[c01efff0] [c000225c] start_here+0x44/0xb0
Instruction dump:
60008000 7c000124 39200010 381f0028 7d600028 7d6b4b78 7c00022c 7d60012d
40a2fff0 4800000c 7c210b78 7ffffb78 <801f0028> 70090008 4182ff70
7c421378
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..<NULL>

------_=_NextPart_001_01C8EB84.AFF2D656
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>Linux on V4FX100</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hopefully beating the bushes in many =
arenas will help me ellict some responses.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have a system on a V4FX100 that is =
using both PPC405s. Each system is an exact clone of the other, with =
some minor variations like how the other's memory controller is mapped =
in. (They both can't be mapped to 0x0 :P).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have a Linux 2.6.22 image (arch/ppc) =
that I've built that will run on one and not the other. And by not run, =
I mean it boots successfully, gives me a console, I run the applications =
and then in some point in time in the near future the system crashes, =
semi-gracefully. The kernel crashes and prints out the crash, hence the =
gracefully part, but its dead in the water. What can an application that =
doesn't interface with any special kernel things do to cause the crash? =
The applications use only 'normal' things, no specific drivers (that =
haven't been completely tested ;).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I use a different software load, it =
runs fine with no problems. In fact, I currently use it for running and =
developing other software.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Has anyone seen anything similar when =
using both PPCs? From what I can tell it looks like it may be related to =
timers, but that's only guessing and inconclusive. I don't have any =
extra timers (plb/opb/xps_timer) built into either system.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Mike</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's the crash output:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oops: kernel access of bad area, sig: =
11 [#1]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP: c002c960 LR: c002c960 CTR: =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">REGS: c1363d90 TRAP: 0300&nbsp;&nbsp; =
Not tainted&nbsp; (2.6.22-rc2-default)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; =
CR: 48002488&nbsp; XER: 20000055</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">DAR: 0000029b, DSISR: 00800000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TASK =3D c102f7b0[496] 'mmngr.exe' =
THREAD: c1362000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR00: c002c960 c1363e40 c102f7b0 =
c1363eb0 c01dd9e8 00000000 00000001 00000001</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR08: 00368044 00000001 c103c580 =
00000000 e7433f04 10030ea8 ffffffff ffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR16: 7f9d1a04 65786563 10080000 =
7ff907f0 00000001 00000000 7ff90808 100c09f0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR24: 10002830 10015068 c1363f18 =
c1363eb0 00000000 00000000 0000027b c1363eb0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP [c002c960] =
__remove_hrtimer+0x3c/0x54</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">LR [c002c960] =
__remove_hrtimer+0x3c/0x54</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Call Trace:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363e40] [c002c960] =
__remove_hrtimer+0x3c/0x54 (unreliable)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363e60] [c002c9d8] =
hrtimer_try_to_cancel+0x60/0x80</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363e70] [c002ca14] =
hrtimer_cancel+0x1c/0x3c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363e80] [c0187af8] =
do_nanosleep+0x68/0xa4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363ea0] [c002ce70] =
hrtimer_nanosleep+0x48/0x184</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363f10] [c002d044] =
sys_nanosleep+0x98/0xcc</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c1363f40] [c0002c30] =
ret_from_syscall+0x0/0x3c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Instruction dump:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">90010024 7c9f2378 8004000c 7c7e1b78 =
7f801800 7cbd2b78 40be000c 480b0fed</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">907f000c 389f0008 7fc3f378 480b108d =
&lt;93be0020&gt; 80010024 bba10014 7c0803a6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oops: kernel access of bad area, sig: =
11 [#2]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP: c00093bc LR: c00093d0 CTR: =
c0077d9c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">REGS: c01efef0 TRAP: 0300&nbsp;&nbsp; =
Not tainted&nbsp; (2.6.22-rc2-default)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MSR: 00029030 =
&lt;EE,ME,IR,DR&gt;&nbsp; CR: 24000082&nbsp; XER: 00000055</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">DAR: 00000027, DSISR: 00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TASK =3D c01db980[0] 'swapper' THREAD: =
c01ee000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR00: 00000000 c01effa0 c01db980 =
00000000 c00088d4 00000000 c020b414 00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR08: 00000002 c01ee028 28002448 =
00000010 8a2c8992 ffffffff ffffffff ffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR16: ffffffff ffffffff ffffffff =
ffffffff ffffffff ffffffff ffffffff ffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR24: ffffffff ffffffff c0209000 =
c0200000 00000000 c01ee000 ffffffff ffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP [c00093bc] =
cpu_idle+0xc0/0xd8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">LR [c00093d0] =
cpu_idle+0xd4/0xd8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Call Trace:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c01effa0] [c00093d0] =
cpu_idle+0xd4/0xd8 (unreliable)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c01effb0] [c0185f5c] =
rest_init+0x50/0x60</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c01effc0] [c01f09e4] =
start_kernel+0x2b4/0x2c8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c01efff0] [c000225c] =
start_here+0x44/0xb0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Instruction dump:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">60008000 7c000124 39200010 381f0028 =
7d600028 7d6b4b78 7c00022c 7d60012d</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">40a2fff0 4800000c 7c210b78 7ffffb78 =
&lt;801f0028&gt; 70090008 4182ff70 7c421378</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kernel panic - not syncing: Attempted =
to kill the idle task!</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Rebooting in 180 =
seconds..&lt;NULL&gt;</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8EB84.AFF2D656--
