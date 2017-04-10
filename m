Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w25280qq4zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:48:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Create asm/debugfs.h and move
 powerpc_debugfs_root there
Date: Tue, 11 Apr 2017 08:48:26 +1000
Message-Id: <1491864507-16741-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc_debugfs_root is the dentry representing the root of the
"powerpc" directory tree in debugfs.

Currently it sits in asm/debug.h, a long with some other things that
have "debug" in the name, but are otherwise unrelated.

Pull it out into a separate header, which also includes linux/debugfs.h,
and convert all the users to include debugfs.h instead of debug.h.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/debug.h          |  2 --
 arch/powerpc/include/asm/debugfs.h        | 17 +++++++++++++++++
 arch/powerpc/kernel/eeh.c                 |  3 +--
 arch/powerpc/kernel/fadump.c              |  2 +-
 arch/powerpc/kernel/setup-common.c        |  2 +-
 arch/powerpc/kernel/traps.c               |  2 +-
 arch/powerpc/kvm/book3s_xics.c            |  3 +--
 arch/powerpc/mm/hash_utils_64.c           |  3 +--
 arch/powerpc/platforms/cell/axon_msi.c    |  2 +-
 arch/powerpc/platforms/powernv/opal-lpc.c |  3 +--
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 +--
 arch/powerpc/platforms/pseries/dtl.c      |  3 +--
 arch/powerpc/sysdev/scom.c                |  3 +--
 arch/powerpc/xmon/xmon.c                  |  5 +----
 14 files changed, 29 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/include/asm/debugfs.h

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 86308f177f2d..5d5af3fddfd8 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -8,8 +8,6 @@
 
 struct pt_regs;
 
-extern struct dentry *powerpc_debugfs_root;
-
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 
 extern int (*__debugger)(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/debugfs.h b/arch/powerpc/include/asm/debugfs.h
new file mode 100644
index 000000000000..4f3b39f3e3d2
--- /dev/null
+++ b/arch/powerpc/include/asm/debugfs.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_POWERPC_DEBUGFS_H
+#define _ASM_POWERPC_DEBUGFS_H
+
+/*
+ * Copyright 2017, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/debugfs.h>
+
+extern struct dentry *powerpc_debugfs_root;
+
+#endif /* _ASM_POWERPC_DEBUGFS_H */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9de7f79e702b..63992b2d8e15 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/debugfs.h>
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -37,7 +36,7 @@
 #include <linux/of.h>
 
 #include <linux/atomic.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 33b2da302730..c7acc6651ce7 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -30,12 +30,12 @@
 #include <linux/string.h>
 #include <linux/memblock.h>
 #include <linux/delay.h>
-#include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 
+#include <asm/debugfs.h>
 #include <asm/page.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index fcdca741f660..5c10b5925ac2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -31,11 +31,11 @@
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
-#include <linux/debugfs.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
+#include <asm/debugfs.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ff365f9de27a..354946236c61 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -35,13 +35,13 @@
 #include <linux/backlight.h>
 #include <linux/bug.h>
 #include <linux/kdebug.h>
-#include <linux/debugfs.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
 
 #include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
 #include <linux/uaccess.h>
+#include <asm/debugfs.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index e48803e2918d..dc4352395887 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -19,10 +19,9 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
 #include <asm/xics.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/time.h>
 
-#include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
 #include "book3s_xics.h"
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 69a05b3e4d3f..f2095ce9d4b0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -35,9 +35,8 @@
 #include <linux/memblock.h>
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
-#include <linux/debugfs.h>
 
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 8b55c5f19d4c..8d3ae2cc52bf 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -15,9 +15,9 @@
 #include <linux/msi.h>
 #include <linux/export.h>
 #include <linux/of_platform.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
 
+#include <asm/debugfs.h>
 #include <asm/dcr.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index a91d7876fae2..6c7ad1d8b32e 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/bug.h>
-#include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -21,7 +20,7 @@
 #include <asm/opal.h>
 #include <asm/prom.h>
 #include <linux/uaccess.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/isa-bridge.h>
 
 static int opal_lpc_chip_id = -1;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9c050fe5a6e8..7eebc76721ea 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/crash_dump.h>
-#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -38,7 +37,7 @@
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/xics.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/firmware.h>
 #include <asm/pnv-pci.h>
 #include <asm/mmzone.h>
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 6b04e3f0f982..18014cdeb590 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -21,13 +21,12 @@
  */
 
 #include <linux/slab.h>
-#include <linux/debugfs.h>
 #include <linux/spinlock.h>
 #include <asm/smp.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
 #include <asm/lppaca.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/machdep.h>
 
diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index d0e9f178a324..76ea32c1b664 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -19,10 +19,9 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <asm/debug.h>
+#include <asm/debugfs.h>
 #include <asm/prom.h>
 #include <asm/scom.h>
 #include <linux/uaccess.h>
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0fab9d7349eb..fddc857af772 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -29,10 +29,7 @@
 #include <linux/nmi.h>
 #include <linux/ctype.h>
 
-#ifdef CONFIG_DEBUG_FS
-#include <linux/debugfs.h>
-#endif
-
+#include <asm/debugfs.h>
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/prom.h>
-- 
2.7.4
