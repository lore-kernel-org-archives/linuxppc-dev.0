Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmYnW6vWnzDrLQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:36:44 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LAZ4BK121848
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:42 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g964mapau-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:42 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 10:36:40 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC PATCH v0 1/2] powerpc, drmem: Fix unexpected flag value in ibm,
 dynamic-memory-v2
Date: Wed, 21 Feb 2018 16:06:26 +0530
In-Reply-To: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1519209387-29767-2-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory addtion and removal by count and indexed-count methods
temporarily mark the LMBs that are being added/removed by a special
flag value DRMEM_LMB_RESERVED. Accessing flags value directly at
a few places without proper accessor method is causing two unexpected
side-effects:

- DRMEM_LMB_RESERVED bit is becoming part of the flags word of
  drconf_cell_v2 entries in ibm,dynamic-memory-v2 DT property.
- This results in extra drconf_cell entries in ibm,dynamic-memory-v2.
  For example if 1G memory is added, it leads to one entry for 3 LMBs
  and 1 separate entry for the last LMB. All the 4 LMBs should be
  defined by one entry here.

Fix this by always accessing the flags by its accessor method
drmem_lmb_flags().

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/mm/drmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 916844f..3f18036 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -98,7 +98,7 @@ static void init_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
 	dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
 	dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
 	dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
-	dr_cell->flags = cpu_to_be32(lmb->flags);
+	dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
 }
 
 static int drmem_update_dt_v2(struct device_node *memory,
@@ -121,7 +121,7 @@ static int drmem_update_dt_v2(struct device_node *memory,
 		}
 
 		if (prev_lmb->aa_index != lmb->aa_index ||
-		    prev_lmb->flags != lmb->flags)
+		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb))
 			lmb_sets++;
 
 		prev_lmb = lmb;
@@ -150,7 +150,7 @@ static int drmem_update_dt_v2(struct device_node *memory,
 		}
 
 		if (prev_lmb->aa_index != lmb->aa_index ||
-		    prev_lmb->flags != lmb->flags) {
+		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb)) {
 			/* end of one set, start of another */
 			dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
 			dr_cell++;
-- 
2.7.4
