Message-ID: <20000324225355.21418.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Porting to a VME board w. MPC740
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Mar 2000 00:53:55 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

just got back home after a long day trying to get Linux
up on a VME bord from ELTEC using MPC740.

The problem seems to be quite common when I browsed
the mailing lists, but I couldn't find any real answer :-(

I am using the VxWorks monitor to load a kernel image
(zvmlinux) over ftp from my x86 Linux system where I also
have done the crosscompiling.
The kernel is compiled from the standard 2.2.14 distribution
and I did have to change some IO addresses of the serial port
to get the bootloader running.
Now it shows that the kernel is decompressed into 0x0 and
should try to run it. The problem is that I don't have any other
means of checking what it does but direct writes to the serial
port and I have tracked down the halt to the
position where boot/head.S does a blr to address 0x4.
Writing to the serial port before this works nicely, but even when I
put a write directly after the NOPS in kernel/head.S there is no
output....

Dumping the code at 0x0-0x20 shows that there is the expected stuff..

I also tried to disable the cache in boot/head.S, but nothing changed.

It seems like  my system refuses to execute the code in 0x0-> ...

Any clues appreciated.

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 NMT: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
