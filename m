Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ED093DDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:23:47 +1100 (EST)
Date: Fri, 21 Dec 2007 15:23:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] pointers marked as __iomem do not need to be
	volatile
Message-Id: <20071221152348.4165099e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes this warning:

arch/powerpc/platforms/powermac/pci.c: In function 'u3_ht_cfg_access':
arch/powerpc/platforms/powermac/pci.c:354: warning: return discards qualifiers from pointer target type
arch/powerpc/platforms/powermac/pci.c:358: warning: return discards qualifiers from pointer target type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/pci-bridge.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index f7ed2b6..a6ea49e 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -75,8 +75,8 @@ struct pci_controller {
 #endif
 
 	struct pci_ops *ops;
-	volatile unsigned int __iomem *cfg_addr;
-	volatile void __iomem *cfg_data;
+	unsigned int __iomem *cfg_addr;
+	void __iomem *cfg_data;
 
 #ifndef CONFIG_PPC64
 	/*
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
