From: phandel@cise.ufl.edu
Date: Mon, 25 Sep 2000 17:06:01 -0700 (PDT)
Subject: kernel panic starting XFree86 4.0.1 / Voodoo3 on 2.4-test9 -
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0009251704210.2150-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been successfully using Ani's penguinppc.org::xfree86-pmac tree
with my Voodoo3 card with a stable 2.2 series kernel (from
ppc.samba.org::linux-pmac-stable, with the voodoo3 driver from the 2.3
series).  Today I tried the 2.4-test9 kernel from
ppc.samba.org::linux-pmac-devel and got the following panic while trying
to startx:

Sep 24 23:33:09 like kernel: Machine check in kernel mode.
Sep 24 23:33:09 like kernel: Caused by (from SRR1=49030): Transfer error
ack signal
Sep 24 23:33:09 like kernel: NIP: C00F78A0 XER: 20000000 LR: C00F9648
REGS: ca9cfb70 TRAP: 0200
Sep 24 23:33:09 like kernel: MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
Sep 24 23:33:09 like kernel: TASK = ca9ce000[501] 'X' Last syscall: 54
Sep 24 23:33:09 like kernel: last math ca9ce000 last altivec 00000000
Sep 24 23:33:09 like kernel: GPR00: 004F006B CA9CFC20 CA9CE000 CDFBA800
CA9CFC48 00000000 CDFBAE50 0617008F
Sep 24 23:33:09 like kernel: GPR08: 00000000 CF000C00 00000008 00000004
00000200 101CD220 00000010 00000001
Sep 24 23:33:09 like kernel: GPR16: 101DF6F8 105AB364 00000800 FFFFFFFF
00009032 0A9CFE80 00000008 00000001
Sep 24 23:33:09 like kernel: GPR24: 00000CB3 00000006 00000280 000001E0
00000001 00000000 CA9CFC48 CDFBA800
Sep 24 23:33:09 like kernel: Call backtrace:
Sep 24 23:33:09 like kernel: C00F9C98 C00FA340 C00ED444 C0047FB8 C00048CC
1003C8F4 10052034
Sep 24 23:33:09 like kernel: 103DD45C 10041AAC 10042730 1068A910 100240BC
10089418 0FE9B67C
Sep 24 23:33:10 like kernel: 00000000
Sep 24 23:33:10 like kernel: Kernel panic: machine check


>From the System.map:
c00f9fb4 t atyfb_get_var
c00fa018 t atyfb_set_disp
c00fa17c t atyfb_set_var
c00fa388 t atyfb_pan_display
c00fa410 t atyfb_get_cmap
c00fa500 t atyfb_set_cmap


When I tell XFree86 to use the ATI card instead (via "Screen 1" instead
of "Screen 2" at the end), it works fine.


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
