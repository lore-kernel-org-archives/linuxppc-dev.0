Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CA71B70A9
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2011 09:22:04 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] 8xx: Move invalidation of non present TLBs
Date: Thu, 13 Jan 2011 23:21:53 +0100
Message-Id: <1294957315-1696-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294957315-1696-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294957315-1696-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

8xx does not invalidate ~PRESENT TLBs, move the workaround
in mm/fault.c here to keep 8xx quirks localized.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   12 ++++++++++--
 arch/ppc/mm/fault.c        |    7 -------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 75acaa0..24b206c 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -221,7 +221,11 @@ DataAccess:
 	mr	r5,r20
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
-	li	r20,0x00f0
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r20,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	li	r20,0x00f0
 	mtspr	DAR,r20	/* Tag DAR */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
@@ -238,7 +242,11 @@ InstructionAccess:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r22
 	mr	r5,r23
-	li	r20,MSR_KERNEL
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r20,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	FINISH_EXCEPTION(do_page_fault)
 
diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
index 874005a..8819fb1 100644
--- a/arch/ppc/mm/fault.c
+++ b/arch/ppc/mm/fault.c
@@ -116,13 +116,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	else
 		is_write = error_code & 0x02000000;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
-#if defined(CONFIG_8xx)
-	/* 8xx does no invalidate TLBs that are ~PRESENT,
-	 * do it here.
-	 */
-	if (error_code & 0x40000000)
-		_tlbie(address);
-#endif
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && regs->trap == 0x300) {
 		debugger_fault_handler(regs);
-- 
1.7.3.4
