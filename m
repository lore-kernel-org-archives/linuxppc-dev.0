Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id D907367C25
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:33 +1100 (EST)
Message-Id: <20061102125625.828393000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:00 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 05/16] powerpc: remove ifdef
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

current kernels always have one of CONFIG_PPC_MULTIPLATFORM
or CONFIG_PPC32 defined, so remove bogus ifdef

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6/include/asm-powerpc/pci.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pci.h
+++ linux-2.6/include/asm-powerpc/pci.h
@@ -238,12 +238,10 @@ extern pgprot_t	pci_phys_mem_access_prot
 					 unsigned long size,
 					 pgprot_t prot);
 
-#if defined(CONFIG_PPC_MULTIPLATFORM) || defined(CONFIG_PPC32)
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
-#endif /* CONFIG_PPC_MULTIPLATFORM || CONFIG_PPC32 */
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
