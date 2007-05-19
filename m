Return-Path: <anton@ozlabs.org>
Date: Sat, 19 May 2007 12:13:43 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] MMCR0_PMA0 != MMCR0_PMAO
Message-ID: <20070519171343.GA25520@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


pmc.c has:

#ifndef MMCR0_PMA0
#define MMCR0_PMA0     0

This one took a while to find. Unfortunately its the wrong define
(number 0 vs letter O). Its probably worth removing this override, since
if our includes get screwed up we will have the same (hard to debug)
failure.

Fix it simply for now, so that we can backport to stable.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Candidate for stable.

Index: kernel/arch/powerpc/kernel/pmc.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/pmc.c	2007-05-19 11:57:57.000000000 -0500
+++ kernel/arch/powerpc/kernel/pmc.c	2007-05-19 11:58:32.000000000 -0500
@@ -20,8 +20,8 @@
 #include <asm/cputable.h>
 #include <asm/pmc.h>
 
-#ifndef MMCR0_PMA0
-#define MMCR0_PMA0	0
+#ifndef MMCR0_PMAO
+#define MMCR0_PMAO	0
 #endif
 
 static void dummy_perf(struct pt_regs *regs)
@@ -30,7 +30,7 @@ static void dummy_perf(struct pt_regs *r
 	mtpmr(PMRN_PMGC0, mfpmr(PMRN_PMGC0) & ~PMGC0_PMIE);
 #elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
 	if (cur_cpu_spec->pmc_type == PPC_PMC_IBM)
-		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMA0));
+		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMAO));
 #else
 	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_PMXE);
 #endif
