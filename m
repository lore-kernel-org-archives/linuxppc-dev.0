Message-ID: <3D8AAE2D.D80646E3@bmrtech.com>
Date: Fri, 20 Sep 2002 13:12:13 +0800
From: sjk <jack.sun@bmrtech.com>
Reply-To: jack.sun@bmrtech.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: cross debug with gdb/gdbserver on 405GP
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am porting Linux on CSB272 405gp board.The Linux kernel works.
But I can't debug applications with gdb and gdbserver.
The problem is described as following:

I want to  cross debug applications by gdbserver and gdb.But only one
breakpoint  can break. Any excute comand including stepi make the
application run over and exit. The application runs correctlly. Why
can't I debug the program step by step?

ppc_405gdb version 5.2.
debug information:
on host:
#ppc_405 -g -ggdb -o hello hello.c
#ddd --debugger ppc_405-gdb  --gdb hello
(gdb) target remote target:1000
0x30013a00 in ?? ()
(gdb) break hello.c:4
Breakpoint 1 at 0x100004f8: file hello.c, line 4.
(gdb) cont
Breakpoint 1, main () at hello.c:4
(gdb) step
Program exited with code 037.
(gdb)

on target:
#gdbserver host:1000 hello
rocess hello created; pid = 97
Remote debugging using 192.9.200.69:1000
Hello World
Child exited with retcode = c
Child exited with status 253
GDBserver exiting

please give some suggestions!
thanks


Jikun Sun
jack.sun@bmrtech.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
