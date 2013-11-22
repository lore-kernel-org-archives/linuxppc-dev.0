Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C4A32C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 19:28:57 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 22 Nov 2013 03:28:54 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D549638C8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 03:28:50 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAM8SqSY6291808
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 08:28:52 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAM8Spsq002483
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 03:28:52 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/eeh: Output PHB diag-data
Date: Fri, 22 Nov 2013 16:28:46 +0800
Message-Id: <1385108926-10817-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1385108926-10817-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1385108926-10817-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When hitting frozen PE or fenced PHB, it's always indicative to
have dumped PHB diag-data for further analysis and diagnosis.
However, we never dump that for the cases. The patch intends to
dump PHB diag-data at the backend of eeh_ops::get_log() for PowerNV
platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index be33a16..31320c6 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -588,11 +588,8 @@ static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 		return -EIO;
 	}
 
-	/*
-	 * FIXME: We probably need log the error in somewhere.
-	 * Lets make it up in future.
-	 */
-	/* pr_info("%s", phb->diag.blob); */
+	/* The PHB diag-data is always indicative */
+	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
 
 	spin_unlock_irqrestore(&phb->lock, flags);
 
-- 
1.7.9.5
