Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA2711A0250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:29 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A15714017E
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 12:36:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 202692CE8064
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2aD5g40829132
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:13 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aQXO025385
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] powerpc/powernv: Bail upon invalid master PE
Date: Wed, 12 Nov 2014 13:36:10 +1100
Message-Id: <1415759771-11359-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When freezing compound PEs in pnv_ioda_freeze_pe(), we should bail
upon illegal master PE. We needn't freeze slave PE because it should
have been put into frozen state by hardware.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 762ca14..d035035 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -373,7 +373,9 @@ static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
 	/* Fetch master PE */
 	if (pe->flags & PNV_IODA_PE_SLAVE) {
 		pe = pe->master;
-		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		if (WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER)))
+			return;
+
 		pe_no = pe->pe_number;
 	}
 
-- 
1.8.3.2
