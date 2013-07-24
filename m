Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF8482C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 11:21:27 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/fsl-booke: Work around erratum A-006958
Date: Tue, 23 Jul 2013 20:21:11 -0500
Message-ID: <1374628871-13050-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, James Yang <James.Yang@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Erratum A-006598 says that 64-bit mftb is not atomic -- it's subject
to a similar race condition as doing mftbu/mftbl on 32-bit.  The lower
half of timebase is updated before the upper half; thus, we can share
the workaround for a similar bug on Cell.  This workaround involves
looping if the lower half of timebase is zero, thus avoiding the need
for a scratch register (other than CR0).  This workaround must be
avoided when the timebase is frozen, such as during the timebase sync
code.

This deals with kernel and vdso accesses, but other userspace accesses
will of course need to be fixed elsewhere.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: Andy Fleming <afleming@freescale.com>
Cc: James Yang <James.Yang@freescale.com>
---
v2: re-use the existing cell workaround

 arch/powerpc/include/asm/cputable.h |  9 +++++++--
 arch/powerpc/include/asm/ppc_asm.h  |  2 +-
 arch/powerpc/include/asm/reg.h      |  2 +-
 arch/powerpc/platforms/85xx/smp.c   | 23 +++++++++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6f3887d..0d4939b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -371,14 +371,19 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_E500MC	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
+/*
+ * e5500/e6500 erratum A-006958 is a timebase bug that can use the
+ * same workaround as CPU_FTR_CELL_TB_BUG.
+ */
 #define CPU_FTRS_E5500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_CELL_TB_BUG)
 #define CPU_FTRS_E6500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
+	    CPU_FTR_CELL_TB_BUG)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2f1b6c5..fe713b6 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -443,7 +443,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 #define ISYNC_601
 #endif
 
-#ifdef CONFIG_PPC_CELL
+#if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define MFTB(dest)			\
 90:	mftb  dest;			\
 BEGIN_FTR_SECTION_NESTED(96);		\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5d7d9c2..aa49fdb 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1116,7 +1116,7 @@
 				     : "memory")
 
 #ifdef __powerpc64__
-#ifdef CONFIG_PPC_CELL
+#if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
 				"90:	mftb %0;\n"			\
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5ced4f5..f60eae2 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -69,7 +69,30 @@ static void mpc85xx_give_timebase(void)
 	tb_req = 0;
 
 	mpc85xx_timebase_freeze(1);
+#ifdef CONFIG_PPC64
+	/*
+	 * e5500/e6500 have a workaround for erratum A-006958 in place
+	 * that will reread the timebase until TBL is non-zero.
+	 * That would be a bad thing when the timebase is frozen.
+	 *
+	 * Thus, we read it manually, and instead of checking that
+	 * TBL is non-zero, we ensure that TB does not change.  We don't
+	 * do that for the main mftb implementation, because it requires
+	 * a scratch register
+	 */
+	{
+		u64 prev;
+
+		asm volatile("mftb %0" : "=r" (timebase));
+
+		do {
+			prev = timebase;
+			asm volatile("mftb %0" : "=r" (timebase));
+		} while (prev != timebase);
+	}
+#else
 	timebase = get_tb();
+#endif
 	mb();
 	tb_valid = 1;
 
-- 
1.8.1.2
