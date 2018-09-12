Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vh5LNhzF3FL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:44 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1IZnm034600
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2meq7h3rmw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NbNB655814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B346A4057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC7CFA4051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AEA28A03A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/14] powerpc/eeh: Cleanup eeh_add_virt_device()
Date: Wed, 12 Sep 2018 11:23:25 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <f78b91fa9e146f4e4e051a376cfd559c9a695a7b.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the unnecessary cast through void * on the first parameter and
remove the unused second parameter (always NULL).

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7766766bab57..cc300eb9585c 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -469,10 +469,9 @@ static enum pci_ers_result eeh_report_failure(struct eeh_dev *edev,
 	return rc;
 }
 
-static void *eeh_add_virt_device(void *data, void *userdata)
+static void *eeh_add_virt_device(struct eeh_dev *edev)
 {
 	struct pci_driver *driver;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
@@ -743,7 +742,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
 		if (pe->type & EEH_PE_VF) {
-			eeh_add_virt_device(edev, NULL);
+			eeh_add_virt_device(edev);
 		} else {
 			if (!driver_eeh_aware)
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
@@ -936,7 +935,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * recovered properly.
 	 */
 	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_list) {
-		eeh_add_virt_device(edev, NULL);
+		eeh_add_virt_device(edev);
 		list_del(&edev->rmv_list);
 	}
 
-- 
2.19.0.2.gcad72f5712
