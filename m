Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80M0dpzzF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:38 +1000 (AEST)
Message-Id: <6dd721cdd3da28d7aa43a45edc7448d5bb8b2e86.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 05/14] powerpc: clean the inclusion of stringify.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:35 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only include linux/stringify.h is files using __stringify()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/dcr-native.h        | 1 +
 arch/powerpc/include/asm/ppc-opcode.h        | 1 -
 arch/powerpc/include/asm/reg_fsl_emb.h       | 2 ++
 arch/powerpc/include/asm/synch.h             | 1 -
 arch/powerpc/include/asm/thread_info.h       | 1 -
 arch/powerpc/kernel/prom.c                   | 1 -
 arch/powerpc/kernel/prom_init.c              | 1 -
 arch/powerpc/kvm/book3s_64_vio_hv.c          | 1 +
 arch/powerpc/lib/locks.c                     | 1 -
 arch/powerpc/perf/req-gen/_begin.h           | 2 ++
 arch/powerpc/perf/req-gen/perf.h             | 1 +
 arch/powerpc/platforms/cell/cbe_thermal.c    | 1 +
 arch/powerpc/platforms/cell/spufs/sputrace.h | 1 +
 arch/powerpc/platforms/powernv/vas.h         | 1 +
 arch/powerpc/platforms/pseries/mobility.c    | 1 +
 15 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 4a2beef74277..151dff555f50 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -25,6 +25,7 @@
 #include <linux/spinlock.h>
 #include <asm/cputable.h>
 #include <asm/cpu_has_feature.h>
+#include <linux/stringify.h>
 
 typedef struct {
 	unsigned int base;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 68d916ae1986..04a03da18602 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -12,7 +12,6 @@
 #ifndef _ASM_POWERPC_PPC_OPCODE_H
 #define _ASM_POWERPC_PPC_OPCODE_H
 
-#include <linux/stringify.h>
 #include <asm/asm-const.h>
 
 #define	__REG_R0	0
diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index d7ccf93e6279..a21f529c43d9 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -7,6 +7,8 @@
 #ifndef __ASM_POWERPC_REG_FSL_EMB_H__
 #define __ASM_POWERPC_REG_FSL_EMB_H__
 
+#include <linux/stringify.h>
+
 #ifndef __ASSEMBLY__
 /* Performance Monitor Registers */
 #define mfpmr(rn)	({unsigned int rval; \
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index f6f8c75bbb24..aca70fb43147 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -3,7 +3,6 @@
 #define _ASM_POWERPC_SYNCH_H 
 #ifdef __KERNEL__
 
-#include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 #include <asm/asm-const.h>
 
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 7b464fcbdb35..60c78b9af82e 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -27,7 +27,6 @@
 #include <linux/cache.h>
 #include <asm/processor.h>
 #include <asm/page.h>
-#include <linux/stringify.h>
 #include <asm/accounting.h>
 
 /*
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05e7fb47a7a4..60ccf08d3a08 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -23,7 +23,6 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/stringify.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 425992e393bc..59cc00414721 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -27,7 +27,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
-#include <linux/stringify.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6651f736a0b1..76cb20ffc201 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 #include <linux/list.h>
+#include <linux/stringify.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index b7b1237d4aa6..35a0ef932e1a 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
-#include <linux/stringify.h>
 #include <linux/smp.h>
 
 /* waiting for a spinlock... */
diff --git a/arch/powerpc/perf/req-gen/_begin.h b/arch/powerpc/perf/req-gen/_begin.h
index 549f8782c52d..a200b86eba3b 100644
--- a/arch/powerpc/perf/req-gen/_begin.h
+++ b/arch/powerpc/perf/req-gen/_begin.h
@@ -3,6 +3,8 @@
 #ifndef POWERPC_PERF_REQ_GEN_H_
 #define POWERPC_PERF_REQ_GEN_H_
 
+#include <linux/stringify.h>
+
 #define CAT2_STR_(t, s) __stringify(t/s)
 #define CAT2_STR(t, s) CAT2_STR_(t, s)
 #define I(...) __VA_ARGS__
diff --git a/arch/powerpc/perf/req-gen/perf.h b/arch/powerpc/perf/req-gen/perf.h
index 871a9a1766c2..fa9bc804e67a 100644
--- a/arch/powerpc/perf/req-gen/perf.h
+++ b/arch/powerpc/perf/req-gen/perf.h
@@ -3,6 +3,7 @@
 #define LINUX_POWERPC_PERF_REQ_GEN_PERF_H_
 
 #include <linux/perf_event.h>
+#include <linux/stringify.h>
 
 #ifndef REQUEST_FILE
 #error "REQUEST_FILE must be defined before including"
diff --git a/arch/powerpc/platforms/cell/cbe_thermal.c b/arch/powerpc/platforms/cell/cbe_thermal.c
index 2c15ff094483..55aac74e1cb9 100644
--- a/arch/powerpc/platforms/cell/cbe_thermal.c
+++ b/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -49,6 +49,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/stringify.h>
 #include <asm/spu.h>
 #include <asm/io.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/platforms/cell/spufs/sputrace.h b/arch/powerpc/platforms/cell/spufs/sputrace.h
index d557e999b662..1def11e911ac 100644
--- a/arch/powerpc/platforms/cell/spufs/sputrace.h
+++ b/arch/powerpc/platforms/cell/spufs/sputrace.h
@@ -3,6 +3,7 @@
 #define _TRACE_SPUFS_H
 
 #include <linux/tracepoint.h>
+#include <linux/stringify.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM spufs
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index ae0100fd35bb..f5493dbdd7ff 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/dcache.h>
 #include <linux/mutex.h>
+#include <linux/stringify.h>
 
 /*
  * Overview of Virtual Accelerator Switchboard (VAS).
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a249c7..f0e30dc94988 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 
 #include <asm/machdep.h>
 #include <asm/rtas.h>
-- 
2.13.3
