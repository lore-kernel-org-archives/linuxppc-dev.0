Date: Sat, 27 Jan 2001 13:36:01 +0000
Subject: network stack oops 2.4.1/gcc 2.95.3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010127133601.4A323DB9CB@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This is not a completely repeatable scenario.

Yesterday, when my network connection was very busy portmap & named timed
out.  Today they both oops'ed in the same place - system came up OK apart
from dead network stack.

Iain.

----

Linux version 2.4.1-pre10-iain1 (iain-s@athena)
(gcc version 2.95.3 20010111 (prerelease/franzo/20010111)) #1 Fri Jan 26

NOTE1:       ^ ^ ^ ^

Oops: Exception in kernel mode, sig: 4
NIP: C017AF80 XER: 20000000 LR: C017AF74 SP: CF52BD00 REGS: cf52bc50 TRAP:
0700

NOTE2: 0700 is Illegal Instruction.

MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cf52a000[227] 'portmap' Last syscall: 102
last math cf390000 last altivec 00000000
GPR00: 00000010 CF52BD00 CF52A000 00000038 00001032 00000000 CF54D458
00000000
GPR08: C099C000 00000001 0000000E C028DC60 22444849 1001E9E8 00000000
100B5390
GPR16: 100CEF50 00000000 00000000 00000000 00009032 0F52BE80 00000000
C00043F0
GPR24: C0004120 7FFFF738 10017948 00002260 CF52BD68 00000000 CF550CA8
CF52BD68
Call backtrace:
C017AF74 C0145E3C C0146D5C C0147578 C000417C 10017B28 00000709
0FF7F248 0FF7FAB0 10001980 0FED2734 00000000

from System.map:

c017af38 T inet_recvmsg
c017af98 T inet_sendmsg

c0145de4 T sock_recvmsg
c0145ee8 t sock_lseek

c0146cbc T sys_recvfrom
c0146dc0 T sys_recv

c01473fc T sys_socketcall
c01475dc T sock_register

======================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
