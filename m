Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Q-ha Park" <qha@infoeq.com>
To: <bradbosch@attbi.com>, "'Mark A. Greer'" <mgreer@mvista.com>,
	<wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: using bdi2000 to debug ppcboot on mpc7455
Date: Wed, 1 Oct 2003 15:57:45 +0900
Message-ID: <000501c387e9$52901590$2a21a8c0@qha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <16242.64239.133401.668446@waldo.lisle.iphase.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Soft breakpoints just don't work for me. I have two BDI tools, and they
behave the same. Not only that, "next", "step", and other commands just
don't work properly.

Here's what I get:
(gdb) add-symbol-file ppcboot 0x1ffc0000
add symbol table from file "ppcboot" at
        .text_addr = 0x1ffc0000
(y or n) y
Reading symbols from ppcboot...done.
(gdb) b board_init_r
Breakpoint 1 at 0x1ffc2cb0: file board.c, line 570.
(gdb) d
Delete all breakpoints? (y or n) y
(gdb) mon bi 0x1ffc2cb0 v
Breakpoint identification is 0

///// I have to use "mon bi" to make the program stop properly.

(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
Cannot remove breakpoints because program is no longer writable.
It might be running in another process.
Further execution is probably impossible.
board_init_r (bd=0x1ff3fffa, dest_addr=536084376) at board.c:570
570     {
------------------------
(gdb) b flash_init
Breakpoint 2 at 0x1ffd4100: file flash.c, line 330.
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
Cannot remove breakpoints because program is no longer writable.
It might be running in another process.
Further execution is probably impossible.
board_init_r (bd=0x1ff3fffa, dest_addr=536084376) at board.c:570
570     {

/////// It stopped at board_init_r again..... not flash_init

(gdb) d
Delete all breakpoints? (y or n) y
(gdb) b flash_init
Breakpoint 3 at 0x1ffd4100: file flash.c, line 330.
(gdb) c
Continuing.
warning: Cannot insert breakpoint -1:
Error accessing memory address 0xfff00100: Unknown error 4294967295.
(gdb)

And now I get this. Did anyone go thru something like this?

Q-ha Park


-----Original Message-----
From: bradbosch@attbi.com [mailto:bradbosch@attbi.com]
Sent: Thursday, September 25, 2003 11:26 PM
To: Mark A. Greer; Q-ha Park; linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455

<snip>

//// OK.  Now we are in RAM and we can use soft breakpoints from here
//// on out.

(gdb) b board_init_r
Breakpoint 6 at 0xffc14a0: file board.c, line 589.
(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
after_reloc (gd=0xff96f9c, dest_addr=268140544) at db64360.c:416
416             board_init_r(gd, dest_addr);
(gdb) list
=======================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
