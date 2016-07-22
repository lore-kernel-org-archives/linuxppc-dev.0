Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwj133ywqzDrKD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:28:07 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id q2so6546505pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 00:28:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/tm: do not use r13 for tabort_syscall
Date: Fri, 22 Jul 2016 17:27:48 +1000
Message-Id: <1469172468-12892-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tabort_syscall runs with RI=1, so a nested recoverable machine
check will load the paca into r13 and overwrite what we loaded
it with, because exceptions returning to privileged mode do not
restore r13.

This has survived testing with sc instruction inside transaction
(bare sc, not glibc syscall because glibc can tabort before sc).
Verified the transaction is failing failing with with
TM_CAUSE_SYSCALL.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>

---

 arch/powerpc/kernel/entry_64.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 73e461a..387dee3 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -368,13 +368,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 tabort_syscall:
 	/* Firstly we need to enable TM in the kernel */
 	mfmsr	r10
-	li	r13, 1
-	rldimi	r10, r13, MSR_TM_LG, 63-MSR_TM_LG
-	mtmsrd	r10, 0
+	li	r9,1
+	rldimi	r10,r9,MSR_TM_LG,63-MSR_TM_LG
+	mtmsrd	r10,0
 
 	/* tabort, this dooms the transaction, nothing else */
-	li	r13, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
-	TABORT(R13)
+	li	r9,(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
+	TABORT(R9)
 
 	/*
 	 * Return directly to userspace. We have corrupted user register state,
@@ -382,11 +382,11 @@ tabort_syscall:
 	 * resume after the tbegin of the aborted transaction with the
 	 * checkpointed register state.
 	 */
-	li	r13, MSR_RI
-	andc	r10, r10, r13
-	mtmsrd	r10, 1
-	mtspr	SPRN_SRR0, r11
-	mtspr	SPRN_SRR1, r12
+	li	r9,MSR_RI
+	andc	r10,r10,r9
+	mtmsrd	r10,1
+	mtspr	SPRN_SRR0,r11
+	mtspr	SPRN_SRR1,r12
 
 	rfid
 	b	.	/* prevent speculative execution */
-- 
2.8.1
