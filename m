Message-ID: <37E8F580.BCCD20AB@sxb.bsf.alcatel.fr>
Date: Wed, 22 Sep 1999 17:28:00 +0200
From: Christophe Reinbold <Christophe.Reinbold@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Ramdisk problem with 2.3.18 on mpc8xx boards.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody


We are trying to port 2.3.18 on a mpc823 or mpc860 based FADS board.

Our board has 8 megs of ram.

Thanks you guys for the 2.3.18 kernel, we found a lot cleaning into it
specially as far as the mpc8xx is concerned.

We configure the kernel from the MBX board and patch the files
as appropriate (we think so anyway).

We correctly open ramdisk files but reading them just returns
zeroed out buffers. (Ie: open works OK then  read(fd, buf, n) returns n
or the file length if initial n was too big, the buffer itself
is filled with zeroes).

Our ramdisk seems to be OK, we are able to read the content of files
under 2.2.10.

Thanks for any idea.

PS:  log of our init.

  Now booting the kernel
  Linux version 2.3.18 (me@ill000018412x) (gcc version egcs-2.91.66
19990314 (egcs-1.1.2 release)) #53 Wed Sep 22 16:24:13 CEST 1999
  Boot arguments: console=ttyS0,9600n8
  time_init: decrementer frequency = 75000000/60
  Calibrating delay loop... 19.61 BogoMIPS
  Memory: 6964k available (748k kernel code, 448k data, 28k init)
[c0000000,c0800000]
  Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
  Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
  POSIX conformance testing by UNIFIX
  Linux NET4.0 for Linux 2.3
  Based upon Swansea University Computer Society NET3.039
  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
  NET4: Linux TCP/IP 1.0 for NET4.0
  IP Protocols: ICMP, UDP, TCP
  TCP: Hash tables configured (established 512 bind 1024)
  Starting kswapd v1.6
  CPM UART driver version 0.02
  ttyS00 at 0x0280 is a SMC
  RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
  loop: registered device at major 7
  RAMDISK: Compressed image found at block 0
  VFS: Mounted root (ext2 filesystem) readonly.
  Freeing unused kernel memory: 28k init
  Kernel panic: No init found.  Try passing init= option to kernel.

 (the init file was found but since its content is read null, the
  do_load_elf_binary function fails to find an elf header and
  correctly reject the file in question.)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
