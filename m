Message-ID: <20040206145813.25115.qmail@web20418.mail.yahoo.com>
Date: Fri, 6 Feb 2004 06:58:13 -0800 (PST)
From: hp <aput99@yahoo.com>
Subject: bash-gdbserver exit problem on PPC4xx board ( the Walnut)
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I encountered a weird problem while using gdbserver-5.3-3 in bash-2.05b on a
PPC4xx board (the Walnut).  I telnet into the board which gives me a bash
shell.  However when I kick of a remote debugging session with gdbserver and
when that session ends, bash terminates the telnet session too.

Here is a senario:

HOST (running RedHat 9.0)

$gdb
(gdb)target remote 192.168.1.5:2345
(gdb) c
Continuing.

Program exited normally.
(gdb)

========================================
========================================

WALNUT:  ( <---- telnet in)

bash-2.05b$  /bin/gdbserver 192.168.1.1:2345 /bin/mount
Process /bin/mount created; pid = 42
Remote debugging from host 192.168.1.1
/dev/root on / type unknown (rw,errors-remount,-re)

Child exited with retcode = 0

Child exited with status 1
GDBserver exiting
bash-2.05b$ logout
Connection closed by foreign host.

[back to where I telnet'ed in from]$

The weird thing is that if I do the debugging on the console using minicom
directly from the Walnut, bash-2.05b does NOT display this behavior.  Only
when I telnet in, then bash kills the telnet session when the remote debug
session ends.
I wonder if anyone knows what is going on here?  Or any pointers as to how to
debug and solve this problem.  That is to stop bash from terminating the
telnet session when the debug session ends.

I'm using strace but it's confusing to trace (telnet->bash->gdbserver) :(

Thanks in advance for any input.
Andrew

ps.  Sorry if this is a re-post.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
