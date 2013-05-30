Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D1242C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:18 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 02:24:16 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F00561FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:19:02 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OCNr150086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:24:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OCfb001616
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 02:24:12 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/23] powerpc/eeh: Make eeh_phb_pe_get() public
Date: Thu, 30 May 2013 16:23:45 +0800
Message-Id: <1369902245-5886-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
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
