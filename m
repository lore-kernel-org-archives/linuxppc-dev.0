Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 719BE1A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 04:03:06 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 12:03:01 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B4A0E38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 12:02:58 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0TH2wZA31064284
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 17:02:58 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0TGvrmj027566
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 11:57:54 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/book3s_32: Fix build error with checkpoint restart
Date: Fri, 29 Jan 2016 22:32:49 +0530
Message-Id: <1454086969-21074-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In file included from mm/vmscan.c:54:0:
include/linux/swapops.h: In function ‘pte_to_swp_entry’:
include/linux/swapops.h:69:2: error: implicit declaration of function ‘pte_swp_soft_dirty’ [-Werror=implicit-function-declaration]
  if (pte_swp_soft_dirty(pte))
  ^
include/linux/swapops.h:70:3: error: implicit declaration of function ‘pte_swp_clear_soft_dirty’ [-Werror=implicit-function-declaration]
   pte = pte_swp_clear_soft_dirty(pte);

We support soft dirty tracking only with book3s 64 for now.
So change the Kconfig dependency accordingly. Also CHECKPOINT_RESTORE
feature is not really dependent on SOFT_DIRTY. We track the dependency
between MEM_SOFT_DIRTY and ARCH_SOFT_DIRTY through headers

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 09b94174d372..599329332613 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -558,7 +558,7 @@ choice
 
 config PPC_4K_PAGES
 	bool "4k page size"
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
 
 config PPC_16K_PAGES
 	bool "16k page size"
@@ -567,7 +567,7 @@ config PPC_16K_PAGES
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
 
 config PPC_256K_PAGES
 	bool "256k page size"
-- 
2.5.0
