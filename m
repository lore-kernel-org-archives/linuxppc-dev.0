Message-ID: <38BA8226.42A8B064@ict.ac.cn>
Date: Mon, 28 Feb 2000 22:11:50 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem on MPC8xx
References: <NCBBKJKKGDLPHKDPAFFMGEBGCDAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jason:

> Which CPM port do you need to use, I have modified the kernel for our custom
> board to support serial consoles on all the SMC's and SCC's.  The
> ramdisk.image.gz of mbx is probably aimed at SMC1 or ttyS0, you will
> probably just want to make your own from a slightly modified minroot.

I just use SMC1 as my console port. I show you all messages from
log_buf:

<4>Linux version 2.2.13 (tliu@Saxophone)
 (gcc version egcs-2.91.66 19990314
 (egcs-1.1.2 release))
  #166 Mon Feb 28 20:55:48 GMT+82000.
<4>Boot arguments: root=/dev/ram.
<4>time_init: decrementer frequency = 240000000/60.
<4>Calibrating delay loop... 63.69 BogoMIPS.
<4>Memory: 13412k available
 (640k kernel code, 412k data, 32k init) [c0000000,c1000000].
<4>DENTRY hash table entries: 262144 (order: 9, 2097152 bytes).
<4>Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes).
<4>Page-cache hash table entries: 4096 (order: 2, 16384 bytes).
<4>POSIX conformance testing by UNIFIX.
<6>Linux NET4.0 for Linux 2.2.
<6>Based upon Swansea University Computer Society NET3.039.
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0..
<6>NET4: Linux TCP/IP 1.0 for NET4.0.
<6>IP Protocols: ICMP, UDP, TCP, IGMP.
<4>TCP: Hash tables configured (ehash 16384 bhash 16384).
<4>Starting kswapd v 1.5 .
<6>CPM UART driver version 0.02.
<6>ttyS00 at 0x0280 is a SMC.
<6>ttyS01 at 0x0100 is a SCC.
<6>ttyS02 at 0x0200 is a SCC.
<4>RAM disk driver initialized:  16 RAM disks of 4096K size.
<4>eth0: CPM ENET Version 0.2, 00:00:00:00:00:00.
<5>RAMDISK: Compressed image found at block 0.
<4>VFS: Mounted root (ext2 filesystem)..
<4>Freeing unused kernel memory: 32k .
<4>rs_open ttyS0, count= 1.
<4>starting up ttys0 (irq 4)
...rs_open ttys0 successful.....



> Methods of testing, sure whether or not characters are coming out of the
> serial port.

I mean that what I should write to test it. eg. printf() or write() or
etc.

> Most likely you will need to modify m8xx_tty.c and not uart.c, from what I

I have modified m8xx_tty.c successfully, but you know, that's not the
true serial driver. I can see the following on serial port:

loaded at:     00200000 0020B1BC
board data at: 0020013C 00200158
relocated to:  001F0100 001F011C
zimage at:     002301B4 002873CC
initrd at:     002873CC 0045E209
avail ram:     0045F000 00FFFFFF

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

But after the Linux boot up, I can't see anything.

> remember uart.c works just fine but you have to have the /dev/console link
> correct.  Let me know which port you want to use and I will look into it.
I don't hope to modify uart.c too.
I am using SMC1 to be serial port.

Thanks for your help!

LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
