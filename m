Return-Path: <bigeasy@linutronix.de>
Received: from custos.ou.linutronix.de (custos.ou.linutronix.de
 [212.62.202.73]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3424D2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 01:07:30 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-msi: use a different locklcass for the cascade
 interrupt
Date: Tue,  2 Apr 2013 15:33:36 +0200
Message-Id: <1364909616-59478-1-git-send-email-bigeasy@linutronix.de>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lockdep thinks that it might deadlock because it grabs a lock of the
same class while calling the generic_irq_handler(). This annotation will
inform lockdep that it will not.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 178c994..ab02db3 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -333,6 +333,8 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	return 0;
 }
 
+static struct lock_class_key fsl_msi_irq_class;
+
 static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 			       int offset, int irq_index)
 {
@@ -351,7 +353,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 		dev_err(&dev->dev, "No memory for MSI cascade data\n");
 		return -ENOMEM;
 	}
-
+	irq_set_lockdep_class(virt_msir, &fsl_msi_irq_class);
 	msi->msi_virqs[irq_index] = virt_msir;
 	cascade_data->index = offset;
 	cascade_data->msi_data = msi;
-- 
1.7.6.5
