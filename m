Date: Thu, 8 Jul 2004 17:33:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: having to configure SCC1 for serial port just to boot??
Message-ID: <Pine.LNX.4.60.0407081710340.19557@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1970997819-1089321480=:19557"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1970997819-1089321480=:19557
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.60.0407081719551.23215@localhost.localdomain>


   on to the next issue.  850DE-based board with

   SMC1:	console

   SCC2: DSP
   SCC3: ethernet

(yes, we're going to have to install a patch to have SMC1 and SCC3
simultaneously, but that's the subject for a later post.)

   for now, just to get the system to boot to the command line, i set
the following:

Device drivers
   Character devices
     Serial drivers

     <*> CPM2 SCC/SMC serial port support
     [*]   Support for console on CPM2 SCC/SMC serial port
     [ ]   Support for SCC1 serial port
     [ ]   Support for SCC2 serial port
     [ ]   Support for SCC3 serial port
     [ ]   Support for SCC4 serial port
     [*]   Support for SMC1 serial port  <-- my console
â   [ ]   Support for SMC2 serial port

and

MPC8xx CPM Options

   [*] CPM SCC Ethernet
         SCC used for Ethernet (SCC2)  --->
         [ ] 860T FEC Ethernet
         [ ] Use Big CPM Ethernet Buffers
         [ ] Use UART               <-- not sure about this ...
         ...

note the deliberately erroneous choice of SCC2 for ethernet, just to
avoid the conflict between SMC1 and SCC3 for now.  just means i won't
really have networking.  compile, load, boot:

===========================================
Linux/PPC load: rw root=/dev/ram0   (do i need console= ??)
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.7 (rpjday@localhost.localdomain) (gcc version 3.2.2
20030217 4On
node 0 totalpages:
8192
   DMA zone: 8192 pages, LIFO batch:2
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: rw root=/dev/ram0
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28592k available (1416k kernel code, 364k data, 72k init, 0k
highmem)
Calibrating delay loop... 47.23 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like
an initrd
Freeing initrd memory: 1913k freed
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:00:00
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 72k init
... and hang ...
=========================================================

   now, just for fun and no reason whatever, add support for an SCC1
serial port:

   <*> CPM2 SCC/SMC serial port support
     [*]   Support for console on CPM2 SCC/SMC serial port
     [*]   Support for SCC1 serial port    <--- add this option

NOTE:  AFAIK, this board doesn't even *have* SCC1, so this is
apparently a meaningless change.  and yet, the result:

===========================================================
Linux/PPC load: rw root=/dev/ram0
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.7 (rpjday@localhost.localdomain) (gcc version 3.2.2
20030217 4On node 0 totalpages: 8192
   DMA zone: 8192 pages, LIFO batch:2
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: rw root=/dev/ram0
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28592k available (1416k kernel code, 364k data, 72k init, 0k
highmem)
Calibrating delay loop... 47.23 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like
an initrd
Freeing initrd memory: 1913k freed
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:00:00
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
... and a successful boot.
===============================================================

   thoughts?  why should adding support for a (non-existent) SCC1
serial port suddenly fix things?  i'm baffled.

rday

p.s.  running "ifconfig" after boot shows:

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:EC:00:00:00
           inet addr:20.0.0.2  Bcast:20.255.255.255  Mask:255.0.0.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Base address:0x3d00

but, not surprisingly, networking doesn't actually work since i
deliberately selected SCC2 which is wrong.  but one thing at a time.









































--8323328-1970997819-1089321480=:19557--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
