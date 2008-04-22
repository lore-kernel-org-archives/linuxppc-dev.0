Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 Apr 2008 10:46:44 +1000
Subject: [PATCH 4/6] ibm_newemac Use status property for unused/unwired EMACs
Message-Id: <20080422004801.E6272DE2DD@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Convert ibm_newemac to use the of_device_is_available function when checking
for unused/unwired EMACs.  We leave the current check for an "unused" property
to maintain backwards compatibility for older device trees.  Newer device
trees should simply use the standard "status" property in the EMAC node.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/ibm_newemac/core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-work.orig/drivers/net/ibm_newemac/core.c	2008-04-22 10:42:42.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/core.c	2008-04-22 10:43:01.000000000 +1000
@@ -2562,8 +2562,11 @@ static int __devinit emac_probe(struct o
 	struct device_node **blist = NULL;
 	int err, i;
 
-	/* Skip unused/unwired EMACS */
-	if (of_get_property(np, "unused", NULL))
+	/* Skip unused/unwired EMACS.  We leave the check for an unused
+	 * property here for now, but new flat device trees should set a
+	 * status property to "disabled" instead.
+	 */
+	if (of_get_property(np, "unused", NULL) || !of_device_is_available(np))
 		return -ENODEV;
 
 	/* Find ourselves in the bootlist if we are there */
