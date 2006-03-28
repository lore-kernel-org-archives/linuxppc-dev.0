Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0EED3679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 14:41:42 +1100 (EST)
Date: Tue, 28 Mar 2006 14:40:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: make ISA floppies work again
Message-Id: <20060328144058.3f1f1042.sfr@canb.auug.org.au>
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

We used to assume that a DMA mapping request with a NULL dev was for
ISA DMA.  This assumption was broken at some point.  Now we explicitly
pass the detected ISA PCI device in the floppy setup.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/pci_64.c |    1 +
 include/asm-powerpc/floppy.h |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

32929948e23a3ab8942b6bedef8e6f15f9a19b46
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index ba92bab..4c4449b 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -78,6 +78,7 @@ int global_phb_number;		/* Global phb co
 
 /* Cached ISA bridge dev. */
 struct pci_dev *ppc64_isabridge_dev = NULL;
+EXPORT_SYMBOL_GPL(ppc64_isabridge_dev);
 
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
diff --git a/include/asm-powerpc/floppy.h b/include/asm-powerpc/floppy.h
index e258778..608164c 100644
--- a/include/asm-powerpc/floppy.h
+++ b/include/asm-powerpc/floppy.h
@@ -35,6 +35,7 @@
 #ifdef CONFIG_PCI
 
 #include <linux/pci.h>
+#include <asm/ppc-pci.h>	/* for ppc64_isabridge_dev */
 
 #define fd_dma_setup(addr,size,mode,io) powerpc_fd_dma_setup(addr,size,mode,io)
 
@@ -52,12 +53,12 @@ static __inline__ int powerpc_fd_dma_set
 	if (bus_addr 
 	    && (addr != prev_addr || size != prev_size || dir != prev_dir)) {
 		/* different from last time -- unmap prev */
-		pci_unmap_single(NULL, bus_addr, prev_size, prev_dir);
+		pci_unmap_single(ppc64_isabridge_dev, bus_addr, prev_size, prev_dir);
 		bus_addr = 0;
 	}
 
 	if (!bus_addr)	/* need to map it */
-		bus_addr = pci_map_single(NULL, addr, size, dir);
+		bus_addr = pci_map_single(ppc64_isabridge_dev, addr, size, dir);
 
 	/* remember this one as prev */
 	prev_addr = addr;
-- 
1.2.4
