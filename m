Date: Tue, 10 Oct 2000 10:35:51 -0400
From: Brad Dixon <brad.dixon@gtri.gatech.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel oops during gdb
Message-ID: <20001010103551.A9531@sen-mail.gtri.gatech.edu>
Reply-To: brad.dixon@gtri.gatech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

I'm having difficulty working with gdb on my target board. I've created a
simple "Hello World" program as the debug target and am executing gdb on
out PPC823 board. Once gdb is given the run command the kernel croaks.

I've appended the example and the generated oops. Reading the oops
indicates that somehow the processor got sent to execute address 0x0. The
backtrace works out to:

a61c: bad_page_fault
a5ac: do_page_fault
253c: int_return
46ec: zero_paged
dcc8: copy_files

Initially I cranked up my BDI2000/gdb to break inside of do_page_fault but
this is more complex then I thought. Since the target board is executing
gdb (to debug the hellow world program) the host gdb session (which is
set to debug the kernel) gets numerous SIGTRAP's and is ineffective.

I'm about ready to break out printk. :)

Does anyone have some insight as to why I'm having trouble executing gdb
on the target and how to get into the kernel to find out why?

Thanks,

Brad


sh-2.03# ./hello
Hello
sh-2.03# gdb ./hello
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "powerpc-hardhat-linux"...
(gdb) b main
Breakpoint 1 at 0x1000043c
(gdb) run
Starting program: /home/bdixon/./hello
[tcsetpgrp failed in terminal_inferior: Inappropriate ioctl for device]
NIP: 00000000 XER: C000FF7F LR: C0003BC0 REGS: c0b81dc0 TRAP: 0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0b80000[22] 'hello' mm->pgd c0b82000 Last syscall: 6
last math 00000000
GPR00: 00000000 C0B81D80 C0B80000 C0B81DC0 00000001 00000001 00000001 C015FB80
GPR08: C00E9BE0 C00F0000 00000001 C0B81C90 35F33F39 1009F944 100A0DB0 00000000
GPR16: 00000000 00000000 00000000 1004B6FC 00009032 00B81DB0 00000000 C000253C
GPR24: C000A310 10000034 00000000 C01DE260 08209032 C01DE278 00000000 C0B81DC0
Call backtrace:
C000A61C C000A5AC C000253C 7FFFF990 C000253C 300046EC 3000DCC8
300031EC 3000312C 30010214


Last few lines of "strace gdb ./hello":
munmap(0x30018000, 4096)                = 0
brk(0)                                  = 0x1021b000
brk(0)                                  = 0x1021b000
brk(0x101f3000)                         = 0x101f3000
ptrace(PTRACE_PEEKTEXT, 19, 0x1000043c, [0x3d201000]) = 0
ptrace(PTRACE_POKEDATA, 19, 0x1000043c, 0x7d821008) = 0
ptrace(PTRACE_PEEKTEXT, 19, 0x3000c0b8, [0x9421fff0]) = 0
ptrace(PTRACE_POKEDATA, 19, 0x3000c0b8, 0x7d821008) = 0
ptrace(PTRACE_CONT, 19, 0x1, SIG_0NIP: 00000000 XER: C000BF7F LR: C0003BC0 REGS0
(and so on with the oops)



--
Brad Dixon <brad.dixon@gtri.gatech.edu>
- Electronic Systems Laboratory, Systems Engineering Division
- Georgia Tech Research Institute, Atlanta, GA




--
Brad Dixon <brad.dixon@gtri.gatech.edu>
- Electronic Systems Laboratory, Systems Engineering Division
- Georgia Tech Research Institute, Atlanta, GA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
