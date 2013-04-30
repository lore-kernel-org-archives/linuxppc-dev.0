Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CE7B2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 18:15:54 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>, <agraf@suse.de>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>
Subject: [PATCH] powerpc: Fix interrupt range check on debug exception
Date: Tue, 30 Apr 2013 13:48:11 +0530
Message-ID: <1367309891-11556-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We do not want to take single step and branch-taken debug exception
in kernel exception code. But the address range check was not covering
all kernel exception handlers address range.

With this patch we defined the interrupt_end label which defines the
end on kernel exception code. So now we check interrupt_base to
interrupt_end range for not handling debug exception in kernel
exception entry.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kernel/head_44x.S       |    2 ++
 arch/powerpc/kernel/head_booke.h     |   16 ++++++++--------
 arch/powerpc/kernel/head_fsl_booke.S |    2 ++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 7a2e5e4..97e2671 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -769,6 +769,8 @@ finish_tlb_load_47x:
 	 */
 	DEBUG_CRIT_EXCEPTION
 
+interrupt_end:
+
 /*
  * Global functions
  */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5f051ee..df564e9 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -286,13 +286,13 @@ label:
 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
 									      \
-	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
-	ori	r10,r10,KERNELBASE@l;					      \
+	lis	r10,interrupt_base@h;	/* check if exception in vectors */   \
+	ori	r10,r10,interrupt_base@l;				      \
 	cmplw	r12,r10;						      \
 	blt+	2f;			/* addr below exception vectors */    \
 									      \
-	lis	r10,DebugDebug@h;					      \
-	ori	r10,r10,DebugDebug@l;					      \
+	lis	r10,interrupt_end@h;					      \
+	ori	r10,r10,interrupt_end@l;				      \
 	cmplw	r12,r10;						      \
 	bgt+	2f;			/* addr above exception vectors */    \
 									      \
@@ -339,13 +339,13 @@ label:
 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
 									      \
-	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
-	ori	r10,r10,KERNELBASE@l;					      \
+	lis	r10,interrupt_base@h;	/* check if exception in vectors */   \
+	ori	r10,r10,interrupt_base@l;				      \
 	cmplw	r12,r10;						      \
 	blt+	2f;			/* addr below exception vectors */    \
 									      \
-	lis	r10,DebugCrit@h;					      \
-	ori	r10,r10,DebugCrit@l;					      \
+	lis	r10,interrupt_end@h;					      \
+	ori	r10,r10,interrupt_end@l;				      \
 	cmplw	r12,r10;						      \
 	bgt+	2f;			/* addr above exception vectors */    \
 									      \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 6f62a73..d10a7ca 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -605,6 +605,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	/* Embedded Hypervisor Privilege */
 	EXCEPTION(0, HV_PRIV, Ehvpriv, unknown_exception, EXC_XFER_EE)
 
+interrupt_end:
+
 /*
  * Local functions
  */
-- 
1.5.6.5
