Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 270A1DDED5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 05:06:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Simple driver for Xilinx SPI controler.
Date: Wed, 6 Jun 2007 12:06:38 -0700
In-Reply-To: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20070606190640.B7028900053@mail104-cpk.bigfish.com>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> > config XILINX_EDK
> >         bool
> >         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
> >         default y
>=20
> I don't have any problem with adding XILINX_EDK (or=20
> whatever), but think particular layout is back-assward. =20
> Rather than XILINX_EDK depending on XILINX_VIRTEX/MICROBLAZE,=20
> XILINX_VIRTEX/MICROBLAZE should 'select' XILINX_EDK and you=20
> need to drop the 'default y' line.
> Otherwise the XILINX_EDK option shows up in non-edk config files.

Good point...
=20
> Why still have XILINX_EDK?  I thought you meant replace=20
> XILINX_EDK with XILINX_DRIVERS.

Yes, that's what I was suggesting.
But I think that Andrei still wants to use XILINX_EDK to pull in the
stuff in drivers/xilinx_common.

# The Xilinx OS common code=20
obj-$(CONFIG_XILINX_EDK) +=3D xbasic_types.o xpacket_fifo_l_v2_00_a.o \
			    xpacket_fifo_v2_00_a.o xversion.o \
			    xdma_channel.o xdma_channel_sg.o

Which you wouldn't want if you were able to build a kernel completely
from 'non-edk' drivers.

Steve
