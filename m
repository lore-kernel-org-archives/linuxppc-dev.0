Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZCN3Hv9zDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:43:12 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 81so670364pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:43:12 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 6/9] powerpc, mm: Enable ZONE_DEVICE on powerpc
Date: Wed, 12 Apr 2017 03:42:30 +1000
Message-Id: <20170411174233.21902-7-oohall@gmail.com>
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Flip the switch. Running around and screaming "IT'S ALIVE" is optional,
but recommended.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 43d000e44424..d696af58f97f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -724,7 +724,7 @@ config ZONE_DEVICE
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on X86_64 #arch_add_memory() comprehends device memory
+	depends on (X86_64 || PPC_BOOK3S_64)  #arch_add_memory() comprehends device memory
 
 	help
 	  Device memory hotplug support allows for establishing pmem,
-- 
2.9.3
