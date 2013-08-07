Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/tm: Save and restore checkpointed TAR,
 PPR and DSCR
Date: Wed,  7 Aug 2013 16:11:58 +1000
Message-Id: <1375855918-3625-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1375855918-3625-1-git-send-email-mikey@neuling.org>
References: <1375855918-3625-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we don't save and restore the checkpointed TAR, PPR and DSCR.

This adds the required save and restore to the treclaim and trechkpt code.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/kernel/tm.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 51be8fb..0554d1f 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -233,6 +233,16 @@ dont_backup_fp:
 	std	r5, _CCR(r7)
 	std	r6, _XER(r7)
 
+
+	/* ******************** TAR, PPR, DSCR ********** */
+	mfspr	r3, SPRN_TAR
+	mfspr	r4, SPRN_PPR
+	mfspr	r5, SPRN_DSCR
+
+	std	r3, THREAD_TM_TAR(r12)
+	std	r4, THREAD_TM_PPR(r12)
+	std	r5, THREAD_TM_DSCR(r12)
+
 	/* MSR and flags:  We don't change CRs, and we don't need to alter
 	 * MSR.
 	 */
@@ -347,6 +357,16 @@ dont_restore_fp:
 	mtmsr	r6				/* FP/Vec off again! */
 
 restore_gprs:
+
+	/* ******************** TAR, PPR, DSCR ********** */
+	ld	r4, THREAD_TM_TAR(r3)
+	ld	r5, THREAD_TM_PPR(r3)
+	ld	r6, THREAD_TM_DSCR(r3)
+
+	mtspr	SPRN_TAR,	r4
+	mtspr	SPRN_PPR,	r5
+	mtspr	SPRN_DSCR,	r6
+
 	/* ******************** CR,LR,CCR,MSR ********** */
 	ld	r3, _CTR(r7)
 	ld	r4, _LINK(r7)
-- 
1.8.1.2
