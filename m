Return-Path: <anton@ozlabs.org>
Date: Fri, 6 Aug 2010 14:53:15 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: inline ppc64_runlatch_off
Message-ID: <20100806045315.GR29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I'm sick of seeing ppc64_runlatch_off in our profiles, so inline the
heavily used part of it into the callers. To avoid a mess of circular includes
I didn't add it as an inline function.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/reg.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/reg.h	2010-08-04 19:55:38.910793475 +1000
+++ powerpc.git/arch/powerpc/include/asm/reg.h	2010-08-04 20:20:19.490751850 +1000
@@ -951,7 +951,14 @@
 #ifdef CONFIG_PPC64
 
 extern void ppc64_runlatch_on(void);
-extern void ppc64_runlatch_off(void);
+extern void __ppc64_runlatch_off(void);
+
+#define ppc64_runlatch_off()					\
+	do {							\
+		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
+		    test_thread_flag(TIF_RUNLATCH))		\
+			__ppc64_runlatch_off();			\
+	} while (0);
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
Index: powerpc.git/arch/powerpc/kernel/process.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/process.c	2010-08-04 19:55:38.890747120 +1000
+++ powerpc.git/arch/powerpc/kernel/process.c	2010-08-04 20:15:27.573241044 +1000
@@ -1198,19 +1198,17 @@ void ppc64_runlatch_on(void)
 	}
 }
 
-void ppc64_runlatch_off(void)
+void __ppc64_runlatch_off(void)
 {
 	unsigned long ctrl;
 
-	if (cpu_has_feature(CPU_FTR_CTRL) && test_thread_flag(TIF_RUNLATCH)) {
-		HMT_medium();
+	HMT_medium();
 
-		clear_thread_flag(TIF_RUNLATCH);
+	clear_thread_flag(TIF_RUNLATCH);
 
-		ctrl = mfspr(SPRN_CTRLF);
-		ctrl &= ~CTRL_RUNLATCH;
-		mtspr(SPRN_CTRLT, ctrl);
-	}
+	ctrl = mfspr(SPRN_CTRLF);
+	ctrl &= ~CTRL_RUNLATCH;
+	mtspr(SPRN_CTRLT, ctrl);
 }
 #endif
 
