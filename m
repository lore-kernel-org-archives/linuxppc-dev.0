Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWW80kg3zF1Rv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:47 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34FBr076791
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:45 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j65fjsn40-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:44 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3Bgif3604784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A531A4051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:00 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08BE0A404D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:00 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:59 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 60824A0206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/13] powerpc/eeh: Add eeh_max_freezes to initial EEH log
 line
Date: Fri, 25 May 2018 13:11:28 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <ac861431c98e0c259fec18a0d220994ad6b362ae.1527217866.git.sbobroff@linux.ibm.com>
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
