Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zG1MD1kvBzF0bP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 16:45:26 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel] powerpc/init: Do not advertise radix during
 client-architecture-support
Date: Tue,  9 Jan 2018 16:45:20 +1100
Message-Id: <20180109054520.31704-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the pseries kernel advertises radix MMU support even if
the actual support is disabled via the CONFIG_PPC_RADIX_MMU option.

This adds a check for CONFIG_PPC_RADIX_MMU to avoid advertising radix
to the hypervisor.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/prom_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 02190e9..65879df 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1109,7 +1109,8 @@ static void __init prom_check_platform_support(void)
 		}
 	}
 
-	if (supported.radix_mmu && supported.radix_gtse) {
+	if (supported.radix_mmu && supported.radix_gtse &&
+	    IS_ENABLED(CONFIG_PPC_RADIX_MMU)) {
 		/* Radix preferred - but we require GTSE for now */
 		prom_debug("Asking for radix with GTSE\n");
 		ibm_architecture_vec.vec5.mmu = OV5_FEAT(OV5_MMU_RADIX);
-- 
2.11.0
