Return-Path: <pradeepsampath@yahoo.com>
Received: from web83213.mail.mud.yahoo.com (web83213.mail.mud.yahoo.com
	[216.252.101.69]) by ozlabs.org (Postfix) with SMTP id E1B5567C01
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Oct 2006 16:42:28 +1000 (EST)
Message-ID: <20061003064227.58091.qmail@web83213.mail.mud.yahoo.com>
Date: Mon, 2 Oct 2006 23:42:27 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: booting 2.6 kernel on ML403
To: Ameet Patil <ammubhai@gmail.com>, Ming Liu <eemingliu@hotmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-532025741-1159857747=:58084"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-532025741-1159857747=:58084
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Ameet/Ming!
   
  I am running linux kernel 2.6 on a ML403. Your posts on the list was extremely helpful and saved a lot of time. But i have ran into a number of issues and need your help. I have described both the scenarios.
   
  Problem 1:
  I followed the steps described in http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/
  After the kernel boots towards the end i get a failure - unknown-block(0,0)

  [    3.012128] VFS: Cannot open root device "sda2" or unknown-block(0,0)
[    3.088465] Please append a correct "root=" boot option
[    3.150933] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno
wn-block(0,0)
[    3.249891]  <0>Rebooting in 180 seconds..
   
  On the linux partition of my CF card i created the following block device files
  # mknod -m 660 console c 5 1
# mknod -m 660 sda b 254 0
# mknod -m 660 sda1 b 254 1
# mknod -m 660 sda2 b 254 2
# mknod -m 660 sda3 b 254 3
  mkdir tts
# mknod -m 660 0 b 4 64


  But the result was same as above. 
  What should be my default bootloader kernel arguments?
  console=ttyS0,9600 root=/dev/sda2
  or 
  console=ttyS0,9600 root=/dev/xsa2
  or
  console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw
   
  I am confused. How do we determine the device name of the CF card?
   
  I have 2 partitions on my CF card - Partition1 is DOS FAT16 partition, Partition2 is Linux with ext3 filesystem.

  
 
  Here is the full log of the serial terminal:
Linux/PPC load: console=ttyS0,9600 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.1 (psampath@psampath-test) (gcc version 3.4.
1) #3 Mon Oct 2 14:43:23 PDT 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 root=/dev/sda2
[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000166] Console: colour dummy device 80x25
[    0.000650] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.001465] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.014853] Memory: 62524k available (1736k kernel code, 552k data, 84k init,
 0k highmem)
[    0.104274] Security Framework v1.0.0 initialized
[    0.104471] Mount-cache hash table entries: 512
[    0.110096] NET: Registered protocol family 16
[    0.118276] NET: Registered protocol family 2
[    0.152515] IP route cache hash table entries: 512 (order: -1, 2048 bytes)
[    0.153502] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.153689] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.153787] TCP: Hash tables configured (established 2048 bind 1024)
[    0.153814] TCP reno registered
[    0.161503] VFS: Disk quotas dquot_6.5.1
[    0.161747] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.162380] Initializing Cryptographic API
[    0.162433] io scheduler noop registered
[    0.162534] io scheduler anticipatory registered (default)
[    0.162630] io scheduler deadline registered
[    0.162764] io scheduler cfq registered
[    0.773694] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
[    0.782331] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450
[    2.663867] RAMDISK driver initialized: 16 RAM disks of 300000K size 1024 blo
cksize
[    2.758159] i8042.c: No controller found.
[    2.806550] mice: PS/2 mouse device common for all mice
[    2.869032] TCP bic registered
[    2.904787] NET: Registered protocol family 8
[    2.956790] NET: Registered protocol family 20
[    3.012128] VFS: Cannot open root device "sda2" or unknown-block(0,0)
[    3.088465] Please append a correct "root=" boot option
[    3.150933] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno
wn-block(0,0)
[    3.249891]  <0>Rebooting in 180 seconds..
   
  Problem 2:
  - Untar the kernel 2.6.17.1
  - Applied the 5 TEMAC patches
  - Applied Ameet's Sysace patch 
  - copied the xparameters_ml403.h to the arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h generated by EDK
   
  - After including the network driver and sysace driver in "make menuconfig" and generating the zImage and booting the board the kernel hangs.
   
  loaded at:     00400000 0051613C
board data at: 00514124 0051413C
relocated to:  004050E8 00405100
zimage at:     00405881 005137E8
avail ram:     00517000 10000000
  Linux/PPC load: console=ttyS0,9600 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel

  I suspect the xparameter addresses are incorrect. Which parameter should i modify in the xparameters_ml403.h?
   
  Kindly send a reply at your earliest. 
  Thanks!
  Pradeep


--0-532025741-1159857747=:58084
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hello Ameet/Ming!</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am running linux kernel 2.6 on a ML403. Your posts on the list was extremely helpful and saved a lot of time. But i have ran into a number of issues and need your help. I have described both the scenarios.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Problem 1:</DIV>  <DIV>I followed the steps described in <A href="http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/">http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/</A></DIV>  <DIV>After the kernel boots towards the end i get a failure - unknown-block(0,0)<BR></DIV>  <DIV>[&nbsp;&nbsp;&nbsp; 3.012128] VFS: Cannot open root device "sda2" or unknown-block(0,0)<BR>[&nbsp;&nbsp;&nbsp; 3.088465] Please append a correct "root=" boot option<BR>[&nbsp;&nbsp;&nbsp; 3.150933] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno<BR>wn-block(0,0)<BR>[&nbsp;&nbsp;&nbsp;
 3.249891]&nbsp; &lt;0&gt;Rebooting in 180 seconds..</DIV>  <DIV>&nbsp;</DIV>  <DIV>On the linux partition of my CF card i created the following block device files</DIV>  <DIV># mknod -m 660 console c 5 1<BR># mknod -m 660&nbsp;sda b 254 0<BR># mknod -m 660 sda1 b 254 1<BR># mknod -m 660 sda2 b 254 2<BR># mknod -m 660 sda3 b 254 3</DIV>  <DIV>mkdir tts<BR># mknod -m 660 0 b 4 64<BR><BR></DIV>  <DIV>But the result was same as above. </DIV>  <DIV>What should be my default bootloader kernel arguments?</DIV>  <DIV>console=ttyS0,9600 root=/dev/sda2</DIV>  <DIV>or </DIV>  <DIV>console=ttyS0,9600 root=/dev/xsa2</DIV>  <DIV>or</DIV>  <DIV>console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am confused. How do we determine the device name of the CF card?</DIV>  <DIV>&nbsp;</DIV>  <DIV>I have 2 partitions on my CF card -&nbsp;Partition1 is&nbsp;DOS FAT16 partition, Partition2 is Linux with ext3 filesystem.<BR></DIV>  <DIV><BR>&nbsp;</DIV>  <DIV>Here
 is the full log of the serial terminal:<BR>Linux/PPC load: console=ttyS0,9600 root=/dev/sda2<BR>Uncompressing Linux...done.<BR>Now booting the kernel<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.17.1 (<A href="mailto:psampath@psampath-test">psampath@psampath-test</A>) (gcc version 3.4.<BR>1) #3 Mon Oct 2 14:43:23 PDT 2006<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=ttyS0,9600 root=/dev/sda2<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0<BR>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.000166] Console: colour dummy device 80x25<BR>[&nbsp;&nbsp;&nbsp; 0.000650] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.001465] Inode-cache hash table entries: 4096 (order: 2, 16384
 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.014853] Memory: 62524k available (1736k kernel code, 552k data, 84k init,<BR>&nbsp;0k highmem)<BR>[&nbsp;&nbsp;&nbsp; 0.104274] Security Framework v1.0.0 initialized<BR>[&nbsp;&nbsp;&nbsp; 0.104471] Mount-cache hash table entries: 512<BR>[&nbsp;&nbsp;&nbsp; 0.110096] NET: Registered protocol family 16<BR>[&nbsp;&nbsp;&nbsp; 0.118276] NET: Registered protocol family 2<BR>[&nbsp;&nbsp;&nbsp; 0.152515] IP route cache hash table entries: 512 (order: -1, 2048 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.153502] TCP established hash table entries: 2048 (order: 1, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.153689] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.153787] TCP: Hash tables configured (established 2048 bind 1024)<BR>[&nbsp;&nbsp;&nbsp; 0.153814] TCP reno registered<BR>[&nbsp;&nbsp;&nbsp; 0.161503] VFS: Disk quotas dquot_6.5.1<BR>[&nbsp;&nbsp;&nbsp; 0.161747] Dquot-cache hash table entries: 1024 (order 0, 4096
 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.162380] Initializing Cryptographic API<BR>[&nbsp;&nbsp;&nbsp; 0.162433] io scheduler noop registered<BR>[&nbsp;&nbsp;&nbsp; 0.162534] io scheduler anticipatory registered (default)<BR>[&nbsp;&nbsp;&nbsp; 0.162630] io scheduler deadline registered<BR>[&nbsp;&nbsp;&nbsp; 0.162764] io scheduler cfq registered<BR>[&nbsp;&nbsp;&nbsp; 0.773694] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing<BR>enabled<BR>[&nbsp;&nbsp;&nbsp; 0.782331] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450<BR>[&nbsp;&nbsp;&nbsp; 2.663867] RAMDISK driver initialized: 16 RAM disks of 300000K size 1024 blo<BR>cksize<BR>[&nbsp;&nbsp;&nbsp; 2.758159] i8042.c: No controller found.<BR>[&nbsp;&nbsp;&nbsp; 2.806550] mice: PS/2 mouse device common for all mice<BR>[&nbsp;&nbsp;&nbsp; 2.869032] TCP bic registered<BR>[&nbsp;&nbsp;&nbsp; 2.904787] NET: Registered protocol family 8<BR>[&nbsp;&nbsp;&nbsp; 2.956790] NET: Registered protocol family
 20<BR>[&nbsp;&nbsp;&nbsp; 3.012128] VFS: Cannot open root device "sda2" or unknown-block(0,0)<BR>[&nbsp;&nbsp;&nbsp; 3.088465] Please append a correct "root=" boot option<BR>[&nbsp;&nbsp;&nbsp; 3.150933] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno<BR>wn-block(0,0)<BR>[&nbsp;&nbsp;&nbsp; 3.249891]&nbsp; &lt;0&gt;Rebooting in 180 seconds..</DIV>  <DIV>&nbsp;</DIV>  <DIV>Problem 2:</DIV>  <DIV>- Untar the kernel 2.6.17.1</DIV>  <DIV>- Applied the 5 TEMAC patches</DIV>  <DIV>- Applied Ameet's Sysace patch </DIV>  <DIV>- copied the xparameters_ml403.h to the arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h generated by EDK</DIV>  <DIV>&nbsp;</DIV>  <DIV>- After including the network driver and sysace driver in "make menuconfig" and generating the zImage and booting the board the kernel hangs.</DIV>  <DIV>&nbsp;</DIV>  <DIV>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 0051613C<BR>board data at: 00514124 0051413C<BR>relocated to:&nbsp; 004050E8
 00405100<BR>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00405881 005137E8<BR>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00517000 10000000</DIV>  <DIV>Linux/PPC load: console=ttyS0,9600 root=/dev/sda2<BR>Uncompressing Linux...done.<BR>Now booting the kernel<BR></DIV>  <DIV>I suspect the xparameter addresses are incorrect. Which parameter should i modify in the xparameters_ml403.h?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Kindly send a reply at&nbsp;your earliest. </DIV>  <DIV>Thanks!</DIV>  <DIV>Pradeep<BR></DIV>
--0-532025741-1159857747=:58084--
