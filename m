Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 132A9DE017
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:59:44 +1000 (EST)
Message-Id: <20070618224923.498962312@arndb.de>
References: <20070618224247.972139855@arndb.de>
Date: Tue, 19 Jun 2007 00:42:51 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 4/5] cell: saving spus information for kexec crash
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andre Detsch <adetsch@br.ibm.com>
This patch adds support for investigating spus information after a
kernel crash event, through kdump vmcore file.
Implementation is based on xmon code, but the new functionality was
kept independent from xmon.

Signed-off-by: Lucio Jose Herculano Correia <luciojhc@br.ibm.com>
Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/kernel/crash.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/crash.c
+++ linux-2.6/arch/powerpc/kernel/crash.c
@@ -219,6 +219,70 @@ void crash_kexec_secondary(struct pt_reg
 	cpus_in_sr = CPU_MASK_NONE;
 }
 #endif
+#ifdef CONFIG_SPU_BASE
+
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
+
+struct crash_spu_info {
+	struct spu *spu;
+	u32 saved_spu_runcntl_RW;
+	u32 saved_spu_status_R;
+	u32 saved_spu_npc_RW;
+	u64 saved_mfc_sr1_RW;
+	u64 saved_mfc_dar;
+	u64 saved_mfc_dsisr;
+};
+
+#define CRASH_NUM_SPUS	16	/* Enough for current hardware */
+static struct crash_spu_info crash_spu_info[CRASH_NUM_SPUS];
+
+static void crash_kexec_stop_spus(void)
+{
+	struct spu *spu;
+	int i;
+	u64 tmp;
+
+	for (i = 0; i < CRASH_NUM_SPUS; i++) {
+		if (!crash_spu_info[i].spu)
+			continue;
+
+		spu = crash_spu_info[i].spu;
+
+		crash_spu_info[i].saved_spu_runcntl_RW =
+			in_be32(&spu->problem->spu_runcntl_RW);
+		crash_spu_info[i].saved_spu_status_R =
+			in_be32(&spu->problem->spu_status_R);
+		crash_spu_info[i].saved_spu_npc_RW =
+			in_be32(&spu->problem->spu_npc_RW);
+
+		crash_spu_info[i].saved_mfc_dar    = spu_mfc_dar_get(spu);
+		crash_spu_info[i].saved_mfc_dsisr  = spu_mfc_dsisr_get(spu);
+		tmp = spu_mfc_sr1_get(spu);
+		crash_spu_info[i].saved_mfc_sr1_RW = tmp;
+
+		tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+		spu_mfc_sr1_set(spu, tmp);
+
+		__delay(200);
+	}
+}
+
+void crash_register_spus(struct list_head *list)
+{
+	struct spu *spu;
+
+	list_for_each_entry(spu, list, full_list) {
+		if (spu->number >= CRASH_NUM_SPUS) {
+			WARN_ON(1);
+			continue;
+		}
+
+		crash_spu_info[spu->number].spu = spu;
+	}
+}
+
+#endif /* CONFIG_SPU_BASE */
 
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
@@ -254,6 +318,9 @@ void default_machine_crash_shutdown(stru
 	crash_save_cpu(regs, crashing_cpu);
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpu_set(crashing_cpu, cpus_in_crash);
+#ifdef CONFIG_SPU_BASE
+	crash_kexec_stop_spus();
+#endif
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(1, 0);
 }
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -166,6 +166,10 @@ int spu_irq_class_0_bottom(struct spu *s
 int spu_irq_class_1_bottom(struct spu *spu);
 void spu_irq_setaffinity(struct spu *spu, int cpu);
 
+#ifdef CONFIG_KEXEC
+void crash_register_spus(struct list_head *list);
+#endif
+
 extern void spu_invalidate_slbs(struct spu *spu);
 extern void spu_associate_mm(struct spu *spu, struct mm_struct *mm);
 
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -610,6 +610,9 @@ static int __init init_spu_base(void)
 	}
 
 	xmon_register_spus(&spu_full_list);
+#ifdef CONFIG_KEXEC
+	crash_register_spus(&spu_full_list);
+#endif
 
 	return 0;
 

--
