Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPYm25nwzF20x
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:49:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c78so7760009pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:49:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 2/3] powerpc/64s/idle: avoid sync for KVM state when waking
 from idle
Date: Sun,  1 Apr 2018 15:48:54 +1000
Message-Id: <20180401054855.17864-3-npiggin@gmail.com>
In-Reply-To: <20180401054855.17864-1-npiggin@gmail.com>
References: <20180401054855.17864-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When waking from a CPU idle instruction (e.g., nap or stop), the sync
for ordering the KVM secondary thread state can be avoided if there
wakeup is coming from a kernel context rather than KVM context.

This improves performance for ping-pong benchmark with the stop0 idle
state by 0.46% for 2 threads in the same core, and 1.02% for different
cores.

Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index fc2e5cf2c74c..68fa97885fc0 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -549,6 +549,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mr	r3,r12
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	lbz	r0,HSTATE_HWTHREAD_STATE(r13)
+	cmpwi	r0,KVM_HWTHREAD_IN_KERNEL
+	beq	1f
 	li	r0,KVM_HWTHREAD_IN_KERNEL
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
 	/* Order setting hwthread_state vs. testing hwthread_req */
-- 
2.16.3
