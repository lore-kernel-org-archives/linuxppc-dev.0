Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFCAF1A0232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:45:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 15 Dec 2014 11:45:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CDDD3357806A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:45:02 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBF1j23E10354864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:45:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBF1j2cF020521
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:45:02 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] powerpc/pci: remove the multi-init for pci_dn->phb
Date: Mon, 15 Dec 2014 09:45:00 +0800
Message-Id: <1418607900-7960-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20141214105742.GA4476@shangw>
References: <20141214105742.GA4476@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_dn->phb is set to phb in update_dn_pci_info(), if succeed.

This patch removes the duplication of pci_dn->phb initialization.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

V2:
   * rebase the code on v3.18
---
 arch/powerpc/kernel/pci_dn.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 1f61fab..83df307 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -147,10 +147,8 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	/* PHB nodes themselves must not match */
 	update_dn_pci_info(dn, phb);
 	pdn = dn->data;
-	if (pdn) {
+	if (pdn)
 		pdn->devfn = pdn->busno = -1;
-		pdn->phb = phb;
-	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
 	traverse_pci_devices(dn, update_dn_pci_info, phb);
-- 
1.7.9.5
