Message-Id: <200108172021.PAA04309@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Debugging Linux with PPCBoot and the BDI2000
Date: Fri, 17 Aug 2001 10:35:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to debug my kernel using PPCBoot to load the kernel image via
tftpboot and then stop it in start_kernel.

I do the following.
1. Power up the to PPCBoot prompt
2. Load the vmlinux.img image via tftpboot created using the mkimage tool.
3. Load vmlinux into gdb that's connected to the bdi2000 at addr 0xc0000000
4. set a break at start_kernel (breaking on _start didn't work at all).
5. Telling PPCBoot to bootm
6. The debugger stops in start_kernel

Now, when I try to step or next I get the following error from gdb:
Breakpoint 2, start_kernel () at init/main.c:530
(gdb) display/i $pc
1: x/i $pc  0xc0142660 <start_kernel+16>:	lis	r9,-16364
(gdb) s
Cannot access memory at address 0x1100

I was under the impressions that the MMU has already been initilized at this
point and we should be running with vaddrs, hence the 0xc0000000
start_kernel function. But, it appears that for some reason gdb is confused
about v to p.

What am I doing wrong here?

Confused.
-bmb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
