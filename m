Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04BCF2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 15:22:22 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 1/1] powerpc/book3e: store critical/machine/debug exception
 thread info
Date: Sat, 27 Oct 2012 12:22:12 +0800
Message-ID: <1351311732-5879-1-git-send-email-tiejun.chen@windriver.com>
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
This patch is followed on my three patches I send recently:

[PATCH 1/3] powerpc/book3e: load critical/machine/debug exception stack
[PATCH 2/3] powerpc/book3e: support kgdb for kernel space
[PATCH 3/3] kgdb/kgdbts: support ppc64

Tiejun

 arch/powerpc/kernel/exceptions-64e.S |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index c5564d4..4e7083e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -91,10 +91,28 @@
 #define SPRN_GDBELL_SRR0	SPRN_GSRR0
 #define SPRN_GDBELL_SRR1	SPRN_GSRR1
 
+/* Store something to exception thread info */
+#define	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(type)					\
+	std	r14,PACA_EX##type+EX_R14(r13);					\
+	std	r15,PACA_EX##type+EX_R15(r13);					\
+	ld	r14,PACA_EX##type+EX_R1(r13);					\
+	clrrdi	r14,r14,THREAD_SHIFT;						\
+	clrrdi	r15,r1,THREAD_SHIFT;						\
+	ld	r10,TI_FLAGS(r14);		     				\
+	std	r10,TI_FLAGS(r15);			     			\
+	ld	r10,TI_PREEMPT(r14);		     				\
+	std	r10,TI_PREEMPT(r1);		     				\
+	ld	r10,TI_TASK(r14);			     			\
+	std	r10,TI_TASK(r1);			     			\
+	ld	r14,PACA_EX##type+EX_R14(r13);					\
+	ld	r15,PACA_EX##type+EX_R15(r13);					\
+1:
+
 #define CRIT_SET_KSTACK						            \
 	BOOK3E_LOAD_EXC_LEVEL_STACK(CRIT);					\
 	ld	r1,PACA_CRIT_STACK(r13);				    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(CRIT);
 #define SPRN_CRIT_SRR0	SPRN_CSRR0
 #define SPRN_CRIT_SRR1	SPRN_CSRR1
 
@@ -102,6 +120,7 @@
 	BOOK3E_LOAD_EXC_LEVEL_STACK(DBG);					\
 	ld	r1,PACA_DBG_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(DBG);
 #define SPRN_DBG_SRR0	SPRN_DSRR0
 #define SPRN_DBG_SRR1	SPRN_DSRR1
 
@@ -109,6 +128,7 @@
 	BOOK3E_LOAD_EXC_LEVEL_STACK(MC);					\
 	ld	r1,PACA_MC_STACK(r13);					    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(MC);
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
-- 
1.7.9.5
