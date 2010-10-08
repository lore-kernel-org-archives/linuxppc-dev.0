Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94EB8B7377
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:09 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J75kg005873
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:05 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/11] powerpc/ppc64e: Fix link problem when building
	ppc64e_defconfig
Date: Fri,  8 Oct 2010 14:06:48 -0500
Message-Id: <1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
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
index c89a370..5c91a99 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -80,6 +80,7 @@ smp_85xx_kick_cpu(int nr)
 	local_irq_save(flags);
 
 	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+#ifdef CONFIG_PPC32
 	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
 
 	if (!ioremappable)
@@ -89,6 +90,12 @@ smp_85xx_kick_cpu(int nr)
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
