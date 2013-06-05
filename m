Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C633A2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:41 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 01:34:39 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A85893E40039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 01:34:18 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YWEf135712
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YY6Z001681
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:35 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/27] powerpc/eeh: Enhance converting EEH dev
Date: Wed,  5 Jun 2013 15:34:03 +0800
Message-Id: <1370417668-16832-3-git-send-email-shangw@linux.vnet.ibm.com>
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
