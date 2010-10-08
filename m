Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8521B70A5
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 03:00:16 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98G0BFm007397
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 11:00:12 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ppc64e: Fix link problem when building
	ppc64e_defconfig
Date: Fri,  8 Oct 2010 11:00:11 -0500
Message-Id: <1286553611-19420-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/platforms/built-in.o:(.toc1+0x18): undefined reference to `__early_start'

This is due to the 85xx/smp.c not handling the 64-bit side properly.  We
need to set the entry point for secondary cores on ppc64e to
generic_secondary_smp_init instead of __early_start that we due on ppc32.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a6b1065..bd38b6a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -79,6 +79,7 @@ smp_85xx_kick_cpu(int nr)
 	local_irq_save(flags);
 
 	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+#ifdef CONFIG_PPC32
 	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
 
 	if (!ioremappable)
@@ -88,6 +89,12 @@ smp_85xx_kick_cpu(int nr)
 	/* Wait a bit for the CPU to ack. */
 	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
 		mdelay(1);
+#else
+	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
+		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
+
+	smp_generic_kick_cpu(nr);
+#endif
 
 	local_irq_restore(flags);
 
-- 
1.7.2.3
