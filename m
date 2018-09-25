Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRst2zV3zF1pS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:51:14 +1000 (AEST)
Message-Id: <a866faa9455b0e59d7d7bca28cb06c09ab5f3589.1537892499.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 16/22] powerpc/mm: move platform specific mmu-xxx.h in
 platform directories
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 16:51:10 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this patch is to move platform specific
mmu-xxx.h files in platform directories like pte-xxx.h files.

In the meantime this patch creates common nohash and
nohash/32 + nohash/64 mmu.h files for future common parts.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h                     | 14 ++------------
 arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |  0
 arch/powerpc/include/asm/nohash/32/mmu.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/mmu.h           |  8 ++++++++
 arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |  0
 arch/powerpc/include/asm/nohash/mmu.h              | 11 +++++++++++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  2 +-
 arch/powerpc/kvm/e500.h                            |  2 +-
 10 files changed, 42 insertions(+), 14 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 13ea441ac531..2b396de45e9e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -326,18 +326,8 @@ static inline void mmu_early_init_devtree(void) { }
 #if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
-#elif defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#  include <asm/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#  include <asm/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#  include <asm/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#  include <asm/mmu-8xx.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/mmu.h>
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-40x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-40x.h
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-44x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-44x.h
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-8xx.h
rename to arch/powerpc/include/asm/nohash/32/mmu-8xx.h
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
new file mode 100644
index 000000000000..af0e8b54876a
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
+#define _ASM_POWERPC_NOHASH_32_MMU_H_
+
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
new file mode 100644
index 000000000000..87871d027b75
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
+#define _ASM_POWERPC_NOHASH_64_MMU_H_
+
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+
+#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-book3e.h
rename to arch/powerpc/include/asm/nohash/mmu-book3e.h
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
new file mode 100644
index 000000000000..a037cb1efb57
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_MMU_H_
+#define _ASM_POWERPC_NOHASH_MMU_H_
+
+#ifdef CONFIG_PPC64
+#include <asm/nohash/64/mmu.h>
+#else
+#include <asm/nohash/32/mmu.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8d142e5d84cd..5fbc890d1094 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,7 +17,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/asm-offsets.h>
 #include <asm/mpc85xx.h>
 
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 94f04fcb373e..962ee90a0dfe 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -20,7 +20,7 @@
 #define KVM_E500_H
 
 #include <linux/kvm_host.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/tlb.h>
 #include <asm/cputhreads.h>
 
-- 
2.13.3
