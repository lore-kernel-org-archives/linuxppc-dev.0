Message-ID: <01C0C982.AB79C6B0@milkweed.cspi.com>
From: Brian Waite <bwaite@cspi.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems onForcePowerCore6750, please help.-Thank you~
Date: Fri, 20 Apr 2001 10:14:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We saw this same kind of problem with a Motorola 2400 under 2.4.3pre3. It turned out for us that the bootinfo struct was not being passed right and everything went haywire. Basically, if I remember correctly, we found the commond string was not being passed from the bootloader to the kernel in the bootinfo struct right. We had to basically remove the bootinfo and use the same boot method the old 2.2.x kernel used. We place initrd_start and initrd_size in r4 and r5 respectively on arch/ppc/boot/head.S and then in arch/ppc/prep_setup.c we read these values to determine the initrd info. Of course this is with a prep board, but the method should be about the same.
If you want I can make a patch of this and send it to you so you can see the changes.

Thanks
Brian



-----Original Message-----
From:	bwaite@cspi.com [SMTP:bwaite@cspi.com]
Sent:	Friday, April 20, 2001 8:48 AM
To:	waite@cspi.com
Subject:	"Zydla Tsui" <zydla   :   Re: initrd problems onForcePowerCore6750, please help.-Thank you~







"Zydla Tsui" <zydla@hotmail.com> on 04/20/2001 08:40:56 AM

Please respond to "Zydla Tsui" <zydla@hotmail.com>


To:   "Stefano Coluccini" <s.coluccini@caen.it>
cc:   "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org> (bcc:
      Brian Waite/CSP)
Subject:  Re: initrd problems on ForcePowerCore6750, please help.-Thank
      you~





Hi,

I try it without the root=/dev/ram argument.
But get the same result:

Start execution at address 0xFFE00000loaded at:     FFE00000 FFE0A1B8
relocated to:  00800000 0080A1B8
zimage at:     FFE07000 FFE5BA8A
initrd at:     FFE5BA8A FFF29BAC
avail ram:     00400000 00800000

Linux/PPC load:
initrd_start located > 16M
Uncompressing Linux...done.
Now booting the kernel
Total memory = 64MB; using 256kB for hash table (at c0100000)
Linux version 2.4.2 (ub@redgf.seu.ch) (gcc version 2.95.2 19991024
(release/franzo)) #25 Fri Apr 20 16:29:09 CEST 2001
Boot arguments: ip=autoconf
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=autoconf
time_init: decrementer frequency = 20.623983 MHz
Calibrating delay loop... 742.19 BogoMIPS
Memory: 63156k available (520k kernel code, 272k data, 160k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 41920kB/13973kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
VFS: Cannot open root device "" or 08:02
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ what is mean? How to transter the
"root="argument to the kernel ????
Please append a correct "root=" boot option
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Kernel panic: VFS: Unable to mount root fs on 08:02
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
