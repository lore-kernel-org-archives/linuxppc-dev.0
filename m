Message-ID: <008e01bfe698$339232e0$640a0a0a@server>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting the MPC823 FADS with 8xxboot...
Date: Wed, 5 Jul 2000 17:43:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(Sorry for my previous post in HTML)

I bought a MPC823 FADS and the PC ADI CARD, because i want to project a
Linux diskless box that boots via Ethernet and run X plus a simple web
browser.

I found the fantastic "solutions for linux" site, and i followed these
suggestione. I downloaded 8xxrom 0.3.0, mpc8xx-2.2.13 and the damm and
bossek patches.

I compiled the kernel and the 8xxrom but when i try to run it, i had some
problems.

These are the steps i made:

KERNEL:
1) Uncompressed "mpc8xx-2.2.13" kernel sources
2) Applied the patch "patch-2.2.13-mpc8xx-damm"
3) Applied the patch "patch-2.2.13-mpc8xx-bossek"
4) Made the link "include/asm" to "include/asm-ppc"
5) Modified the directive "mcpu=823" instead of "mcpu=860" into
"arch/ppc/Makefile"
6) Modified the variable "ARCH  := ppc" instead of "ARCH := ..." into
"Makefile"
7) Set the variable "CROSS-COMPILE = powerpc-linux-"
8) Run "make menuconfig" and set cpu, board and finally ethernet on SCC2
9) Run "make dep; make clean; make zImage"

8xxROM:
1) Uncompressed "8xxrom-0.3.0"
2) Modified the directive "mcpu=823" instead of "mcpu=860" into
"Make.config"
3) Defined these directives in "config.h":
    #define MPC823 1
    #define CONFIG_FADS
4) Set the variable "CROSS-COMPILE = powerpc-linux-"
5) Added the directive "CONFIG_SCC2_ENET" into "/arch/ppc/8xx_io/commproc.h"
of Kernel
6) Run "make clean; make s19"

Loading the rom on MPC823 FADS via the MPC8BUG version 1.3.2 (into a dos
shell fo Win98):
1) Run the command "loadf 8xxrom.bin.s19 100000"

Now, where i made mistakes?
By running the command "go" or "t" (trace), the program halts with:
"Exception: SOFTWARE EMULATION - 0x00000000 deadc0de stfdu
fr21, -0x3f22(r13)"

What can i do, next?

Thanx for helping me, too!

BYE!

-- MAY THE PINGUIN B WITH U -


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
