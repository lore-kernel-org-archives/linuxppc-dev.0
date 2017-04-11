Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZCR45FZzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:43:15 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g2so675880pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:43:15 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 7/9] powerpc/mm: Wire up ioremap_cache
Date: Wed, 12 Apr 2017 03:42:31 +1000
Message-Id: <20170411174233.21902-8-oohall@gmail.com>
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

The default implementation of ioremap_cache() is aliased to ioremap().
On powerpc ioremap() creates cache-inhibited mappings by default which
is almost certainly not what you wanted.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5ed292431b5b..839eb031857f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -757,6 +757,8 @@ extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
 extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 #define ioremap_uc(addr, size)		ioremap((addr), (size))
+#define ioremap_cache(addr, size) \
+	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
 extern void iounmap(volatile void __iomem *addr);
 
-- 
2.9.3
