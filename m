Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40yRV344yMzF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 13:27:54 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 04/11] macintosh/via-pmu: Enhance state machine with new
 'uninitialized' state
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 68k Macs, the via/vias pointer can't be used to determine whether
the PMU driver has been initialized. For portability, add a new state
to indicate that via_find_pmu() succeeded.

After via_find_pmu() executes, testing vias == NULL is equivalent to
testing via == NULL. Replace these tests with pmu_state == uninitialized
which is simpler and more consistent. No functional change.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-pmu.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 087c3aa5233a..7fba3c88991d 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -114,6 +114,7 @@ static volatile unsigned char __iomem *via;
 #define CB1_INT		0x10		/* transition on CB1 input */
 
 static volatile enum pmu_state {
+	uninitialized = 0,
 	idle,
 	sending,
 	intack,
@@ -274,7 +275,7 @@ int __init find_via_pmu(void)
 	u64 taddr;
 	const u32 *reg;
 
-	if (via != 0)
+	if (pmu_state != uninitialized)
 		return 1;
 	vias = of_find_node_by_name(NULL, "via-pmu");
 	if (vias == NULL)
@@ -369,20 +370,19 @@ int __init find_via_pmu(void)
  fail:
 	of_node_put(vias);
 	vias = NULL;
+	pmu_state = uninitialized;
 	return 0;
 }
 
 #ifdef CONFIG_ADB
 static int pmu_probe(void)
 {
-	return vias == NULL? -ENODEV: 0;
+	return pmu_state == uninitialized ? -ENODEV : 0;
 }
 
 static int pmu_init(void)
 {
-	if (vias == NULL)
-		return -ENODEV;
-	return 0;
+	return pmu_state == uninitialized ? -ENODEV : 0;
 }
 #endif /* CONFIG_ADB */
 
@@ -397,7 +397,7 @@ static int __init via_pmu_start(void)
 {
 	unsigned int irq;
 
-	if (vias == NULL)
+	if (pmu_state == uninitialized)
 		return -ENODEV;
 
 	batt_req.complete = 1;
@@ -463,7 +463,7 @@ arch_initcall(via_pmu_start);
  */
 static int __init via_pmu_dev_init(void)
 {
-	if (vias == NULL)
+	if (pmu_state == uninitialized)
 		return -ENODEV;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
@@ -966,7 +966,7 @@ static int pmu_send_request(struct adb_request *req, int sync)
 {
 	int i, ret;
 
-	if ((vias == NULL) || (!pmu_fully_inited)) {
+	if (pmu_state == uninitialized || !pmu_fully_inited) {
 		req->complete = 1;
 		return -ENXIO;
 	}
@@ -1060,7 +1060,7 @@ static int __pmu_adb_autopoll(int devs)
 
 static int pmu_adb_autopoll(int devs)
 {
-	if ((vias == NULL) || (!pmu_fully_inited) || !pmu_has_adb)
+	if (pmu_state == uninitialized || !pmu_fully_inited || !pmu_has_adb)
 		return -ENXIO;
 
 	adb_dev_map = devs;
@@ -1073,7 +1073,7 @@ static int pmu_adb_reset_bus(void)
 	struct adb_request req;
 	int save_autopoll = adb_dev_map;
 
-	if ((vias == NULL) || (!pmu_fully_inited) || !pmu_has_adb)
+	if (pmu_state == uninitialized || !pmu_fully_inited || !pmu_has_adb)
 		return -ENXIO;
 
 	/* anyone got a better idea?? */
@@ -1109,7 +1109,7 @@ pmu_request(struct adb_request *req, void (*done)(struct adb_request *),
 	va_list list;
 	int i;
 
-	if (vias == NULL)
+	if (pmu_state == uninitialized)
 		return -ENXIO;
 
 	if (nbytes < 0 || nbytes > 32) {
@@ -1134,7 +1134,7 @@ pmu_queue_request(struct adb_request *req)
 	unsigned long flags;
 	int nsend;
 
-	if (via == NULL) {
+	if (pmu_state == uninitialized) {
 		req->complete = 1;
 		return -ENXIO;
 	}
@@ -1247,7 +1247,7 @@ pmu_start(void)
 void
 pmu_poll(void)
 {
-	if (!via)
+	if (pmu_state == uninitialized)
 		return;
 	if (disable_poll)
 		return;
@@ -1257,7 +1257,7 @@ pmu_poll(void)
 void
 pmu_poll_adb(void)
 {
-	if (!via)
+	if (pmu_state == uninitialized)
 		return;
 	if (disable_poll)
 		return;
@@ -1272,7 +1272,7 @@ pmu_poll_adb(void)
 void
 pmu_wait_complete(struct adb_request *req)
 {
-	if (!via)
+	if (pmu_state == uninitialized)
 		return;
 	while((pmu_state != idle && pmu_state != locked) || !req->complete)
 		via_pmu_interrupt(0, NULL);
@@ -1288,7 +1288,7 @@ pmu_suspend(void)
 {
 	unsigned long flags;
 
-	if (!via)
+	if (pmu_state == uninitialized)
 		return;
 	
 	spin_lock_irqsave(&pmu_lock, flags);
@@ -1319,7 +1319,7 @@ pmu_resume(void)
 {
 	unsigned long flags;
 
-	if (!via || (pmu_suspended < 1))
+	if (pmu_state == uninitialized || pmu_suspended < 1)
 		return;
 
 	spin_lock_irqsave(&pmu_lock, flags);
@@ -1681,7 +1681,7 @@ pmu_enable_irled(int on)
 {
 	struct adb_request req;
 
-	if (vias == NULL)
+	if (pmu_state == uninitialized)
 		return ;
 	if (pmu_kind == PMU_KEYLARGO_BASED)
 		return ;
@@ -1696,7 +1696,7 @@ pmu_restart(void)
 {
 	struct adb_request req;
 
-	if (via == NULL)
+	if (pmu_state == uninitialized)
 		return;
 
 	local_irq_disable();
@@ -1721,7 +1721,7 @@ pmu_shutdown(void)
 {
 	struct adb_request req;
 
-	if (via == NULL)
+	if (pmu_state == uninitialized)
 		return;
 
 	local_irq_disable();
@@ -1749,7 +1749,7 @@ pmu_shutdown(void)
 int
 pmu_present(void)
 {
-	return via != 0;
+	return pmu_state != uninitialized;
 }
 
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
@@ -2415,7 +2415,7 @@ static struct miscdevice pmu_device = {
 
 static int pmu_device_init(void)
 {
-	if (!via)
+	if (pmu_state == uninitialized)
 		return 0;
 	if (misc_register(&pmu_device) < 0)
 		printk(KERN_ERR "via-pmu: cannot register misc device.\n");
-- 
2.16.1
