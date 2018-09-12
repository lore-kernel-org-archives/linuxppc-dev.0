Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vg3T3pzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:43 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1IbiI041223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2memy30gd8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:40 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NaXP60358680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0875452052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA91152050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B4B44A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/14] powerpc/eeh: Cleanup logic in eeh_rmv_from_parent_pe()
Date: Wed, 12 Sep 2018 11:23:28 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <7a9a1f802c8f14a90db27e03494e1d7922ef3df9.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the call to eeh_dev_to_pe() up, so that later it's clear that
"pe" isn't NULL.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 7d6d93cd67e1..78f125d24bd0 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -456,7 +456,8 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	int cnt;
 	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
-	if (!edev->pe) {
+	pe = eeh_dev_to_pe(edev);
+	if (!pe) {
 		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
 			 __func__,  pdn->phb->global_number,
 			 pdn->busno,
@@ -466,7 +467,6 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	}
 
 	/* Remove the EEH device */
-	pe = eeh_dev_to_pe(edev);
 	edev->pe = NULL;
 	list_del(&edev->entry);
 
-- 
2.19.0.2.gcad72f5712
