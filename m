Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWB50nHzF1Sn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34G3I076847
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j65fjsn5c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BhNB63307918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42AE4AE045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:00:55 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4BC8AE057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:00:54 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:00:54 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 75F3AA03B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 12/13] powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER
Date: Fri, 25 May 2018 13:11:39 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <820eeed1f330ac0d0fb4d2669432d45233c2fe36.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a device without a driver is recovered via EEH, the flag
EEH_DEV_NO_HANDLER is incorrectly left set on the device after
recovery, because the test in eeh_report_resume() for the existence of
a bound driver is done before the flag is cleared. If a driver is
later bound, and EEH experienced again, some of the drivers EEH
handers are not called.

To correct this, clear the flag unconditionally after EEH processing
is complete.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 8dd2a33424a1..42fe80ed6f59 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -405,7 +405,6 @@ static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
-		edev->mode &= ~EEH_DEV_NO_HANDLER;
 		goto out;
 	}
 
@@ -780,6 +779,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *bus;
 	struct eeh_dev *edev, *tmp;
+	struct eeh_pe *tmp_pe;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
 	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
@@ -934,6 +934,10 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	eeh_set_irq_state(pe, true);
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
+	eeh_for_each_pe(pe, tmp_pe)
+		eeh_pe_for_each_dev(tmp_pe, edev, tmp)
+			edev->mode &= ~EEH_DEV_NO_HANDLER;
+
 	pr_info("EEH: Recovery successful.\n");
 	goto final;
 
-- 
2.16.1.74.g9b0b1f47b
