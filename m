Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9CC2DE1C9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 06:00:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx EDK 9.2i and current Linux src tree(s)
Date: Mon, 10 Mar 2008 11:57:02 -0700
In-Reply-To: <ADA5878BA63680469C75C14CEEE2FE28012F4DBA@mail.serveron.com>
References: <ADA5878BA63680469C75C14CEEE2FE28012F4DBA@mail.serveron.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Phil Hochstetler" <Phil.Hochstetler@serveron.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080310185704.DACCC468086@mail34-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


You should copy the xparameters file into the Linux kernel tree.

Although the overall structure of the file is very different from EDK
7.1, and many names are different when using the xps* IP in EDK 9.2, the
names that are used by the kernel (in arch/ppc/syslib/virtex_devices.c)
should be defined correctly (as long as you use the linux-2.6 BSP).

Under no circumstances would I ever recommend editing that file by hand.
If you modify the design, you should regenerate the xparameters file and
copy it into your kernel.  Furthermoe, the file that is in the kernel is
for a standard reference design, and unless you are using this reference
design, you *must* copy the xparameters file for your design.  The
kernel from git.xilinx.com already has all the drivers, all you need is
the one file.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Phil
Hochstetler
> Sent: Monday, March 10, 2008 11:34 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Xilinx EDK 9.2i and current Linux src tree(s)
>=20
> Thanks to responses from this group, I'm using Ubuntu and ELDK 4.1, I
have a working environment to
> build a linux kernel for a Xilinx ML403 board.  I pulled the kernel
source at
> git://git.xilinx.com/linux-2.6-xlnx.git
<http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-
> xlnx.git;a=3Dsummary>  and while it will compile using "make =
ARCH=3Dppc
ml403_defconfig" and "make
> ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- bzImage", when I use the EDK 9.2i =
to
create a bitstream for the ML403
> board, the BSP based header files (xparam*) files are out of sync with
the kernel source.  The files
> in the linux-2.6-xlnx tree appear to have been build with EDK 7.1 and
I am using the current EDK
> release 9.2i.  The major diff seems to be that the new EDK release
moves all the periphials off the
> OPB bus and uses the XPS bus instead.  Any ideas on how best to
resolve this?  Is there a linux tree
> out there that is synced with the current EDK release?   Is it
sufficient to had edit in the hardware
> address in the existing OPB based file and ignore the differences
between OPB and XPS?   Is the
> difference in name only?  Should I just try to pick up the entire
linux tree from the EDK release and
> drop it on the linux kernel?  Has anyone else been down this path
already?  Thanks for any words of
> wisdom.
>=20
> --phil
