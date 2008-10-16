Return-Path: <ganeshkumar@signal-networks.com>
Message-ID: <004c01c92f92$bca991d0$0d01a8c0@signet>
From: "Ganesh Kumar N M" <ganeshkumar@signal-networks.com>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
Subject: Loadable module crashes at kernel stack overflow or machine check
Date: Thu, 16 Oct 2008 18:56:02 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0049_01C92FC0.D617F390"
Cc: Ganesh Kumar NM <ganeshkumar@signal-networks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0049_01C92FC0.D617F390
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

    I'm working on MPC860 with Montavista linux 2.4.18
We have a Linux kernel loadable module which on loading
panicks after some random time say 8 hours, 4 hours or so
the oops outputs say either machine check exception or=20
kernel stack overflow (randomly both show up) are as below:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Machine check in kernel mood/e.
Caused by lPC:M C000A934 XER:3REGS: c0b73cb0 TRAP: 0200    Tainted: PF
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0b72000[3] 'ksoftirqd_CPU0' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C0B73D60 C0B72000 00000000 00000000 0000000B 00000000 =
00000000
GPR08: E244E000 C01A0000 00000014 00000002 00000000 100374B8 1FFFA000 =
007FFF36
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00009032 00B73E30 00000000 =
C00029D4
GPR24: 00000000 00030001 C0B73E40 00000000 00000000 0000000B 08200000 =
C0B73E40
Call backtrace:
C00CB774 C0009CBC C00029D4 C0B73FA0 C00E0208 C00E8800 C00D8920
C0014E98 C0015524 C0004D88
Machine check in kernel mode.
Caused by (from SRR1=3D1032): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000A934 XER: 00000000 LR: C0009EFC SP: C0B73990 REGS: c0b738e0 =
TRAP: 0200F
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0b72000[3] 'ksoftirqd_CPU0' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C0B73990 C0B72000 E20286D0 E242D03C 0000000B C01F6268 =
E20286D0
GPR08: E244E000 C01A0000 C01B4F1C 00000002 24004028 100374B8 1FFFA000 =
007FFF36
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 00B73A60 00000000 =
C00029D4
GPR24: 00000000 00030001 C0B73A70 E242D03C 00000000 0000000B 88000000 =
C0B73A70
Call backtrace:
C0B73A40 C0009CBC C00029D4 E20286D0 C00CB774 C00039EC C0003AB0
C00029CC C0002B54 C0002C74 C00029D4 C00CB774 C0009CBC C00029D4
C0B73FA0 C00E0208 C00E8800 C00D8920 C0014E98 C0015524 C0004D88
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Kernel stack overflow in process c018e030, r1=3Dc018e370
NIP: C000A934 XER: 00000000 LR: C0009EFC SP: C018E370 REGS: c018e2c0 =
TRAP: 0300    Tainted: PF
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: E2474034, DSISR: 88000000
TASK =3D c018e030[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C0009CBC C018E370 C018E030 C000A934 E2474034 0000000B C0B6C400 =
C000A934
GPR08: E2474000 C01A0000 00000014 00000002 002AE754 10052EC8 1FFFA000 =
007FFF1C
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00009032 0018E440 00000000 =
C00029D4
GPR24: 00000000 00030001 C018E450 E2474034 00000000 0000000B 88000000 =
C018E450
Call backtrace:
00000000 C0009CBC C00029D4 0000000B C0009CBC C00029D4 00000000
C0009CBC C00029D4 00000000 C0009CBC C00029D4 00000000 C0009CBC
C00029D4 00000000 C0009CBC C00029D4 00000000 C0009CBC C00029D4
00000000 C0009CBC C00029D4 00000000 C0009CBC C00029D4 00000000
C0009CBC C00029D4 00000000 C0009CBC C00029D4
Kernel panic: kernel stack overflow
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Looking at the Ksymoops pointed me to some do_page_fault


ksymoops 2.4.6 on i686 2.4.18-3smp.  Options used
     -V (default)
     -k ksyms (specified)
     -L (default)
     -O (default)
     -m System.map (specified)

Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ipt_MASQUER=
ADE.o) for ipt_MASQUERADE
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/iptable_fil=
ter.o) for iptable_filter
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_nat_ftp.=
o) for ip_nat_ftp
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/iptable_nat=
.o) for iptable_nat
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k_irc.o) for ip_conntrack_irc
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k_ftp.o) for ip_conntrack_ftp
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k.o) for ip_conntrack
Error (expand_objects): cannot =
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_tables.o=
) for ip_tables
Error (expand_objects): cannot stat(/home/ICM/ISDN/sig860el.o) for =
sig860el
Error (expand_objects): cannot stat(/home/ICM/LKM/sysk_procif_ver.o) for =
sysk_procif_ver
Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says =
c00095e4, System.map says c0004af0.  Ignoring ksyms_base entry
Kernel stack overflow in process c0a08000, r1=3Dc0a08460
NIP: C000A934 XER: 00000000 LR: C0009EFC SP: C0A08460 REGS: c0a083b0 =
TRAP: 0300F
Using defaults from ksymoops -t elf32-little -a unknown
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0a08000[1] 'init' Last syscall: 106
last math 00000000 last altivec 00000000
GPR00: 00000000 C0A08460 C0A08000 C000A934 E2433034 0000000B C0B6AA00 =
C000A934
GPR08: E2433000 C01A0000 DDDDB81E 00000003 CA010101 1001EE38 00000000 =
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00A08530 00000000 =
C00029D4
GPR24: 00000000 00030001 C0A08540 E2433034 C01AF090 0000000B 88000000 =
C0A08540
Call backtrace:
00000000 C0009CBC C00029D4 DD394530 C0009CBC C00029D4 00000000
C0009CBC C00029D4 65666175 C0009CBC C00029D4 00000000 C0009CBC
C00029D4 CEA99000 C0009CBC C00029D4 C0A08E10 C0009CBC C00029D4
00000000 C0009CBC C00029D4 00000000 C0009CBC C00029D4 00A09320
C0009CBC C00029D4 C0007640 C0009CBC C00029D4
Kernel panic: kernel stack overflow
Warning (Oops_read): Code line not seen, dumping what data is available


>>???; c000a934 <search_exception_table+14/94>   <=3D=3D=3D=3D=3D

>>GPR1; c0a08460 <_end+80ff96/21e0ab96>
>>GPR2; c0a08000 <_end+80fb36/21e0ab96>
>>GPR3; c000a934 <search_exception_table+14/94>
>>GPR4; e2433034 <[sig860el].bss.end+6001/602d>
>>GPR6; c0b6aa00 <_end+972536/21e0ab96>
>>GPR7; c000a934 <search_exception_table+14/94>
>>GPR8; e2433000 <[sig860el].bss.end+5fcd/602d>
>>GPR9; c01a0000 <g_stCfgKSFuncHndl+17d4/1eb0>
>>GPR10; ddddb81e <_end+1dbe3354/21e0ab96>
>>GPR12; ca010101 <_end+9e17c37/21e0ab96>
>>GPR23; c00029d4 <ret_from_except+0/34>
>>GPR26; c0a08540 <_end+810076/21e0ab96>
>>GPR27; e2433034 <[sig860el].bss.end+6001/602d>
>>GPR28; c01af090 <serial_console_setup+58/2a4>
>>GPR31; c0a08540 <_end+810076/21e0ab96>

Trace; 00000000 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; dd394530 <_end+1d19c066/21e0ab96>
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 00000000 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 65666175 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 00000000 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; cea99000 <_end+e8a0b36/21e0ab96>
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; c0a08e10 <_end+810946/21e0ab96>
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 00000000 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 00000000 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; 00a09320 Before first symbol
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>
Trace; c0007640 <__up+38/48>
Trace; c0009cbc <do_page_fault+138/358>
Trace; c00029d4 <ret_from_except+0/34>



So just to check I made the same loadable module as Part of the
Kernel and booted my system and it booted fine and runs fine
for more than 5 days without any problem.=20
What may be the reason for this?

Is there any loading/linking difference between the Linux kernel
module(as this is dynamically done) and Part of=20
Kernel (statically linked with the kernel)

As the insmod does a vmalloc to allocate the memory for loading the =
module,
does it have some memory allocation problems or something like that?

Any pointers will be really helpful,Thanks in advance,
Pls cc to me as I'm not subscribed to this list.


--Ganesh
------=_NextPart_000_0049_01C92FC0.D617F390
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Hi =
All,</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>&nbsp;&nbsp;&nbsp; I'm =
working on=20
MPC860 with Montavista linux 2.4.18</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>We have a Linux kernel =
loadable=20
module which on loading</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>panicks after some =
random time say=20
8 hours, 4 hours or so</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>the oops outputs say =
either machine=20
check exception or </FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>kernel stack overflow =
(randomly=20
both show up)&nbsp;a</FONT></STRONG><STRONG><FONT face=3D"Courier New" =
size=3D2>re=20
as below:</FONT></STRONG></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New"=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Machine check in kernel =

mood/e.<BR>Caused by lPC:M C000A934 XER:3REGS: c0b73cb0 TRAP:=20
0200&nbsp;&nbsp;&nbsp; Tainted: PF<BR>MSR: 00009032 EE: 1 PR: 0 FP: 0 =
ME: 1=20
IR/DR: 11<BR>TASK =3D c0b72000[3] 'ksoftirqd_CPU0' Last syscall: =
-1<BR>last math=20
00000000 last altivec 00000000<BR>GPR00: 00000000 C0B73D60 C0B72000 =
00000000=20
00000000 0000000B 00000000 00000000<BR>GPR08: E244E000 C01A0000 00000014 =

00000002 00000000 100374B8 1FFFA000 007FFF36<BR>GPR16: 00000000 00000001 =

007FFF00 FFFFFFFF 00009032 00B73E30 00000000 C00029D4<BR>GPR24: 00000000 =

00030001 C0B73E40 00000000 00000000 0000000B 08200000 C0B73E40<BR>Call=20
backtrace:<BR>C00CB774 C0009CBC C00029D4 C0B73FA0 C00E0208 C00E8800=20
C00D8920<BR>C0014E98 C0015524 C0004D88<BR>Machine check in kernel=20
mode.<BR>Caused by (from SRR1=3D1032): Transfer error ack =
signal<BR>Oops: machine=20
check, sig: 7<BR>NIP: C000A934 XER: 00000000 LR: C0009EFC SP: C0B73990 =
REGS:=20
c0b738e0 TRAP: 0200F<BR>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: =
11<BR>TASK=20
=3D c0b72000[3] 'ksoftirqd_CPU0' Last syscall: -1<BR>last math 00000000 =
last=20
altivec 00000000<BR>GPR00: 00000000 C0B73990 C0B72000 E20286D0 E242D03C =
0000000B=20
C01F6268 E20286D0<BR>GPR08: E244E000 C01A0000 C01B4F1C 00000002 24004028 =

100374B8 1FFFA000 007FFF36<BR>GPR16: 00000000 00000001 007FFF00 FFFFFFFF =

00001032 00B73A60 00000000 C00029D4<BR>GPR24: 00000000 00030001 C0B73A70 =

E242D03C 00000000 0000000B 88000000 C0B73A70<BR>Call =
backtrace:<BR>C0B73A40=20
C0009CBC C00029D4 E20286D0 C00CB774 C00039EC C0003AB0<BR>C00029CC =
C0002B54=20
C0002C74 C00029D4 C00CB774 C0009CBC C00029D4<BR>C0B73FA0 C00E0208 =
C00E8800=20
C00D8920 C0014E98 C0015524=20
C0004D88<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Kernel stack overflow =
in process=20
c018e030, r1=3Dc018e370<BR>NIP: C000A934 XER: 00000000 LR: C0009EFC SP: =
C018E370=20
REGS: c018e2c0 TRAP: 0300&nbsp;&nbsp;&nbsp; Tainted: PF<BR>MSR: 00009032 =
EE: 1=20
PR: 0 FP: 0 ME: 1 IR/DR: 11<BR>DAR: E2474034, DSISR: 88000000<BR>TASK =
=3D=20
c018e030[0] 'swapper' Last syscall: 120<BR>last math 00000000 last =
altivec=20
00000000<BR>GPR00: C0009CBC C018E370 C018E030 C000A934 E2474034 0000000B =

C0B6C400 C000A934<BR>GPR08: E2474000 C01A0000 00000014 00000002 002AE754 =

10052EC8 1FFFA000 007FFF1C<BR>GPR16: 00000000 00000001 007FFF00 FFFFFFFF =

00009032 0018E440 00000000 C00029D4<BR>GPR24: 00000000 00030001 C018E450 =

E2474034 00000000 0000000B 88000000 C018E450<BR>Call =
backtrace:<BR>00000000=20
C0009CBC C00029D4 0000000B C0009CBC C00029D4 00000000<BR>C0009CBC =
C00029D4=20
00000000 C0009CBC C00029D4 00000000 C0009CBC<BR>C00029D4 00000000 =
C0009CBC=20
C00029D4 00000000 C0009CBC C00029D4<BR>00000000 C0009CBC C00029D4 =
00000000=20
C0009CBC C00029D4 00000000<BR>C0009CBC C00029D4 00000000 C0009CBC=20
C00029D4<BR>Kernel panic: kernel stack overflow<BR>In interrupt handler =
- not=20
syncing<BR>&nbsp;&lt;0&gt;Rebooting in 180 =
seconds..<BR></FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New"=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
/FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Looking at the Ksymoops =
pointed me=20
to some do_page_fault</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>ksymoops 2.4.6 on i686=20
2.4.18-3smp.&nbsp; Options used<BR>&nbsp;&nbsp;&nbsp;&nbsp; -V=20
(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -k ksyms=20
(specified)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -L =
(default)<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
-O (default)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -m System.map=20
(specified)</FONT></STRONG></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Error (expand_objects): =
cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ipt_MASQUER=
ADE.o)=20
for ipt_MASQUERADE<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/iptable_fil=
ter.o)=20
for iptable_filter<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_nat_ftp.=
o) for=20
ip_nat_ftp<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/iptable_nat=
.o) for=20
iptable_nat<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k_irc.o)=20
for ip_conntrack_irc<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k_ftp.o)=20
for ip_conntrack_ftp<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_conntrac=
k.o)=20
for ip_conntrack<BR>Error (expand_objects): cannot=20
stat(/lib/modules/2.4.18_mvl30-fads/kernel/net/ipv4/netfilter/ip_tables.o=
) for=20
ip_tables<BR>Error (expand_objects): cannot =
stat(/home/ICM/ISDN/sig860el.o) for=20
sig860el<BR>Error (expand_objects): cannot =
stat(/home/ICM/LKM/sysk_procif_ver.o)=20
for sysk_procif_ver<BR>Warning (compare_maps): mismatch on symbol =
xchg_u32&nbsp;=20
, ksyms_base says c00095e4, System.map says c0004af0.&nbsp; Ignoring =
ksyms_base=20
entry<BR>Kernel stack overflow in process c0a08000, =
r1=3Dc0a08460<BR>NIP: C000A934=20
XER: 00000000 LR: C0009EFC SP: C0A08460 REGS: c0a083b0 TRAP: =
0300F<BR>Using=20
defaults from ksymoops -t elf32-little -a unknown<BR>MSR: 00009032 EE: 1 =
PR: 0=20
FP: 0 ME: 1 IR/DR: 11<BR>TASK =3D c0a08000[1] 'init' Last syscall: =
106<BR>last=20
math 00000000 last altivec 00000000<BR>GPR00: 00000000 C0A08460 C0A08000 =

C000A934 E2433034 0000000B C0B6AA00 C000A934<BR>GPR08: E2433000 C01A0000 =

DDDDB81E 00000003 CA010101 1001EE38 00000000 00000000<BR>GPR16: 00000000 =

00000000 00000000 00000000 00009032 00A08530 00000000 C00029D4<BR>GPR24: =

00000000 00030001 C0A08540 E2433034 C01AF090 0000000B 88000000 =
C0A08540<BR>Call=20
backtrace:<BR>00000000 C0009CBC C00029D4 DD394530 C0009CBC C00029D4=20
00000000<BR>C0009CBC C00029D4 65666175 C0009CBC C00029D4 00000000=20
C0009CBC<BR>C00029D4 CEA99000 C0009CBC C00029D4 C0A08E10 C0009CBC=20
C00029D4<BR>00000000 C0009CBC C00029D4 00000000 C0009CBC C00029D4=20
00A09320<BR>C0009CBC C00029D4 C0007640 C0009CBC C00029D4<BR>Kernel =
panic: kernel=20
stack overflow<BR>Warning (Oops_read): Code line not seen, dumping what =
data is=20
available</FONT></STRONG></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2><BR>&gt;&gt;???; =
c000a934=20
&lt;search_exception_table+14/94&gt;&nbsp;&nbsp; =
&lt;=3D=3D=3D=3D=3D</FONT></STRONG></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>&gt;&gt;GPR1; c0a08460=20
&lt;_end+80ff96/21e0ab96&gt;<BR>&gt;&gt;GPR2; c0a08000=20
&lt;_end+80fb36/21e0ab96&gt;<BR>&gt;&gt;GPR3; c000a934=20
&lt;search_exception_table+14/94&gt;<BR>&gt;&gt;GPR4; e2433034=20
&lt;[sig860el].bss.end+6001/602d&gt;<BR>&gt;&gt;GPR6; c0b6aa00=20
&lt;_end+972536/21e0ab96&gt;<BR>&gt;&gt;GPR7; c000a934=20
&lt;search_exception_table+14/94&gt;<BR>&gt;&gt;GPR8; e2433000=20
&lt;[sig860el].bss.end+5fcd/602d&gt;<BR>&gt;&gt;GPR9; c01a0000=20
&lt;g_stCfgKSFuncHndl+17d4/1eb0&gt;<BR>&gt;&gt;GPR10; ddddb81e=20
&lt;_end+1dbe3354/21e0ab96&gt;<BR>&gt;&gt;GPR12; ca010101=20
&lt;_end+9e17c37/21e0ab96&gt;<BR>&gt;&gt;GPR23; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>&gt;&gt;GPR26; c0a08540=20
&lt;_end+810076/21e0ab96&gt;<BR>&gt;&gt;GPR27; e2433034=20
&lt;[sig860el].bss.end+6001/602d&gt;<BR>&gt;&gt;GPR28; c01af090=20
&lt;serial_console_setup+58/2a4&gt;<BR>&gt;&gt;GPR31; c0a08540=20
&lt;_end+810076/21e0ab96&gt;</FONT></STRONG></DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Trace; 00000000 Before =
first=20
symbol<BR>Trace; c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; =
c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; dd394530=20
&lt;_end+1d19c066/21e0ab96&gt;<BR>Trace; c0009cbc=20
&lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 00000000 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 65666175 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 00000000 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; cea99000=20
&lt;_end+e8a0b36/21e0ab96&gt;<BR>Trace; c0009cbc=20
&lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; c0a08e10=20
&lt;_end+810946/21e0ab96&gt;<BR>Trace; c0009cbc=20
&lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 00000000 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 00000000 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; 00a09320 Before first =
symbol<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR>Trace; c0007640 =
&lt;__up+38/48&gt;<BR>Trace;=20
c0009cbc &lt;do_page_fault+138/358&gt;<BR>Trace; c00029d4=20
&lt;ret_from_except+0/34&gt;<BR></DIV></FONT></STRONG>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>So just to check I made =
the same=20
loadable module as Part of the</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Kernel and booted my =
system and it=20
booted fine and runs fine</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>for&nbsp;more than 5 =
days without=20
any problem. </FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>What may be the reason =
for=20
this?</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Is there any =
loading/linking=20
difference between the Linux kernel</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>module(as this is =
dynamically done)=20
and Part of </FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Kernel (statically =
linked with the=20
kernel)</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>As the insmod does a =
vmalloc to=20
allocate the memory for loading the module,</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>does it have some =
memory allocation=20
problems or something like that?</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Any pointers will be =
really=20
helpful,</FONT></STRONG><STRONG><FONT face=3D"Courier New" =
size=3D2>Thanks in=20
advance,</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" size=3D2>Pls cc to me as I'm not =
subscribed=20
to this list.</FONT></STRONG></DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New" =
size=3D2></FONT></STRONG>&nbsp;</DIV>
<DIV><STRONG><FONT face=3D"Courier New"=20
size=3D2>--Ganesh</FONT></STRONG></DIV></BODY></HTML>

------=_NextPart_000_0049_01C92FC0.D617F390--
