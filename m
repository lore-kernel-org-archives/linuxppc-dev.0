Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42D392C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 04:20:08 +1000 (EST)
Received: by mail-ie0-f174.google.com with SMTP id 9so13019554iec.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2013 11:20:05 -0700 (PDT)
Subject: [PATCH] powerpc/powernv: Mark pnv_pci_init_ioda2_phb() as __init
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 02 Jul 2013 12:20:03 -0600
Message-ID: <20130702182003.28238.61942.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark pnv_pci_init_ioda2_phb() as __init.  It is called only from an
init function (pnv_pci_init()), and it calls an init function
(pnv_pci_init_ioda_phb()):

    pnv_pci_init                # init
      pnv_pci_init_ioda2_phb    # non-init
	pnv_pci_init_ioda_phb   # init

This should fix a section mismatch warning.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9c9d15e..dfbb03d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1210,7 +1210,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 		opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
 }
 
-void pnv_pci_init_ioda2_phb(struct device_node *np)
+void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 {
 	pnv_pci_init_ioda_phb(np, PNV_PHB_IODA2);
 }
