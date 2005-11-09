Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D763686E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 05:15:02 +1100 (EST)
Date: Wed, 9 Nov 2005 12:13:11 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: jgarzik@pobox.com
Message-ID: <Pine.LNX.4.44.0511091211030.26349-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] gianfar mii needs to zero out the mii_bus structure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To ensure that phy_mask and any future elements of the mii_bus
structure are initialized use kzalloc() instead of kmalloc().

This fixes an issue in which phy_mask was not being initialized
and we would skip random phy addresses when scanning.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 35003e02e33939b7359635f3cf7b424723ffd4b0
tree 386160e32c51e8f1e662811738e79571c7218fdb
parent d0876a2748ddc33ca9ed1ea26cf958726c50c7b9
author Kumar Gala <galak@kernel.crashing.org> Wed, 09 Nov 2005 12:11:40 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 09 Nov 2005 12:11:40 -0600

 drivers/net/gianfar_mii.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 5a74d3d..ee1a77a 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -134,7 +134,7 @@ int gfar_mdio_probe(struct device *dev)
 	if (NULL == dev)
 		return -EINVAL;
 
-	new_bus = kmalloc(sizeof(struct mii_bus), GFP_KERNEL);
+	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
 
 	if (NULL == new_bus)
 		return -ENOMEM;
