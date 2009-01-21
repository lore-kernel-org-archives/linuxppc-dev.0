Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 14EC3474C8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:17 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so300762ele.3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:16 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/8] powerpc/5200: Stop using device_type and port-number
	properties
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:13 -0700
Message-ID: <20090121205512.31232.99373.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
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

From: Grant Likely <grant.likely@secretlab.ca>

There is no reason for the PSC UART driver or the Ethernet driver
to require a device_type property.  The compatible value is sufficient
to uniquely identify the device.  Remove it from the driver.

The whole 'port-number' scheme for assigning numbers to PSC uarts was
always rather half baked and just adds complexity.  Remove it from the
driver.  After this patch is applied, PSC UART numbers are simply
assigned from the order they are found in the device tree (just like
all the other devices).  Userspace can query sysfs to determine what
ttyPSC number is assigned to each PSC instance.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Wolfram Sang <w.sang@pengutronix.de>
---

 drivers/net/fec_mpc52xx.c     |    6 +++---
 drivers/serial/mpc52xx_uart.c |   38 ++++++++++----------------------------
 2 files changed, 13 insertions(+), 31 deletions(-)


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cd8e98b..049b0a7 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -1123,9 +1123,9 @@ static int mpc52xx_fec_of_resume(struct of_device *op)
 #endif
 
 static struct of_device_id mpc52xx_fec_match[] = {
-	{ .type = "network", .compatible = "fsl,mpc5200b-fec", },
-	{ .type = "network", .compatible = "fsl,mpc5200-fec", },
-	{ .type = "network", .compatible = "mpc5200-fec", },
+	{ .compatible = "fsl,mpc5200b-fec", },
+	{ .compatible = "fsl,mpc5200-fec", },
+	{ .compatible = "mpc5200-fec", },
 	{ }
 };
 
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 0c3a2ab..d73d7da 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -50,8 +50,8 @@
 /* OF Platform device Usage :
  *
  * This driver is only used for PSCs configured in uart mode.  The device
- * tree will have a node for each PSC in uart mode w/ device_type = "serial"
- * and "mpc52xx-psc-uart" in the compatible string
+ * tree will have a node for each PSC with "mpc52xx-psc-uart" in the compatible
+ * list.
  *
  * By default, PSC devices are enumerated in the order they are found.  However
  * a particular PSC number can be forces by adding 'device_no = <port#>'
@@ -1212,30 +1212,18 @@ mpc52xx_uart_of_resume(struct of_device *op)
 #endif
 
 static void
-mpc52xx_uart_of_assign(struct device_node *np, int idx)
+mpc52xx_uart_of_assign(struct device_node *np)
 {
-	int free_idx = -1;
 	int i;
 
-	/* Find the first free node */
+	/* Find the first free PSC number */
 	for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
 		if (mpc52xx_uart_nodes[i] == NULL) {
-			free_idx = i;
-			break;
+			of_node_get(np);
+			mpc52xx_uart_nodes[i] = np;
+			return;
 		}
 	}
-
-	if ((idx < 0) || (idx >= MPC52xx_PSC_MAXNUM))
-		idx = free_idx;
-
-	if (idx < 0)
-		return; /* No free slot; abort */
-
-	of_node_get(np);
-	/* If the slot is already occupied, then swap slots */
-	if (mpc52xx_uart_nodes[idx] && (free_idx != -1))
-		mpc52xx_uart_nodes[free_idx] = mpc52xx_uart_nodes[idx];
-	mpc52xx_uart_nodes[idx] = np;
 }
 
 static void
@@ -1243,23 +1231,17 @@ mpc52xx_uart_of_enumerate(void)
 {
 	static int enum_done;
 	struct device_node *np;
-	const unsigned int *devno;
 	const struct  of_device_id *match;
 	int i;
 
 	if (enum_done)
 		return;
 
-	for_each_node_by_type(np, "serial") {
+	/* Assign index to each PSC in device tree */
+	for_each_matching_node(np, mpc52xx_uart_of_match) {
 		match = of_match_node(mpc52xx_uart_of_match, np);
-		if (!match)
-			continue;
-
 		psc_ops = match->data;
-
-		/* Is a particular device number requested? */
-		devno = of_get_property(np, "port-number", NULL);
-		mpc52xx_uart_of_assign(np, devno ? *devno : -1);
+		mpc52xx_uart_of_assign(np);
 	}
 
 	enum_done = 1;
