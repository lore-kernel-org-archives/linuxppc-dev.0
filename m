Return-Path: <MBenedict@twacs.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6FCFEDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 08:43:12 +1100 (EST)
Received: from outbound2-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-sin-R.bigfish.com (Postfix) with ESMTP id 13F4A14F4758
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 21:43:09 +0000 (UTC)
Received: from mail45-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound2-sin.bigfish.com (Postfix) with ESMTP id E4BC7528054
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 21:43:08 +0000 (UTC)
Received: from mail45-sin (localhost.localdomain [127.0.0.1])
	by mail45-sin-R.bigfish.com (Postfix) with ESMTP id A3C0E908106
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 21:43:08 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail45-sin.bigfish.com (Postfix) with ESMTP id DFD1A13A006A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 21:43:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: U-boot with flat device tree
Date: Wed, 14 Mar 2007 16:42:49 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC27953E@twx-exch01.twacs.local>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
	Sorry, I realize this was discussed a month ago: "device tree /
how to build/compile & use with u-boot to boot uImage?"  However, I
wasn't on the list at the time.  I read through it and I thought I
understood everything.

	I am trying to get an mpc8349e-mITX to boot a recent kernel.  I
have tried all permutations of:

dtc    - development snapshot "dtc-20060419.tar.gz" and recent git
sources
U-boot - 1.2.0, git sources from denx.de, and git sources from freescale
Kernel - 2.6.20.1, 2.6.20.2, and freescale git sources

Everytime I boot U-boot will tell me the kernel uncompress find and
then... Nothing.  I passed initcall_debug to the kernel and didn't get
anything printed to the serial console.  Note that if I do not specify
the flat device tree, the kernel progresses up to the point of mounting
root.  It can't mount root because it is an NFS root and the ethernet
drivers aren't working:

0:00 not found
eth0: Could not attach to PHY

Just as you would expect (since eth0 is defined in the dts).

Just to be sure I start be building the device tree, eg:
$ dtc -I dts -O dtb -f -V 16
linux/arch/powerpc/boot/dts/mpc8349emitx.dts -o mpc8349emitx.dtb

Then, from u-Boot, download the dtb and kernel and boot:

MPC8349E-mITX> tftp 01000000 mpc8349emitx.dtb
Speed: 100, full duplex
Using TSEC0 device
TFTP from server 10.100.10.74; our IP address is 10.100.10.83
Filename 'mpc8349emitx.dtb'.
Load address: 0x1000000
Loading: #
done
Bytes transferred =3D 3976 (f88 hex)
MPC8349E-mITX> tftp 01001000 uImage
Speed: 100, full duplex
Using TSEC0 device
TFTP from server 10.100.10.74; our IP address is 10.100.10.83
Filename 'uImage'.
Load address: 0x1001000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
=20
#################################################################
         #################################
done
Bytes transferred =3D 1499510 (16e176 hex)
MPC8349E-mITX> bootm 1001000 - 1000000
## Booting image at 01001000 ...
   Image Name:   Linux-2.6.21-rc3-gb5d99e64
   Created:      2007-03-12  19:28:43 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1499446 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x1000000



<stuck>

Any ideas?
	Thank you!
		Michael
