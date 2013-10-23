Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A6C32C0405
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:31:38 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [v6][PATCH 2/5] powerpc/book3e: store crit/mc/dbg exception thread
 info
Date: Wed, 23 Oct 2013 17:31:22 +0800
Message-ID: <1382520685-11609-3-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
References: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to store thread info to these exception thread info like something
we already did for PPC32.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 68d74b4..a55cf62 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -36,6 +36,19 @@
  */
 #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
 
+/* Now we only store something to exception thread info */
+#define	EXC_LEVEL_EXCEPTION_PROLOG(type)				\
+	ld	r14,PACAKSAVE(r13);					\
+	CURRENT_THREAD_INFO(r14, r14);					\
+	CURRENT_THREAD_INFO(r15, r1);					\
+	ld	r10,TI_FLAGS(r14);		     			\
+	std	r10,TI_FLAGS(r15);			     		\
+	ld	r10,TI_PREEMPT(r14);		     			\
+	std	r10,TI_PREEMPT(r15);		     			\
+	ld	r10,TI_TASK(r14);			     		\
+	std	r10,TI_TASK(r15);
+
+
 /* Exception prolog code for all exceptions */
 #define EXCEPTION_PROLOG(n, intnum, type, addition)	    		    \
 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
@@ -69,19 +82,22 @@
 
 #define CRIT_SET_KSTACK						            \
 	ld	r1,PACA_CRIT_STACK(r13);				    \
-	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;				    \
+	EXC_LEVEL_EXCEPTION_PROLOG(CRIT);
 #define SPRN_CRIT_SRR0	SPRN_CSRR0
 #define SPRN_CRIT_SRR1	SPRN_CSRR1
 
 #define DBG_SET_KSTACK						            \
 	ld	r1,PACA_DBG_STACK(r13);					    \
-	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;				    \
+	EXC_LEVEL_EXCEPTION_PROLOG(DBG);
 #define SPRN_DBG_SRR0	SPRN_DSRR0
 #define SPRN_DBG_SRR1	SPRN_DSRR1
 
 #define MC_SET_KSTACK						            \
 	ld	r1,PACA_MC_STACK(r13);					    \
-	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;				    \
+	EXC_LEVEL_EXCEPTION_PROLOG(MC);
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
-- 
1.7.9.5
