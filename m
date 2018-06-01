Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80K1PM6zF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:37 +1000 (AEST)
Message-Id: <50631629bf42d8dcbf8f9f316ae6fced0692d3c1.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 04/14] powerpc: move ASM_CONST and stringify_in_c()
 into asm-const.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:33 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves ASM_CONST() and stringify_in_c() into
dedicated asm-const.h, then cleans all related inclusions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/crypto/md5-asm.S                  |  1 +
 arch/powerpc/crypto/sha1-powerpc-asm.S         |  1 +
 arch/powerpc/include/asm/asm-compat.h          | 13 +------------
 arch/powerpc/include/asm/asm-const.h           | 14 ++++++++++++++
 arch/powerpc/include/asm/barrier.h             |  2 ++
 arch/powerpc/include/asm/book3s/64/hash.h      |  2 ++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/radix.h     |  2 ++
 arch/powerpc/include/asm/cmpxchg.h             |  1 -
 arch/powerpc/include/asm/code-patching.h       |  1 +
 arch/powerpc/include/asm/cputable.h            |  2 +-
 arch/powerpc/include/asm/dt_cpu_ftrs.h         |  1 -
 arch/powerpc/include/asm/feature-fixups.h      |  2 ++
 arch/powerpc/include/asm/firmware.h            |  2 +-
 arch/powerpc/include/asm/futex.h               |  1 -
 arch/powerpc/include/asm/iommu.h               |  1 +
 arch/powerpc/include/asm/jump_label.h          |  2 +-
 arch/powerpc/include/asm/mmu-44x.h             |  1 +
 arch/powerpc/include/asm/mmu.h                 |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h   |  1 +
 arch/powerpc/include/asm/page.h                |  2 +-
 arch/powerpc/include/asm/page_64.h             |  2 ++
 arch/powerpc/include/asm/ppc-opcode.h          |  2 +-
 arch/powerpc/include/asm/ptrace.h              |  1 +
 arch/powerpc/include/asm/reg.h                 |  1 +
 arch/powerpc/include/asm/reg_a2.h              |  2 ++
 arch/powerpc/include/asm/spinlock.h            |  1 -
 arch/powerpc/include/asm/synch.h               |  1 +
 arch/powerpc/include/asm/thread_info.h         |  2 ++
 arch/powerpc/include/asm/uaccess.h             |  1 -
 arch/powerpc/kernel/entry_64.S                 |  1 +
 arch/powerpc/kernel/fpu.S                      |  1 +
 arch/powerpc/kernel/idle_book3s.S              |  1 +
 arch/powerpc/kernel/kvm_emul.S                 |  1 +
 arch/powerpc/kernel/ppc_save_regs.S            |  1 +
 arch/powerpc/kernel/vector.S                   |  1 +
 arch/powerpc/kvm/book3s_64_slb.S               |  2 ++
 arch/powerpc/kvm/book3s_hv_interrupts.S        |  1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  1 +
 arch/powerpc/kvm/book3s_interrupts.S           |  1 +
 arch/powerpc/kvm/book3s_rmhandlers.S           |  1 +
 arch/powerpc/kvm/book3s_segment.S              |  2 ++
 arch/powerpc/lib/copyuser_64.S                 |  1 +
 arch/powerpc/lib/feature-fixups-test.S         |  1 +
 arch/powerpc/lib/ldstfp.S                      |  1 +
 arch/powerpc/lib/memcpy_64.S                   |  1 +
 arch/powerpc/lib/string.S                      |  1 +
 arch/powerpc/mm/tlb_nohash_low.S               |  1 +
 arch/powerpc/net/bpf_jit32.h                   |  1 +
 arch/powerpc/net/bpf_jit_asm.S                 |  1 +
 arch/powerpc/net/bpf_jit_asm64.S               |  1 +
 arch/powerpc/net/bpf_jit_comp.c                |  1 +
 arch/powerpc/net/bpf_jit_comp64.c              |  1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/pseries/setup.c         |  1 +
 arch/powerpc/purgatory/trampoline.S            | 10 +---------
 arch/powerpc/xmon/spr_access.S                 |  1 +
 57 files changed, 74 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm-const.h

diff --git a/arch/powerpc/crypto/md5-asm.S b/arch/powerpc/crypto/md5-asm.S
index 10cdf5bceebb..1834065362c7 100644
--- a/arch/powerpc/crypto/md5-asm.S
+++ b/arch/powerpc/crypto/md5-asm.S
@@ -11,6 +11,7 @@
  */
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-compat.h>
 
 #define rHP	r3
 #define rWP	r4
diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
index c8951ce0dcc4..23e248beff71 100644
--- a/arch/powerpc/crypto/sha1-powerpc-asm.S
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -7,6 +7,7 @@
 
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-compat.h>
 
 #ifdef __BIG_ENDIAN__
 #define LWZ(rt, d, ra)	\
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index d2cf3593e987..09f8dd4da883 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -1,21 +1,10 @@
 #ifndef _ASM_POWERPC_ASM_COMPAT_H
 #define _ASM_POWERPC_ASM_COMPAT_H
 
+#include <asm/asm-compat.h>
 #include <asm/types.h>
 #include <asm/ppc-opcode.h>
 
-#ifdef __ASSEMBLY__
-#  define stringify_in_c(...)	__VA_ARGS__
-#  define ASM_CONST(x)		x
-#else
-/* This version of stringify will deal with commas... */
-#  define __stringify_in_c(...)	#__VA_ARGS__
-#  define stringify_in_c(...)	__stringify_in_c(__VA_ARGS__) " "
-#  define __ASM_CONST(x)	x##UL
-#  define ASM_CONST(x)		__ASM_CONST(x)
-#endif
-
-
 #ifdef __powerpc64__
 
 /* operations for longs and pointers */
diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
new file mode 100644
index 000000000000..082c1538c562
--- /dev/null
+++ b/arch/powerpc/include/asm/asm-const.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_POWERPC_ASM_CONST_H
+#define _ASM_POWERPC_ASM_CONST_H
+
+#ifdef __ASSEMBLY__
+#  define stringify_in_c(...)	__VA_ARGS__
+#  define ASM_CONST(x)		x
+#else
+/* This version of stringify will deal with commas... */
+#  define __stringify_in_c(...)	#__VA_ARGS__
+#  define stringify_in_c(...)	__stringify_in_c(__VA_ARGS__) " "
+#  define __ASM_CONST(x)	x##UL
+#  define ASM_CONST(x)		__ASM_CONST(x)
+#endif
+#endif /* _ASM_POWERPC_ASM_CONST_H */
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c7c63959ba91..117d09df869f 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_POWERPC_BARRIER_H
 #define _ASM_POWERPC_BARRIER_H
 
+#include <asm/asm-const.h>
+
 /*
  * Memory barrier.
  * The sync instruction guarantees that all memory accesses initiated
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0387b155f13d..d52a51b2ce7b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -3,6 +3,8 @@
 #define _ASM_POWERPC_BOOK3S_64_HASH_H
 #ifdef __KERNEL__
 
+#include <asm/asm-const.h>
+
 /*
  * Common bits between 4K and 64K pages in a linux-style PTE.
  * Additional bits may be defined in pgtable-hash64-*.h
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 50ed64fba4ae..a2b384545bce 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -12,9 +12,9 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <asm/asm-compat.h>
 #include <asm/page.h>
 #include <asm/bug.h>
+#include <asm/asm-const.h>
 
 /*
  * This is necessary to get the definition of PGTABLE_RANGE which we
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 705193e7192f..c62cfd19f3f5 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_PGTABLE_RADIX_H
 #define _ASM_POWERPC_PGTABLE_RADIX_H
 
+#include <asm/asm-const.h>
+
 #ifndef __ASSEMBLY__
 #include <asm/cmpxchg.h>
 #endif
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 67ec1073ac97..27183871eb3b 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -5,7 +5,6 @@
 #ifdef __KERNEL__
 #include <linux/compiler.h>
 #include <asm/synch.h>
-#include <asm/asm-compat.h>
 #include <linux/bug.h>
 #include <asm/asm-405.h>
 
diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 812535f40124..9ecc7bfc8ae7 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -14,6 +14,7 @@
 #include <asm/ppc-opcode.h>
 #include <linux/string.h>
 #include <linux/kallsyms.h>
+#include <asm/asm-compat.h>
 
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 66fcab13c8b4..5e29b8a2106a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -4,9 +4,9 @@
 
 
 #include <linux/types.h>
-#include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
+#include <asm/asm-const.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/dt_cpu_ftrs.h b/arch/powerpc/include/asm/dt_cpu_ftrs.h
index 71515d909ed1..55113432fc91 100644
--- a/arch/powerpc/include/asm/dt_cpu_ftrs.h
+++ b/arch/powerpc/include/asm/dt_cpu_ftrs.h
@@ -10,7 +10,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index a9b64df34e2a..b4dc055498e0 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_POWERPC_FEATURE_FIXUPS_H
 #define __ASM_POWERPC_FEATURE_FIXUPS_H
 
+#include <asm/asm-const.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 535add3f7791..ce8aab72c21b 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -14,8 +14,8 @@
 
 #ifdef __KERNEL__
 
-#include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/asm-const.h>
 
 /* firmware feature bitmask values */
 
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 76c8648d0fa8..94542776a62d 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -8,7 +8,6 @@
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 #include <asm/synch.h>
-#include <asm/asm-compat.h>
 #include <asm/asm-405.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 20febe0b7f32..880a8a19d20d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -30,6 +30,7 @@
 #include <asm/machdep.h>
 #include <asm/types.h>
 #include <asm/pci-bridge.h>
+#include <asm/asm-const.h>
 
 #define IOMMU_PAGE_SHIFT_4K      12
 #define IOMMU_PAGE_SIZE_4K       (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K)
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..a3b2cf940b4e 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 
 #include <asm/feature-fixups.h>
-#include <asm/asm-compat.h>
+#include <asm/asm-const.h>
 
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index cb57f29f531d..9bdbe1d1c9b9 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -6,6 +6,7 @@
  */
 
 #include <asm/page.h>
+#include <asm/asm-const.h>
 
 #define PPC44x_MMUCR_TID	0x000000ff
 #define PPC44x_MMUCR_STS	0x00010000
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 61d15ce92278..8418d83b5eb0 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -5,8 +5,8 @@
 
 #include <linux/types.h>
 
-#include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/asm-const.h>
 
 /*
  * MMU features bit definitions
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index de78eda5f841..b90256f74cc8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -8,6 +8,7 @@
 
 #include <asm/nohash/64/pgtable-4k.h>
 #include <asm/barrier.h>
+#include <asm/asm-const.h>
 
 #ifdef CONFIG_PPC_64K_PAGES
 #error "Page size not supported"
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index a9fbefaacf10..f6a1265face2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -16,7 +16,7 @@
 #else
 #include <asm/types.h>
 #endif
-#include <asm/asm-compat.h>
+#include <asm/asm-const.h>
 
 /*
  * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index af04acdb873f..c0ce17e909ef 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <asm/asm-const.h>
+
 /*
  * We always define HW_PAGE_SHIFT to 12 as use of 64K pages remains Linux
  * specific, every notion of page number shared with the firmware, TCEs,
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 4436887bc415..68d916ae1986 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -13,7 +13,7 @@
 #define _ASM_POWERPC_PPC_OPCODE_H
 
 #include <linux/stringify.h>
-#include <asm/asm-compat.h>
+#include <asm/asm-const.h>
 
 #define	__REG_R0	0
 #define	__REG_R1	1
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index e4923686e43a..447cbd1bee99 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -24,6 +24,7 @@
 #define _ASM_POWERPC_PTRACE_H
 
 #include <uapi/asm/ptrace.h>
+#include <asm/asm-const.h>
 
 
 #ifdef __powerpc64__
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cb0f272ce123..11bcbe1ba134 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -13,6 +13,7 @@
 
 #include <linux/stringify.h>
 #include <asm/cputable.h>
+#include <asm/asm-const.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
diff --git a/arch/powerpc/include/asm/reg_a2.h b/arch/powerpc/include/asm/reg_a2.h
index 3ba9c6f096fc..74c2c57c492a 100644
--- a/arch/powerpc/include/asm/reg_a2.h
+++ b/arch/powerpc/include/asm/reg_a2.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_POWERPC_REG_A2_H__
 #define __ASM_POWERPC_REG_A2_H__
 
+#include <asm/asm-const.h>
+
 #define SPRN_TENSR	0x1b5
 #define SPRN_TENS	0x1b6	/* Thread ENable Set */
 #define SPRN_TENC	0x1b7	/* Thread ENable Clear */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 7ec38f4ee927..685c72310f5d 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -24,7 +24,6 @@
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #endif
-#include <asm/asm-compat.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-405.h>
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index 6ec546090ba1..f6f8c75bbb24 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -5,6 +5,7 @@
 
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
+#include <asm/asm-const.h>
 
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 5964145db03d..7b464fcbdb35 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_POWERPC_THREAD_INFO_H
 #define _ASM_POWERPC_THREAD_INFO_H
 
+#include <asm/asm-const.h>
+
 #ifdef __KERNEL__
 
 #define THREAD_SHIFT		CONFIG_THREAD_SHIFT
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a62ee663b2c8..3629288a0440 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -2,7 +2,6 @@
 #ifndef _ARCH_POWERPC_UACCESS_H
 #define _ARCH_POWERPC_UACCESS_H
 
-#include <asm/asm-compat.h>
 #include <asm/ppc_asm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51695608c68b..47fa78de602d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -37,6 +37,7 @@
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
 #else
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 6c509f39bbde..07c913fd5aba 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -25,6 +25,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 
 #ifdef CONFIG_VSX
 #define __REST_32FPVSRS(n,c,base)					\
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index e734f6e45abc..3db0513d8442 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -23,6 +23,7 @@
 #include <asm/exception-64s.h>
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/mmu.h>
+#include <asm/asm-compat.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index e100ff324a85..c005088f6c9c 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -23,6 +23,7 @@
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-compat.h>
 
 #define KVM_MAGIC_PAGE		(-4096)
 
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 8afbe213d729..6d1b42ee797c 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -12,6 +12,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/asm-compat.h>
 
 /*
  * Grab the register values as they are now.
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index f314fd475491..21165da0052d 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -8,6 +8,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 
 /*
  * Load state from memory into VMX registers including VSCR.
diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_slb.S
index 688722acd692..d293485c1a60 100644
--- a/arch/powerpc/kvm/book3s_64_slb.S
+++ b/arch/powerpc/kvm/book3s_64_slb.S
@@ -17,6 +17,8 @@
  * Authors: Alexander Graf <agraf@suse.de>
  */
 
+#include <asm/asm-compat.h>
+
 #define SHADOW_SLB_ENTRY_LEN	0x10
 #define OFFSET_ESID(x)		(SHADOW_SLB_ENTRY_LEN * x)
 #define OFFSET_VSID(x)		((SHADOW_SLB_ENTRY_LEN * x) + 8)
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 0e8493033288..eb918756f54e 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -27,6 +27,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/exception-64s.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-compat.h>
 
 /*****************************************************************************
  *                                                                           *
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b97d261d3b89..849063a5d39b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -32,6 +32,7 @@
 #include <asm/opal.h>
 #include <asm/xive-regs.h>
 #include <asm/thread_info.h>
+#include <asm/asm-compat.h>
 
 /* Sign-extend HDEC if not on POWER9 */
 #define EXTEND_HDEC(reg)			\
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index c18e845019ec..d71dab16dc6f 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -23,6 +23,7 @@
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 #include <asm/exception-64s.h>
+#include <asm/asm-compat.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 #ifdef PPC64_ELF_ABI_v2
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 34a5adeff084..b0089e04c8c8 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -23,6 +23,7 @@
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-compat.h>
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/exception-64s.h>
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 93a180ceefad..e19dabea22cc 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -19,6 +19,8 @@
 
 /* Real mode helpers */
 
+#include <asm/asm-compat.h>
+
 #if defined(CONFIG_PPC_BOOK3S_64)
 
 #define GET_SHADOW_VCPU(reg)    \
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 506677395681..65244263b6a3 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 
 #ifdef __BIG_ENDIAN__
 #define sLd sld		/* Shift towards low-numbered address. */
diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index f16cec989506..ee7c5fd5fc64 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -11,6 +11,7 @@
 #include <asm/feature-fixups.h>
 #include <asm/ppc_asm.h>
 #include <asm/synch.h>
+#include <asm/asm-compat.h>
 
 	.text
 
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index ae15eba49c1f..32e91994b6b2 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -15,6 +15,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/reg.h>
 #include <asm/asm-offsets.h>
+#include <asm/asm-compat.h>
 #include <linux/errno.h>
 
 #ifdef CONFIG_PPC_FPU
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 8d8265be1a59..26ea02b7311f 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 
 	.align	7
 _GLOBAL_TOC(memcpy)
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index a787776822d8..2eb3cb1b94df 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -12,6 +12,7 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/asm-compat.h>
 
 	.text
 	
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 048b8e9f4492..505a3d010c47 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -34,6 +34,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/bug.h>
+#include <asm/asm-compat.h>
 
 #if defined(CONFIG_40x)
 
diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
index a8cd7e289ecd..6f4daacad296 100644
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -13,6 +13,7 @@
 #ifndef _BPF_JIT32_H
 #define _BPF_JIT32_H
 
+#include <asm/asm-compat.h>
 #include "bpf_jit.h"
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/net/bpf_jit_asm.S b/arch/powerpc/net/bpf_jit_asm.S
index 3dd9c43d40c9..c80280dc2e04 100644
--- a/arch/powerpc/net/bpf_jit_asm.S
+++ b/arch/powerpc/net/bpf_jit_asm.S
@@ -10,6 +10,7 @@
  */
 
 #include <asm/ppc_asm.h>
+#include <asm/asm-compat.h>
 #include "bpf_jit32.h"
 
 /*
diff --git a/arch/powerpc/net/bpf_jit_asm64.S b/arch/powerpc/net/bpf_jit_asm64.S
index 7e4c51430b84..ce24f4969d8e 100644
--- a/arch/powerpc/net/bpf_jit_asm64.S
+++ b/arch/powerpc/net/bpf_jit_asm64.S
@@ -15,6 +15,7 @@
 
 #include <asm/ppc_asm.h>
 #include <asm/ptrace.h>
+#include <asm/asm-compat.h>
 #include "bpf_jit64.h"
 
 /*
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a9636d8cba15..4524ea813a7c 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
  */
 #include <linux/moduleloader.h>
 #include <asm/cacheflush.h>
+#include <asm/asm-compat.h>
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 0ef3d9580e98..4bc8c077f7a7 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -13,6 +13,7 @@
  */
 #include <linux/moduleloader.h>
 #include <asm/cacheflush.h>
+#include <asm/asm-compat.h>
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8482df255969..974885ff14c4 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -14,6 +14,7 @@
 #include <asm/hvcall.h>
 #include <asm/asm-offsets.h>
 #include <asm/opal.h>
+#include <asm/asm-compat.h>
 
 	.section	".text"
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fdb32e056ef4..a0a6c8b92b60 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -69,6 +69,7 @@
 #include <asm/kexec.h>
 #include <asm/isa-bridge.h>
 #include <asm/security_features.h>
+#include <asm/asm-const.h>
 
 #include "pseries.h"
 
diff --git a/arch/powerpc/purgatory/trampoline.S b/arch/powerpc/purgatory/trampoline.S
index 4aad9dd10ace..1e1129553fd7 100644
--- a/arch/powerpc/purgatory/trampoline.S
+++ b/arch/powerpc/purgatory/trampoline.S
@@ -12,15 +12,7 @@
  * Software Foundation (version 2 of the License).
  */
 
-#if defined(__LITTLE_ENDIAN__)
-#define STWX_BE	stwbrx
-#define LWZX_BE	lwbrx
-#elif defined(__BIG_ENDIAN__)
-#define STWX_BE	stwx
-#define LWZX_BE	lwzx
-#else
-#error no endianness defined!
-#endif
+#include <asm/asm-compat.h>
 
 	.machine ppc64
 	.balign 256
diff --git a/arch/powerpc/xmon/spr_access.S b/arch/powerpc/xmon/spr_access.S
index 4099cbcddaaa..720a52afdd58 100644
--- a/arch/powerpc/xmon/spr_access.S
+++ b/arch/powerpc/xmon/spr_access.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/ppc_asm.h>
+#include <asm/asm-compat.h>
 
 /* unsigned long xmon_mfspr(sprn, default_value) */
 _GLOBAL(xmon_mfspr)
-- 
2.13.3
