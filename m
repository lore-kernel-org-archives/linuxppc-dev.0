Message-ID: <3E675B9A.1107D89@cdotd.ernet.in>
Date: Thu, 06 Mar 2003 07:30:51 -0700
From: Rahul Dev <rahuld@cdotd.ernet.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: initrd problem: unable to read from /dev/initrd
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    I m using  ads m8260 board and trying to run  linux2.5.9  over it.
    I  have got  16MB of  RAM.

    I have compiled the kernel with KERNELBASE= 0xc0000000.
    In my .config file i have set
    CONFIG_BLK_DEV_RAM=y
    CONFIG_BLK_DEV_RAM_SIZE=4096
    CONFIG_BLK_DEV_INITRD=y

    I load the kernel at physical address 0x00 in ram using debugger.
    Then i load the ramdisk image (4 MB in size) at address 0xa00000
using my debugger.

    Then  before passing te control to the _start() of kernel  i  set
     r3=0, r4=0xa00000(start of initrd) , r5=0xe00000(end of initrd)
r6=0, r7=0.

     I get the following prints:
=======================================================
Linux version 2.5.9 (rahuld@hpv2k-35) (gcc version 3.0.4) #1
Mon Mar 3 19:52:09 IST 2003
On node 0 totalpages: 4095
zone(0): 4095 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Warning: real time clock seems stuck!
Calibrating delay loop... 88.67 BogoMIPS
Memory: 10956k available (812k kernel code, 300k data, 44k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
ttyS1 on SCC2 at 0x8100, BRG2
Serial driver version 5.05c (2001-07-08) with no serial options enabled
block: 64 slots per queue, batch=16
eth0: FCC ENET Version 0.3, 00:00:00:80:00:00
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4096k freed
kernel BUG at page_alloc.c:222:22
==========================================================

On analyzing , i found  that the ramdisk image was loaded properly at
0xa00000,
but in the function  "identify_ramdisk_image()" when i try to read the
first block from
/dev/initrd, i could read only  16 bytes correctly, rest all bytes are
junk.
Can anybody please point out why am i read  only first 16 bytes
correctly from /dev/initrd.

If  instead of reading 512 bytes i  read  only 16 bytes at a time   32
times  ( 16 * 32 =512) i get the correct
results.

thanx and reagrds,
rahul


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
