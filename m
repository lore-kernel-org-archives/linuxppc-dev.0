Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3674EDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:15:59 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1CNFuhq020575
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 17:15:56 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix compile warning
Date: Thu, 12 Feb 2009 17:15:56 -0600
Message-Id: <1234480556-1144-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/fsl_booke_mmu.c: In function 'adjust_total_lowmem':
arch/powerpc/mm/fsl_booke_mmu.c:221: warning: format '%ld' expects type 'long int', but argument 3 has type 'phys_addr_t'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 6d38d77..985b6c3 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -218,7 +218,7 @@ adjust_total_lowmem(void)
 		p += sprintf(p, "0/");
 	p[-1] = '\0';
 
-	pr_info("Memory CAM mapping: %s Mb, residual: %ldMb\n", buf,
-	        (total_lowmem - __max_low_memory) >> 20);
+	pr_info("Memory CAM mapping: %s Mb, residual: %dMb\n", buf,
+	        (unsigned int)((total_lowmem - __max_low_memory) >> 20));
 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
-- 
1.5.6.6
