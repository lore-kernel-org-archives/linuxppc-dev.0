Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 64667B7BE8
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 05:00:57 +1100 (EST)
Date: Thu, 10 Dec 2009 21:00:56 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/83xx/suspend: Save and restore SICRL, SICRH
	and SCCR
Message-ID: <20091210180056.GB32482@oksana.dev.rtsoft.ru>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to save SICRL, SICRH and SCCR registers on suspend, and restore
them on resume. Otherwise, we lose IO and clocks setup on MPC8315E-RDB
boards when ULPI USB PHY is used (non-POR setup).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/suspend.c |   48 +++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index b0c2619..4380534 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -32,6 +32,7 @@
 #define PMCCR1_NEXT_STATE       0x0C /* Next state for power management */
 #define PMCCR1_NEXT_STATE_SHIFT 2
 #define PMCCR1_CURR_STATE       0x03 /* Current state for power management*/
+#define IMMR_SYSCR_OFFSET       0x100
 #define IMMR_RCW_OFFSET         0x900
 #define RCW_PCI_HOST            0x80000000
 
@@ -78,6 +79,22 @@ struct mpc83xx_clock {
 	u32 sccr;
 };
 
+struct mpc83xx_syscr {
+	__be32 sgprl;
+	__be32 sgprh;
+	__be32 spridr;
+	__be32 :32;
+	__be32 spcr;
+	__be32 sicrl;
+	__be32 sicrh;
+};
+
+struct mpc83xx_saved {
+	u32 sicrl;
+	u32 sicrh;
+	u32 sccr;
+};
+
 struct pmc_type {
 	int has_deep_sleep;
 };
@@ -87,6 +104,8 @@ static int has_deep_sleep, deep_sleeping;
 static int pmc_irq;
 static struct mpc83xx_pmc __iomem *pmc_regs;
 static struct mpc83xx_clock __iomem *clock_regs;
+static struct mpc83xx_syscr __iomem *syscr_regs;
+static struct mpc83xx_saved saved_regs;
 static int is_pci_agent, wake_from_pci;
 static phys_addr_t immrbase;
 static int pci_pm_state;
@@ -137,6 +156,20 @@ static irqreturn_t pmc_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static void mpc83xx_suspend_restore_regs(void)
+{
+	out_be32(&syscr_regs->sicrl, saved_regs.sicrl);
+	out_be32(&syscr_regs->sicrh, saved_regs.sicrh);
+	out_be32(&clock_regs->sccr, saved_regs.sccr);
+}
+
+static void mpc83xx_suspend_save_regs(void)
+{
+	saved_regs.sicrl = in_be32(&syscr_regs->sicrl);
+	saved_regs.sicrh = in_be32(&syscr_regs->sicrh);
+	saved_regs.sccr = in_be32(&clock_regs->sccr);
+}
+
 static int mpc83xx_suspend_enter(suspend_state_t state)
 {
 	int ret = -EAGAIN;
@@ -166,6 +199,8 @@ static int mpc83xx_suspend_enter(suspend_state_t state)
 	 */
 
 	if (deep_sleeping) {
+		mpc83xx_suspend_save_regs();
+
 		out_be32(&pmc_regs->mask, PMCER_ALL);
 
 		out_be32(&pmc_regs->config1,
@@ -179,6 +214,8 @@ static int mpc83xx_suspend_enter(suspend_state_t state)
 		         in_be32(&pmc_regs->config1) & ~PMCCR1_POWER_OFF);
 
 		out_be32(&pmc_regs->mask, PMCER_PMCI);
+
+		mpc83xx_suspend_restore_regs();
 	} else {
 		out_be32(&pmc_regs->mask, PMCER_PMCI);
 
@@ -333,12 +370,23 @@ static int pmc_probe(struct of_device *ofdev,
 		goto out_pmc;
 	}
 
+	if (has_deep_sleep) {
+		syscr_regs = ioremap(immrbase + IMMR_SYSCR_OFFSET,
+				     sizeof(*syscr_regs));
+		if (!syscr_regs) {
+			ret = -ENOMEM;
+			goto out_syscr;
+		}
+	}
+
 	if (is_pci_agent)
 		mpc83xx_set_agent();
 
 	suspend_set_ops(&mpc83xx_suspend_ops);
 	return 0;
 
+out_syscr:
+	iounmap(clock_regs);
 out_pmc:
 	iounmap(pmc_regs);
 out:
-- 
1.6.3.3
