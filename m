Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT8P5MYXzF2Ry
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:36:53 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426Yjp2005077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:36:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hq6syayvb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:36:50 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:36:49 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426akBX62586888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:36:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 729D511C04C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:22 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FA5C11C058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:22 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:22 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CC108A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:36:44 +1000 (AEST)
Date: Wed, 2 May 2018 16:36:43 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/13] powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <67f76320f1d43b0a691337c8af48414f86e76f07.1525242772.git.sbobroff@linux.ibm.com>
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
index b3edd0df04b8..eb4feee81ff4 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -399,7 +399,6 @@ static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
-		edev->mode &= ~EEH_DEV_NO_HANDLER;
 		goto out;
 	}
 
@@ -774,6 +773,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *bus;
 	struct eeh_dev *edev, *tmp;
+	struct eeh_pe *tmp_pe;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
 	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
@@ -928,6 +928,10 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
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
