Date: Wed, 13 Jan 1999 23:15:04 +0100 (CET)
From: Geert Uytterhoeven <geert@thomas.kotnet.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Crash when early load of cs4236 module
Message-ID: <Pine.LNX.4.05.9901132310180.341-100000@callisto.thomas.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



To make my sound module load automatically at boot time, I put

    cs4232 io=0x530 irq=5 dma=1 dma2=5

in /etc/modules (I'm using Debian `sid' on a CHRP box with cs4236 sound).
This works fine, except that I get a kernel crash later when the boot
scripts are initializing the network daemons:

    NIP: cc831bb0
    bad access address: 0000ac44
    backtrace: cc8319b0      ???
               cc8303dc      ???
               c003438c      (c0034154 T sys_ioctl)
               c0003898      (c0003898 T syscall_ret_1)
               <garbage>

It happens in both 2.2.0pre6 and 2.2.0pre4 and is reproducible (I hate
file system checks on 2 GB partitions on slow disks :-(.

If I remove the cs4232 line from /etc/modules again and load the module by
hand later

    modprobe cs4232 io=0x530 irq=5 dma=1 dma2=5

I have no problems at all. Really weird...

Greetings,

						Geert

--
Geert Uytterhoeven                   Geert.Uytterhoeven@cs.kuleuven.ac.be
Linux/m68k on Amiga, Wavelets        http://www.cs.kuleuven.ac.be/~geert/
KotNET@Thomas Network Administration -- Make you bed part of Cyberspace!!


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
