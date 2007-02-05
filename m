Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CA4BDE6F7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:10:05 +1100 (EST)
Message-Id: <20070205185837.244398000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:33 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 06/10] powerpc: MPIC sys_device & suspend/resume
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
The first hunk is just a tiny whitespace cleanup.

Without this patch, i2sbus (built as a module) for example
doesn't work properly across a suspend-to-disk/resume cycle,
with this patch it works fine.

I'm not entirely sure if there should be some wait logic
after I restore the MPIC registers, it works as-is for me.

--- mb-wireless.orig/arch/powerpc/sysdev/mpic.c	2007-02-05 14:24:05.734526864 +0100
+++ mb-wireless/arch/powerpc/sysdev/mpic.c	2007-02-05 14:24:39.464526864 +0100
@@ -1123,7 +1123,7 @@ void __init mpic_init(struct mpic *mpic)
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+		mpic_scan_ht_pics(mpic);
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
@@ -1147,6 +1147,12 @@ void __init mpic_init(struct mpic *mpic)
 
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
@@ -1376,3 +1382,61 @@ void smp_mpic_message_pass(int target, i
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
+	}
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
--- mb-wireless.orig/include/asm-powerpc/mpic.h	2007-02-05 14:24:05.784526864 +0100
+++ mb-wireless/include/asm-powerpc/mpic.h	2007-02-05 14:24:39.464526864 +0100
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <linux/irq.h>
+#include <linux/sysdev.h>
 #include <asm/dcr.h>
 
 /*
@@ -243,6 +244,11 @@ struct mpic_reg_bank {
 #endif /* CONFIG_PPC_DCR */
 };
 
+struct mpic_irq_save {
+	u32		vecprio,
+			dest;
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -302,6 +308,12 @@ struct mpic
 
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
