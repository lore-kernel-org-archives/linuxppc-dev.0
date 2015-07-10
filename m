Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 007AB1A0225
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 15:20:40 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A57B2140273
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 15:20:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Fri, 10 Jul 2015 15:20:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E22792BB003F
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 15:20:36 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6A5KUHd59048102
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 15:20:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6A5K4J9024900
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 15:20:04 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: [PATCH V3 2/2] powerpc/kexec: Reset HILE before entering target kernel
Date: Fri, 10 Jul 2015 15:19:59 +1000
Message-Id: <1436505599-32109-3-git-send-email-sam.mj@au1.ibm.com>
In-Reply-To: <1436505599-32109-1-git-send-email-sam.mj@au1.ibm.com>
References: <1436505599-32109-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powernv secondary cpus are returned to OPAL, and will then enter the
target kernel in big-endian. However if it is set the HILE bit will persist,
causing the first exception in the target kernel to be delivered in
litte-endian regardless of the current endianess.

If running on top of OPAL make sure the HILE bit is reset before any
thread branches into the target kernel.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_64.c |  6 ++++--
 arch/powerpc/kernel/misc_64.S          | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1a74446..60bb626 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -29,6 +29,7 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/firmware.h>
 
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -313,7 +314,8 @@ struct paca_struct kexec_paca;
 /* Our assembly helper, in misc_64.S */
 extern void kexec_sequence(void *newstack, unsigned long start,
 			   void *image, void *control,
-			   void (*clear_all)(void)) __noreturn;
+			   void (*clear_all)(void),
+			   unsigned long features) __noreturn;
 
 /* too late to fail here */
 void default_machine_kexec(struct kimage *image)
@@ -361,7 +363,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-			ppc_md.hpte_clear_all);
+			ppc_md.hpte_clear_all, powerpc_firmware_features);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 6e4168c..abde07d 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -19,6 +19,7 @@
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/page.h>
+#include <asm/opal.h>
 #include <asm/cache.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
@@ -539,7 +540,7 @@ real_mode:	/* assume normal blr return */
 
 
 /*
- * kexec_sequence(newstack, start, image, control, clear_all())
+ * kexec_sequence(newstack, start, image, control, clear_all(), features)
  *
  * does the grungy work with stack switching and real mode switches
  * also does simple calls to other code
@@ -575,7 +576,7 @@ _GLOBAL(kexec_sequence)
 	mr	r29,r5			/* image (virt) */
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
-	mr	r26,r8			/* spare */
+	mr	r26,r8			/* powerpc_firmware_features */
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
@@ -590,6 +591,20 @@ _GLOBAL(kexec_sequence)
 	/* turn off mmu */
 	bl	real_mode
 
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_POWERNV)
+	li	r3,(FW_FEATURE_OPAL >> 16)
+	rldicr	r3,r3,16,63
+	and.	r3,r3,r26
+	cmpwi	r3,0
+	beq	99f
+
+	/* Reset HILE bit now that interrupts are disabled */
+	li	r3,1
+	li	r0,OPAL_REINIT_CPUS
+	bl	opal_call_realmode
+99:
+#endif
+
 	/* copy  0x100 bytes starting at start to 0 */
 	li	r3,0
 	mr	r4,r30		/* start, aka phys mem offset */
-- 
2.4.5
