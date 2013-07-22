Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F21BD2C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:53:20 +1000 (EST)
Message-ID: <51ECD6A4.3050408@asianux.com>
Date: Mon, 22 Jul 2013 14:52:20 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 shangw@linux.vnet.ibm.com, weiyang@linux.vnet.ibm.com,
 linuxram@us.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] powerpc: platforms: powernv: add '__init' for
 pnv_pci_init_ioda2_phb()
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_pci_init_ioda2_phb() is only used during boot up, so need add
'__init' to save the related memory, and avoid related warning:

  The function .pnv_pci_init_ioda2_phb() references
  the function __init .pnv_pci_init_ioda_phb().
  This is often because .pnv_pci_init_ioda2_phb lacks a __init 
  annotation or the annotation of .pnv_pci_init_ioda_phb is wrong.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 49b57b9..d8140b1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1266,7 +1266,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
 }
 
-void pnv_pci_init_ioda2_phb(struct device_node *np)
+void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 {
 	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
 }
-- 
1.7.7.6
