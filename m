Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9B491DE01E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 04:52:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: i2c device for a linux 2.6 in XUPV2P
Date: Wed, 9 Jan 2008 09:52:18 -0800
References: <ef1737dc0712241327t3cc7c14kcb91e9a4e550df18@mail.gmail.com> 
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Josep Maria Batlle" <jepmalinux@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080109175219.C0C31168005B@mail1-blu.bigfish.com>
Cc: git <git@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Yes, it should be possible, however I don't believe the Linux adapter
for the i2c driver has been updated for current 2.6 kernel versions.
It's not currently on git.xilinx.com, and apparently the i2c subsystem
has changed significantly since the adapter was written, so it's not a
straightforward update.

If all you want to do is some simple configuration, then bitbanging the
i2c is straightforward.  I'll send you a driver that I cooked up at one
point in a separate email.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Josep =
Maria
Batlle
> Sent: Monday, December 24, 2007 1:27 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: i2c device for a linux 2.6 in XUPV2P
>=20
> Hi all,
>=20
> I have booted up linux 2.6 on Xilinx XUPV2P (using the base of ml300
config file).
> Now I am trying to use the i2c in the user-space. First of all: is it
possible?
>=20
> My first attempts have not worked. I have made this:
> 1) I enable "I2C Support" and "I2C device interface" in the kernel
recompilation.
> 2) I added the "i2c-0" device in /dev (# mknod i2c-0 c 89 0)
> 3) then I run a simple program to open the device (provided by the
"dev-interface" file of i2c kernel
> documentation) that returns this errno message: "No such device".
>=20
> I have tried to use the device number 1, 2, 3, 4 but these have not
worked. I have tried to use the
> device "i2cn" but not worked. I have tried to use all the BSP's from
the EDK (7.1i) and then only the
> "xparameters_ml300.h" in the compilation. After all of this, now I am
modifying the RFS for "mdev"...
> Somebody can tell me what I am doing wrong if this use is possible?
>=20
> I use the kernel tree "virtex-for-2.6.24" from SecretLab and Busybox
1.7.2.
>=20
> Thanks.
