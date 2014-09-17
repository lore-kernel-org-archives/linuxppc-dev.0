Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA0B41A04FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 15:58:28 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 3/5] powerpc: Remove superfluous bootmem includes
Date: Wed, 17 Sep 2014 15:58:22 +1000
Message-Id: <1410933504-28564-3-git-send-email-anton@samba.org>
In-Reply-To: <1410933504-28564-1-git-send-email-anton@samba.org>
References: <1410933504-28564-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lots of places included bootmem.h even when not using bootmem.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/crash_dump.c               | 1 -
 arch/powerpc/kernel/irq.c                      | 1 -
 arch/powerpc/kernel/pci_64.c                   | 1 -
 arch/powerpc/kernel/rtas_pci.c                 | 1 -
 arch/powerpc/kernel/setup_32.c                 | 1 -
 arch/powerpc/kernel/vdso.c                     | 1 -
 arch/powerpc/kvm/book3s_hv_builtin.c           | 1 -
 arch/powerpc/mm/init_32.c                      | 1 -
 arch/powerpc/mm/init_64.c                      | 1 -
 arch/powerpc/mm/pgtable_64.c                   | 1 -
 arch/powerpc/platforms/cell/celleb_scc_epci.c  | 1 -
 arch/powerpc/platforms/cell/celleb_scc_pciex.c | 1 -
 arch/powerpc/platforms/maple/pci.c             | 1 -
 arch/powerpc/platforms/powermac/pci.c          | 1 -
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 1 -
 arch/powerpc/platforms/powernv/pci.c           | 1 -
 arch/powerpc/sysdev/fsl_msi.c                  | 1 -
 arch/powerpc/sysdev/ipic.c                     | 1 -
 arch/powerpc/sysdev/mpic.c                     | 1 -
 arch/powerpc/sysdev/mpic_pasemi_msi.c          | 1 -
 arch/powerpc/sysdev/mpic_u3msi.c               | 1 -
 arch/powerpc/sysdev/ppc4xx_msi.c               | 1 -
 arch/powerpc/sysdev/ppc4xx_pci.c               | 1 -
 arch/powerpc/sysdev/qe_lib/qe.c                | 1 -
 arch/powerpc/sysdev/qe_lib/qe_ic.c             | 1 -
 arch/powerpc/sysdev/uic.c                      | 1 -
 26 files changed, 26 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 7a13f37..0bfe370 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -12,7 +12,6 @@
 #undef DEBUG
 
 #include <linux/crash_dump.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <asm/code-patching.h>
 #include <asm/kdump.h>
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4c5891d..c47a74d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -50,7 +50,6 @@
 #include <linux/list.h>
 #include <linux/radix-tree.h>
 #include <linux/mutex.h>
-#include <linux/bootmem.h>
 #include <linux/pci.h>
 #include <linux/debugfs.h>
 #include <linux/of.h>
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 155013d..ba0f2d6 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -17,7 +17,6 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/list.h>
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index c168337..fe39926 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -26,7 +26,6 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index e2bc044..84dafdf 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/tty.h>
-#include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index f174351..305eb0d 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -20,7 +20,6 @@
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/security.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 297dbaf..6baa186 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -12,7 +12,6 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/bootmem.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/sizes.h>
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 9d1bde2..6332368 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -26,7 +26,6 @@
 #include <linux/mm.h>
 #include <linux/stddef.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 3481556..10471f9 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -34,7 +34,6 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/nodemask.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index aa91737..feed47c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -33,7 +33,6 @@
 #include <linux/swap.h>
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
-#include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
diff --git a/arch/powerpc/platforms/cell/celleb_scc_epci.c b/arch/powerpc/platforms/cell/celleb_scc_epci.c
index 844c0fa..9438bbe 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_epci.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_epci.c
@@ -25,7 +25,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/pci_regs.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/cell/celleb_scc_pciex.c b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
index 4278acf..f223875 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_pciex.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
@@ -25,7 +25,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index f7136aa..d3a1306 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/irq.h>
 
 #include <asm/sections.h>
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 7e868cc..04702db 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/of_pci.h>
 
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index df5c2cc..3ff6fe7 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -11,7 +11,6 @@
  * (at your option) any later version.
  */
 
-#include <linux/bootmem.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b854b57..f4e91a3 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/msi.h>
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 77efbae..b9afd5f 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -13,7 +13,6 @@
  *
  */
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index b50f978..b287337 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -20,7 +20,6 @@
 #include <linux/signal.h>
 #include <linux/syscore_ops.h>
 #include <linux/device.h>
-#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/fsl_devices.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 89cec0e..c4648ad 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -24,7 +24,6 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 38e6238..71d3e85 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -16,7 +16,6 @@
 #undef DEBUG
 
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/msi.h>
 #include <asm/mpic.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 9a7aa0e..6b1dd9b 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/msi.h>
 #include <asm/mpic.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 43948da..ed188a1 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_platform.h>
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index df6e2fc..086aca6 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -22,7 +22,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 238a07b..b584deb 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -22,7 +22,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/bootmem.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index b2b87c3..543765e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -23,7 +23,6 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/device.h>
-#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 9203393..7c37157 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -19,7 +19,6 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/device.h>
-#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-- 
1.9.1
