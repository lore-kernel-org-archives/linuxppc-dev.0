Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <A3E34B558F5CD211B4980008C7A4A9900242418D@sparrow.gso.mcs.marconi.com>
From: "Banks, Kelly" <kelly.banks@gilbarco.com>
To: "'Andres Chamorro Morillas'" <achamorro@prodys.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: MPC860 onchip WatchDog
Date: Wed, 6 Mar 2002 17:01:30 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just did this last week.  My test load is cooking in the test oven now.
You need to tickle the WD at several places within the kernel.  For me, it
worked by putting the tickle code in kernel/sched.c &
arch/ppc/boot/simple/misc-embedded.c.  Granted, there is likely a better
place to put chip specific code than in kernel/sched.c, but it did get the
job done.

I'm curious to know if there are any 'proper conventions' for doing this
sort of thing.

Kelly

-----Original Message-----
From: Andres Chamorro Morillas [mailto:achamorro@prodys.net]
Sent: Wednesday, March 06, 2002 6:57 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC860 onchip WatchDog



Hi, I trying to use the MPC860 onchip WatchDog.I compile ppcboot-1.1.4
with include/config_MBX.h ( I have a MBX860 board) I compile the
linux-2.4.4-2002-02-14 kernel by denx. I activate the WatchDog support
for
MPC860.Well, I make tftpboot then I tray to boot the
kernel but...
Loading .text @ 0x00180000 (23052 bytes)
Loading .rodata @ 0x00185a10 (2320 bytes)
Loading .data @ 0x00187000 (808bytes)
Loading __ex_table @ 0x00187328 (24 bytes)
## Starting application at 0x00180000...
loaded at:  00210000 0021B59C
relocated to:  00180000 0018B59C
board data at: 043A0288 043A02BC
relocated to:  00200100 00200134
zimage at:  00218000 002A95D8
avail ram:  002AA000 04400000
Linux/PPC load:root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel

And reset.
Thats mean that WD works fine but I can't boot.
What can I do???
Modify the kernel code to service the watchdog????
Which part of kernel I have to modify???
Thanks a lot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
