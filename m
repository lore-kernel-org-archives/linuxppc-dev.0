Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 918B22C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 22:31:13 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kvm@vger.kernel.org>,
 <kvm-ppc@vger.kernel.org>, <agraf@suse.de>, <scottwood@freescale.com>
Subject: [PATCH] [RFC] bookehv: Handle debug exception on guest exit
Date: Wed, 20 Mar 2013 16:59:40 +0530
Message-ID: <1363778980-23689-1-git-send-email-Bharat.Bhushan@freescale.com>
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

EPCR.DUVD controls whether the debug events can come in
hypervisor mode or not. When KVM guest is using the debug
resource then we do not want debug events to be captured
in guest entry/exit path. So we set EPCR.DUVD when entering
and clears EPCR.DUVD when exiting from guest.

Debug instruction complete is a post-completion debug
exception but debug event gets posted on the basis of MSR
before the instruction is executed. Now if the instruction
switches the context from guest mode (MSR.GS = 1) to hypervisor
mode (MSR.GS = 0) then the xSRR0 points to first instruction of
KVM handler and xSRR1 points that MSR.GS is clear
(hypervisor context). Now as xSRR1.GS is used to decide whether
KVM handler will be invoked to handle the exception or host
host kernel debug handler will be invoked to handle the exception.
This leads to host kernel debug handler handling the exception
which should either be handled by KVM.

This is tested on e500mc in 32 bit mode

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |   54 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_booke.h     |   35 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4684e33..56882a0 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -450,6 +450,33 @@ interrupt_end_book3e:
 	andis.	r15,r14,DBSR_IC@h
 	beq+	1f
 
+#ifdef CONFIG_KVM_BOOKE_HV
+	/*
+	 * EPCR.DUVD controls whether the debug events can come in
+	 * hypervisor mode or not. When KVM guest is using the debug
+	 * resource then we do not want debug events to be captured
+	 * in guest entry/exit path. So we set EPCR.DUVD when entering
+	 * and clears EPCR.DUVD when exiting from guest.
+	 * Debug instruction complete is a post-completion debug
+	 * exception but debug event gets posted on the basis of MSR
+	 * before the instruction is executed. Now if the instruction
+	 * switches the context from guest mode (MSR.GS = 1) to hypervisor
+	 * mode (MSR.GS = 0) then the xSRR0 points to first instruction of
+	 * KVM handler and xSRR1 points that MSR.GS is clear
+	 * (hypervisor context). Now as xSRR1.GS is used to decide whether
+	 * KVM handler will be invoked to handle the exception or host
+	 * host kernel debug handler will be invoked to handle the exception.
+	 * This leads to host kernel debug handler handling the exception
+	 * which should either be handled by KVM.
+	 */
+	mfspr	r10, SPRN_EPCR
+	andis.	r10,r10,SPRN_EPCR_DUVD@h
+	beq+	2f
+
+	andis.	r10,r9,MSR_GS@h
+	beq+	1f
+2:
+#endif
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
 	cmpld	cr0,r10,r14
@@ -516,6 +543,33 @@ kernel_dbg_exc:
 	andis.	r15,r14,DBSR_IC@h
 	beq+	1f
 
+#ifdef CONFIG_KVM_BOOKE_HV
+	/*
+	 * EPCR.DUVD controls whether the debug events can come in
+	 * hypervisor mode or not. When KVM guest is using the debug
+	 * resource then we do not want debug events to be captured
+	 * in guest entry/exit path. So we set EPCR.DUVD when entering
+	 * and clears EPCR.DUVD when exiting from guest.
+	 * Debug instruction complete is a post-completion debug
+	 * exception but debug event gets posted on the basis of MSR
+	 * before the instruction is executed. Now if the instruction
+	 * switches the context from guest mode (MSR.GS = 1) to hypervisor
+	 * mode (MSR.GS = 0) then the xSRR0 points to first instruction of
+	 * KVM handler and xSRR1 points that MSR.GS is clear
+	 * (hypervisor context). Now as xSRR1.GS is used to decide whether
+	 * KVM handler will be invoked to handle the exception or host
+	 * host kernel debug handler will be invoked to handle the exception.
+	 * This leads to host kernel debug handler handling the exception
+	 * which should either be handled by KVM.
+	 */
+	mfspr	r10, SPRN_EPCR
+	andis.	r10,r10,SPRN_EPCR_DUVD@h
+	beq+	2f
+
+	andis.	r10,r9,MSR_GS@h
+	beq+	1f
+2:
+#endif
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
 	cmpld	cr0,r10,r14
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5f051ee..040b0a3 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -285,7 +285,33 @@ label:
 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
+#ifdef CONFIG_KVM_BOOKE_HV						      \
+	/*								      \
+	 * EPCR.DUVD controls whether the debug events can come in	      \
+	 * hypervisor mode or not. When KVM guest is using the debug	      \
+	 * resource then we do not want debug events to be captured 	      \
+	 * in guest entry/exit path. So we set EPCR.DUVD when entering	      \
+	 * and clears EPCR.DUVD when exiting from guest.		      \
+	 * Debug instruction complete is a post-completion debug	      \
+	 * exception but debug event gets posted on the basis of MSR	      \
+	 * before the instruction is executed. Now if the instruction	      \
+	 * switches the context from guest mode (MSR.GS = 1) to hypervisor    \
+	 * mode (MSR.GS = 0) then the xSRR0 points to first instruction of    \
+	 * KVM handler and xSRR1 points that MSR.GS is clear 		      \
+	 * (hypervisor context). Now as xSRR1.GS is used to decide whether    \
+	 * KVM handler will be invoked to handle the exception or host	      \
+	 * host kernel debug handler will be invoked to handle the exception. \
+	 * This leads to host kernel debug handler handling the exception     \
+	 * which should either be handled by KVM.			      \
+	 */								      \
+	mfspr	r10, SPRN_EPCR;						      \
+	andis.	r10,r10,SPRN_EPCR_DUVD@h;				      \
+	beq+	3f;							      \
 									      \
+	andis.	r10,r9,MSR_GS@h;				    	      \
+	beq+	1f;							      \
+3:									      \
+#endif									      \
 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
 	ori	r10,r10,KERNELBASE@l;					      \
 	cmplw	r12,r10;						      \
@@ -339,6 +365,15 @@ label:
 	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
 									      \
+#ifdef CONFIG_KVM_BOOKE_HV						      \
+	mfspr	r10, SPRN_EPCR;						      \
+	andis.	r10,r10,SPRN_EPCR_DUVD@h;				      \
+	beq+	3f;							      \
+									      \
+	andis.	r10,r9,MSR_GS@h;				    	      \
+	beq+	1f;							      \
+3:									      \
+#endif									      \
 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
 	ori	r10,r10,KERNELBASE@l;					      \
 	cmplw	r12,r10;						      \
-- 
1.7.0.4
