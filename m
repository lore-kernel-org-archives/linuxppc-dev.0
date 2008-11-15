Return-Path: <cristian.axenie@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id AE784DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 12:05:41 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so1715860fke.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Nov 2008 17:05:38 -0800 (PST)
Message-ID: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
Date: Sat, 15 Nov 2008 03:05:38 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: USB Flash rootfs prep!
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14098_2881481.1226711138129"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_14098_2881481.1226711138129
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all !
I'm porting a former Control application from x86 (Linux+RTAI+Comedi) to
PowerPC (Xenomai+Comedi for RTDM). I've choosed for my development the ELDK
tool and a MPC8315ERDB platform. So I 've properly patched and build my
kernel with the Xenomai support and I get some errors when running a latency
test app. I've managed to spot the problem , that consists in an
incompatibility between the shared libraries used on the target (ver 2.5)
and the standard libraries used (and with which were compiled the kernel and
the Xenomai addon) version 2.6, and so ld screams and a SegFault appears.
Now I,ve creted an ext2.img rootfs with the rootfs.tar.gz from
/eldk/ppc_6xx/images and I've added in the rootfs some libs and other useful
stuff for Xenomai for elliminating the need for an NFS mount.
My primary concern is now to write the new FS to a USB Flash Stick so that I
can test if the latency tests works now when the libs are compatible (ver
2.6).
So resuming I want to now what are the corect steps to do this, because I've
tried to write the generated ext2.img to my USB flash stick (formated as
ext2) and added to the uBoot bootargs to the following :

setenv usbstick_args setenv bootargs root=/dev/sdb1 ro rootdelay=10
rootfstype=ext2 console=$consoledev,$baudrate;
setenv usbstick 'run usbstick_args;bootm fe500000 - fe700000'
setenv bootcmd run usbstick

As a result I get the following output :

Waiting 10sec before mounting root device...
scsi 2:0:0:0: Direct-Access     SanDisk  Cruzer Micro     0.1  PQ: 0 ANSI: 2
sd 2:0:0:0: [sdb] 2001888 512-byte hardware sectors (1025 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] 2001888 512-byte hardware sectors (1025 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI removable disk
sd 2:0:0:0: Attached scsi generic sg1 type 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k init
Warning: unable to open an initial console.
Failed to execute /bin/busybox.  Attempting defaults...
Kernel panic - not syncing: No init found.  Try passing init= option to
kernel.
Rebooting in 180 seconds..

Shall I explicitly give the init ? What should be ... init=/sbin/init,
init=/bin/busybox ????

Thanks in advance !!!

Best regards ,
Cristian

------=_Part_14098_2881481.1226711138129
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all !<br>I&#39;m porting a former Control application from x86 (Linux+RTAI+Comedi) to PowerPC (Xenomai+Comedi for RTDM). I&#39;ve choosed for my development the ELDK tool and a MPC8315ERDB platform. So I &#39;ve properly patched and build my kernel with the Xenomai support and I get some errors when running a latency test app. I&#39;ve managed to spot the problem , that consists in an incompatibility between the shared libraries used on the target (ver 2.5) and the standard libraries used (and with which were compiled the kernel and the Xenomai addon) version 2.6, and so ld screams and a SegFault appears. Now I,ve creted an ext2.img rootfs with the rootfs.tar.gz from /eldk/ppc_6xx/images and I&#39;ve added in the rootfs some libs and other useful stuff for Xenomai for elliminating the need for an NFS mount. <br>
My primary concern is now to write the new FS to a USB Flash Stick so that I can test if the latency tests works now when the libs are compatible (ver 2.6).<br>So resuming I want to now what are the corect steps to do this, because I&#39;ve tried to write the generated ext2.img to my USB flash stick (formated as ext2) and added to the uBoot bootargs to the following :<br>
<br>setenv usbstick_args setenv bootargs root=/dev/sdb1 ro rootdelay=10 rootfstype=ext2 console=$consoledev,$baudrate;<br>setenv usbstick &#39;run usbstick_args;bootm fe500000 - fe700000&#39;<br>setenv bootcmd run usbstick<br>
<br>As a result I get the following output :<br><br>Waiting 10sec before mounting root device...<br>scsi 2:0:0:0: Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; SanDisk&nbsp; Cruzer Micro&nbsp;&nbsp;&nbsp;&nbsp; 0.1&nbsp; PQ: 0 ANSI: 2<br>sd 2:0:0:0: [sdb] 2001888 512-byte hardware sectors (1025 MB)<br>
sd 2:0:0:0: [sdb] Write Protect is off<br>sd 2:0:0:0: [sdb] Assuming drive cache: write through<br>sd 2:0:0:0: [sdb] 2001888 512-byte hardware sectors (1025 MB)<br>sd 2:0:0:0: [sdb] Write Protect is off<br>sd 2:0:0:0: [sdb] Assuming drive cache: write through<br>
&nbsp;sdb: sdb1<br>sd 2:0:0:0: [sdb] Attached SCSI removable disk<br>sd 2:0:0:0: Attached scsi generic sg1 type 0<br>VFS: Mounted root (ext2 filesystem) readonly.<br>Freeing unused kernel memory: 156k init<br>Warning: unable to open an initial console.<br>
Failed to execute /bin/busybox.&nbsp; Attempting defaults...<br>Kernel panic - not syncing: No init found.&nbsp; Try passing init= option to kernel.<br>Rebooting in 180 seconds..<br><br>Shall I explicitly give the init ? What should be ... init=/sbin/init, init=/bin/busybox ????<br>
<br>Thanks in advance !!!<br><br>Best regards ,<br>Cristian<br>

------=_Part_14098_2881481.1226711138129--
