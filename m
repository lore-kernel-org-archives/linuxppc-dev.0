Message-ID: <3B6BF1DB.3BBF9BDA@tejasnetworks.com>
Date: Sat, 04 Aug 2001 18:30:11 +0530
From: Nicholas Basker <nbasker@india.tejasnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: nbasker@india.tejasnetworks.com
Subject: while running gdb kernel crashes
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

I am running powerpc linux kernal (version 2.2.14)
on a custom board with MPC860 processor.
When I run gdb (version 5.0) on a hello world program the
kernel crashes. There is no
swap space configured and "cat /proc/meminfo" is shown below

        total:    used:    free:  shared: buffers:
cached:
Mem:  131600384 15015936 116584448  3817472  4792320
6012928
Swap:        0        0
0
MemTotal:    128516
kB
MemFree:     113852
kB
MemShared:     3728
kB
Buffers:       4680
kB
Cached:        5872
kB
SwapTotal:        0
kB
SwapFree:         0 kB

The output during kernel crash is as shown below:
(t is the name of the hello world program I am running)

sh-2.03# NIP: 00000000 XER: 8000BA76 LR: C0003C04 REGS: c7517dc0 TRAP:
0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR:
11
TASK = c7516000[153] 't' mm->pgd c7762000 Last syscall:
4
last math
00000000
GPR00: 00000000 C7517E70 C7516000 C7517E90 30014000 0000000D 00000018
15000000
GPR08: 10000575 C0100000 00001712 7FFFFD30 30015000 10018688 100AFA90
00000000
GPR16: 100A2990 7FFFDBE8 10015315 00000000 00009032 07517E80 00000000
C000253C
GPR24: C0003BB8 100A2990 10000544 00000001 7FFFFE24 7FFFFE2C 0FFE8720
C7517E90
Call
backtrace:
7FFFFE2C C000253C 100003FC 1000048C 0FF094F8
00000000
NIP: 00000000 XER: 8000BA76 LR: C000B4DC REGS: c7517cd0 TRAP:
0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR:
11
TASK = c7516000[153] 't' mm->pgd c7762000 Last syscall:
4
last math
00000000
GPR00: 00000000 C7517D80 C7516000 C7517DC0 00000001 00000001 00000001
C0299C20
GPR08: C00FFC38 C0100000 00000001 C7517C90 35033A39 10018688 100AFA90
00000000
GPR16: 100A2990 7FFFDBE8 10015315 00000000 00009032 07517DB0 00000000
C000253C
GPR24: C000B1AC 100A2990 10000544 C7BEE2E0 08209032 C7BEE2F8 00000000
C7517DC0
Call
backtrace:
C000B4B8 C000B448 C000253C 7FFFFE2C C000253C 100003FC
1000048C
0FF094F8 00000000

The program by itself runs fine. I also tried running gdbserver,
when I connect to the target from host and "continue" the same
kernel crash can be observed. I am also able to run gdb and specify
the symbol file. The crash happens when I run the program from gdb.

I would appreciate any help to know the reason for the crash.
Also, it would be helpful if somebody could point me to some
documentation to analyze the kernel crash messages and register
outputs.

Thanks for your time,
Nicholas.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
