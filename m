Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C77F5DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:06:48 +1100 (EST)
Date: Mon, 19 Nov 2007 17:06:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: declare iSeries_pci_final_fixup in pci.h
Message-Id: <20071119170656.74fb77f7.sfr@canb.auug.org.au>
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

Fixes sparse warning:
arch/powerpc/platforms/iseries/pci.c:169:13: warning: symbol 'iSeries_pci_final_fixup' was not declared. Should it be static?

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.h   |    5 +++++
 arch/powerpc/platforms/iseries/setup.c |    6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index 33a8489..730986b 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -59,5 +59,10 @@ static inline u64 iseries_ds_addr(struct device_node *node)
 }
 
 extern void	iSeries_Device_Information(struct pci_dev*, int);
+#ifdef CONFIG_PCI
+extern void	iSeries_pci_final_fixup(void);
+#else
+static void	iSeries_pci_final_fixup(void) { }
+#endif
 
 #endif /* _PLATFORMS_ISERIES_PCI_H */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 0877a88..8a652da 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -63,6 +63,7 @@
 #include "main_store.h"
 #include "call_sm.h"
 #include "call_hpt.h"
+#include "pci.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -74,11 +75,6 @@
 static unsigned long build_iSeries_Memory_Map(void);
 static void iseries_shared_idle(void);
 static void iseries_dedicated_idle(void);
-#ifdef CONFIG_PCI
-extern void iSeries_pci_final_fixup(void);
-#else
-static void iSeries_pci_final_fixup(void) { }
-#endif
 
 
 struct MemoryBlock {
-- 
1.5.3.5
