Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5C080DE22B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 04:50:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx  PowerPC
Date: Thu, 21 Feb 2008 09:50:23 -0800
In-Reply-To: <47BD212B.6090809@dlasys.net>
References: <47BD212B.6090809@dlasys.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20080221175025.7817BBD8057@mail91-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of David H.
Lynch Jr.
> Sent: Wednesday, February 20, 2008 10:59 PM
> To: Grant Likely; linuxppc-embedded
> Subject: Xilinx PowerPC
>=20
>=20
>     So when you have Xilinx under powerpc working, do we pull it from
your
>     git tree or the xilinx one ?
>=20
>     Will there be an announcement ?
>=20
>     How about a one paragraph getting started guide to moving a xilinx
> ppc bsp to
>     xilinx powerpc.
>=20
>     Like  ?
>=20
>     step 1).
>              Generate a dts - gen-mhs-devicetree ?
>              And pass it to through your boot loader to Linux ?

http://git.xilinx.com/gen-mhs-devtree.git contains two utilities for
generating device trees from EDK projects.  The older option is a python
script, originally written by Grant.  The newer (and probably more
mature at this point) option is an EDK BSP generator for u-boot,
originally written by Michal Simek.  Preferably this gets passed from a
uboot, although it's also possible to compile it into the kernel.
Currently, the uboot option is somewhat annoying because there's not a
good surefire way for getting uboot up and running on an EDK design.
(Unfortunately, the EDK BSP generator is incomplete, and the uboot
support for virtex needs some work to get it integrated as well).

>     Step 2).
>              the code in arch/powerpc/???? is the devicetree equvalent
to
>              arch/ppc/platforms/4xx/xilinx_ml410.c
http://git.xilinx.com/linux-2.6-xlnx.git contains a preliminary stab at
the bootcode for Virtex.  I've been using this for a while with
ARCH=3Dpowerpc.  There isn't really much need for board specific =
platform
code: This should (I think) be handled by the device tree.  All of this
is still pretty preliminary at the moment however.  The big problem with
the boot code in the Xilinx tree is that you need to be able to allocate
memory in order to parse the device tree in order to figure out how much
memory you have.  I just haven't rewritten the code to use libfdt, which
can query the device tree without memory allocation yet.  Grant has a
slightly different scheme in his tree, but it works as well.  Generally
I've been more focused on avoiding u-boot, whereas Grant has been using
u-boot exclusively, I think.

>     Step 3).
>              device drivers need to change initialization/setup from
>              ???? to ???
All the xilinx drivers in mainline and most of the ones in the
git.xilinx.com tree export both platform device and of_device
interfaces.  You should be able to look at any of them to figure out a
good way of adding of_device support to a driver.  the ll_temac is by
far the most complex instance of this, which has to do some non-trivial
traversal of the device tree to discover the information it needs about
it's interface to memory.

So, the short answer is, you might be able to get it to work today, but
the code isn't in shape for mainline yet.

Steve
