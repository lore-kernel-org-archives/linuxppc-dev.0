Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrJ4kc3zDrDB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:24 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id t86so6802044pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 4/9] powerpc/64s/radix: Remove bolted-SLB address limit for
 per-cpu stacks
Date: Sun, 13 Aug 2017 11:33:41 +1000
Message-Id: <20170813013346.14002-4-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix MMU does not take SLB or TLB interrupts when accessing kernel
linear address. Remove this restriction for radix mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index af23d4b576ec..7393bac3c7f4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -564,6 +564,9 @@ static __init u64 safe_stack_limit(void)
 	/* Other BookE, we assume the first GB is bolted */
 	return 1ul << 30;
 #else
+	if (early_radix_enabled())
+		return ULONG_MAX;
+
 	/* BookS, the first segment is bolted */
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return 1UL << SID_SHIFT_1T;
@@ -578,7 +581,8 @@ void __init irqstack_early_init(void)
 
 	/*
 	 * Interrupt stacks must be in the first segment since we
-	 * cannot afford to take SLB misses on them.
+	 * cannot afford to take SLB misses on them. They are not
+	 * accessed in realmode.
 	 */
 	for_each_possible_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)
@@ -649,8 +653,9 @@ void __init emergency_stack_init(void)
 	 * aligned.
 	 *
 	 * Since we use these as temporary stacks during secondary CPU
-	 * bringup, we need to get at them in real mode. This means they
-	 * must also be within the RMO region.
+	 * bringup, machine check, system reset, and HMI, we need to get
+	 * at them in real mode. This means they must also be within the RMO
+	 * region.
 	 *
 	 * The IRQ stacks allocated elsewhere in this file are zeroed and
 	 * initialized in kernel/irq.c. These are initialized here in order
-- 
2.13.3
