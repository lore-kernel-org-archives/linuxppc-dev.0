Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6042B2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:12 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 23:35:09 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 97C93C90058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:07 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3Z7o4321210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 23:35:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3Z6Tx017821
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:35:07 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/22] powerpc/eeh: Make eeh_phb_pe_get() public
Date: Wed, 15 May 2013 11:34:39 +0800
Message-Id: <1368588898-16224-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While processing EEH event interrupt from P7IOC, we need function
to retrieve the PE according to the indicated PCI host controller
(struct pci_controller). The patch makes function eeh_phb_pe_get()
public so that other source files can call it for that purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index eeaeab6..4b48178 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -185,6 +185,7 @@ static inline void eeh_unlock(void)
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
 int eeh_phb_pe_create(struct pci_controller *phb);
+struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index fe43d1a..6e3eb43 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -95,7 +95,7 @@ int eeh_phb_pe_create(struct pci_controller *phb)
  * hierarchy tree is composed of PHB PEs. The function is used
  * to retrieve the corresponding PHB PE according to the given PHB.
  */
-static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
+struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 {
 	struct eeh_pe *pe;
 
-- 
1.7.5.4
