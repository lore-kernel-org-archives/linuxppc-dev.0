Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id EC60F67AC7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 08:17:26 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1470543wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 15:17:22 -0700 (PDT)
Message-ID: <c3d0340b0504251517589940b8@mail.gmail.com>
Date: Mon, 25 Apr 2005 15:17:22 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: 2.6.10 unable to mount a root fs on ramdisk
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Tried to mount a root fs on ramdisk on an ebony board but the
following error shows up.

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1=
,0)

There may be a simple answer for this common error. But I haven't
found out it after googling for a while. I remember I had a similar
problem when trying to mount a jffs2 as the root fs. The solution is
to add rootfstype=3Djffs2. I downloaded the ramdisk image from DENX's
ftp site. So I'm sure the image itself has no problem.

I already enabled RAMDISK and initrd support in kernel configuration.

=3D> run ramroot
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.10
   Created:      2005-02-23  18:40:02 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    887207 Bytes =3D 866.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FA9CC0 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFC10
bd address  =3D 0x07FAAF90
memstart    =3D 0x00000000
memsize     =3D 0x08000000
flashstart  =3D 0xFF800000
flashsize   =3D 0x00480000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000005
intfreq     =3D    400 MHz
busfreq     =3D 133.333 MHz
baudrate    =3D   9600 bps
## Loading RAMDisk Image at 00600000 ...
   Image Name:   Simple Embedded Linux Framework
   Created:      2002-10-24   9:30:38 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1476478 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x00600040 ... 0x007687BD (len=3D1476478=3D0x16877E)
   Loading Ramdisk to 07e41000, end 07fa977e ... OK
## Transferring control to Linux (at address 00000000) ...
Linux version 2.6.10  (gcc version 3.3.3 (DENX ELDK 3.1 3.3.3-8)) #1 We
d Feb 23 10:34:11 PST 2005
IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
<SNIPPED>
NET: Registered protocol family 1
NET: Registered protocol family 17
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1=
,0)

Thanks,
-Shawn.
