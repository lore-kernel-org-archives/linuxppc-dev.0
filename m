Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38BD2B7D1E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 04:41:09 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: stable@kernel.org
Subject: [PATCH] powerpc/fsl-booke: Fix InstructionTLBError execute permission
	check
Date: Mon, 24 May 2010 13:38:38 -0500
Message-Id: <1274726319-4673-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
References: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

In CONFIG_PTE_64BIT the PTE format has unique permission bits for user
and supervisor execute.  However on !CONFIG_PTE_64BIT we overload the
supervisor bit to imply user execute with _PAGE_USER set.  This allows
us to use the same permission check mask for user or supervisor code on
!CONFIG_PTE_64BIT.

However, on CONFIG_PTE_64BIT we map _PAGE_EXEC to _PAGE_BAP_UX so we
need a different permission mask based on the fault coming from a kernel
address or user space.

Without unique permission masks we see issues like the following with
modules:

Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0xf938d040
Oops: Kernel access of bad area, sig: 11 [#1]

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
For 2.6.34 stable commit 78e2e68a2b79f394b7cd61e07987a8a89af907f7

 arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 7255265..edd4a57 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -639,6 +639,13 @@ interrupt_base:
 	rlwinm	r12,r12,0,16,1
 	mtspr	SPRN_MAS1,r12
 
+	/* Make up the required permissions for kernel code */
+#ifdef CONFIG_PTE_64BIT
+	li	r13,_PAGE_PRESENT | _PAGE_BAP_SX
+	oris	r13,r13,_PAGE_ACCESSED@h
+#else
+	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+#endif
 	b	4f
 
 	/* Get the PGD for the current thread */
@@ -646,15 +653,15 @@ interrupt_base:
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
-4:
-	/* Make up the required permissions */
+	/* Make up the required permissions for user code */
 #ifdef CONFIG_PTE_64BIT
-	li	r13,_PAGE_PRESENT | _PAGE_EXEC
+	li	r13,_PAGE_PRESENT | _PAGE_BAP_UX
 	oris	r13,r13,_PAGE_ACCESSED@h
 #else
 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 #endif
 
+4:
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
 
-- 
1.6.0.6
