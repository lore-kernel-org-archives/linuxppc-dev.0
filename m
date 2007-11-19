Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E7A65DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 16:56:07 +1100 (EST)
Date: Mon, 19 Nov 2007 16:56:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] make global_phb_number static
Message-Id: <20071119165615.28de8b81.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 include/asm-powerpc/ppc-pci.h    |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0d89350..252dd1e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -48,7 +48,7 @@
 static DEFINE_SPINLOCK(hose_spinlock);
 
 /* XXX kill that some day ... */
-int global_phb_number;		/* Global phb counter */
+static int global_phb_number;		/* Global phb counter */
 
 /* ISA Memory physical address (or 0 if none) */
 resource_size_t isa_mem_base    = 0;
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index d41645e..854ab71 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -22,7 +22,6 @@ extern void pci_setup_phb_io_dynamic(struct pci_controller *hose, int primary);
 
 
 extern struct list_head hose_list;
-extern int global_phb_number;
 
 extern void find_and_init_phbs(void);
 
-- 
1.5.3.5
