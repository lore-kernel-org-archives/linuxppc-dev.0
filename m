Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:14:30 +1100
Subject: [PATCH 7/11] ibm_newemac: Skip EMACs that are marked unused by the
	firmware
Message-Id: <20071205001539.97730DE091@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hugh Blemings <hugh@blemings.org>

Depending on how the 44x processors are wired, some EMAC cells
might not be useable (and not connected to a PHY). However, some
device-trees may choose to still expose them (since their registers
are present in the MMIO space) but with an "unused" property in them.

Signed-off-by: Hugh Blemings <hugh@blemings.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/ibm_newemac/core.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-work/drivers/net/ibm_newemac/core.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/core.c	2007-11-20 14:47:02.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/core.c	2007-11-20 14:47:05.000000000 +1100
@@ -2550,6 +2550,10 @@ static int __devinit emac_probe(struct o
 	struct device_node **blist = NULL;
 	int err, i;
 
+	/* Skip unused/unwired EMACS */
+	if (of_get_property(np, "unused", NULL))
+		return -ENODEV;
+
 	/* Find ourselves in the bootlist if we are there */
 	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
 		if (emac_boot_list[i] == np)
