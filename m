Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04CDD140171
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2AA973578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dQUB10748274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Ten014951
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 14/25] powerpc/powernv: Fix endless reporting frozen PE
Date: Thu, 24 Apr 2014 18:00:20 +1000
Message-Id: <1398326431-24305-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once one specific PE has been marked as EEH_PE_ISOLATED, it's in
the middile of recovery or removed permenently. We needn't report
the frozen PE again. Otherwise, we will have endless reporting
same frozen PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 35ec394..3a755b5 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -745,6 +745,11 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			 * If we can't find the corresponding PE, the
 			 * PEEV / PEST would be messy. So we force an
 			 * fenced PHB so that it can be recovered.
+			 *
+			 * If the PE has been marked as isolated, that
+			 * should have been removed permanently or in
+			 * progress with recovery. We needn't report
+			 * it again.
 			 */
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
 				*pe = phb_pe;
@@ -753,6 +758,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					hose->global_number,
 					frozen_pe_no);
 				ret = EEH_NEXT_ERR_FENCED_PHB;
+			} else if ((*pe)->state & EEH_PE_ISOLATED) {
+				ret = EEH_NEXT_ERR_NONE;
 			} else {
 				pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
 					(*pe)->addr, (*pe)->phb->global_number);
-- 
1.8.3.2
