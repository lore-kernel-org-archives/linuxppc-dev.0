Return-Path: <shh.xie@gmail.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D33952C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 23:21:38 +1100 (EST)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] phylib: Add Clause 45 read/write functions
Date: Mon, 11 Nov 2013 19:04:02 +0800
Message-ID: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming

You need an extra parameter to read or write Clause 45 PHYs, so
we need a different API with the extra parameter.

Signed-off-by: Andy Fleming
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 include/linux/phy.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 64ab823..684925a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -498,6 +498,21 @@ static inline int phy_read(struct phy_device *phydev, u32 regnum)
 }
 
 /**
+ * phy_read_mmd - Convenience function for reading a register
+ *   from an MMD on a given PHY.
+ * @phydev: The phy_device struct
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Same rules as for phy_read();
+ */
+static inline int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
+{
+	return mdiobus_read(phydev->bus, phydev->addr,
+		MII_ADDR_C45 | (devad << 16) | (regnum & 0xffff));
+}
+
+/**
  * phy_write - Convenience function for writing a given PHY register
  * @phydev: the phy_device struct
  * @regnum: register number to write
@@ -533,6 +548,24 @@ static inline bool phy_is_internal(struct phy_device *phydev)
 	return phydev->is_internal;
 }
 
+/**
+ * phy_write_mmd - Convenience function for writing a register
+ *   on an MMD on a given PHY.
+ * @phydev: The phy_device struct
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ * @val: value to write to @regnum
+ *
+ * Same rules as for phy_write();
+ */
+static inline int phy_write_mmd(struct phy_device *phydev, int devad,
+		u32 regnum, u16 val)
+{
+	regnum = MII_ADDR_C45 | ((devad & 0x1f) << 16) | (regnum & 0xffff);
+
+	return mdiobus_write(phydev->bus, phydev->addr, regnum, val);
+}
+
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
 		bool is_c45, struct phy_c45_device_ids *c45_ids);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
-- 
1.8.4.1
