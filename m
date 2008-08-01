Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8AD2DDE43C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:14:29 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] powerpc: implement crash_setup_regs for ppc32
Message-ID: <20080801141427.GG1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/asm-powerpc/kexec.h |   60 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/asm-powerpc/kexec.h b/include/asm-powerpc/kexec.h
index acdcdc6..9ecc307 100644
--- a/include/asm-powerpc/kexec.h
+++ b/include/asm-powerpc/kexec.h
@@ -38,7 +38,6 @@ typedef void (*crash_shutdown_t)(void);
 
 #ifdef CONFIG_KEXEC
 
-#ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
  * via panic or invoking dump using sysrq-trigger.
@@ -51,6 +50,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	else {
 		/* FIXME Merge this with xmon_save_regs ?? */
 		unsigned long tmp1, tmp2;
+#ifdef __powerpc64__
 		__asm__ __volatile__ (
 			"std    0,0(%2)\n"
 			"std    1,8(%2)\n"
@@ -99,16 +99,58 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 			: "=&r" (tmp1), "=&r" (tmp2)
 			: "b" (newregs)
 			: "memory");
+#else /* __powerpc64__ */
+		__asm__ __volatile__ (
+			"stw    0,0(%2)\n"
+			"stw    1,4(%2)\n"
+			"stw    2,8(%2)\n"
+			"stw    3,12(%2)\n"
+			"stw    4,16(%2)\n"
+			"stw    5,20(%2)\n"
+			"stw    6,24(%2)\n"
+			"stw    7,28(%2)\n"
+			"stw    8,32(%2)\n"
+			"stw    9,36(%2)\n"
+			"stw    10,40(%2)\n"
+			"stw    11,44(%2)\n"
+			"stw    12,48(%2)\n"
+			"stw    13,52(%2)\n"
+			"stw    14,56(%2)\n"
+			"stw    15,60(%2)\n"
+			"stw    16,64(%2)\n"
+			"stw    17,68(%2)\n"
+			"stw    18,72(%2)\n"
+			"stw    19,76(%2)\n"
+			"stw    20,80(%2)\n"
+			"stw    21,84(%2)\n"
+			"stw    22,88(%2)\n"
+			"stw    23,92(%2)\n"
+			"stw    24,96(%2)\n"
+			"stw    25,100(%2)\n"
+			"stw    26,104(%2)\n"
+			"stw    27,108(%2)\n"
+			"stw    28,112(%2)\n"
+			"stw    29,116(%2)\n"
+			"stw    30,120(%2)\n"
+			"stw    31,124(%2)\n"
+			"mfmsr  %0\n"
+			"stw    %0,132(%2)\n"
+			"mfctr  %0\n"
+			"stw    %0,140(%2)\n"
+			"mflr   %0\n"
+			"stw    %0,144(%2)\n"
+			"bl     1f\n"
+		"1:     mflr   %1\n"
+			"stw    %1,128(%2)\n"
+			"mtlr   %0\n"
+			"mfxer  %0\n"
+			"stw    %0,148(%2)\n"
+			: "=&r" (tmp1), "=&r" (tmp2)
+			: "b" (newregs)
+			: "memory");
+#endif /* __powerpc64 __ */
 	}
 }
-#else
-/*
- * Provide a dummy definition to avoid build failures. Will remain
- * empty till crash dump support is enabled.
- */
-static inline void crash_setup_regs(struct pt_regs *newregs,
-					struct pt_regs *oldregs) { }
-#endif /* !__powerpc64 __ */
 
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
-- 
1.5.5.4
