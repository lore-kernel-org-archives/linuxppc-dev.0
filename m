Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 47E031007D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:54:15 +1100 (EST)
Received: from mail30-va3 (localhost [127.0.0.1])	by mail30-va3-R.bigfish.com
 (Postfix) with ESMTP id 436591A0090	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 25 Oct 2011 22:54:06 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.239])	by
 mail30-va3.bigfish.com (Postfix) with ESMTP id 0A5BD1E0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:06 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 4/5] powerpc/85xx: use physical cpu from device tree
Date: Tue, 25 Oct 2011 17:54:05 -0500
Message-ID: <1319583246-6120-4-git-send-email-msm@freescale.com>
In-Reply-To: <1319583246-6120-1-git-send-email-msm@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we assume the first CPU to come up is the boot cpu. Instead
we can use the boot_cpu_phys from the device tree.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/asm-offsets.c    |    4 ++++
 arch/powerpc/kernel/head_fsl_booke.S |    9 ++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 536ffa8..264f8ad 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -28,6 +28,7 @@
 #include <linux/hardirq.h>
 #endif
 #include <linux/kbuild.h>
+#include <linux/of_fdt.h>
 
 #include <asm/io.h>
 #include <asm/page.h>
@@ -619,5 +620,8 @@ int main(void)
 	DEFINE(PACA_OPAL_MC_EVT, offsetof(struct paca_struct, opal_mc_evt));
 #endif
 
+	DEFINE(DT_BOOTCPU, offsetof(struct boot_param_header,
+					boot_cpuid_phys));
+
 	return 0;
 }
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9f5d210..eb28ade 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -87,6 +87,7 @@ _ENTRY(_start);
 	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
 	li	r23,0			/* phys kernel start (high) */
+	lwz	r22,DT_BOOTCPU(r3)	/* boot_cpuid_phys */
 
 /* We try to not make any assumptions about how the boot loader
  * setup or used the TLBs.  We invalidate all mappings from the
@@ -166,11 +167,8 @@ _ENTRY(__early_start)
 	/* Check to see if we're the second processor, and jump
 	 * to the secondary_start code if so
 	 */
-	lis	r24, boot_cpuid@h
-	ori	r24, r24, boot_cpuid@l
-	lwz	r24, 0(r24)
-	cmpwi	r24, -1
 	mfspr   r24,SPRN_PIR
+	cmpw	r22,r24
 	bne	__secondary_start
 #endif
 
@@ -192,9 +190,6 @@ _ENTRY(__early_start)
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
-	rlwinm  r22,r1,0,0,31-THREAD_SHIFT      /* current thread_info */
-	stw	r24, TI_CPU(r22)
-
 	bl	early_init
 
 #ifdef CONFIG_RELOCATABLE
-- 
1.7.6.1
