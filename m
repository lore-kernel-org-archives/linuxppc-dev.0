Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BD791A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:17:35 +1000 (AEST)
Date: Tue, 22 Sep 2015 17:17:10 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>, David Miller <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 Iyappan Subramanian <isubramanian@apm.com>,
 Keyur Chudgar <kchudgar@apm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Li Yang <leoli@freescale.com>,
 Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
 Robert Richter <rric@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Soren Brinkmann <soren.brinkmann@xilinx.com>,
 Sunil Goutham <sgoutham@cavium.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 0/9] Phy, mdiobus, and netdev struct device fixes
Message-ID: <20150922161710.GA21084@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the second version of the series, with the comments David had
on the first patch fixed up.  Original series description with updated
diffstat below.

While looking at the DSA code, I noticed we have a
of_find_net_device_by_node(), and it looks like users of that are
similarly buggy - it looks like net/dsa/dsa.c is the only user.  Fix
that too.

Hi,

While looking at the phy code, I identified a number of weaknesses
where refcounting on device structures was being leaked, where
modules could be removed while in-use, and where the fixed-phy could
end up having unintended consequences caused by incorrect calls to
fixed_phy_update_state().

This patch series resolves those issues, some of which were discovered
with testing on an Armada 388 board.  Not all patches are fully tested,
particularly the one which touches several network drivers.

When resolving the struct device refcounting problems, several different
solutions were considered before settling on the implementation here -
one of the considerations was to avoid touching many network drivers.
The solution here is:

	phy_attach*() - takes a refcount
	phy_detach*() - drops the phy_attach refcount

Provided drivers always attach and detach their phys, which they should
already be doing, this should change nothing, even if they leak a refcount.

	of_phy_find_device() and of_* functions which use that take
	a refcount.  Arrange for this refcount to be dropped once
	the phy is attached.

This is the reason why the previous change is important - we can't drop
this refcount taken by of_phy_find_device() until something else holds
a reference on the device.  This resolves the leaked refcount caused by
using of_phy_connect() or of_phy_attach().

Even without the above changes, these drivers are leaking by calling
of_phy_find_device().  These drivers are addressed by adding the
appropriate release of that refcount.

The mdiobus code also suffered from the same kind of leak, but thankfully
this only happened in one place - the mdio-mux code.

I also found that the try_module_get() in the phy layer code was utterly
useless: phydev->dev.driver was guaranteed to always be NULL, so
try_module_get() was always being called with a NULL argument.  I proved
this with my SFP code, which declares its own MDIO bus - the module use
count was never incremented irrespective of how I set the MDIO bus up.
This allowed the MDIO bus code to be removed from the kernel while there
were still PHYs attached to it.

One other bug was discovered: while using in-band-status with mvneta, it
was found that if a real phy is attached with in-band-status enabled,
and another ethernet interface is using the fixed-phy infrastructure, the
interface using the fixed-phy infrastructure is configured according to
the other interface using the in-band-status - which is caused by the
fixed-phy code not verifying that the phy_device passed in is actually
a fixed-phy device, rather than a real MDIO phy.

Lastly, having mdio_bus reversing phy_device_register() internals seems
like a layering violation - it's trivial to move that code to the phy
device layer.

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    | 23 ++++++---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 19 +++++++
 drivers/net/ethernet/freescale/gianfar.c          |  6 ++-
 drivers/net/ethernet/freescale/ucc_geth.c         |  8 ++-
 drivers/net/ethernet/marvell/mvneta.c             |  2 +
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     |  2 +
 drivers/net/phy/fixed_phy.c                       |  2 +-
 drivers/net/phy/mdio-mux.c                        | 19 ++++---
 drivers/net/phy/mdio_bus.c                        | 24 ++++++---
 drivers/net/phy/phy_device.c                      | 62 ++++++++++++++++++-----
 drivers/of/of_mdio.c                              | 27 ++++++++--
 include/linux/phy.h                               |  6 ++-
 net/core/net-sysfs.c                              |  9 ++++
 net/dsa/dsa.c                                     | 41 ++++++++++++---
 14 files changed, 199 insertions(+), 51 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
