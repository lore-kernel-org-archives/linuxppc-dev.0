Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC5F3B6F88
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2011 06:52:05 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p52Kq1hg024305
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jun 2011 15:52:01 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/book3e: Fix CPU feature handling on e5500 in 32-bit
	mode
Date: Thu,  2 Jun 2011 15:52:01 -0500
Message-Id: <1307047921-4784-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are missing FPU feature bit that user space may require.  In the
64-bit mode this gets set since we pull it in via COMMON_USER_PPC64.  We
just explicity set it so user space will be happy again.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/cputable.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 34d2722..9fb9332 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1979,7 +1979,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_value		= 0x80240000,
 		.cpu_name		= "e5500",
 		.cpu_features		= CPU_FTRS_E5500,
-		.cpu_user_features	= COMMON_USER_BOOKE,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
-- 
1.7.3.4
