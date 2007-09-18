Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B3300DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:26:54 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 593EF8810
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 17:26:53 +0500 (SAMST)
Date: Tue, 18 Sep 2007 16:29:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC][RFC] sysdev/commproc.c: fix build caused by
	undefined symbols
Message-ID: <20070918122925.GA17481@localhost.localdomain>
References: <20070918120752.GA4859@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070918120752.GA4859@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cpm_install_handler and cpm_free_handler neither used nor defined
for arch/powerpc.

This causes MPC8xx build failure, patch used to fix that.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    5 -----
 include/asm-powerpc/commproc.h  |    3 ---
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index b4163c3..4d28774 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -176,11 +176,6 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
 #endif
 
-#ifdef  CONFIG_8xx
-EXPORT_SYMBOL(cpm_install_handler);
-EXPORT_SYMBOL(cpm_free_handler);
-#endif /* CONFIG_8xx */
-
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 3972487..0d92012 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -686,7 +686,4 @@ typedef struct risc_timer_pram {
 #define CICR_IEN		((uint)0x00000080)	/* Int. enable */
 #define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
 
-extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
-extern void cpm_free_handler(int vec);
-
 #endif /* __CPM_8XX__ */
-- 
1.5.0.6
