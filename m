From: "Q-ha Park" <qha@infoeq.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: using bdi2000 to debug ppcboot on mpc7455
Date: Thu, 25 Sep 2003 09:56:34 +0900
Message-ID: <004c01c382ff$de2da2f0$2a21a8c0@qha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[I apologize this question is off topic in this mailing
list:ppc-embedded. But I coundn't find a better place to ask,
ppcboot-users is inactive..]

I'm new to BDI2000, and after reading a manual that came with the tool,
I tried to debug ppcboot using bdi2000 and gdb. The problem is I just
can't set the breakpoint whether be it software or hardware breakpoint;
For example, when I set the break point at "boot_cold" and type
"continue", the program just runs without ever stopping at the
breakpoint where it's supposed to stop!

Here's what I did:
a. turn on bdi2000.
b. connect to bdi2000 in gdb session.
c. set the breakpoint
d. type "continue"

==========
90              li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot
from FLASH */
(gdb) l
85              .ascii  CONFIG_IDENT_STRING, "\0"
86
87              . = EXC_OFF_SYS_RESET
88              .globl  _start
89      _start:
90              li      r21, BOOTFLAG_COLD      /* Normal Power-On: Boot
from FLASH */
91              b       boot_cold
92              sync
93
94              . = EXC_OFF_SYS_RESET + 0x10
(gdb) b boot_cold
Breakpoint 1 at 0xfff02000: file
/home/users/qpark/hobby/ppcboot-1.1.6/cpu/74xx_7xx/start.S, line 253.
(gdb) cont
Continuing.
(continues for good...)
==========

What am I probably doing wrong? FYI, I tried to remove H/W breakpoint
before I entered "go"

Any help would be greatly appreciated!!

:::::::::::::::::::::::::::::::::::::::::::::::::
Q-ha Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
