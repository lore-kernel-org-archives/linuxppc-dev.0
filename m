To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot time with several filesystems on RPXlite DW 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Aug 2004 22:54:54 +0800."
             <20040809145454.46774.qmail@web15609.mail.cnb.yahoo.com>
Date: Tue, 10 Aug 2004 09:41:46 +0200
Message-Id: <20040810074151.80522C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040809145454.46774.qmail@web15609.mail.cnb.yahoo.com> you wrote:
>
> I used several filesystems based on MTD vs ramdisk to test boot time
> on RPXlite DW and got the following result:
...
> It seemed that Cramfs filesystem could get the most fast boot
> time.Also No matter how I tried,the boot time still exceeded 12
> seconds at least.But this result is not the same as Wolfgang said,5~6
> seconds boot time on 8xx board with 50MHZ core and bus frequency.Where
> did I go wrong?

There are many potential problems.

One thing that is obvious is:

You use an uncompressed kernel image, but have the CRC32 checksumming
enabled. This is counterproductive - the uncompressed image is nearly
3 times as big as a compressed one,  so  checksumming  it  will  take
about 3 times as long.

If you want to go for speed and use an uncompressed image, you should
also  turn  off  the  CRC  checksum  test  (by  setting  the   U-Boot
environment variable "verify" to "no").

Then you may try increasing  the  console  baudrate,  or  suppressing
console  output  completely  (pass console=null to the Linux kernel).
Other issues are system dependent. Your system may not  be  optimized
for  minimum  access times for SDRAM and/or flash memory. Your system
might not be using 32 bit buswidth on SDRAM and/or flash. You may  be
running  on a processor which is slower because of small caches (like
a MPC850), etc. etc.

> I would be satisfied with less than 8 seconds in my case.Any ideas?

This is what I get using:

* A MPC860-T at 50 MHz CPU/50 MHz bus, 16 MB RAM.
* Our standard Linux kernel (uncompressed)
* Our standard (uncompressed) SELF image as included with the ELDK
* CRC32 verification turned off

   0.000 START_TEST
   0.090 ## Booting image at 40040000 ...
   0.090    Image Name:   Linux-2.4.4 uncompressed
   0.091    Created:      2004-08-10   7:21:20 UTC
   0.091    Image Type:   PowerPC Linux Kernel Image (uncompressed)
   0.091    Data Size:    1438656 Bytes =  1.4 MB
   0.091    Load Address: 00000000
   0.120    Entry Point:  00000000
   0.200 OK
   0.201 ## Loading RAMDisk Image at 40200000 ...
   0.201    Image Name:   Simple Embedded Linux Framework
   0.201    Created:      2004-08-10   7:23:35 UTC
   0.201    Image Type:   PowerPC Linux RAMDisk Image (uncompressed)
   0.201    Data Size:    4194304 Bytes =  4 MB
   0.270    Load Address: 00000000
   0.270    Entry Point:  00000000
   0.590    Loading Ramdisk to 00bad000, end 00fad000 ... OK
   0.981 Linux version 2.4.4 (wd@atlas.denx.de) (gcc version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #2 Thu Jul 22 19:12:37 MEST 2004
   0.981 On node 0 totalpages: 4096
   0.981 zone(0): 4096 pages.
   0.981 zone(1): 0 pages.
   0.981 zone(2): 0 pages.
   1.010 Kernel command line: root=/dev/ram rw ip=192.168.3.71:192.168.3.1::255.255.0.0:tqm8xx:eth0:off panic=1
   1.010 Decrementer Frequency: 3125000
   1.140 Calibrating delay loop... 49.86 BogoMIPS
   1.140 Memory: 10356k available (1144k kernel code, 440k data, 52k init, 0k highmem)
   1.201 Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
   1.201 Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
   1.201 Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
   1.201 Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
   ...
   2.515 TQM flash bank 0: Using static image partition definition
   2.515 Creating 4 MTD partitions on "TQM8xxL Bank 0":
   2.516 0x00000000-0x00040000 : "u-boot"
   2.516 0x00040000-0x00100000 : "kernel"
   2.516 0x00100000-0x00200000 : "user"
   2.516 0x00200000-0x00400000 : "initrd"
   2.516 TQM flash bank 1: Using static file system partition definition
   2.516 Creating 2 MTD partitions on "TQM8xxL Bank 1":
   2.516 0x00000000-0x00200000 : "cramfs"
   2.516 0x00200000-0x00400000 : "jffs"
   2.516 NET4: Linux TCP/IP 1.0 for NET4.0
   2.516 IP Protocols: ICMP, UDP, TCP
   2.517 IP: routing cache hash table of 512 buckets, 4Kbytes
   2.517 TCP: Hash tables configured (established 1024 bind 2048)
   2.517 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
   2.517 VFS: Mounted root (ext2 filesystem).
   2.517 Freeing unused kernel memory: 52k init
   6.533 ### Application running ...

Without any further optimization (like throwing out  unused  drivers,
disabling  slow  console  output,  using  pre-calculated jiffies-per-
second etc.) your "phase I" is less than 1 second,  your  phase  "II"
takes about 2.5 seconds, and your "phase III" takes 6.5 seconds - but
this is our standard image, which includes some slow operations (like
starting  xinetd)  which  I  normally woould try to avoid or at least
pospone until the  critical  parts  of  the  applications  have  been
started.  By  just  disabling xinetd you will see a boot time of 4..5
seconds on this system.

And as mentioned there is a long list of options to optimize the boot
time.

As you can see there is no magic involved.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: can't find /

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
