Message-ID: <19991115140645.12495.rocketmail@web207.mail.yahoo.com>
Date: Mon, 15 Nov 1999 06:06:45 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Bug in ptrace on smp systems
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I found a bugs which causes gdb to go to sleep 
forever on smp systems occaisionally
in ptrace.c in the 2.2.10 kernel
( maybe you've this fixed maybe not ) 
in the sys_ptrace call you are
setting exit_code in most cases after calling
wake_up_process(child) this is incorrect as the
function sys_wait4 will get very confused on smp
systems as the process will be woken up on another
processor & deliver a new exit_code from do_signal
which this code will subsequently clear.

It also would be wise to move the clear_single_step
statement before wake_up_process in PTRACE_CONT.

For the correct treatment of exit_code look at the
intel code.

D.J.

=====


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
