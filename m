Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC2722C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:41 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 03:34:38 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 14BFFC90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 03:34:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YaiR298056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YZG2021684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 04:34:36 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/27] powerpc/eeh: Make eeh_phb_pe_get() public
Date: Wed,  5 Jun 2013 15:34:04 +0800
Message-Id: <1370417668-16832-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of the possible cases indicated by P7IOC interrupt is fenced
PHB. For that case, we need fetch the PE corresponding to the PHB
and disable the PHB and all subordinate PCI buses/devices, recover
from the fenced state and eventually enable the whole PHB. We need
one function to fetch the PHB PE outside eeh_pe.c and the patch is
going to make eeh_phb_pe_get() public for that purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e32c3c5..4ac6f70 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -184,6 +184,7 @@ static inline void eeh_unlock(void)
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int eeh_phb_pe_create(struct pci_controller *phb);
+struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 9d4a9e8..71c4544 100644
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
