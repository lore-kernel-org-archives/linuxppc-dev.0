Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydg2k00wnzDrSZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 01:09:01 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id q4so2017848pfg.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:09:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/3] powerpc/64s/idle: avoid sync for KVM state when waking
 from idle
Date: Sat, 18 Nov 2017 00:08:06 +1000
Message-Id: <20171117140807.22105-3-npiggin@gmail.com>
In-Reply-To: <20171117140807.22105-1-npiggin@gmail.com>
References: <20171117140807.22105-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 2f8364e7b489..07a306173c5a 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -532,6 +532,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mr	r3,r12
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	lbz	r0,HSTATE_HWTHREAD_STATE(r13)
+	cmpwi	r0,KVM_HWTHREAD_IN_KERNEL
+	beq	1f
 	li	r0,KVM_HWTHREAD_IN_KERNEL
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
 	/* Order setting hwthread_state vs. testing hwthread_req */
-- 
2.15.0
