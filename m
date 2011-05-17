Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F19EA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 09:36:40 +1000 (EST)
Date: Tue, 17 May 2011 18:36:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>
Subject: [PATCH 02/13] powerpc/e500: SPE register saving: take arbitrary
	struct offset
Message-ID: <20110517233628.GA3542@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110517233551.GA3511@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, these macros hardcoded THREAD_EVR0 as the base of the save
area, relative to the base register passed.  This base offset is now
passed as a separate macro parameter, allowing reuse with other SPE
save areas, such as used by KVM.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This is a resending of http://www.spinics.net/lists/kvm-ppc/msg02672.html

Kumar, please ack to go via kvm.

 arch/powerpc/include/asm/ppc_asm.h   |   28 ++++++++++++++++------------
 arch/powerpc/kernel/head_fsl_booke.S |    6 +++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 9821006..ba0cd33 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -150,18 +150,22 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define REST_16VSRSU(n,b,base)	REST_8VSRSU(n,b,base); REST_8VSRSU(n+8,b,base)
 #define REST_32VSRSU(n,b,base)	REST_16VSRSU(n,b,base); REST_16VSRSU(n+16,b,base)
 
-#define SAVE_EVR(n,s,base)	evmergehi s,s,n; stw s,THREAD_EVR0+4*(n)(base)
-#define SAVE_2EVRS(n,s,base)	SAVE_EVR(n,s,base); SAVE_EVR(n+1,s,base)
-#define SAVE_4EVRS(n,s,base)	SAVE_2EVRS(n,s,base); SAVE_2EVRS(n+2,s,base)
-#define SAVE_8EVRS(n,s,base)	SAVE_4EVRS(n,s,base); SAVE_4EVRS(n+4,s,base)
-#define SAVE_16EVRS(n,s,base)	SAVE_8EVRS(n,s,base); SAVE_8EVRS(n+8,s,base)
-#define SAVE_32EVRS(n,s,base)	SAVE_16EVRS(n,s,base); SAVE_16EVRS(n+16,s,base)
-#define REST_EVR(n,s,base)	lwz s,THREAD_EVR0+4*(n)(base); evmergelo n,s,n
-#define REST_2EVRS(n,s,base)	REST_EVR(n,s,base); REST_EVR(n+1,s,base)
-#define REST_4EVRS(n,s,base)	REST_2EVRS(n,s,base); REST_2EVRS(n+2,s,base)
-#define REST_8EVRS(n,s,base)	REST_4EVRS(n,s,base); REST_4EVRS(n+4,s,base)
-#define REST_16EVRS(n,s,base)	REST_8EVRS(n,s,base); REST_8EVRS(n+8,s,base)
-#define REST_32EVRS(n,s,base)	REST_16EVRS(n,s,base); REST_16EVRS(n+16,s,base)
+/*
+ * b = base register for addressing, o = base offset from register of 1st EVR
+ * n = first EVR, s = scratch
+ */
+#define SAVE_EVR(n,s,b,o)	evmergehi s,s,n; stw s,o+4*(n)(b)
+#define SAVE_2EVRS(n,s,b,o)	SAVE_EVR(n,s,b,o); SAVE_EVR(n+1,s,b,o)
+#define SAVE_4EVRS(n,s,b,o)	SAVE_2EVRS(n,s,b,o); SAVE_2EVRS(n+2,s,b,o)
+#define SAVE_8EVRS(n,s,b,o)	SAVE_4EVRS(n,s,b,o); SAVE_4EVRS(n+4,s,b,o)
+#define SAVE_16EVRS(n,s,b,o)	SAVE_8EVRS(n,s,b,o); SAVE_8EVRS(n+8,s,b,o)
+#define SAVE_32EVRS(n,s,b,o)	SAVE_16EVRS(n,s,b,o); SAVE_16EVRS(n+16,s,b,o)
+#define REST_EVR(n,s,b,o)	lwz s,o+4*(n)(b); evmergelo n,s,n
+#define REST_2EVRS(n,s,b,o)	REST_EVR(n,s,b,o); REST_EVR(n+1,s,b,o)
+#define REST_4EVRS(n,s,b,o)	REST_2EVRS(n,s,b,o); REST_2EVRS(n+2,s,b,o)
+#define REST_8EVRS(n,s,b,o)	REST_4EVRS(n,s,b,o); REST_4EVRS(n+4,s,b,o)
+#define REST_16EVRS(n,s,b,o)	REST_8EVRS(n,s,b,o); REST_8EVRS(n+8,s,b,o)
+#define REST_32EVRS(n,s,b,o)	REST_16EVRS(n,s,b,o); REST_16EVRS(n+16,s,b,o)
 
 /* Macros to adjust thread priority for hardware multithreading */
 #define HMT_VERY_LOW	or	31,31,31	# very low priority
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index aede4f8..fe37dd0 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -656,7 +656,7 @@ load_up_spe:
 	cmpi	0,r4,0
 	beq	1f
 	addi	r4,r4,THREAD	/* want THREAD of last_task_used_spe */
-	SAVE_32EVRS(0,r10,r4)
+	SAVE_32EVRS(0,r10,r4,THREAD_EVR0)
 	evxor	evr10, evr10, evr10	/* clear out evr10 */
 	evmwumiaa evr10, evr10, evr10	/* evr10 <- ACC = 0 * 0 + ACC */
 	li	r5,THREAD_ACC
@@ -676,7 +676,7 @@ load_up_spe:
 	stw	r4,THREAD_USED_SPE(r5)
 	evlddx	evr4,r10,r5
 	evmra	evr4,evr4
-	REST_32EVRS(0,r10,r5)
+	REST_32EVRS(0,r10,r5,THREAD_EVR0)
 #ifndef CONFIG_SMP
 	subi	r4,r5,THREAD
 	stw	r4,last_task_used_spe@l(r3)
@@ -787,7 +787,7 @@ _GLOBAL(giveup_spe)
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	lwz	r5,PT_REGS(r3)
 	cmpi	0,r5,0
-	SAVE_32EVRS(0, r4, r3)
+	SAVE_32EVRS(0, r4, r3, THREAD_EVR0)
 	evxor	evr6, evr6, evr6	/* clear out evr6 */
 	evmwumiaa evr6, evr6, evr6	/* evr6 <- ACC = 0 * 0 + ACC */
 	li	r4,THREAD_ACC
-- 
1.7.4.1
