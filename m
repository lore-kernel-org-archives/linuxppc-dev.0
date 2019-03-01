Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:10:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2403D2083D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 16:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="S8krNtu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2403D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449vXp21BhzDqTG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 03:10:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="S8krNtu1"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449vPy2TzszDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 03:04:54 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 8E099419B7;
 Fri,  1 Mar 2019 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1551456289; x=1553270690; bh=kUv77+pt4lOtpPkbWsHmP07RFuPq+4Erkig
 u1vUkblY=; b=S8krNtu1adDSlioycDwG006PEz0LkKcjuQLpG3oNRIF4zGM9TvK
 LuTDzQcwo783SDn1rK9J+C1x4ilofqr6APtjjhC2u3MSY9X7wm2g1m+HF4pkV1Et
 wJ6iuWiDHspfRvrPM4oRCgB0IVMpX/rMFfGWCHVEP3O/birCqCrkpchQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1BojSsm7Xn2; Fri,  1 Mar 2019 19:04:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6869E41990;
 Fri,  1 Mar 2019 19:04:48 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 1 Mar
 2019 19:04:47 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 2/9] powerpc/powernv/pci: Suppress an EEH error when
 reading an empty slot
Date: Fri, 1 Mar 2019 19:04:33 +0300
Message-ID: <20190301160440.26262-3-s.miroshnichenko@yadro.com>
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

Reading an empty slot returns all ones, which triggers a false
EEH error event on PowerNV. This patch unfreezes the bus where
it has happened.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |  1 +
 arch/powerpc/kernel/pci_dn.c         |  2 +-
 arch/powerpc/platforms/powernv/pci.c | 34 ++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index f67da277d652..737393c54f58 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -40,6 +40,7 @@ void *traverse_pci_dn(struct pci_dn *root,
 		      void *(*fn)(struct pci_dn *, void *),
 		      void *data);
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
+struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus);
 
 /* From rtas_pci.h */
 extern void init_pci_config_tokens (void);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ab147a1909c8..341ed71250f1 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -40,7 +40,7 @@
  * one of PF's bridge. For other devices, their firmware
  * data is linked to that of their bridge.
  */
-static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
+struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
 {
 	struct pci_bus *pbus;
 	struct device_node *dn;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 3260250d2029..73c2d0aed996 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -761,6 +761,21 @@ static inline pnv_pci_cfg_check(struct pci_dn *pdn)
 }
 #endif /* CONFIG_EEH */
 
+static int get_bus_pe_number(struct pci_bus *bus)
+{
+	struct pci_dn *pdn = pci_bus_to_pdn(bus);
+	struct pci_dn *child;
+
+	if (!pdn)
+		return IODA_INVALID_PE;
+
+	list_for_each_entry(child, &pdn->child_list, list)
+		if (child->pe_number != IODA_INVALID_PE)
+			return child->pe_number;
+
+	return IODA_INVALID_PE;
+}
+
 static int pnv_pci_read_config(struct pci_bus *bus,
 			       unsigned int devfn,
 			       int where, int size, u32 *val)
@@ -769,12 +784,23 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	int ret;
+	u32 empty_val = 0xFFFFFFFF;
 
-	*val = 0xFFFFFFFF;
+	*val = empty_val;
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
-	if (!pdn)
-		return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
-					    where, size, val);
+	if (!pdn) {
+		int pe_number = get_bus_pe_number(bus);
+
+		ret = pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
+					   where, size, val);
+
+		if (!ret && (*val == empty_val) && phb->unfreeze_pe)
+			phb->unfreeze_pe(phb, (pe_number == IODA_INVALID_PE) ?
+					 0xff : pe_number,
+					 OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+
+		return ret;
+	}
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.20.1

