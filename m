Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB06E2C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:39 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:17:37 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1962FC9002A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:31 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHVkf27721980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:31 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHUOx007382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:30 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/22] powerpc/eeh: Make eeh_pe_get public
Date: Fri,  1 Mar 2013 22:17:02 +0800
Message-Id: <1362147440-14096-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While processing EEH event caused by interrupt sent from P7IOC,
we need function to retrieve the PE according to the indicated
EEH device.

The patch makes function eeh_pe_get() public so that other source
files can call it. Also, the patch fixes referring to wrong BDF
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
