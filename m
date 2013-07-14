Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A6AE2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:07:30 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: remove the unused function disable_kernel_fp()
Date: Sun, 14 Jul 2013 17:02:03 +0800
Message-ID: <1373792526-16241-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
References: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only using of function disable_kernel_fp() was already dropped
in the commit 5daf9071 (powerpc: merge align.c).

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h |  1 -
 arch/powerpc/kernel/misc_64.S        | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 49a13e0..33e1cd8 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -18,7 +18,6 @@ extern struct task_struct *_switch(struct thread_struct *prev,
 
 extern void giveup_fpu(struct task_struct *);
 extern void load_up_fpu(void);
-extern void disable_kernel_fp(void);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 6820e45..8110abe 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -416,19 +416,6 @@ _GLOBAL(scom970_write)
 	blr
 #endif /* CONFIG_CPU_FREQ_PMAC64 || CONFIG_CPU_FREQ_MAPLE */
 
-
-/*
- * disable_kernel_fp()
- * Disable the FPU.
- */
-_GLOBAL(disable_kernel_fp)
-	mfmsr	r3
-	rldicl	r0,r3,(63-MSR_FP_LG),1
-	rldicl	r3,r0,(MSR_FP_LG+1),0
-	mtmsrd	r3			/* disable use of fpu now */
-	isync
-	blr
-
 /* kexec_wait(phys_cpu)
  *
  * wait for the flag to change, indicating this kernel is going away but
-- 
1.8.1.4
