Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 25/39] powerpc/powernv: Fix endian issues in OPAL ICS backend
Date: Mon, 23 Sep 2013 12:04:59 +1000
Message-Id: <1379901913-5945-26-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xics/ics-opal.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 39d7221..3c6ee1b 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -112,6 +112,7 @@ static int ics_opal_set_affinity(struct irq_data *d,
 				 bool force)
 {
 	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	__be16 oserver;
 	int16_t server;
 	int8_t priority;
 	int64_t rc;
@@ -120,13 +121,13 @@ static int ics_opal_set_affinity(struct irq_data *d,
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return -1;
 
-	rc = opal_get_xive(hw_irq, &server, &priority);
+	rc = opal_get_xive(hw_irq, &oserver, &priority);
 	if (rc != OPAL_SUCCESS) {
-		pr_err("%s: opal_set_xive(irq=%d [hw 0x%x] server=%x)"
-		       " error %lld\n",
-		       __func__, d->irq, hw_irq, server, rc);
+		pr_err("%s: opal_get_xive(irq=%d [hw 0x%x]) error %lld\n",
+		       __func__, d->irq, hw_irq, rc);
 		return -1;
 	}
+	server = be16_to_cpu(oserver);
 
 	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
 	if (wanted_server < 0) {
@@ -181,7 +182,7 @@ static int ics_opal_map(struct ics *ics, unsigned int virq)
 {
 	unsigned int hw_irq = (unsigned int)virq_to_hw(virq);
 	int64_t rc;
-	int16_t server;
+	__be16 server;
 	int8_t priority;
 
 	if (WARN_ON(hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS))
@@ -201,7 +202,7 @@ static int ics_opal_map(struct ics *ics, unsigned int virq)
 static void ics_opal_mask_unknown(struct ics *ics, unsigned long vec)
 {
 	int64_t rc;
-	int16_t server;
+	__be16 server;
 	int8_t priority;
 
 	/* Check if HAL knows about this interrupt */
@@ -215,14 +216,14 @@ static void ics_opal_mask_unknown(struct ics *ics, unsigned long vec)
 static long ics_opal_get_server(struct ics *ics, unsigned long vec)
 {
 	int64_t rc;
-	int16_t server;
+	__be16 server;
 	int8_t priority;
 
 	/* Check if HAL knows about this interrupt */
 	rc = opal_get_xive(vec, &server, &priority);
 	if (rc != OPAL_SUCCESS)
 		return -1;
-	return ics_opal_unmangle_server(server);
+	return ics_opal_unmangle_server(be16_to_cpu(server));
 }
 
 int __init ics_opal_init(void)
-- 
1.8.1.2
