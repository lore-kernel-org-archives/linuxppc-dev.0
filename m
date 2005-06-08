Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (exchange.tsi-telsys.com
	[205.230.130.11]) by ozlabs.org (Postfix) with ESMTP id 22BEE67B21
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 01:36:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 8 Jun 2005 11:36:27 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7BA5@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Mark Chambers" <markc@mail.com>,
	"Peter Ryser" <peter.ryser@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: root fs mount issue: Xilinx System ACE on PCI bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Mark and Peter for your responses.

I was not using devfs filesystem earlier. I included that in the kernel =
build and set the "root=3D" in the bootargs to "/dev/xsysace/disc0/part2 =
rw". A similar string I found in Xilinx ML300 documentation. It worked !

Thanks Again.
Sanjay



-----Original Message-----
From: Mark Chambers [mailto:markc@mail.com]
Sent: Tuesday, June 07, 2005 8:48 PM
To: Sanjay Bajaj
Subject: Re: root fs mount issue: Xilinx System ACE on PCI bus


Arggh, sorry, I told you wrong.  It's "rootfstype=3D".  Also, I see that =
the
command list I use (which came from u-boot) also has "noinitrd" in it.  =
The
whole line is (just for a reference):

root=3D/dev/mtdblock0 rw noinitrd rootfstype=3Djffs2
ip=3D192.168.1.4:192.168.1.6:192.168.1.1:255.255.255.0:iView:eth0:off =
panic=3D1

I'm using devfs - are you?

----- Original Message -----=20
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Mark Chambers" <markc@mail.com>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, June 07, 2005 1:02 PM
Subject: RE: root fs mount issue: Xilinx System ACE on PCI bus


Hi! Mark,

I did put in "rootfs=3Dext3", but, the result is still the same.

Sanjay

-----Original Message-----
From: Mark Chambers [mailto:markc@mail.com]
Sent: Tuesday, June 07, 2005 11:51 AM
To: Sanjay Bajaj
Subject: Re: root fs mount issue: Xilinx System ACE on PCI bus


Well, I'm no guru, but you could try adding a 'rootfs=3D" option to your
kernel command line (rootfs=3Djffs2, for instance, or ext2).  Perhaps =
the
kernel is not able to automatically determine the filesystem.  When you
'mount' you explicitly tell the kernel what kind of file system is on =
the
device.

Mark Chambers

----- Original Message -----=20
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, June 07, 2005 11:05 AM
Subject: root fs mount issue: Xilinx System ACE on PCI bus


Hi! Gurus,

Need some help in understanding root fs mounting. The setup we have here =
is
our hardware has Xilinx Virtex II pro chip that has System ACE hardware
connected to a compact flash. The Virtex II Pro is connected to Local =
PCI
bus which is run by PPC 440GX processor. I have ported the driver for
xsysace from ml300 config to our hardware (From OPB to PCI). When I boot
over nfs, I can easily mount the partictions on the compact flash. The =
nodes
in /dev directory are:

brw-r--r--    1 root     root     254,   0 Jun  3 13:04 xsysacea
brw-r--r--    1 root     root     254,   1 Jun  3 13:04 xsysacea1
brw-r--r--    1 root     root     254,   2 Jun  3 13:04 xsysacea2

When I try to boot from the commpact flash, the kernel panics. The =
edited
boot listing is as follows:

=3D> bootm
...
...
Kernel command line: root=3D/dev/xsysacea2 rw console=3DttyS0,9600 =
mem=3D128M
...
...
Partition check:
 xsysacea: xsysacea1 xsysacea2
System ACE at 0xFFFC1000 mapped to 0xD2070000, irq=3D26, 500472KB
...
...
VFS: Cannot open root device "xsysacea2" or 00:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00
 <0>Rebooting in 180 seconds..

-------

What am I missing here? Any help is appreciated.
Thanks,
Sanjay
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
