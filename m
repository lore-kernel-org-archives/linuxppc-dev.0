Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020820144703.16442.qmail@web20107.mail.yahoo.com>
Date: Tue, 20 Aug 2002 07:47:03 -0700 (PDT)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: Remote Multithread debugging problems
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-131296800-1029854823=:16429"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-131296800-1029854823=:16429
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I`m trying to debug a multi-threaded application using
gdbserver on the remote/target side and I`m having
some problems, the output I got is depicted below:

TARGET SIDE:(NORMAL OUTPUT)
--------------------------------------------------------------------
# threadTest
Break Function Reached
Init....
Passed 0 times
Main Thread
Passed 1 times
Main Thread
Passed 2 times
Main Thread
Passed 3 times

TARGET SIDE:(DEBUGGING)
--------------------------------------------------------------------
# gdbserver :6666 /bin/threadTest
Process /bin/threadTest created; pid = 32
Remote debugging from host 192.168.0.155
Break Function Reached
Init....
Passed 0 times
GDB bug: target.c (target_signal_from_host):
unrecognized real-time signal
Passed 1 times
Passed 2 times
Passed 3 times
Passed 4 times

HOST SIDE:
--------------------------------------------------------------------
(gdb) target remote 192.168.0.238:6666
0x30012f40 in ?? ()
(gdb) add-symbol-file /usr/src/threadTest 0x30012f40
add symbol table from file "/usr/src/threadTest" at
	.text_addr = 0x30012f40
(gdb) b funcToBreak
Breakpoint 1 at 0x300131b8: file threadTest.c, line
42.
(gdb) b main
Breakpoint 2 at 0x30013130: file threadTest.c, line
22.
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) next
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) next
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
Breakpoint 1, funcToBreak () at threadTest.c:42
(gdb) c
---------------------------------------------------------------------

Note that till the last continue, nothing have been
written on the target`s console, it seems like gdb and
gdbserver are having problems and do restart the
application several times... and finally the main
thread is killed(!?).
And if I try info threads, I got this:

(gdb) info threads
warning: RMT ERROR : failed to get remote thread list

I`m using gdbserver5.2.1 (I tried the one from HHL-2.0
Journeyman and didn`t worked too) compiled by myself
using Mvista HHL 2.0 tools and gdb 5.2.1 on my i386.
Am I doing something wrong or remote thread debugging
is not supported by gdb? I have read something about
problems with multi-thread application debugging but I
thought that it may be OK at this time...
Could someone explain to me what`s happening?
I`ve attached de source of threadTest application on
this mail...

Any comment, insight and/or help will be very
appreciate,

thanks in advance,

Owen.



--0-131296800-1029854823=:16429
Content-Type: application/octet-stream; name="threadTest.c"
Content-Transfer-Encoding: base64
Content-Description: threadTest.c
Content-Disposition: attachment; filename="threadTest.c"

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNs
dWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4JLy9wdGhyZWFk
cwojaW5jbHVkZSA8YXNzZXJ0Lmg+Cgp2b2lkIGZ1bmNUb0JyZWFrICh2b2lk
KTsKdm9pZCAqdGhyZWFkRnVuYyh2b2lkICphcmdzKTsKCnZvaWQgKnRocmVh
ZEZ1bmModm9pZCAqYXJncykKewoJc3RhdGljIGludCB0ZXN0Q291bnQ9MDsK
CXdoaWxlICgxKSB7CgkJcHJpbnRmICgiUGFzc2VkICVkIHRpbWVzXG4iLCB0
ZXN0Q291bnQpOwoJCXRlc3RDb3VudCsrOwoJCXNsZWVwKDEwKTsKCX0KfQoK
CmludCBtYWluKHZvaWQpCnsKICBwdGhyZWFkX3QgdGhyZWFkVGVzdDsKCiAg
ZnVuY1RvQnJlYWsoKTsKCiAgcHJpbnRmKCJJbml0Li4uLlxuIik7CgogIHB0
aHJlYWRfY3JlYXRlKCZ0aHJlYWRUZXN0LCBOVUxMLCAodm9pZCopdGhyZWFk
RnVuYywgTlVMTCk7CgogIHdoaWxlICgxKSB7CiAgICBzbGVlcCgxMCk7CiAg
ICBwcmludGYoIk1haW4gVGhyZWFkXG4iKTsKICB9CgogIHByaW50ZigiRXhp
dGVkLi4uLlxuIik7CgogIGV4aXQgKDApOwp9Cgp2b2lkIGZ1bmNUb0JyZWFr
KHZvaWQpCnsKCXByaW50ZiAoIkJyZWFrIEZ1bmN0aW9uIFJlYWNoZWRcbiIp
OwoJcmV0dXJuOwp9

--0-131296800-1029854823=:16429--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
