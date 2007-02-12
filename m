Return-Path: <bgill@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DA841DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:43:55 +1100 (EST)
Date: Mon, 12 Feb 2007 17:43:46 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc: UPDATED Don't write reserved values to MAS1[TSIZE]
Message-ID: <Pine.LNX.4.61.0702121741350.11175@ld2044.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some of the current tlbwe instructions early on in head_fsl_booke.S take
advantage of unarchitected behavior that allows the writing of reserved
values to the TSIZE field.  This patch corrects that, as well as an error
where an unitialized (by linux) value was written into a MAS register and
used for a tlbwe.

Correct this for both arch/ppc and arch/powerpc.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit 2a5f6e78c834e1824a9d6ef3d561920cbda61a5e
tree c26c26d5eee61c1201fbf9e40a1087835d9bbef9
parent 5986a2ec35836a878350c54af4bd91b1de6abc59
author Becky Bruce <becky.bruce@freescale.com> Mon, 12 Feb 2007 17:41:09 -0600
committer Becky Bruce <becky.bruce@freescale.com> Mon, 12 Feb 2007 17:41:09 -0600

 arch/powerpc/kernel/head_fsl_booke.S |    5 ++++-
 arch/ppc/kernel/head_fsl_booke.S     |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 66877bd..54f40d9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -206,7 +206,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rlwimi	r7,r3,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
-	li	r6,0
+	mfspr	r6,SPRN_MAS1
+	rlwinm	r6,r6,0,2,0	/* clear IPROT */
 	mtspr	SPRN_MAS1,r6
 	tlbwe
 	/* Invalidate TLB1 */
@@ -248,6 +249,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
+	mfspr	r8,SPRN_MAS1
+	rlwinm	r8,r8,0,2,0	/* clear IPROT */
 	mtspr	SPRN_MAS1,r8
 	tlbwe
 	/* Invalidate TLB1 */
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
index 66877bd..54f40d9 100644
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -206,7 +206,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rlwimi	r7,r3,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
-	li	r6,0
+	mfspr	r6,SPRN_MAS1
+	rlwinm	r6,r6,0,2,0	/* clear IPROT */
 	mtspr	SPRN_MAS1,r6
 	tlbwe
 	/* Invalidate TLB1 */
@@ -248,6 +249,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
 	mtspr	SPRN_MAS0,r7
 	tlbre
+	mfspr	r8,SPRN_MAS1
+	rlwinm	r8,r8,0,2,0	/* clear IPROT */
 	mtspr	SPRN_MAS1,r8
 	tlbwe
 	/* Invalidate TLB1 */
