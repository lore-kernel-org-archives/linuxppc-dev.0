Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT6M3mLCzF2S2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:35:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426Y8ij134716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:35:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hq6sxtxq3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:35:04 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:35:02 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426Z0uE3932432
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:35:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8609442047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:12 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0699642041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:12 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:11 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 28698A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:34:58 +1000 (AEST)
Date: Wed, 2 May 2018 16:34:57 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/13] powerpc/eeh: Add eeh_max_freezes to initial EEH log line
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <ac861431c98e0c259fec18a0d220994ad6b362ae.1525242772.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current failure message includes the number of failures that have
occurred in the last hour (for a device) but it does not indicate
how many failures will be tolerated before the device is permanently
disabled.

Include the limit (eeh_max_freezes) to make this less surprising when
it happens.

Also remove the embedded newline from the existing message to make it
easier to grep for.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b8a329f04814..56a60b9eb397 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -778,14 +778,13 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	eeh_pe_update_time_stamp(pe);
 	pe->freeze_count++;
 	if (pe->freeze_count > eeh_max_freezes) {
-		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
-		       "last hour and has been permanently disabled.\n",
+		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the last hour and has been permanently disabled.\n",
 		       pe->phb->global_number, pe->addr,
 		       pe->freeze_count);
 		goto hard_fail;
 	}
-	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
-		pe->freeze_count);
+	pr_warn("EEH: This PCI device has failed %d times in the last hour and will be permanently disabled after %d failures.\n",
+		pe->freeze_count, eeh_max_freezes);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
-- 
2.16.1.74.g9b0b1f47b
