Message-ID: <3BE086F8.3A6158DA@midrivers.com>
Date: Wed, 31 Oct 2001 16:19:20 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: building gdb ... 
References: <20011031213937.C0BC611269@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I received a patch to fix the problem of gdb core dumping while
debugging a kernel ... and have hit a snag:

after I built gdb 5.0, right from the gnu distribution,
I ran it -- got the gdb header and prompt and then nothing.

-- it's as if it's not checking stdin or stdin has been redirected
elsewhere ...

I debug'd gdb and got to:

-- (gdb)
Continuing.

Program received signal SIGINT, Interrupt.
0x40129f50 in __poll (fds=0x81c8e30, nfds=1, timeout=-1)
    at ../sysdeps/unix/sysv/linux/poll.c:45
45      in ../sysdeps/unix/sysv/linux/poll.c
(gdb) where
#0  0x40129f50 in __poll (fds=0x81c8e30, nfds=1, timeout=-1)
    at ../sysdeps/unix/sysv/linux/poll.c:45
#1  0x80c9502 in gdb_wait_for_event () at event-loop.c:773
#2  0x80c8fd2 in gdb_do_one_event (data=0x0) at event-loop.c:408
#3  0x80b2183 in catch_errors (func=0x80c8fbc <gdb_do_one_event>, args=0x0,
    errstring=0x816e480 "", mask=6) at top.c:615
#4  0x80c9003 in start_event_loop () at event-loop.c:438
#5  0x8091705 in cli_command_loop () at event-top.c:196
#6  0x806a675 in captured_command_loop (data=0x0) at main.c:104
#7  0x80b2183 in catch_errors (func=0x806a660 <captured_command_loop>,
    args=0x0, errstring=0x8145f11 "", mask=6) at top.c:615
#8  0x806b053 in captured_main (data=0xbffff9b0) at main.c:749
#9  0x80b2183 in catch_errors (func=0x806a6a4 <captured_main>,
    args=0xbffff9b0, errstring=0x8145f11 "", mask=6) at top.c:615
#10 0x806b07f in main (argc=1, argv=0xbffffa04) at main.c:761
(gdb) p *fds
$3 = {fd = 0, events = 1, revents = 0}
(gdb) quit

-- the call to poll appears to be looking for input on fd 0 ...
but stdin isn't consumed by this gdb.  if I suspend, all the
keystrokes I typed @ the gdb prompt then appear as if passed to
the shell.

did I miss something in the configure line? my configure line:
   ./configure --target=powerpc-linux \
      --host=i586-pc-linux-gnu \
      --prefix=/home/mpilon/ppc_tools/ppc_home

has anyone seen this?

Mark
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
