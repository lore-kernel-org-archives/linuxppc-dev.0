Message-ID: <006201c11b10$6b26dbe0$1701a8c0@paulplanet>
From: "Paul Chu" <paulchu1973@yahoo.com.tw>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hanging in Init
Date: Thu, 2 Aug 2001 12:35:47 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

    I have similar problems on my MPC8240 board with kernel 2.4.6.
After kernel mount the rootfs on the disk and execve("/sbin/init"),
the console shows as follows:
    Freeing unused kernel memory: 180k init
    INIT: version 2.77 booting
    Kernel panic: Attempted to kill init!
    Reboot in 180 seconds...
When I reboot the system and kernel runs to execve init, there is
nothing shown on the console after the "Freeing..." message. It seems
that the init program has been modified in the previous booting. And,
at this moment the console is still capable of echo any keys I pressed.
    I replace the init program with my testing progarm (staticly-linked
with libs); I found when I do fork(), the program hangs without
any messages. I added checkpoints in the kernel and found that kernel
completed sys_fork() without errors.
    My rootfs on the disk can be mounted and be kicked-off well with
kernel 2.2.17 on our board. The library is libc-2.1.3.so and ld-2.1.3.so.
My GCC is 2.95.2. The kernel booting messages are attached also.
    Does it have anything to do with memory management setup ? Please
advise me to deal with this. Any comments are welcome. Thank you.

Regards,
Paul Chu

Decompressing kernel....done.
Total memory = 64MB; using 256kB for hash table (at c01c0000)
Linux version 2.4.6 (gcc version 2.95.2 19991024 (1
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at fdf40000
time_init: decrementer frequency = 26.214400 MHz
Date from real time clock: 8/2/2001 11:1:53
Calibrating delay loop... 174.48 BogoMIPS
Memory: 62384k available (1172k kernel code, 388k data, 180k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 16) is a 16550A
ttyS01 at 0x02f8 (irq = 16) is a 16550A
block: queued sectors max/low 41397kB/13799kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 24576K size 1024 blocksize
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 18, function 0
sym53c8xx: 53c895 detected
sym53c895-0: rev 0x1 on pci bus 0 device 18 function 0 irq 20
sym53c895-0: ID 7, Fast-40, Parity Checking
sym53c895-0: SCSI bus mode change from 80 to 80.
sym53c895-0: SCSI bus mode change from c0 to c0.
scsi0 : sym53c8xx-1.7.3a-20010304
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
sym53c895-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k init
INIT: version 2.77 booting
Kernel panic: Attempted to kill init!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
