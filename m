Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWP2rcjzDqmL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:25 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D17EF2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:20 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UCMd62587022
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436Tl6F023124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:48 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 2/7] powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64
 platforms
Date: Tue,  3 May 2016 11:59:21 +0530
Message-Id: <1462256966-19321-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
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
 arch/powerpc/Kconfig | 4 ++++
 mm/Kconfig           | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c0..9ac5c6f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1084,6 +1084,10 @@ endif
 config	ARCH_RANDOM
 	def_bool n
 
+config ZONE_DEVICE
+	bool
+	default y if PPC_BOOK3S_64
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
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
1.8.3.1
