Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D30AFB70E7
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Mar 2011 08:05:25 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix writing to spin table 'cpu-release-addr' on
	ppc64e
Date: Sat,  5 Mar 2011 15:05:19 -0600
Message-Id: <1299359119-7176-1-git-send-email-galak@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kumar Gala <kumar.gala@freescale.com>

If the spin table is located in the linear mapping (which can happen if
we have 4G or more of memory) we need to access the spin table via a
cacheable coherent mapping like we do on ppc32 (and do explicit cache
flush).

See the following commit for the ppc32 version of this issue:

commit d1d47ec6e62ab08d2ebb925fd9203abfad3adfbf
Author: Peter Tyser <ptyser@xes-inc.com>
Date:   Fri Dec 18 16:50:37 2009 -0600

    powerpc/85xx: Fix SMP when "cpu-release-addr" is in lowmem

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5c91a99..0d00ff9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -91,10 +91,14 @@ smp_85xx_kick_cpu(int nr)
 	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
 		mdelay(1);
 #else
+	smp_generic_kick_cpu(nr);
+
 	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
 		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
 
-	smp_generic_kick_cpu(nr);
+	if (!ioremappable)
+		flush_dcache_range((ulong)bptr_vaddr,
+				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
 #endif
 
 	local_irq_restore(flags);
-- 
1.7.2.3
