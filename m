Message-ID: <3A811BA3.C2793FA3@tei.ericsson.se>
Date: Wed, 07 Feb 2001 10:55:47 +0100
From: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
CC: "Giacomo Borlizzi (TEI)" <giacomo.borlizzi@tei.ericsson.se>
Subject: get_pgd_slow() function
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hey, now I've reach some milestone!!!!

output is:
=> go 400000
## Starting application at 0x00400000 ...
loaded at:     00400000 0040B1D4
relocated to:  00180000 0018B1D4
board data at: 001801B8 001801D4
relocated to:  003F0100 003F011C
zimage at:     00406000 0047A8AA
initrd at:     0047A8AA 00621C0A
avail ram:     00622000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.1 (teigibo@italia) (gcc version 2.95.2 19991024
(release)) #21 Wed Feb 7 09:49:31 MET 2001
Boot arguments: root=/dev/ram
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
time_init: decrementer frequency = 300000000/60
Calibrating delay loop... 79.66 BogoMIPS
Memory: 13072k available (912k kernel code, 348k data, 48k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 8602kB/2867kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2, 00:00:f6:00:5e:76
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194300k freed
PPP generic driver version 2.4.1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Sending RARP requests.... OK
IP-Config: Got RARP answer from 141.137.74.233, my address is
141.137.74.235
IP-Config: Guessing netmask 255.255.0.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 48k

.. :(((

and I don't have any output... board seems dead.....
After some debugging (nights, cakes, beers, wines ecc...)
I discovered that modifing the function "get_pgd_slow" in   file
include/asm-ppc/pgalloc.h
it works and obtaining the output of shell..... or bash or sash
depending wich
file system I use.

The original function is:


extern __inline__ pgd_t *get_pgd_slow(void)
{
 pgd_t *ret, *init;
 /*if ( (ret = (pgd_t *)get_zero_page_fast()) == NULL )*/
 if ( (ret = (pgd_t *)__get_free_page(GFP_KERNEL)) != NULL )
  memset (ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 if (ret) {
  init = pgd_offset(&init_mm, 0);
  memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
   (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 }
 return ret;
}


but I've modified with:


extern __inline__ pgd_t *get_pgd_slow(void)
{
 pgd_t *ret, *init;
 /*if ( (ret = (pgd_t *)get_zero_page_fast()) == NULL )*/
 if ( (ret = (pgd_t *)__get_free_page(GFP_KERNEL)) != NULL )
  memset (ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 if (ret) {
  init = pgd_offset(&init_mm, 0);
                memcpy (ret, init, USER_PTRS_PER_PGD * sizeof(pgd_t));
/*GB*/
  memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
   (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 }
 return ret;
}

So I have add just a line.
The linux version that I use is 2.4.1 but the same problem is on the
2.2.13

Is it just an error or it is a bad configuration that I have in my
develop tree?
In the last one case how can I repair it?
some suggestion on it?

Thank you also for previous answer that I have received.
ciao,
/Giacomo Borlizzi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
