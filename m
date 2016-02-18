Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBA871A0359
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:52:12 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 09:52:10 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9AFD419D8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:40:06 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGq8wo31588456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 16:52:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGq7mE029760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:52:08 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 24/30] powerpc/mm: Move hash related mmu-*.h headers to
 book3s/
Date: Thu, 18 Feb 2016 22:20:48 +0530
Message-Id: <1455814254-10226-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/{mmu-hash32.h => book3s/32/mmu-hash.h} | 0
 arch/powerpc/include/asm/{mmu-hash64.h => book3s/64/mmu-hash.h} | 0
 arch/powerpc/include/asm/mmu.h                                  | 4 ++--
 arch/powerpc/kernel/idle_power7.S                               | 2 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c                           | 2 +-
 arch/powerpc/kvm/book3s_64_mmu.c                                | 2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c                           | 2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                             | 2 +-
 arch/powerpc/kvm/book3s_64_vio.c                                | 2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                             | 2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                             | 2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S                         | 2 +-
 12 files changed, 11 insertions(+), 11 deletions(-)
 rename arch/powerpc/include/asm/{mmu-hash32.h => book3s/32/mmu-hash.h} (100%)
 rename arch/powerpc/include/asm/{mmu-hash64.h => book3s/64/mmu-hash.h} (100%)

diff --git a/arch/powerpc/include/asm/mmu-hash32.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-hash32.h
rename to arch/powerpc/include/asm/book3s/32/mmu-hash.h
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-hash64.h
rename to arch/powerpc/include/asm/book3s/64/mmu-hash.h
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 54d46504733d..8ca1c983bf6c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -183,10 +183,10 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 
 #if defined(CONFIG_PPC_STD_MMU_64)
 /* 64-bit classic hash table MMU */
-#  include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #elif defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
-#  include <asm/mmu-hash32.h>
+#include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
 /* 40x-style software loaded TLB */
 #  include <asm/mmu-40x.h>
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index cf4fb5429cf1..470ceebd2d23 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -19,7 +19,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/opal.h>
 #include <asm/cpuidle.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 55c4d51ea3e2..999106991a76 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -22,7 +22,7 @@
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash32.h>
+#include <asm/book3s/32/mmu-hash.h>
 #include <asm/machdep.h>
 #include <asm/mmu_context.h>
 #include <asm/hw_irq.h>
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 9bf7031a67ff..b9131aa1aedf 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -26,7 +26,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 
 /* #define DEBUG_MMU */
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 30fc2d83dffa..d7959b2a8b32 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -23,7 +23,7 @@
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/machdep.h>
 #include <asm/mmu_context.h>
 #include <asm/hw_irq.h>
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index fb37290a57b4..c7b78d8336b2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -32,7 +32,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 54cf9bc94dad..9c3b76bb69d9 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -30,7 +30,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 89e96b3e0039..039028d3ccb5 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -29,7 +29,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 91700518bbf3..4cb8db05f3e5 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -17,7 +17,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6ee26de9a1de..c613fee0b9f7 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -27,7 +27,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/exception-64s.h>
 #include <asm/kvm_book3s_asm.h>
-#include <asm/mmu-hash64.h>
+#include <asm/book3s/64/mmu-hash.h>
 #include <asm/tm.h>
 
 #define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
-- 
2.5.0
