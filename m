Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rySrk6fsNzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:27:02 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so11146170pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 21:27:02 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id u7sm32810144paz.45.2016.07.24.21.26.58
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Jul 2016 21:27:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: do not use r13 for tabort_syscall
Date: Mon, 25 Jul 2016 14:26:51 +1000
Message-Id: <1469420811-10951-1-git-send-email-npiggin@gmail.com>
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

Fixes: b4b56f9ecab4 (powerpc/tm: Abort syscalls in active transactions)
Cc: stable@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 73e461a..96fd031 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -368,13 +368,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 tabort_syscall:
 	/* Firstly we need to enable TM in the kernel */
 	mfmsr	r10
-	li	r13, 1
-	rldimi	r10, r13, MSR_TM_LG, 63-MSR_TM_LG
+	li	r9, 1
+	rldimi	r10, r9, MSR_TM_LG, 63-MSR_TM_LG
 	mtmsrd	r10, 0
 
 	/* tabort, this dooms the transaction, nothing else */
-	li	r13, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
-	TABORT(R13)
+	li	r9, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
+	TABORT(R9)
 
 	/*
 	 * Return directly to userspace. We have corrupted user register state,
@@ -382,8 +382,8 @@ tabort_syscall:
 	 * resume after the tbegin of the aborted transaction with the
 	 * checkpointed register state.
 	 */
-	li	r13, MSR_RI
-	andc	r10, r10, r13
+	li	r9, MSR_RI
+	andc	r10, r10, r9
 	mtmsrd	r10, 1
 	mtspr	SPRN_SRR0, r11
 	mtspr	SPRN_SRR1, r12
-- 
2.8.1
