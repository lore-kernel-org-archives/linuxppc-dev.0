Return-Path: <anton@samba.org>
Date: Tue, 15 Oct 2013 14:36:31 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
 amodra@gmail.com
Subject: [PATCH] powerpc: Use 32 bit loads and stores when operating on
 condition register values
Message-ID: <20131015143631.1879607c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The condition register (CR) is a 32 bit quantity so we should use
32 bit loads and stores.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index cd809ea..432cf54 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -107,7 +107,7 @@ DSCR_DEFAULT:
 _GLOBAL(tm_reclaim)
 	mfcr	r6
 	mflr	r0
-	std	r6, 8(r1)
+	stw	r6, 8(r1)
 	std	r0, 16(r1)
 	std	r2, 40(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
@@ -284,7 +284,7 @@ dont_backup_fp:
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, TM_FRAME_SIZE
-	ld	r4, 8(r1)
+	lwz	r4, 8(r1)
 	ld	r0, 16(r1)
 	mtcr	r4
 	mtlr	r0
@@ -309,7 +309,7 @@ dont_backup_fp:
 _GLOBAL(tm_recheckpoint)
 	mfcr	r5
 	mflr	r0
-	std	r5, 8(r1)
+	stw	r5, 8(r1)
 	std	r0, 16(r1)
 	std	r2, 40(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
@@ -441,7 +441,7 @@ restore_gprs:
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, TM_FRAME_SIZE
-	ld	r4, 8(r1)
+	lwz	r4, 8(r1)
 	ld	r0, 16(r1)
 	mtcr	r4
 	mtlr	r0
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8f38445..2acc226 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -24,7 +24,7 @@
 	mflr	r0;			\
 	mfcr	r12;			\
 	std	r0,16(r1);		\
-	std	r12,8(r1);		\
+	stw	r12,8(r1);		\
 	std	r1,PACAR1(r13);		\
 	li	r0,0;			\
 	mfmsr	r12;			\
@@ -46,7 +46,7 @@
 
 _STATIC(opal_return)
 	ld	r2,PACATOC(r13);
-	ld	r4,8(r1);
+	lwz	r4,8(r1);
 	ld	r5,16(r1);
 	ld	r6,PACASAVEDMSR(r13);
 	mtspr	SPRN_SRR0,r5;
