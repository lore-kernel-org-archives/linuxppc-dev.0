Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 70468B708A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 17:16:12 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/1] powerpc/smp: remove the incorrect decrementer initial
	codes for AP
Date: Fri, 16 Jul 2010 14:17:11 +0800
Message-Id: <1279261031-26190-1-git-send-email-tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already defined start_cpu_decrementer() to invoke decrementer for AP as
the following path:
---
start_secondary() -> secondary_cpu_time_init() -> start_cpu_decrementer()

So remove these incorrect codes introduced from commit:
e7f75ad0 powerpc/47x: Base ppc476 support

And actually we really should not enable decrementer before calling set_dec().

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/smp.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5c196d1..976fc7d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -501,14 +501,6 @@ int __devinit start_secondary(void *unused)
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
-
-#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-	/* Clear any pending timer interrupts */
-	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
-
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif
 	set_dec(tb_ticks_per_jiffy);
 	preempt_disable();
 	cpu_callin_map[cpu] = 1;
-- 
1.5.6
