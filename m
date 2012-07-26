Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/18] powerpc/mm: Replace abs_to_virt() with __va()
Date: Thu, 26 Jul 2012 17:19:50 +1000
Message-Id: <1343287204-7700-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

abs_to_virt() is just a wrapper around __va(), call __va() directly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 377e5cb..ba45739b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -43,7 +43,6 @@
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
-#include <asm/abs_addr.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/eeh.h>
@@ -651,7 +650,7 @@ static void __init htab_initialize(void)
 		DBG("Hash table allocated at %lx, size: %lx\n", table,
 		    htab_size_bytes);
 
-		htab_address = abs_to_virt(table);
+		htab_address = __va(table);
 
 		/* htab absolute addr + encoded htabsize */
 		_SDR1 = table + __ilog2(pteg_count) - 11;
-- 
1.7.9.5
