Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58FC42C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:12 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 21:35:09 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2369219D8036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:01 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3Z7Za134166
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3Z6bE003353
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:07 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/22] powerpc/eeh: Make eeh_pe_get() public
Date: Wed, 15 May 2013 11:34:40 +0800
Message-Id: <1368588898-16224-5-git-send-email-shangw@linux.vnet.ibm.com>
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
index 4b48178..9230aa4 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -186,6 +186,7 @@ typedef void *(*eeh_traverse_func)(void *data, void *flag);
 typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
+struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 6e3eb43..93ed9cb 100644
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
