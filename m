Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id B1EEB67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 03:42:51 +1100 (EST)
Message-ID: <42386209.2070407@timesys.com>
Date: Wed, 16 Mar 2005 11:42:49 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------080203040009020207060406"
Subject: [patch] fix gianfar unitilized spinlock.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080203040009020207060406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix unitilized spinlock in the gianfar tsec etherenet driver.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com>


--------------080203040009020207060406
Content-Type: text/x-patch;
 name="gianfar.spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gianfar.spinlock.patch"

--- all/drivers/net/gianfar.c-orig
+++ all/drivers/net/gianfar.c

@@ -384,6 +384,8 @@
 	mii_info->mdio_read = &read_phy_reg;
 	mii_info->mdio_write = &write_phy_reg;
 
+        spin_lock_init(&mii_info->mdio_lock);
+
 	priv->mii_info = mii_info;
 
 	/* Reset the management interface */

--------------080203040009020207060406--
