Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPKK69HYzF20x
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:38:29 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c78so7755771pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:38:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] powerpc/powernv: Fix SMT4 forcing idle code
Date: Sun,  1 Apr 2018 15:38:13 +1000
Message-Id: <20180401053813.17405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PSSCR value is not stored to PACA_REQ_PSSCR in case the CPU does
not have the XER[SO] bug.

Fix this by storing up-front, outside the workaround code. The
initial test is not required because it is a slow path.

The workaround is made to depend on CONFIG_KVM_BOOK3S_HV_POSSIBLE, to
match pnv_power9_force_smt4_catch() where it is used.

Fixes: 7672691a08 ("powerpc/powernv: Provide a way to force a core into SMT4 mode")
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 89157cf452e3..d503203842b0 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -430,20 +430,20 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * r3 contains desired PSSCR register value.
  */
 _GLOBAL(power9_idle_stop)
-BEGIN_FTR_SECTION
-	lwz	r5, PACA_DONT_STOP(r13)
-	cmpwi	r5, 0
-	bne	1f
 	std	r3, PACA_REQ_PSSCR(r13)
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+BEGIN_FTR_SECTION
 	sync
 	lwz	r5, PACA_DONT_STOP(r13)
 	cmpwi	r5, 0
 	bne	1f
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
+#endif
 	mtspr 	SPRN_PSSCR,r3
 	LOAD_REG_ADDR(r4,power_enter_stop)
 	b	pnv_powersave_common
 	/* No return */
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 1:
 	/*
 	 * We get here when TM / thread reconfiguration bug workaround
@@ -453,6 +453,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
 	li	r3, 0
 	std	r3, PACA_REQ_PSSCR(r13)
 	blr		/* return 0 for wakeup cause / SRR1 value */
+#endif
 
 /*
  * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
-- 
2.16.3
