Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2C70468A96
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Feb 2006 09:41:31 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k18MnZSN024769
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2006 15:49:35 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id k18Mrtio019834
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2006 16:53:56 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (cde-tx32-ldt329 [10.82.19.206])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k18Mc6kt029403
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2006 16:38:07 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (localhost [127.0.0.1])
	by cde-tx32-ldt329.sps.mot.com (Postfix) with ESMTP id 01772C2DD7
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 16:41:26 -0600 (CST)
Received: from localhost (bgill@localhost)
	by cde-tx32-ldt329.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	k18MfQIF015638
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Feb 2006 16:41:26 -0600
Date: Wed, 8 Feb 2006 16:41:26 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ppc: Add missing isyncs in head_fsl_booke.S
Message-ID: <Pine.LNX.4.61.0602081639120.15617@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e500 core reference manual indicates that isync is required
after mtmsr(DE bit) and mtspr DBCR0.  Add isyncs to make the code
conform to the spec.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit b9c7e75735829b3dc3d6ba3afa715896d96f1093
tree 08700b171fc4d8ddc6b42e9650261e5f735ebec8
parent 0ebd6b01576657e51c6023803f2de1d1181b67b9
author Becky Bruce <becky.bruce@freescale.com> Wed, 08 Feb 2006 16:29:50 -0600
committer Becky Bruce <becky.bruce@freescale.com> Wed, 08 Feb 2006 16:29:50 -0600

 arch/powerpc/kernel/head_fsl_booke.S |    4 ++++
 arch/ppc/kernel/head_fsl_booke.S     |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 8d60fa9..0abd05f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -316,6 +316,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	 */
 	lis	r2,DBCR0_IDM@h
 	mtspr	SPRN_DBCR0,r2
+	isync
 	/* clear any residual debug events */
 	li	r2,-1
 	mtspr	SPRN_DBSR,r2
@@ -1002,12 +1003,15 @@ _GLOBAL(giveup_fpu)
 _GLOBAL(abort)
 	li	r13,0
         mtspr   SPRN_DBCR0,r13		/* disable all debug events */
+	isync
 	mfmsr	r13
 	ori	r13,r13,MSR_DE@l	/* Enable Debug Events */
 	mtmsr	r13
+	isync
         mfspr   r13,SPRN_DBCR0
         lis	r13,(DBCR0_IDM|DBCR0_RST_CHIP)@h
         mtspr   SPRN_DBCR0,r13
+	isync
 
 _GLOBAL(set_context)
 
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
index 8d60fa9..0abd05f 100644
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -316,6 +316,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	 */
 	lis	r2,DBCR0_IDM@h
 	mtspr	SPRN_DBCR0,r2
+	isync
 	/* clear any residual debug events */
 	li	r2,-1
 	mtspr	SPRN_DBSR,r2
@@ -1002,12 +1003,15 @@ _GLOBAL(giveup_fpu)
 _GLOBAL(abort)
 	li	r13,0
         mtspr   SPRN_DBCR0,r13		/* disable all debug events */
+	isync
 	mfmsr	r13
 	ori	r13,r13,MSR_DE@l	/* Enable Debug Events */
 	mtmsr	r13
+	isync
         mfspr   r13,SPRN_DBCR0
         lis	r13,(DBCR0_IDM|DBCR0_RST_CHIP)@h
         mtspr   SPRN_DBCR0,r13
+	isync
 
 _GLOBAL(set_context)
 
