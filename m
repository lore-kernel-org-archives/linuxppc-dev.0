Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 84179DE048
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:55 +1100 (EST)
Date: Sun, 4 Mar 2007 17:07:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 6/6] [POWERPC] make find_and_init_pbs() a void function
Message-Id: <20070304170738.26de2007.sfr@canb.auug.org.au>
In-Reply-To: <20070304170534.5c1ba10f.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
	<20070304170534.5c1ba10f.sfr@canb.auug.org.au>
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

It always returned 0 and noone checked.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/rtas_pci.c |    4 +---
 include/asm-powerpc/ppc-pci.h  |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index ace9f4c..1616a44 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -274,7 +274,7 @@ int __devinit rtas_setup_phb(struct pci_controller *phb)
 	return 0;
 }
 
-unsigned long __init find_and_init_phbs(void)
+void __init find_and_init_phbs(void)
 {
 	struct device_node *node;
 	struct pci_controller *phb;
@@ -319,8 +319,6 @@ unsigned long __init find_and_init_phbs(void)
 		if (prop)
 			pci_assign_all_buses = *prop;
 	}
-
-	return 0;
 }
 
 /* RPA-specific bits for removing PHBs */
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index 4a05340..f186720 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -24,7 +24,7 @@ extern void pci_setup_phb_io_dynamic(struct pci_controller *hose, int primary);
 extern struct list_head hose_list;
 extern int global_phb_number;
 
-extern unsigned long find_and_init_phbs(void);
+extern void find_and_init_phbs(void);
 
 extern struct pci_dev *ppc64_isabridge_dev;	/* may be NULL if no ISA bus */
 
-- 
1.5.0.1
