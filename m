Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD0616A.B5FE43C0@midrivers.com>
Date: Fri, 19 Oct 2001 11:22:50 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging ppc4xx VM, part 2
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I left out some of the things I've done:

I'm at the point of trying to bring a linux kernel (mvista
2.4.2 for ppc4xx) and am running into
a problem with debugging virtual memory:

per the BDI2000 user manual 'embedded linux MMU support` I've added
the entries to our bdi config file:

[INIT]
.
.
.
; zero out the page table base
WM32    0x000000f0  0x00000000

[TARGET]
.
.
.
MMU         XLAT        ; enable mmu translation, page table base @ 0xf0
PTBASE      0x000000f0

I've patched the kernel to spin in a simple loop, waiting on a var
to be set != 0 before continuing ... it's a way to get the kernel
uncompressed and started, but without proceeding.  this func is
called before doing the 'rfi' to get to the first thread.

I connect w/ gdb (hhl gdb 5.0) and set a breakpoint in start_kernel()
-- clear the above loop var, continue, and the breakpoint is hit.

however, if I step or next, gdb never comes back; if I break out
and 'where' it looks like I've taken a fault ...

I think I've set everything up for mmu support in the bdi --
there was 1 statement in the user's manual to:
'If not automatically done by the kernel, setup the page table pointers
for the BDI.' -- I don't know from this what to check or what to do.

a complete debug session:
(gdb) 1     <connect-to-target macro>
gdb_spin () at serial.c:5857
5857                 i++ ) {
(gdb) set gdb_spin_exit = 1
(gdb) p $pc
$1 = 0xc009b158
(gdb) b start_kernel
Breakpoint 1 at 0xc012f660: file init/main.c, line 534.
(gdb) c
Continuing.

Breakpoint 1, start_kernel () at init/main.c:534
534             printk(linux_banner);
(gdb) n
< I hit ctrl/C here>
Program received signal SIGSTOP, Stopped (signal).
panic (fmt=0x0) at panic.c:100
100             for(;;) {
(gdb) where
#0  panic (fmt=0x0) at panic.c:100
#1  0xc0016694 in do_exit (code=0xb) at exit.c:438
#2  0xc0002bb4 in _exception (signr=0xc00f16bc, regs=0x0) at traps.c:86
#3  0xc000ccc0 in bad_page_fault (regs=0xc011ef30, address=0x0, sig=0xb)
    at fault.c:235
#4  0xc000cb94 in do_page_fault (regs=0xc011ef30, address=0xc011ef30,
    error_code=0x1030) at fault.c:186
#5  0xc0002980 in ret_from_except () at init/main.c:801
#6  0xc000d7ac in ioremap (addr=0x9030, size=0x0) at ioremap.c:148
#7  0xc0002334 in start_here ()
(gdb)


--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
