Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD3492C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:55:29 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:55:26 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A692D38C8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tOUl62718088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tMbW016808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:55:23 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/10] powerpc/eeh: Don't collect PCI-CFG data on PHB
Date: Tue, 25 Jun 2013 13:55:09 +0800
Message-Id: <1372139717-14885-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the PHB is fenced or dead, it's pointless to collect the data
from PCI config space of subordinate PCI devices since it should
return 0xFF's. It also has potential risk to incur additional errors.
The patch avoids collecting PCI-CFG data while PHB is in fenced or
dead state.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 951a632..65320fd 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -232,16 +232,30 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 {
 	size_t loglen = 0;
 	struct eeh_dev *edev;
+	bool valid_cfg_log = true;
 
-	eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
-	eeh_ops->configure_bridge(pe);
-	eeh_pe_restore_bars(pe);
-
-	pci_regs_buf[0] = 0;
-	eeh_pe_for_each_dev(pe, edev) {
-		loglen += eeh_gather_pci_data(edev, pci_regs_buf,
-				EEH_PCI_REGS_LOG_LEN);
-        }
+	/*
+	 * When the PHB is fenced or dead, it's pointless to collect
+	 * the data from PCI config space because it should return
+	 * 0xFF's. The potential risk of that is introducing additional
+	 * errors.
+	 */
+	if (eeh_probe_mode_dev() &&
+	    (pe->type & EEH_PE_PHB) &&
+	    (pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)))
+		valid_cfg_log = false;
+
+	if (valid_cfg_log) {
+		eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+		eeh_ops->configure_bridge(pe);
+		eeh_pe_restore_bars(pe);
+
+		pci_regs_buf[0] = 0;
+		eeh_pe_for_each_dev(pe, edev) {
+			loglen += eeh_gather_pci_data(edev, pci_regs_buf,
+						      EEH_PCI_REGS_LOG_LEN);
+		}
+	}
 
 	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
 }
-- 
1.7.5.4
