Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:04:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91722075C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="lI8AfzhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91722075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HxbN44X0zDq7N
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 23:04:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="lI8AfzhX"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HxLR5VPKzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 22:52:47 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CF17C4198C;
 Mon, 11 Mar 2019 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552305162; x=1554119563; bh=6p4AMdEs7dNKwo75VsMuHI/v8UbrRRkDyDk
 GcB4A1JQ=; b=lI8AfzhX2cQE+qo2EC0m9ekKUnuhjGl4tLxooA4Q6eKgNy7DC+7
 XVzFXDEukknpPP311JkJ8CgkiUiMPoKR1MRMk/fNehzotfeLJFV7pemYIyN8PClG
 +JRyK9Y20O30lC0pbO63/yLDdspD9OeZh2H25UG9nYYoot9id/cARxE8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g33T8IdwFgUD; Mon, 11 Mar 2019 14:52:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9D8574193A;
 Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:40 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 2/8] powerpc/powernv/pci: Suppress an EEH error when
 reading an empty slot
Date: Mon, 11 Mar 2019 14:52:27 +0300
Message-ID: <20190311115233.6514-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
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
 arch/powerpc/platforms/powernv/pci.c | 31 +++++++++++++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index f191ef0d2a0a..a22d52a9bb1f 100644
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
index 41a381dfc2a1..8cc6661781e2 100644
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
@@ -772,9 +787,19 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 
 	*val = 0xFFFFFFFF;
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
+		if (!ret && (*val == EEH_IO_ERROR_VALUE(size)) && phb->unfreeze_pe)
+			phb->unfreeze_pe(phb, (pe_number == IODA_INVALID_PE) ?
+					 phb->ioda.reserved_pe_idx : pe_number,
+					 OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+
+		return ret;
+	}
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.20.1

