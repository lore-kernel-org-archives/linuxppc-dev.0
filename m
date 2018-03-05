Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH2L1Y5TzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:38 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NxY8x092285
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 18:59:35 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghe9fkguy-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:59:35 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:59:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25NxSwV42074134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:59:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7642E4C04A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E3A4C044
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:52 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:52 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DE047A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:26 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:59:25 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/9] powerpc/eeh: Rename frozen_bus to bus in
 eeh_handle_normal_event()
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <a8d5f7792b761721852b68363c68519c6c8b62ff.1520294174.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The name "frozen_bus" is misleading: it's not necessarily frozen, it's
just the PE's PCI bus.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 04a5d9db5499..cb584d72b0a5 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -754,14 +754,14 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
  */
 void eeh_handle_normal_event(struct eeh_pe *pe)
 {
-	struct pci_bus *frozen_bus;
+	struct pci_bus *bus;
 	struct eeh_dev *edev, *tmp;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
 	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
 
-	frozen_bus = eeh_pe_bus_get(pe);
-	if (!frozen_bus) {
+	bus = eeh_pe_bus_get(pe);
+	if (!bus) {
 		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
 		return;
@@ -820,7 +820,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
 		pr_info("EEH: Reset with hotplug activity\n");
-		rc = eeh_reset_device(pe, frozen_bus, NULL);
+		rc = eeh_reset_device(pe, bus, NULL);
 		if (rc) {
 			pr_warn("%s: Unable to reset, err=%d\n",
 				__func__, rc);
@@ -938,7 +938,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
 		pci_lock_rescan_remove();
-		pci_hp_remove_devices(frozen_bus);
+		pci_hp_remove_devices(bus);
 		pci_unlock_rescan_remove();
 		/* The passed PE should no longer be used */
 		return;
-- 
2.16.1.74.g9b0b1f47b
