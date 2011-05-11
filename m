Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 9363DB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:37 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <ddef30cc215715662c6e997f9e82e8d79d1c4582.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:15 -0500
Subject: [PATCH 29/37] powerpc: mpc5121_ads_cpld: remove use of NO_IRQ_IGNORE
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As NO_IRQ_IGNORE is only used between the static function cpld_pic_get_irq
and its caller cpld_pic_cascade, and cpld_pic_cascade only uses it to
suppress calling handle_generic_irq, we can change these uses to NO_IRQ
and remove the extra tests and pathlength in cpld_pic_cascade.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index a8bc0d4..9f09319 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -97,7 +97,7 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 	status |= (ignore | mask);
 
 	if (status == 0xff)
-		return NO_IRQ_IGNORE;
+		return NO_IRQ;
 
 	cpld_irq = ffz(status) + offset;
 
@@ -109,14 +109,14 @@ cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
-	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
+	if (irq != NO_IRQ) {
 		generic_handle_irq(irq);
 		return;
 	}
 
 	irq = cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
 		&cpld_regs->misc_mask);
-	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
+	if (irq != NO_IRQ) {
 		generic_handle_irq(irq);
 		return;
 	}
-- 
1.7.0.4
