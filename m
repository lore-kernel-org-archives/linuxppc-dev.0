Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id 9E97AB6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 21:04:04 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer
	interrupts
Date: Wed, 28 Jul 2010 11:54:26 +0100
Message-Id: <1280314467-5637-3-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
Cc: Ian Campbell <ian.campbell@citrix.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kw_i2c_irq and via_pmu_interrupt are not timer interrupts and
therefore should not use IRQF_TIMER. Use the recently introduced
IRQF_NO_SUSPEND instead since that is the actual desired behaviour.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/powerpc/platforms/powermac/low_i2c.c |    4 ++--
 drivers/macintosh/via-pmu.c               |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 06a137c..1554d29 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -542,11 +542,11 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	/* Make sure IRQ is disabled */
 	kw_write_reg(reg_ier, 0);
 
-	/* Request chip interrupt. We set IRQF_TIMER because we don't
+	/* Request chip interrupt. We set IRQF_NO_SUSPEND because we don't
 	 * want that interrupt disabled between the 2 passes of driver
 	 * suspend or we'll have issues running the pfuncs
 	 */
-	if (request_irq(host->irq, kw_i2c_irq, IRQF_TIMER, "keywest i2c", host))
+	if (request_irq(host->irq, kw_i2c_irq, IRQF_NO_SUSPEND, "keywest i2c", host))
 		host->irq = NO_IRQ;
 
 	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 3d4fc0f..5c6b5be 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -400,11 +400,11 @@ static int __init via_pmu_start(void)
 		printk(KERN_ERR "via-pmu: can't map interrupt\n");
 		return -ENODEV;
 	}
-	/* We set IRQF_TIMER because we don't want the interrupt to be disabled
+	/* We set IRQF_NO_SUSPEND because we don't want the interrupt to be disabled
 	 * between the 2 passes of driver suspend, we control our own disabling
 	 * for that one
 	 */
-	if (request_irq(irq, via_pmu_interrupt, IRQF_TIMER, "VIA-PMU", (void *)0)) {
+	if (request_irq(irq, via_pmu_interrupt, IRQF_NO_SUSPEND, "VIA-PMU", (void *)0)) {
 		printk(KERN_ERR "via-pmu: can't request irq %d\n", irq);
 		return -ENODEV;
 	}
-- 
1.5.6.5
