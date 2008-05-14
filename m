Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9EB48DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 04:37:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: xilinx_hwicap driver problems
Date: Wed, 14 May 2008 11:37:29 -0700
In-reply-to: <3ee6f9e50805140903o381346f5kddbce29a3d06ba1f@mail.gmail.com>
References: <3ee6f9e50805140903o381346f5kddbce29a3d06ba1f@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Will Kritikos" <will.kritikos@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080514183731.04FE920053@mail163-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I bet you're using ARCH ppc...

It looks like in arch/ppc/syslib/virtex_devices.c:

#define XPAR_HWICAP(num) { \
	.name =3D "xilinx_icap", \

Should probably be:

#define XPAR_HWICAP(num) { \
	.name =3D "icap", \

now.

Can you make this change locally and verify that it solves the problem?

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Will
Kritikos
> Sent: Wednesday, May 14, 2008 9:03 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: xilinx_hwicap driver problems
>=20
> I am having some trouble using the xilinx_hwicap driver in Linux.
> I am using version 2.6.24-rc8-xlnx of the Linux kernel from the Xilinx
> GIT repository.
> The xilinx_hwicap driver is statically compiled in - not a loadable
module.
> I am using the opb_hwicap device on a V4FX60 FPGA, Linux running on
the PPC405.
>=20
> The driver successfully is initialized on boot - I added a printk to
> the init function to verify this.   However, as far as I can tell, the
> probe function is never called.  There is nothing in dmesg from the
> icap driver.
>=20
> After boot, the following files exist in /sys
>=20
> /sys/bus/platform/xilinx_icap.0
> /sys/bus/platform/drivers/icap/bind
> /sys/bus/platform/drivers/icap/uevent
> /sys/bus/platform/drivers/icap/unbind
> /sys/devices/platform/xilinx_icap.0
>=20
> I can make a device node /dev/icap, major number 259 minor number 0,
> and copy partial bitstreams to it, but again nothing happens, and no
> output in dmesg.
>=20
> Any help is appreciated.  I am probably overlooking something simple.
>=20
> Thanks,
> Will Kritikos
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be=
 proprietary, privileged or copyrighted under applicable law. If you are=
 not the intended recipient, do not read, copy, or forward this email=
 message or any attachments. Delete this email message and any attachments=
 immediately.
