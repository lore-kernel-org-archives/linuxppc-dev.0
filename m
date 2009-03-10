Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 08EF2DE0DC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 02:21:59 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2457804wfd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 08:21:58 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/5] Retrieving Ethernet PHY wireup from the OF device tree
To: afleming@freescale.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Date: Tue, 10 Mar 2009 09:21:56 -0600
Message-ID: <20090310150751.12455.70598.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This series reworks some of the phylib code to allow PHY descriptions and
connections to be extracted from the OF device tree.  MDIO bus drivers gain
a common helper function for parsing the PHY data and registering new
phy_devices to match.  Ethernet controller drivers gain the ability to
resolve to a phy_device from a device tree phandle.

One notable aspect is that the Ethernet controller driver doesn't know
if the phy_device is registered before or after the Ethernet driver.  This
series adds a function to the device model core code to make it simple for
the driver to register a bus notifier (mdio_bus in this case), which gets
called both for existing devices and for future device registrations.  The
advantage of this is that the driver doesn't need to know or care when the
device actually shows up.  It just knows that its callback will get called
when the device is available.  I think this is a good approach, but I'd
appreciate some feedback on it.

Cheers,
g.

drivers/base/bus.c            |   47 +++++++++
 drivers/net/Kconfig           |    2 +-
 drivers/net/fec_mpc52xx.c     |  220 ++++++++++++++++++-----------------------
 drivers/net/fec_mpc52xx_phy.c |   30 +++---
 drivers/net/phy/mdio_bus.c    |   29 +-----
 drivers/net/phy/phy_device.c  |  161 +++++++++++++++++++++++-------
 drivers/of/Kconfig            |    6 +
 drivers/of/Makefile           |    1 +
 drivers/of/of_mdio.c          |   70 +++++++++++++
 include/linux/device.h        |    2 +
 include/linux/of_mdio.h       |   20 ++++
 include/linux/phy.h           |    6 +
 12 files changed, 388 insertions(+), 206 deletions(-)

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
