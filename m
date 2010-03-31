Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 971BCB7C09
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 15:46:54 +1100 (EST)
Subject: Re: [RFC v3] net: add PCINet driver
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20081105212225.GA17821@ovro.caltech.edu>
Date: Tue, 30 Mar 2010 23:46:29 -0500
Message-Id: <E924DFE1-9569-4805-9269-480F2D128636@kernel.crashing.org>
References: <20081105212225.GA17821@ovro.caltech.edu>
To: Ira Snyder <iws@ovro.caltech.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stephen Hemminger <shemminger@vyatta.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 3:22 PM, Ira Snyder wrote:

> This adds support to Linux for a virtual ethernet interface which uses =
the
> PCI bus as its transport mechanism. It creates a simple, familiar, and =
fast
> method of communication for two devices connected by a PCI interface.
>=20
> I have implemented client support for the Freescale MPC8349EMDS board,
> which is capable of running in PCI Agent mode (It acts like a PCI =
card, but
> is a complete PowerPC computer, running Linux). It is almost certainly
> trivially ported to any MPC83xx system.
>=20
> It was developed to work in a CompactPCI crate of computers, one of =
which
> is a relatively standard x86 system (acting as the host) and many =
PowerPC
> systems (acting as clients).
>=20
> RFC v2 -> RFC v3:
>  * use inline functions for accessing struct circ_buf_desc
>  * use pointer dereferencing on PowerPC local memory instead of =
ioread32()
>  * move IMMR and buffer descriptor accessors inside drivers
>  * update for dma_mapping_error() API changes
>  * use minimal locking primitives (i.e. spin_lock() instead of =
_irqsave())
>  * always disable checksumming, PCI is reliable
>  * replace typedef cbd_t with struct circ_buf_desc
>  * use get_immrbase() to get IMMR register offsets
>=20
> RFC v1 -> RFC v2:
>  * remove vim modelines
>  * use net_device->name in request_irq(), for irqbalance
>  * remove unneccesary wqt_get_stats(), use default get_stats() instead
>  * use dev_printk() and friends
>  * add message unit to MPC8349EMDS dts file
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> This is the third RFC posting of this driver. I got some feedback, and =
have
> corrected the problems. Thanks to everyone who has done review! I have
> gotten off-list feedback from several potential users, so there are
> definitely many potential users.
>=20
> I'll post up a revised version about once a week as long as the =
changes are
> minor. If they are more substantial, I'll post them as needed.
>=20
> The remaining issues I see in this driver:
> 1) =3D=3D=3D=3D Naming =3D=3D=3D=3D
>   The name wqt originally stood for "workqueue-test" and somewhat =
evolved
>   over time into the current driver. I'm looking for suggestions for a
>   better name. It should be the same between the host and client =
drivers,
>   to make porting the code between them easier. The drivers are /very/
>   similar other than the setup code.
> 2) =3D=3D=3D=3D IMMR Usage =3D=3D=3D=3D
>   In the Freescale client driver, I use the whole set of board control
>   registers (AKA IMMR registers). I only need a very small subset of =
them,
>   during startup to set up the DMA window. I used the full set of
>   registers so that I could share the register offsets between the =
drivers
>   (in pcinet_hw.h)
> 3) =3D=3D=3D=3D Hardcoded DMA Window Address =3D=3D=3D=3D
>   In the Freescale client driver, I just hardcoded the address of the
>   outbound PCI window into the DMA transfer code. It is 0x80000000.
>   Suggestions on how to get this value at runtime are welcome.
>=20
>=20
> Rationale behind some decisions:
> 1) =3D=3D=3D=3D Usage of the PCINET_NET_REGISTERS_VALID bit =3D=3D=3D=3D=

>   I want to be able to use this driver from U-Boot to tftp a kernel =
over
>   the PCI backplane, and then boot up the board. This means that the
>   device descriptor memory, which lives in the client RAM, becomes =
invalid
>   during boot.
> 2) =3D=3D=3D=3D Buffer Descriptors in client memory =3D=3D=3D=3D
>   I chose to put the buffer descriptors in client memory rather than =
host
>   memory. It seemed more logical to me at the time. In my application,
>   I'll have 19 boards + 1 host per cPCI chassis. The client -> host
>   direction will see most of the traffic, and so I thought I would cut
>   down on the number of PCI accesses needed. I'm willing to change =
this.
> 3) =3D=3D=3D=3D Usage of client DMA controller for all data transfer =
=3D=3D=3D=3D
>   This was done purely for speed. I tried using the CPU to transfer =
all
>   data, and it is very slow: ~3MB/sec. Using the DMA controller gets =
me to
>   ~40MB/sec (as tested with netperf).
> 4) =3D=3D=3D=3D Static 1GB DMA window =3D=3D=3D=3D
>   Maintaining a window while DMA's in flight, and then changing it =
seemed
>   too complicated. Also, testing showed that using a static window =
gave me
>   a ~10MB/sec speedup compared to moving the window for each skb.
> 5) =3D=3D=3D=3D The serial driver =3D=3D=3D=3D
>   Yes, there are two essentially separate drivers here. I needed a =
method
>   to communicate with the U-Boot bootloader on these boards without
>   plugging in a serial cable. With 19 clients + 1 host per chassis, =
the
>   cable clutter is worth avoiding. Since everything is connected via =
the
>   PCI bus anyway, I used that. A virtual serial port was simple to
>   implement using the messaging unit hardware that I used for the =
network
>   driver.
>=20
> I'll post both U-Boot drivers to their mailing list once this driver =
is
> finalized.
>=20
> Thanks,
> Ira
>=20
> arch/powerpc/boot/dts/mpc834x_mds.dts |    7 +
> drivers/net/Kconfig                   |   29 +
> drivers/net/Makefile                  |    3 +
> drivers/net/pcinet.h                  |   60 ++
> drivers/net/pcinet_fsl.c              | 1358 =
++++++++++++++++++++++++++++++++
> drivers/net/pcinet_host.c             | 1388 =
+++++++++++++++++++++++++++++++++
> drivers/net/pcinet_hw.h               |   77 ++
> 7 files changed, 2922 insertions(+), 0 deletions(-)
> create mode 100644 drivers/net/pcinet.h
> create mode 100644 drivers/net/pcinet_fsl.c
> create mode 100644 drivers/net/pcinet_host.c
> create mode 100644 drivers/net/pcinet_hw.h

What ever happened to this?

- k=
