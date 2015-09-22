Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 375CC1A038B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:19:06 +1000 (AEST)
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>, David Miller <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 Iyappan Subramanian <isubramanian@apm.com>, Keyur Chudgar <kchudgar@apm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Li Yang <leoli@freescale.com>, Michal Simek <michal.simek@xilinx.com>,
 netdev@vger.kernel.org, Robert Richter <rric@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Soren Brinkmann" <soren.brinkmann@xilinx.com>,
 Sunil Goutham <sgoutham@cavium.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] phy: add proper phy struct device refcounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZeQGo-0006Xf-7Y@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 22 Sep 2015 17:18:18 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Take a refcount on the phy struct device when the phy device is attached
to a network device, and drop it after it's detached.  This ensures that
a refcount is held on the phy device while the device is being used by
a network device, thereby preventing the phy_device from being
unexpectedly kfree()'d by phy_device_release().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/phy/phy_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 03adf328f49b..97a4f52addac 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -578,6 +578,7 @@ EXPORT_SYMBOL(phy_init_hw);
  *     generic driver is used.  The phy_device is given a ptr to
  *     the attaching device, and given a callback for link status
  *     change.  The phy_device is returned to the attaching driver.
+ *     This function takes a reference on the phy device.
  */
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface)
@@ -591,6 +592,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		return -EIO;
 	}
 
+	get_device(d);
+
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
 	 */
@@ -636,6 +639,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error:
+	put_device(d);
 	module_put(bus->owner);
 	return err;
 }
@@ -679,6 +683,9 @@ EXPORT_SYMBOL(phy_attach);
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
+ *
+ * This detaches the phy device from its network device and the phy
+ * driver, and drops the reference count taken in phy_attach_direct().
  */
 void phy_detach(struct phy_device *phydev)
 {
@@ -701,8 +708,13 @@ void phy_detach(struct phy_device *phydev)
 		}
 	}
 
+	/*
+	 * The phydev might go away on the put_device() below, so avoid
+	 * a use-after-free bug by reading the underlying bus first.
+	 */
 	bus = phydev->bus;
 
+	put_device(&phydev->dev);
 	module_put(bus->owner);
 }
 EXPORT_SYMBOL(phy_detach);
-- 
2.1.0
