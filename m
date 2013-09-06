Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 375DA2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:16 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:14 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 790FD6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:11 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610Bx417563844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:11 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610AUa029634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:00:11 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/eeh: Output error number
Date: Fri,  6 Sep 2013 09:00:02 +0800
Message-Id: <1378429205-16248-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch prints the error number while failing to retrieve error
log from firmware. It's helpful for debugging.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 3ee44b0..d60ba3b 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -590,8 +590,8 @@ static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
 	if (ret) {
 		spin_unlock_irqrestore(&phb->lock, flags);
-		pr_warning("%s: Failed to get log for PHB#%x-PE#%x\n",
-			   __func__, hose->global_number, pe->addr);
+		pr_warning("%s: Can't get log for PHB#%x-PE#%x (%lld)\n",
+			   __func__, hose->global_number, pe->addr, ret);
 		return -EIO;
 	}
 
-- 
1.7.5.4
