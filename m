Return-Path: <chrisw@cristie.com>
Received: from exchangesrv.cristie.co.uk (ip02.christiedata.adsl.gxn.net
	[195.147.204.218]) by ozlabs.org (Postfix) with ESMTP id DA4F7DDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 21:28:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Cannot open ramdisk
Date: Tue, 10 Apr 2007 12:16:09 +0100
Message-ID: <E1AF14BEE9B355499E146B179F69E9AF152EB6@exchangesrv.cristie.co.uk>
From: "Chris West" <chrisw@cristie.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a problem with booting a kernel and ramdisk from CDROM on pSeries =
630 6E4.

I have compiled my 2.6.18-1.2798.fc6 kernel with:

CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D65536
CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
CONFIG_BLK_DEV_INITRD=3Dy

My yaboot.conf file looks like this:

init-message=3Dlinux
timeout=3D300
default=3Dlinux
image=3Dppc/chrp/kernel
        label=3Dlinux
        initrd=3Dppc/chrp/system
        root=3D/dev/ram0
        append=3D"console=3DttyS0"

My ramdisk is a compressed 64MB ext3 filesystem in /ppc/chrp/system

After the kernel has booted I get the following message:

VFS: Cannot open root device "ram0" or unknown-block(1,0)
Please append a correct "root=3D" boot option

I've read that only uncompressed kernels can load a ramdisk, is this =
still the case?
I have tried using an uncompressed kernel with the same results.

Can anyone tell me why my ramdisk isn't being loaded?

Thanks
Chris
