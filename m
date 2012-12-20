Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBD6E2C0131
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2012 20:08:44 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v1][PATCH 2/6] powerpc/book3e: store critical/machine/debug
 exception thread info
Date: Thu, 20 Dec 2012 17:08:26 +0800
Message-ID: <1355994510-11934-3-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1355994510-11934-1-git-send-email-tiejun.chen@windriver.com>
References: <1355994510-11934-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
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
 arch/powerpc/kernel/exceptions-64e.S |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 376e3d1..9a99cba 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -58,6 +58,18 @@
 	std	r10,PACA_##level##_STACK(r13);
 #endif
 
+/* Store something to exception thread info */
+#define	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(type)					\
+	ld	r14,PACA_EX##type+EX_R1(r13);					\
+	CURRENT_THREAD_INFO(r14, r14);						\
+	CURRENT_THREAD_INFO(r15, r1);						\
+	ld	r10,TI_FLAGS(r14);		     				\
+	std	r10,TI_FLAGS(r15);			     			\
+	ld	r10,TI_PREEMPT(r14);		     				\
+	std	r10,TI_PREEMPT(r15);		     				\
+	ld	r10,TI_TASK(r14);			     			\
+	std	r10,TI_TASK(r15);
+
 /* Exception prolog code for all exceptions */
 #define EXCEPTION_PROLOG(n, intnum, type, addition)	    		    \
 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
@@ -95,6 +107,7 @@
 	BOOK3E_LOAD_EXC_LEVEL_STACK(CRIT);					\
 	ld	r1,PACA_CRIT_STACK(r13);				    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;					\
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(CRIT);				\
 1:
 #define SPRN_CRIT_SRR0	SPRN_CSRR0
 #define SPRN_CRIT_SRR1	SPRN_CSRR1
@@ -105,6 +118,7 @@
 	BOOK3E_LOAD_EXC_LEVEL_STACK(DBG);					\
 	ld	r1,PACA_DBG_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;					\
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(DBG);					\
 1:
 #define SPRN_DBG_SRR0	SPRN_DSRR0
 #define SPRN_DBG_SRR1	SPRN_DSRR1
@@ -115,6 +129,7 @@
 	BOOK3E_LOAD_EXC_LEVEL_STACK(MC);					\
 	ld	r1,PACA_MC_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;					\
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(MC);					\
 1:
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
-- 
1.7.9.5
