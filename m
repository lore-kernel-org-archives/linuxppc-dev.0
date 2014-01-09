Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30D8B2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 19:53:05 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH] powerpc: delete non-required instances of include
 <linux/init.h>
Date: Thu, 9 Jan 2014 00:44:29 -0500
Message-ID: <1389246269-1555-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

None of these files are actually using any __init type directives
and hence don't need to include <linux/init.h>.  Most are just a
left over from __devinit and __cpuinit removal, or simply due to
code getting copied from one driver to the next.

The one instance where we add an include for init.h covers off
a case where that file was implicitly getting it from another
header which itself didn't need it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ build tested for every arch/powerpc/config/* file, on next
  branch of benh/powerpc.git -- v3.13-rc1-92-gdece8ada993e ]

 arch/powerpc/include/asm/paca.h                | 1 -
 arch/powerpc/include/asm/ppc_asm.h             | 1 -
 arch/powerpc/include/asm/ps3.h                 | 1 -
 arch/powerpc/include/asm/vio.h                 | 1 -
 arch/powerpc/kernel/cacheinfo.c                | 1 -
 arch/powerpc/kernel/crash.c                    | 1 -
 arch/powerpc/kernel/eeh_pe.c                   | 1 -
 arch/powerpc/kernel/head_64.S                  | 1 +
 arch/powerpc/kernel/hw_breakpoint.c            | 1 -
 arch/powerpc/kernel/iomap.c                    | 1 -
 arch/powerpc/kernel/kgdb.c                     | 1 -
 arch/powerpc/kernel/process.c                  | 1 -
 arch/powerpc/kernel/smp-tbsync.c               | 1 -
 arch/powerpc/kernel/syscalls.c                 | 1 -
 arch/powerpc/kernel/vdso32/vdso32_wrapper.S    | 1 -
 arch/powerpc/kernel/vdso64/vdso64_wrapper.S    | 1 -
 arch/powerpc/mm/pgtable.c                      | 1 -
 arch/powerpc/mm/pgtable_64.c                   | 1 -
 arch/powerpc/mm/tlb_hash64.c                   | 1 -
 arch/powerpc/oprofile/op_model_7450.c          | 1 -
 arch/powerpc/oprofile/op_model_cell.c          | 1 -
 arch/powerpc/oprofile/op_model_fsl_emb.c       | 1 -
 arch/powerpc/oprofile/op_model_pa6t.c          | 1 -
 arch/powerpc/oprofile/op_model_power4.c        | 1 -
 arch/powerpc/oprofile/op_model_rs64.c          | 1 -
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 1 -
 arch/powerpc/platforms/83xx/suspend.c          | 1 -
 arch/powerpc/platforms/85xx/sgy_cts1000.c      | 1 -
 arch/powerpc/platforms/chrp/smp.c              | 1 -
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c  | 1 -
 arch/powerpc/platforms/pasemi/dma_lib.c        | 1 -
 arch/powerpc/platforms/powermac/pfunc_core.c   | 1 -
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 1 -
 arch/powerpc/platforms/pseries/cmm.c           | 1 -
 arch/powerpc/platforms/pseries/dtl.c           | 1 -
 arch/powerpc/sysdev/cpm2_pic.c                 | 1 -
 arch/powerpc/sysdev/fsl_ifc.c                  | 1 -
 arch/powerpc/sysdev/ge/ge_pic.h                | 1 -
 arch/powerpc/sysdev/i8259.c                    | 1 -
 arch/powerpc/sysdev/mpc8xx_pic.c               | 1 -
 arch/powerpc/sysdev/qe_lib/qe_io.c             | 1 -
 arch/powerpc/sysdev/qe_lib/ucc.c               | 1 -
 arch/powerpc/sysdev/qe_lib/ucc_fast.c          | 1 -
 arch/powerpc/sysdev/qe_lib/ucc_slow.c          | 1 -
 arch/powerpc/sysdev/udbg_memcons.c             | 1 -
 arch/powerpc/sysdev/xics/icp-hv.c              | 1 -
 46 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c3523d1dda58..68bee4636045 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -16,7 +16,6 @@
 
 #ifdef CONFIG_PPC64
 
-#include <linux/init.h>
 #include <asm/types.h>
 #include <asm/lppaca.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index f595b98079ee..7689e0e98d33 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -4,7 +4,6 @@
 #ifndef _ASM_POWERPC_PPC_ASM_H
 #define _ASM_POWERPC_PPC_ASM_H
 
-#include <linux/init.h>
 #include <linux/stringify.h>
 #include <asm/asm-compat.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 678a7c1d9cb8..a1bc7e758422 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -21,7 +21,6 @@
 #if !defined(_ASM_POWERPC_PS3_H)
 #define _ASM_POWERPC_PS3_H
 
-#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <asm/cell-pmu.h>
diff --git a/arch/powerpc/include/asm/vio.h b/arch/powerpc/include/asm/vio.h
index 68d0cc998b1b..4f9b7ca0710f 100644
--- a/arch/powerpc/include/asm/vio.h
+++ b/arch/powerpc/include/asm/vio.h
@@ -15,7 +15,6 @@
 #define _ASM_POWERPC_VIO_H
 #ifdef __KERNEL__
 
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 654932727873..abfa011344d9 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -12,7 +12,6 @@
 
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index fdcd8f551aff..18d7c80ddeb9 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -17,7 +17,6 @@
 #include <linux/export.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/types.h>
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f9450537e335..1feccd64f955 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4f0946de2d5c..b7363bd42452 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -23,6 +23,7 @@
  */
 
 #include <linux/threads.h>
+#include <linux/init.h>
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f0b47d1a6b0e..b0a1792279bb 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -28,7 +28,6 @@
 #include <linux/percpu.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 
 #include <asm/hw_breakpoint.h>
diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 97a3715ac8bd..b82227e7e21b 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -3,7 +3,6 @@
  *
  * (C) Copyright 2004 Linus Torvalds
  */
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/mm.h>
 #include <linux/export.h>
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 83e89d310734..8504657379f1 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 #include <linux/signal.h>
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3386d8ab7eb0..bf8e136316e2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/elf.h>
-#include <linux/init.h>
 #include <linux/prctl.h>
 #include <linux/init_task.h>
 #include <linux/export.h>
diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/smp-tbsync.c
index e68fd1ae727a..7a37ecd3afa3 100644
--- a/arch/powerpc/kernel/smp-tbsync.c
+++ b/arch/powerpc/kernel/smp-tbsync.c
@@ -9,7 +9,6 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/unistd.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <asm/smp.h>
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 4e3cc47f26b9..cd9be9aa016d 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -34,7 +34,6 @@
 #include <linux/ipc.h>
 #include <linux/utsname.h>
 #include <linux/file.h>
-#include <linux/init.h>
 #include <linux/personality.h>
 
 #include <asm/uaccess.h>
diff --git a/arch/powerpc/kernel/vdso32/vdso32_wrapper.S b/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
index 6e8f507ed32b..79683d0393f5 100644
--- a/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
+++ b/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
@@ -1,4 +1,3 @@
-#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/page.h>
 
diff --git a/arch/powerpc/kernel/vdso64/vdso64_wrapper.S b/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
index b8553d62b792..8df9e2463007 100644
--- a/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
+++ b/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
@@ -1,4 +1,3 @@
-#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/page.h>
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ad90429bbd8b..c695943a513c 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -24,7 +24,6 @@
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/hugetlb.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 02e8681fb865..7f0e872ab83d 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -33,7 +33,6 @@
 #include <linux/swap.h>
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
-#include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 36e44b4260eb..c99f6510a0b2 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -23,7 +23,6 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <asm/pgalloc.h>
diff --git a/arch/powerpc/oprofile/op_model_7450.c b/arch/powerpc/oprofile/op_model_7450.c
index ff617246d128..d29b6e4e5e72 100644
--- a/arch/powerpc/oprofile/op_model_7450.c
+++ b/arch/powerpc/oprofile/op_model_7450.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprofile/op_model_cell.c
index b9589c19ccda..1f0ebdeea5f7 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -16,7 +16,6 @@
 
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kthread.h>
 #include <linux/oprofile.h>
diff --git a/arch/powerpc/oprofile/op_model_fsl_emb.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
index 2a82d3ed464d..14cf86fdddab 100644
--- a/arch/powerpc/oprofile/op_model_fsl_emb.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/oprofile/op_model_pa6t.c b/arch/powerpc/oprofile/op_model_pa6t.c
index 42f778dff919..a114a7c22d40 100644
--- a/arch/powerpc/oprofile/op_model_pa6t.c
+++ b/arch/powerpc/oprofile/op_model_pa6t.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/percpu.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index f444b94935f5..962fe7b3e3fb 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
diff --git a/arch/powerpc/oprofile/op_model_rs64.c b/arch/powerpc/oprofile/op_model_rs64.c
index 9b801b8c8c5a..7e5b8ed3a1b7 100644
--- a/arch/powerpc/oprofile/op_model_rs64.c
+++ b/arch/powerpc/oprofile/op_model_rs64.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/init.h>
 #include <linux/smp.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index fd71cfdf2380..e238b6a55b15 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -11,7 +11,6 @@
  * (at your option) any later version.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 3d9716ccd327..4b4c081df94d 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -10,7 +10,6 @@
  * by the Free Software Foundation.
  */
 
-#include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index b9197cea1854..bb75add67084 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/workqueue.h>
diff --git a/arch/powerpc/platforms/chrp/smp.c b/arch/powerpc/platforms/chrp/smp.c
index dead91b177b9..b6c9a0dcc924 100644
--- a/arch/powerpc/platforms/chrp/smp.c
+++ b/arch/powerpc/platforms/chrp/smp.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/spinlock.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 6c03034dbbd3..c269caee58f9 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -15,7 +15,6 @@
 #define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index f3defd8a2806..aafa01ba062f 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index d588e48dff74..43075081721f 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -5,7 +5,6 @@
  * FIXME: LOCKING !!!
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 9b1db254898a..007ac4989841 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -14,7 +14,6 @@
 #include <linux/bootmem.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 1e561bef459b..2d8bf15879fd 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -25,7 +25,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
-#include <linux/init.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/oom.h>
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 5db66f1fbc26..7d61498e45c0 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -20,7 +20,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/spinlock.h>
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 10386b676d87..a11bd1d433ad 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -27,7 +27,6 @@
  */
 
 #include <linux/stddef.h>
-#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/irq.h>
diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/arch/powerpc/sysdev/fsl_ifc.c
index d7fc72239144..fbc885b31946 100644
--- a/arch/powerpc/sysdev/fsl_ifc.c
+++ b/arch/powerpc/sysdev/fsl_ifc.c
@@ -19,7 +19,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
diff --git a/arch/powerpc/sysdev/ge/ge_pic.h b/arch/powerpc/sysdev/ge/ge_pic.h
index 6149916da3f4..908dbd9826b6 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.h
+++ b/arch/powerpc/sysdev/ge/ge_pic.h
@@ -1,7 +1,6 @@
 #ifndef __GEF_PIC_H__
 #define __GEF_PIC_H__
 
-#include <linux/init.h>
 
 void gef_pic_cascade(unsigned int, struct irq_desc *);
 unsigned int gef_pic_get_irq(void);
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 997df6a7ab5d..45598da0b321 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -8,7 +8,6 @@
  */
 #undef DEBUG
 
-#include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index b724622c3a0b..c4828c0be5bd 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -1,6 +1,5 @@
 #include <linux/kernel.h>
 #include <linux/stddef.h>
-#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/irq.h>
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index a88807b3dd57..d09994164daf 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -16,7 +16,6 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index 134b07d29435..621575b7e84a 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -14,7 +14,6 @@
  * option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index cceb2e366738..65aaf15032ae 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -13,7 +13,6 @@
  * option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 1c062f48f1ac..befaf1123f7f 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -13,7 +13,6 @@
  * option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
diff --git a/arch/powerpc/sysdev/udbg_memcons.c b/arch/powerpc/sysdev/udbg_memcons.c
index ce5a7b489e4b..9998c0de12d0 100644
--- a/arch/powerpc/sysdev/udbg_memcons.c
+++ b/arch/powerpc/sysdev/udbg_memcons.c
@@ -18,7 +18,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <asm/barrier.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index df0fc5821469..c1917cf67c3d 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -12,7 +12,6 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
-- 
1.8.5.2
