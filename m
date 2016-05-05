Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0v0b57RzzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 22:11:59 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 5 May 2016 17:41:53 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 99F293940061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:41:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45CBoih51445844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:50 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45CBlXf022766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:49 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [PATCH 2/2] powerpc/mm: Enable support for ZONE_DEVICE on
 PPC_BOOK3S_64 platforms
Date: Thu,  5 May 2016 17:41:44 +0530
Message-Id: <1462450304-19173-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables support for the new ZONE_DEVCICE on PPC_BOOK3S_64 platforms
which now accommodates device memory during memory hotplug operation.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
NOTE: We need to enable CONFIG_EXPERT first before attempting to enable
CONFIG_ZONE_DEVICE, which will work when all of it's dependent configs
are enabled.

 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 989f8f3..8ecd869 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -654,7 +654,7 @@ config ZONE_DEVICE
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on X86_64 #arch_add_memory() comprehends device memory
+	depends on (X86_64 || PPC_BOOK3S_64) #arch_add_memory() comprehends device memory
 
 	help
 	  Device memory hotplug support allows for establishing pmem,
-- 
1.9.3
