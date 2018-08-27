Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zGsw02F8zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 13:03:15 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id z25-v6so6721527pgu.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 20:03:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] powerpc/64s/hash: do not use PPC_INVALIDATE_ERAT on CPUs
 before POWER9
Date: Mon, 27 Aug 2018 13:03:01 +1000
Message-Id: <20180827030302.17541-2-npiggin@gmail.com>
In-Reply-To: <20180827030302.17541-1-npiggin@gmail.com>
References: <20180827030302.17541-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC_INVALIDATE_ERAT is slbia IH=7 which is a new variant introduced
with POWER9, and the result is undefined on earlier CPUs.

Commits 7b9f71f974 ("powerpc/64s: POWER9 machine check handler") and
d4748276ae ("powerpc/64s: Improve local TLB flush for boot and MCE on
POWER9") caused POWER7/8 code to use this instruction. Remove it. An
ERAT flush can be made by invalidatig the SLB, but before POWER9 that
requires a flush and rebolt.

Fixes: 7b9f71f974 ("powerpc/64s: POWER9 machine check handler")
Fixes: d4748276ae ("powerpc/64s: Improve local TLB flush for boot and
MCE on POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c  | 7 +++++++
 arch/powerpc/mm/hash_native_64.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 3497c8329c1d..3022d67f0c48 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -89,6 +89,13 @@ static void flush_and_reload_slb(void)
 
 static void flush_erat(void)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
+		flush_and_reload_slb();
+		return;
+	}
+#endif
+	/* PPC_INVALIDATE_ERAT can only be used on ISA v3 and newer */
 	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 }
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 729f02df8290..aaa28fd918fe 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -115,6 +115,8 @@ static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
 	tlbiel_hash_set_isa300(0, is, 0, 2, 1);
 
 	asm volatile("ptesync": : :"memory");
+
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
 void hash__tlbiel_all(unsigned int action)
@@ -140,8 +142,6 @@ void hash__tlbiel_all(unsigned int action)
 		tlbiel_all_isa206(POWER7_TLB_SETS, is);
 	else
 		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
-
-	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
 static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
-- 
2.18.0
