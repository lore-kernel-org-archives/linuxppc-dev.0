Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 094042C030B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:42 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:17:39 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A16D7C9001D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:26 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHQVb310734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:26 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHPKv007040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:26 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/22] powerpc/eeh: Enhance converting EEH dev
Date: Fri,  1 Mar 2013 22:16:59 +0800
Message-Id: <1362147440-14096-2-git-send-email-shangw@linux.vnet.ibm.com>
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

Under some special circumstances, the EEH device doesn't have the
associated device tree node or PCI device. It is caused by the
PCI device corresponding to the device tree node can't support
EEH function.

The patch enhances converting EEH device to device tree node or
PCI device accordingly to avoid system crash.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a80e32b..e32c3c5 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -95,12 +95,12 @@ struct eeh_dev {
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
 {
-	return edev->dn;
+	return edev ? edev->dn : NULL;
 }
 
 static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 {
-	return edev->pdev;
+	return edev ? edev->pdev : NULL;
 }
 
 /*
-- 
1.7.5.4
