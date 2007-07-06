Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0CBABDDEEF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 22:48:03 +1000 (EST)
Date: Fri, 6 Jul 2007 14:47:57 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Too verbose compat_ioctl messages?
Message-ID: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-186828651-1183726077=:1203"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-186828651-1183726077=:1203
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi,

Fuse-san discovered that running the umount that's part of busybox on a PS3
with a recent kernel causes an error message to be printed on the console:

| ioctl32(busybox:1340): Unknown cmd fd(3) cmd(00004c01){t:'L';sz:0} arg(00000000) on /dev/sda1 

On older kernels (e.g. 2.6.16), this doesn't happen.

It can easily be reproduced by installing busybox and running

| busybox umount /mountpoint

on a mounted filesystem (except when using the loop device).

Apparently Busybox uses the LOOP_CLR_FD ioctl when unmounting a file system,
which is supported by the loop device only.
On other block device types, this ioctl is not supported:
  - With a 64-bit application, the block layer returns ENOTTY (Inappropriate
    ioctl for device), while the SCSI layer returns EINVAL (Invalid argument)
  - With a 32-bit application, the compat_ioctl code returns EINVAL (Invalid
    argument) and prints an error on the console (for the first 50
    occurrencies, cfr. fs/compat_ioctl.c:compat_sys_ioctl())

As I understand, compat_ioctl_error() is used to inform the user about ioctl
values that are not yet handled by the compat_ioctl layer. However, LOOP_CLR_FD
doesn't need to be handled (no data to convert between 32-bit and 64-bit), and
it's perfectly valid for a block device to not implement it.
So it's confusing to print this error message.

Is there anything we can do about this?

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-186828651-1183726077=:1203--
