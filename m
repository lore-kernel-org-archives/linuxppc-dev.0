Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F7E72C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:46:59 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:46:55 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CE1033E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:33 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5krgD158046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5kqf2010877
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:53 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/eeh: Don't collect PCI-CFG data on PHB
Date: Thu, 27 Jun 2013 13:46:42 +0800
Message-Id: <1372312009-13710-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
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
return 0xFF's. The patch also fixes overwritten buffer while getting
PCI config data.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 951a632..2dd0bd1 100644
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
+	 * 0xFF's. For ER, we still retrieve the data from the PCI
+	 * config space.
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
+			loglen += eeh_gather_pci_data(edev, pci_regs_buf + loglen,
+						      EEH_PCI_REGS_LOG_LEN - loglen);
+		}
+	}
 
 	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
 }
-- 
1.7.5.4
