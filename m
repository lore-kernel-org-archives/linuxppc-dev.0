Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E9EA7C6.2020605@tataelxsi.co.in>
Date: Thu, 17 Apr 2003 18:40:30 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: debugging using bdi2000, unable to proceed.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using bdi200 for debugging linux kernel (2.4.1 and 2.4.17).
our target board is mpc8260ADS, with ppcboot 2.0.0

we are using http://www.ultsol.com/PDFS/Tool%20Talk%2002-001a.pdf as a
refernce to get bdi 2000 setup running.
Connections are made as per the document.
bdisetup is run from the host. Using the configuration file.
We used format IMAGE and file zImage and the image file  loaded to
0x400000 using bdi2000.
run ppc_82xx-gdb from the host.

Output from gdb
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux"...
(gdb) target remote 10.1.40.176:2001
Remote debugging using 10.1.40.176:2001
0x00404480 in ?? ()
(gdb) continue
Continuing.

Program received signal SIGSTOP, Stopped (signal).
0x00404478 in ?? ()
(gdb) pwd
Working directory /root.
(gdb) b start_here
Breakpoint 1 at 0xc0003694
(gdb) b startk _kernel
Breakpoint 2 at 0xc013e618: file init/main.c, line 527.
(gdb) continue
Continuing.

Program received signal SIGSTOP, Stopped (signal).
0x00404474 in ?? ()
(gdb) until start_kernel

Program received signal SIGSTOP, Stopped (signal).
0x00404470 in ?? ()
(gdb) until start_here

Program received signal SIGSTOP, Stopped (signal).
0x0040446c in ?? ()

</end of gdb output>

The documnetation (above referneced) says that one should connect
minicom (any serial communication
program). But when we connect the BDI JTag interface, we get the message
on BDI Telnet,

004000c0 : 3863fffc 3884fffc 38000000 94030004  8c..8...8.......
004000d0 : 7c032000 4082fff8 7c290b78 3c200040  |. .@...|).x< .@
004000e0 : 60217148 38212000 3821ff00 3840000f  `!qH8! .8!..8@..
004000f0 : 7c211078 4800012d 7d034378 7ce43b78  |!.xH..-}.Cx|.;x
- TARGET: target has entered debug mode
- TARGET: target has entered debug mode

The target is in debug mode and we cannot enter any command from
minicom/kermit.

We are struck at this point. Is there any funcamental error we are
commiting?

Any idea/poiters will be appreciated.
Thanks.
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
