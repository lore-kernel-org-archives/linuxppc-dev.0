Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21BFD1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 16:19:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 4/5] powerpc/mm: Simplify page size kconfig dependencies
Date: Fri,  7 Aug 2015 16:19:46 +1000
Message-Id: <1438928387-6454-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For config options with only a single value, guarding the single value
with 'if' is the same as adding a 'depends' statement. And it's more
standard to just use 'depends'.

And if the option has both an 'if' guard and a 'depends' we can collapse
them into a single 'depends' by combining them with &&.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5ef27113b898..3a4ba2809201 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -560,16 +560,17 @@ config PPC_4K_PAGES
 	bool "4k page size"
 
 config PPC_16K_PAGES
-	bool "16k page size" if 44x || PPC_8xx
+	bool "16k page size"
+	depends on 44x || PPC_8xx
 
 config PPC_64K_PAGES
-	bool "64k page size" if 44x || PPC_STD_MMU_64 || PPC_BOOK3E_64
-	depends on !PPC_FSL_BOOK3E
+	bool "64k page size"
+	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
 	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
 config PPC_256K_PAGES
-	bool "256k page size" if 44x
-	depends on !STDBINUTILS
+	bool "256k page size"
+	depends on 44x && !STDBINUTILS
 	help
 	  Make the page size 256k.
 
-- 
2.1.4
