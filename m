Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BD01DDF23
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:00:49 +1100 (EST)
Message-Id: <20070207124609.224207000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/12] powerpc: MPIC sys_device & suspend/resume
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds mpic to the system devices and implements suspend
and resume for them. This is necessary to get interrupts for
modules back to where they were before a suspend to disk.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Without this patch, i2sbus (built as a module) for example
doesn't work properly across a suspend-to-disk/resume cycle,
with this patch it works fine.

I'm not entirely sure if there should be some wait logic
after I restore the MPIC registers, it works as-is for me.

Over the previous version of this patch this changes that
it also restores the HT interrupts if necessary, making my
quad G5 actually work.

--- linux-2.6-git.orig/arch/powerpc/sysdev/mpic.c	2007-02-07 02:55:06.708884289 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/mpic.c	2007-02-07 04:40:38.190855996 +0100
@@ -354,6 +354,12 @@ static void mpic_startup_ht_interrupt(st
 		tmp |= 0x22;
 	writel(tmp, fixup->base + 4);
 	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+
+#ifdef CONFIG_PM
+	/* use the lowest bit inverted to the actual HW,
+	 * set if this fixup was enabled, clear otherwise */
+	mpic->save_data[source].fixup_data = tmp | 1;
+#endif
 }
 
 static void mpic_shutdown_ht_interrupt(struct mpic *mpic, unsigned int source,
@@ -375,6 +381,12 @@ static void mpic_shutdown_ht_interrupt(s
 	tmp |= 1;
 	writel(tmp, fixup->base + 4);
 	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+
+#ifdef CONFIG_PM
+	/* use the lowest bit inverted to the actual HW,
+	 * set if this fixup was enabled, clear otherwise */
+	mpic->save_data[source].fixup_data = tmp & ~1;
+#endif
 }
 
 static void __init mpic_scan_ht_pic(struct mpic *mpic, u8 __iomem *devbase,
@@ -1123,7 +1135,7 @@ void __init mpic_init(struct mpic *mpic)
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+		mpic_scan_ht_pics(mpic);
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
@@ -1147,6 +1159,12 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
+
+#ifdef CONFIG_PM
+	/* allocate memory to save mpic state */
+	mpic->save_data = alloc_bootmem(mpic->num_sources * sizeof(struct mpic_irq_save));
+	BUG_ON(mpic->save_data == NULL);
+#endif
 }
 
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
@@ -1376,3 +1394,79 @@ void smp_mpic_message_pass(int target, i
 	}
 }
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_PM
+static int mpic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct mpic *mpic = container_of(dev, struct mpic, sysdev);
+	int i;
+
+	for (i = 0; i < mpic->num_sources; i++) {
+		mpic->save_data[i].vecprio =
+			mpic_irq_read(i, MPIC_INFO(IRQ_VECTOR_PRI));
+		mpic->save_data[i].dest =
+			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION));
+	}
+
+	return 0;
+}
+
+static int mpic_resume(struct sys_device *dev)
+{
+	struct mpic *mpic = container_of(dev, struct mpic, sysdev);
+	int i;
+
+	for (i = 0; i < mpic->num_sources; i++) {
+		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI),
+			       mpic->save_data[i].vecprio);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+			       mpic->save_data[i].dest);
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+	{
+		struct mpic_irq_fixup *fixup = &mpic->fixups[i];
+
+		if (fixup->base) {
+			/* we use the lowest bit in an inverted meaning */
+			if ((mpic->save_data[i].fixup_data & 1) == 0)
+				continue;
+
+			/* Enable and configure */
+			writeb(0x10 + 2 * fixup->index, fixup->base + 2);
+
+			writel(mpic->save_data[i].fixup_data & ~1,
+			       fixup->base + 4);
+		}
+	}
+#endif
+	} /* end for loop */
+
+	return 0;
+}
+#endif
+
+static struct sysdev_class mpic_sysclass = {
+#ifdef CONFIG_PM
+	.resume = mpic_resume,
+	.suspend = mpic_suspend,
+#endif
+	set_kset_name("mpic"),
+};
+
+static int mpic_init_sys(void)
+{
+	struct mpic *mpic = mpics;
+	int error, id = 0;
+
+	error = sysdev_class_register(&mpic_sysclass);
+
+	while (mpic && !error) {
+		mpic->sysdev.cls = &mpic_sysclass;
+		mpic->sysdev.id = id++;
+		error = sysdev_register(&mpic->sysdev);
+		mpic = mpic->next;
+	}
+	return error;
+}
+
+device_initcall(mpic_init_sys);
--- linux-2.6-git.orig/include/asm-powerpc/mpic.h	2007-02-07 02:55:06.868884289 +0100
+++ linux-2.6-git/include/asm-powerpc/mpic.h	2007-02-07 04:31:41.937855996 +0100
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <linux/irq.h>
+#include <linux/sysdev.h>
 #include <asm/dcr.h>
 
 /*
@@ -243,6 +244,14 @@ struct mpic_reg_bank {
 #endif /* CONFIG_PPC_DCR */
 };
 
+struct mpic_irq_save {
+	u32		vecprio,
+			dest;
+#ifdef CONFIG_MPIC_BROKEN_U3
+	u32		fixup_data;
+#endif
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -302,6 +311,12 @@ struct mpic
 
 	/* link */
 	struct mpic		*next;
+
+	struct sys_device	sysdev;
+
+#ifdef CONFIG_PM
+	struct mpic_irq_save	*save_data;
+#endif
 };
 
 /*

--
