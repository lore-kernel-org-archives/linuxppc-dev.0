Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8DF32C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:43 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 01:34:41 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1E62E19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 01:34:30 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YbJj195132
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557Ya2u007474
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:37 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/27] powerpc/eeh: Make eeh_pe_get() public
Date: Wed,  5 Jun 2013 15:34:05 +0800
Message-Id: <1370417668-16832-5-git-send-email-shangw@linux.vnet.ibm.com>
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

While processing EEH event interrupt from P7IOC, we need function
to retrieve the PE according to the indicated EEH device. The patch
makes function eeh_pe_get() public so that other source files can call
it for that purpose. Also, the patch fixes referring to wrong BDF
(Bus/Device/Function) address while searching PE in function
__eeh_pe_get().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 4ac6f70..acdfcaa 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -185,6 +185,7 @@ static inline void eeh_unlock(void)
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
+struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 71c4544..3d2dcf5 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -228,7 +228,7 @@ static void *__eeh_pe_get(void *data, void *flag)
 		return pe;
 
 	/* Try BDF address */
-	if (edev->pe_config_addr &&
+	if (edev->config_addr &&
 	   (edev->config_addr == pe->config_addr))
 		return pe;
 
@@ -246,7 +246,7 @@ static void *__eeh_pe_get(void *data, void *flag)
  * which is composed of PCI bus/device/function number, or unified
  * PE address.
  */
-static struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
+struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 {
 	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
 	struct eeh_pe *pe;
-- 
1.7.5.4
