Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E54C92C029E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:33 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 23:21:31 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E0E37C90042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:27 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LSQ4339980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:28 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LRhJ002991
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:28 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/31] powerpc/eeh: Make eeh_pe_get() public
Date: Thu, 20 Jun 2013 13:20:54 +0800
Message-Id: <1371705681-24632-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/eeh.h |    1 +
 arch/powerpc/kernel/eeh_pe.c   |    4 ++--
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
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 71c4544..3d2dcf5 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
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
