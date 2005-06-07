Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (exchange.tsi-telsys.com
	[205.230.130.11]) by ozlabs.org (Postfix) with ESMTP id 766CF67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 01:05:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 7 Jun 2005 11:05:08 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7BA4@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: root fs mount issue: Xilinx System ACE on PCI bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi! Gurus,

Need some help in understanding root fs mounting. The setup we have here =
is our hardware has Xilinx Virtex II pro chip that has System ACE =
hardware connected to a compact flash. The Virtex II Pro is connected to =
Local PCI bus which is run by PPC 440GX processor. I have ported the =
driver for xsysace from ml300 config to our hardware (From OPB to PCI). =
When I boot over nfs, I can easily mount the partictions on the compact =
flash. The nodes in /dev directory are:

brw-r--r--    1 root     root     254,   0 Jun  3 13:04 xsysacea
brw-r--r--    1 root     root     254,   1 Jun  3 13:04 xsysacea1
brw-r--r--    1 root     root     254,   2 Jun  3 13:04 xsysacea2

When I try to boot from the commpact flash, the kernel panics. The =
edited boot listing is as follows:

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
