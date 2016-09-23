Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sgLlF1KLTzDsml
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 15:00:08 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel] powerpc: Bump minimum zone order for 4K system page
 size
Date: Fri, 23 Sep 2016 14:51:03 +1000
Message-Id: <1474606263-19298-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The moderm kernel on powernv platform cannot possibly boot with values
less than 12 as the default DMA window of 2GB requires
(2<<30)/4096 TCEs which is 4MB of contiguous memory, log2(4M) == 22
so anything less than 12 won't work.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I am hitting this when switching the system page size from 64K to 4K and
back. When I switch to 64K, zone order is set to 9 by default and
it does not change when I switch to 4K as 9 is still within the limits.
And there are other folks complaining about this too.
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab..3516f16 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -637,7 +637,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
 	default "9" if PPC64 && PPC_64K_PAGES
-	range 9 13 if PPC64 && !PPC_64K_PAGES
+	range 12 13 if PPC64 && !PPC_64K_PAGES
 	default "13" if PPC64 && !PPC_64K_PAGES
 	range 9 64 if PPC32 && PPC_16K_PAGES
 	default "9" if PPC32 && PPC_16K_PAGES
-- 
2.5.0.rc3
