Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D8601A2CA7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 19:48:29 +1000 (AEST)
In-Reply-To: <20150918094625.GB21084@n2100.arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org,Frank Rowand <frowand.list@gmail.com>,Grant Likely <grant.likely@linaro.org>,Iyappan Subramanian <isubramanian@apm.com>,Keyur Chudgar <kchudgar@apm.com>,linux-arm-kernel@lists.infradead.org,linuxppc-dev@lists.ozlabs.org,Li Yang <leoli@freescale.com>,Michal Simek <michal.simek@xilinx.com>,netdev@vger.kernel.org,Robert Richter <rric@kernel.org>,Rob Herring <robh+dt@kernel.org>,"Sören Brinkmann" <soren.brinkmann@xilinx.com>,Sunil Goutham <sgoutham@cavium.com>,Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] phy: fixed-phy: properly validate phy in
 fixed_phy_update_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZcsGa-0000uk-Az@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Fri, 18 Sep 2015 10:47:40 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Validate that the phy_device passed into fixed_phy_update_state() is a
fixed-phy device before walking the list of phys for a fixed phy at the
same address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/phy/fixed_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index fb1299c6326e..e23bf5b90e17 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -220,7 +220,7 @@ int fixed_phy_update_state(struct phy_device *phydev,
 	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp;
 
-	if (!phydev || !phydev->bus)
+	if (!phydev || phydev->bus != fmb->mii_bus)
 		return -EINVAL;
 
 	list_for_each_entry(fp, &fmb->phys, node) {
-- 
2.1.0
