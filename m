Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404L7T38gZzF0wR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 13:47:01 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2J2hrVo133505
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:46:58 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gsxyrge3a-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:46:58 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 19 Mar 2018 02:46:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w2J2ktQa54067270
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:46:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06F5C4C050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:40:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A81864C040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:40:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:40:04 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (unknown [9.192.172.254])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 756A1A003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 13:46:53 +1100 (AEDT)
Date: Mon, 19 Mar 2018 13:46:51 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/9] powerpc/eeh: Remove misleading test in
 eeh_handle_normal_event()
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
Message-Id: <52c15c0414d248981e251386384ed2a716315003.1521427331.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove a test that checks if "frozen_bus" is NULL, because it cannot
have changed since it was tested at the start of the function and so
must be true here.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 5b7a5ed4db4d..04a5d9db5499 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -930,20 +930,18 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * all removed devices correctly to avoid access
 	 * the their PCI config any more.
 	 */
-	if (frozen_bus) {
-		if (pe->type & EEH_PE_VF) {
-			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
-			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
-		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
-			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+	if (pe->type & EEH_PE_VF) {
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+	} else {
+		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
-			pci_lock_rescan_remove();
-			pci_hp_remove_devices(frozen_bus);
-			pci_unlock_rescan_remove();
-			/* The passed PE should no longer be used */
-			return;
-		}
+		pci_lock_rescan_remove();
+		pci_hp_remove_devices(frozen_bus);
+		pci_unlock_rescan_remove();
+		/* The passed PE should no longer be used */
+		return;
 	}
 final:
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
-- 
2.16.1.74.g9b0b1f47b
