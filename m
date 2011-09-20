Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35B57100E59
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:09 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/20] powerpc/powernv: Register and handle OPAL interrupts
Date: Tue, 20 Sep 2011 13:45:03 +1000
Message-Id: <1316490307-28030-16-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We do the minimum which is to "pass" interrupts to HAL, which
makes the console smoother and will allow us to implement
interrupt based completion and console.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 7887733..5a598ca 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/interrupt.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 
@@ -135,9 +136,22 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	return written;
 }
 
+static irqreturn_t opal_interrupt(int irq, void *data)
+{
+	uint64_t events;
+
+	opal_handle_interrupt(virq_to_hw(irq), &events);
+
+	/* XXX TODO: Do something with the events */
+
+	return IRQ_HANDLED;
+}
+
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
+	const u32 *irqs;
+	int rc, i, irqlen;
 
 	opal_node = of_find_node_by_path("/ibm,opal");
 	if (!opal_node) {
@@ -156,6 +170,23 @@ static int __init opal_init(void)
 		of_platform_device_create(np, NULL, NULL);
 	}
 	of_node_put(consoles);
+
+	/* Find all OPAL interrupts and request them */
+	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
+	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
+		 irqs ? (irqlen / 4) : 0);
+	for (i = 0; irqs && i < (irqlen / 4); i++, irqs++) {
+		unsigned int hwirq = be32_to_cpup(irqs);
+		unsigned int irq = irq_create_mapping(NULL, hwirq);
+		if (irq == NO_IRQ) {
+			pr_warning("opal: Failed to map irq 0x%x\n", hwirq);
+			continue;
+		}
+		rc = request_irq(irq, opal_interrupt, 0, "opal", NULL);
+		if (rc)
+			pr_warning("opal: Error %d requesting irq %d"
+				   " (0x%x)\n", rc, irq, hwirq);
+	}
 	return 0;
 }
 subsys_initcall(opal_init);
-- 
1.7.4.1
