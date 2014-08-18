Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com
 [IPv6:2607:f8b0:4002:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9131A00E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 05:01:11 +1000 (EST)
Received: by mail-yh0-f44.google.com with SMTP id f73so4889214yha.17
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 12:01:07 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Gerhard Sittig <gsi@denx.de>, Rob Herring <robh@kernel.org>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Fix build failure for PPC_32
Date: Mon, 18 Aug 2014 15:01:04 -0400
Message-Id: <1408388465-26577-1-git-send-email-bobby.prani@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix ppc 32 build failure as reported here:

http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/

The error is that pci_32.o was not being built for PPC_32. Fix error by adding
it in the Makefile. Tested using the ppc cross compiler.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 670c312..3206ba1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -89,7 +89,7 @@ extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc_32.o
 
-obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
+obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o pci_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
-- 
1.9.1
