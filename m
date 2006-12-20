Return-Path: <benh@kernel.crashing.org>
Subject: [RFC/PATCH] EMAC "powerpc" port
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 17:22:18 +1100
Message-Id: <1166595738.19254.140.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This is still fairly WIP, but I felt it was time to share it for
comments. This is a branch/fork of the EMAC driver for use by
arch/powerpc (for now, only cell platforms using the Axon chip but
ultimately, 4xx as it gets ported).

Before people jump all over, here's what it's NOT doing (yet):

 - It needs cleanups here or there in some of my changes.

 - The workaround for the PHY RX clock issue is gone temporarily. I'll
put it back in, once I've either sorted out locking issues with access
to those global clock registers or verified it can be done differently
using loopback

 - It's not been tested/used on any 4xx platform yet and may need some
more work in that area

 - It's not be very much tested at all in fact. I got a link and
transferred a few things on a test board but didn't stress it a lot

 - The PHY code should really be reworked to use the generic PHY layer

 - It doesn't fully solve some issues with the busy_phy_map when using
multiple ASICs (where it's actually legal to have the same PHY ID) or
cases where MDIO lines are actually separate. The whole busy_phy_map
should be reworked... possibly used only for devices that share MDIO in
which case the busy map should be in the MDIO master...

 - I haven't fixed the problem of not DMA unmapping (I have to for cell,
for now, I gave IOMMU disabled but that can't last).

Now, what I actually did:

 - Ripped off the OCP stuff. Used probing based on the device-tree.
Everybody is an of_driver, and EMAC uses multithread probing to "wait"
for required sub-drivers to show up. I still need to publish an
exhaustive list of the expected properties but it's not fully final yet
in that area so best is look at the code and comment on it :-)

That's the area causing the most changes to the driver

 - No more ifdef's for defining the MAL and EMAC variant. It's all
soft-test, though it uses for EMAC a feature mecanism which should allow
code to be compiled out when building for only one platform. The current
implementation doesn't deal with that as well as it could though (no
EMAC_FTRS_POSSIBLE mask) but the basic is there. That means that it
should be possible to have kernels booting different 44x or 40x variants
with different EMACs while still being able to have compact code if
building for only one platform.

 - Locking. Cell is SMP, 46x is SMP, so we need SMP (and I've heard some
of the -rt folks having problem in that area too). I haven't triple
checked what I've done, it's rather simplistic, so feel free to propose
something better, and I still have a race with the multicast stuff that
I need to fix, but the base idea is that "hard" work and PHY polling are
all done at task level so we can use mutexes for most things (zmii,
rgmii, mdio accesses, etc...) and no big latencies.

A mecanism is added to stop NAPI poll for a given commac with
appropriate synchronisation similar to the "pure" NAPI version of it.
All of that should be simplifiable very significantly if/when Stephen
patch that splits the NAPI core from the net_device gets in.

 - Some slight changes specific to Axon support, like adding a fifo
size (axon is 2K/2K, oopsa).

The patch is too big of course for this list so I've put it there:

http://gate.crashing.org/~benh/powerpc-emac-new-20061220.diff

Enjoy !

Ben.
