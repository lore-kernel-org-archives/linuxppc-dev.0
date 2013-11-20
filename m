Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 191102C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 20:36:48 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 20 Nov 2013 04:36:46 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 94944C90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 04:36:42 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAK9ahIA4587836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 09:36:43 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAK9ahuk031313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 04:36:43 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Dump PHB3 diag-data on frozen PE
Date: Wed, 20 Nov 2013 17:36:36 +0800
Message-Id: <1384940196-32514-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While we detect frozen PE on PHB3, it's always meaningful to have
the dumped diag-data for further diagnosis and analysis.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 02245ce..481528d 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -994,8 +994,11 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
 				break;
 
+			/* It would be always indicative to have PHB diag-data */
 			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
 				(*pe)->addr, (*pe)->phb->global_number);
+			ioda_eeh_phb_diag(hose);
+
 			ret = 1;
 			goto out;
 		}
-- 
1.7.9.5
