Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Mar 2006 11:46:18 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: export validate_sp for oprofile calltrace
Message-ID: <20060327004618.GB4962@krispykreme>
References: <20060327002329.GA4962@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060327002329.GA4962@krispykreme>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Export validate_sp so we can use it in the oprofile calltrace code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/process.c
===================================================================
--- build.orig/arch/powerpc/kernel/process.c	2006-03-26 10:39:29.000000000 +1000
+++ build/arch/powerpc/kernel/process.c	2006-03-26 12:48:03.000000000 +1000
@@ -767,7 +767,7 @@ out:
 	return error;
 }
 
-static int validate_sp(unsigned long sp, struct task_struct *p,
+int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
 	unsigned long stack_page = (unsigned long)task_stack_page(p);
@@ -805,6 +805,8 @@ static int validate_sp(unsigned long sp,
 #define FRAME_MARKER	2
 #endif
 
+EXPORT_SYMBOL(validate_sp);
+
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
Index: build/include/asm-powerpc/processor.h
===================================================================
--- build.orig/include/asm-powerpc/processor.h	2006-03-24 15:51:22.000000000 +1100
+++ build/include/asm-powerpc/processor.h	2006-03-26 12:48:03.000000000 +1000
@@ -251,6 +251,10 @@ static inline unsigned long __pack_fe01(
 #define cpu_relax()	barrier()
 #endif
 
+/* Check that a certain kernel stack pointer is valid in task_struct p */
+int validate_sp(unsigned long sp, struct task_struct *p,
+                       unsigned long nbytes);
+
 /*
  * Prefetch macros.
  */
