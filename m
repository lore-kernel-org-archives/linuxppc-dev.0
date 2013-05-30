Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/pseries: Kill all prefetch streams on context switch
Date: Thu, 30 May 2013 15:34:27 +1000
Message-ID: <17925.1369892067@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, anton@samba.org,
 miltonm@realtime.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On context switch, we should have no prefetch streams leak from one
userspace process to another.  This frees up prefetch resources for the
next process.

Based on patch from Milton Miller.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index cea8496..2f1b6c5 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -523,6 +523,17 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
 #define PPC440EP_ERR42
 #endif
 
+/* The following stops all load and store data streams associated with stream
+ * ID (ie. streams created explicitly).  The embedded and server mnemonics for
+ * dcbt are different so we use machine "power4" here explicitly.
+ */
+#define DCBT_STOP_ALL_STREAM_IDS(scratch)	\
+.machine push ;					\
+.machine "power4" ;				\
+       lis     scratch,0x60000000@h;		\
+       dcbt    r0,scratch,0b01010;		\
+.machine pop
+
 /*
  * toreal/fromreal/tophys/tovirt macros. 32-bit BookE makes them
  * keep the address intact to be compatible with code shared with
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0e9095e..246b11c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -501,6 +501,13 @@ BEGIN_FTR_SECTION
 	ldarx	r6,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
 
+#ifdef CONFIG_PPC_BOOK3S
+/* Cancel all explict user streams as they will have no use after context
+ * switch and will stop the HW from creating streams itself
+ */
+	DCBT_STOP_ALL_STREAM_IDS(r6)
+#endif
+
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
