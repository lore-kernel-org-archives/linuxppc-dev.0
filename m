Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE88C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:23:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8126F2083D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="O0Npklz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8126F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449vqP2xlXzDqVC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 03:23:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="O0Npklz/"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449vQ729wTzDqTR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 03:05:03 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7390B419CA;
 Fri,  1 Mar 2019 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1551456297; x=1553270698; bh=KA6NPazejh7O5QEKvFEOBktDMjpH57Y5rGh
 7WejsWE8=; b=O0Npklz/yJMtQsG/onFCW0YsuR8a5pzkqnMJtbJ9eYeNtAibZkn
 5GWtwF333IbUxH8gjsjarV0ed2C8mW4GzE/gjimT3XgJlqPn4Xcok27b5Bz9fRho
 51FDN44cdNx43c2HQLYi6goDnNk3k1pviB6Ey2XEmXxBAaCiuicUMDlg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJnW_Sqd0mqp; Fri,  1 Mar 2019 19:04:57 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 49FE3419CF;
 Fri,  1 Mar 2019 19:04:49 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 19:04:48 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 8/9] powerpc/powernv/pci: Hook up the writes to
 PCI_SECONDARY_BUS register
Date: Fri, 1 Mar 2019 19:04:39 +0300
Message-ID: <20190301160440.26262-9-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, linux@yadro.com,
 Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Writing a new value to the PCI_SECONDARY_BUS register of the bridge means
that its children will become addressable on another address (new B in BDF)
or even un-addressable if the secondary bus is set to zero.

On PowerNV, device PEs are heavily BDF-dependent, so they must be updated
on every such change of its address.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/platforms/powernv/pci.c | 118 ++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 73c2d0aed996..52ce717a7905 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -722,13 +722,127 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 				    where, size, val);
 }
 
+static void invalidate_children_pes(struct pci_dn *pdn)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+	struct pci_dn *child;
+	bool found_pe = false;
+	int pe_num;
+	int pe_bus;
+
+	list_for_each_entry(child, &pdn->child_list, list) {
+		struct pnv_ioda_pe *pe = (child->pe_number != IODA_INVALID_PE) ?
+			&phb->ioda.pe_array[child->pe_number] :
+			NULL;
+
+		if (!child->busno)
+			continue;
+
+		if ((child->class_code >> 8) == PCI_CLASS_BRIDGE_PCI)
+			invalidate_children_pes(child);
+
+		if (pe) {
+			u8 rid_bus = (pe->rid >> 8) & 0xff;
+
+			if (rid_bus) {
+				pe_num = child->pe_number;
+				pe_bus = rid_bus;
+				found_pe = true;
+			}
+
+			pe->rid &= 0xff;
+		}
+
+		child->busno = 0;
+	}
+
+	if (found_pe) {
+		u16 rid = pe_bus << 8;
+
+		opal_pci_set_pe(phb->opal_id, pe_num, rid, 7, 0, 0, OPAL_UNMAP_PE);
+	}
+}
+
+static u8 pre_hook_new_sec_bus(struct pci_dn *pdn, u8 new_secondary_bus)
+{
+	u32 old_secondary_bus = 0;
+
+	if ((pdn->class_code >> 8) != PCI_CLASS_BRIDGE_PCI)
+		return 0;
+
+	pnv_pci_cfg_read(pdn, PCI_SECONDARY_BUS, 1, &old_secondary_bus);
+	old_secondary_bus &= 0xff;
+
+	if (old_secondary_bus != new_secondary_bus)
+		invalidate_children_pes(pdn);
+
+	return old_secondary_bus;
+}
+
+static void update_children_pes(struct pci_dn *pdn, u8 new_secondary_bus)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+	struct pci_dn *child;
+	bool found_pe = false;
+	int pe_num;
+
+	if (!new_secondary_bus)
+		return;
+
+	list_for_each_entry(child, &pdn->child_list, list) {
+		struct pnv_ioda_pe *pe = (child->pe_number != IODA_INVALID_PE) ?
+			&phb->ioda.pe_array[child->pe_number] :
+			NULL;
+
+		if (child->busno)
+			continue;
+
+		child->busno = new_secondary_bus;
+
+		if (pe) {
+			pe->rid |= (child->busno << 8);
+			pe_num = child->pe_number;
+			found_pe = true;
+		}
+	}
+
+	if (found_pe) {
+		u16 rid = new_secondary_bus << 8;
+
+		opal_pci_set_pe(phb->opal_id, pe_num, rid, 7, 0, 0, OPAL_MAP_PE);
+	}
+}
+
+static void post_hook_new_sec_bus(struct pci_dn *pdn, u8 new_secondary_bus)
+{
+	if ((pdn->class_code >> 8) != PCI_CLASS_BRIDGE_PCI)
+		return;
+
+	update_children_pes(pdn, new_secondary_bus);
+}
+
 int pnv_pci_cfg_write(struct pci_dn *pdn,
 		      int where, int size, u32 val)
 {
 	struct pnv_phb *phb = pdn->phb->private_data;
+	u8 old_secondary_bus = 0, new_secondary_bus = 0;
+	int rc;
+
+	if (where == PCI_SECONDARY_BUS) {
+		new_secondary_bus = val & 0xff;
+		old_secondary_bus = pre_hook_new_sec_bus(pdn, new_secondary_bus);
+	} else if (where == PCI_PRIMARY_BUS && size > 1) {
+		new_secondary_bus = (val >> 8) & 0xff;
+		old_secondary_bus = pre_hook_new_sec_bus(pdn, new_secondary_bus);
+	}
 
-	return pnv_pci_cfg_write_raw(phb->opal_id, pdn->busno, pdn->devfn,
-				     where, size, val);
+	rc = pnv_pci_cfg_write_raw(phb->opal_id, pdn->busno, pdn->devfn,
+				   where, size, val);
+
+	if (new_secondary_bus && old_secondary_bus != new_secondary_bus)
+		post_hook_new_sec_bus(pdn, new_secondary_bus);
+
+	return rc;
 }
 
 #if CONFIG_EEH
-- 
2.20.1

