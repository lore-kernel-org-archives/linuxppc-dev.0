Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D6BD2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 02:24:14 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 13E2A38C801A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:11 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OB5J298160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OAvm032546
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:24:11 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/23] powerpc/eeh: Enhance converting EEH dev
Date: Thu, 30 May 2013 16:23:43 +0800
Message-Id: <1369902245-5886-2-git-send-email-shangw@linux.vnet.ibm.com>
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

Under some special circumstances, the EEH device doesn't have the
associated device tree node or PCI device. The patch enhances those
functions converting EEH device to device tree node or PCI device
accordingly to avoid unnecessary system crash.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a80e32b4..e32c3c5 100644
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
