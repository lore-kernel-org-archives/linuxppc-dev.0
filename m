Message-ID: <384C2509.3CDA6500@mitre.org>
Date: Mon, 06 Dec 1999 16:05:56 -0500
From: Frank McPherson <frank@mitre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: real-time signals, gdb
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running Yellowdog Champion Server 1.1 with the kernel version and
support tools & libs versions it shipped with.  

I've got a simple test program which prints a message to the screen and
then goes to sleep for a while.   When I run this under gdb and send a
real-time signal, let's say 32, to the process, I get the message
"Program received signal ?, Unknown signal." from gdb.  

So I did a little rtfm, and tried this: 
(gdb) handle 32 nostop pass print
gdb helpfully responded, "Only signals 1-15 are valid as numeric signals."
Okay, no problem:  (gdb) handle SIG32 nostop pass print
Great, looks like we're getting somewhere:
Signal        Stop      Print   Pass to program Description
SIG32         No        Yes     Yes             Real-time event 32

Only problem is, I get the same behavior from my program when I run it again:
(gdb) run
(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /home/frank/Source/pthread-test/./foo 
Beginning main thread main() pid = 15129.
(kill -32 15129 in another window)
Program received signal ?, Unknown signal.

Any ideas?  I wrote my simple test program because I'm trying to debug
some bizarre behavior in dce rpc where the function called by
pthread_once() is getting about halfway through, then infinitely looping
between just at the end of an exception handling macro and the end of
the function.   When I try to run that program under gdb, I get this
same behavior, which is why I'd like to fix it.  

Any chance of a more recent gdb version helping me out?  More recent
glibc version?  
gdb version is gdb-4.17.0.11-6, glibc version is glibc-2.1.1-6h. 

thanks in advance! 

-- 
Frank H. McPherson IV
W118 Embedded Solutions Team
The MITRE Corporation
703-883-5404

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
