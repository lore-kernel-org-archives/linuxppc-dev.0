Message-ID: <3BD05C20.20E3396B@midrivers.com>
Date: Fri, 19 Oct 2001 11:00:16 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging ppc4xx VM w/ abatron
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I know this has been addressed before -- I've searched this list
for the solution, and have read the manual ...

I'm trying to debug mvista's 2.4.2 kernel w/ the bdi2000 (v.1.05) and
am having trouble once the mmu is turned on -- I can set a
breakpoint in start_kernel(), gdb shows me the correct line
of source, but if I step-into or next-over the first call (a printk)
gdb (hhl 5.0) hangs -- I then break and it looks like I've taken
a bad fault ...:

(gdb) 1   <connect-to-target macro>
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

all construction suggestions appreciated,

Mark
--
Mark Pilon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
