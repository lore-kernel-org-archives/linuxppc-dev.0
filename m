Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB95C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:54:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF26206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="SdroBMca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF26206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HxNW0Sp9zDqF1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 22:54:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="SdroBMca"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HxLR46lmzDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 22:52:47 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 07C6C412D6;
 Mon, 11 Mar 2019 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552305161; x=1554119562; bh=iqsZJYSE0QT2RmCSuJ5sFlhPsWtQvE3B0DB
 8TaTg3HA=; b=SdroBMcacYczCSKktDyBxYsnSUXNgZfztUq1L9AOE0oLeNSpBP+
 NQSp6nlByuQyHQLxCtw111C3JpCMjqKVgILOv4Ugzf0NwfgLfn1ZMUoJ5Wb6c0Sd
 5VaA6rPoK0KRR70d5cq7E2RuFK73KwYSwYxfgZPTprVUfWQrqtgHJTDI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjQgqxbfdfbh; Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 747BD412D2;
 Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:40 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 1/8] powerpc/pci: Access PCI config space directly w/o
 pci_dn
Date: Mon, 11 Mar 2019 14:52:26 +0300
Message-ID: <20190311115233.6514-2-s.miroshnichenko@yadro.com>
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

To fetch an updated DT for the newly hotplugged device, OS must explicitly
request it from the firmware via the pnv_php driver.

If pnv_php wasn't triggered/loaded, it is still possible to discover new
devices if PCIe I/O will not stop in absence of the pci_dn structure.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/rtas_pci.c       | 97 +++++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.c | 64 ++++++++++++------
 2 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index c2b148b1634a..f675b5ecb5bc 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -55,10 +55,26 @@ static inline int config_access_valid(struct pci_dn *dn, int where)
 	return 0;
 }
 
-int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
+static int rtas_read_raw_config(unsigned long buid, int busno, unsigned int devfn,
+				int where, int size, u32 *val)
 {
 	int returnval = -1;
-	unsigned long buid, addr;
+	unsigned long addr = rtas_config_addr(busno, devfn, where);
+	int ret;
+
+	if (buid) {
+		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
+				addr, BUID_HI(buid), BUID_LO(buid), size);
+	} else {
+		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
+	}
+	*val = returnval;
+
+	return ret;
+}
+
+int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
+{
 	int ret;
 
 	if (!pdn)
@@ -71,16 +87,8 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 		return PCIBIOS_SET_FAILED;
 #endif
 
-	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
-	buid = pdn->phb->buid;
-	if (buid) {
-		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
-				addr, BUID_HI(buid), BUID_LO(buid), size);
-	} else {
-		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
-	}
-	*val = returnval;
-
+	ret = rtas_read_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
+				   where, size, val);
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -98,18 +106,44 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 
-	/* Validity of pdn is checked in here */
-	ret = rtas_read_config(pdn, where, size, val);
-	if (*val == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (pdn) {
+		/* Validity of pdn is checked in here */
+		ret = rtas_read_config(pdn, where, size, val);
+
+		if (*val == EEH_IO_ERROR_VALUE(size) &&
+		    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
+			ret = PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		struct pci_controller *phb = pci_bus_to_host(bus);
+
+		ret = rtas_read_raw_config(phb->buid, bus->number, devfn,
+					   where, size, val);
+	}
 
 	return ret;
 }
 
+static int rtas_write_raw_config(unsigned long buid, int busno, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	unsigned long addr = rtas_config_addr(busno, devfn, where);
+	int ret;
+
+	if (buid) {
+		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
+				BUID_HI(buid), BUID_LO(buid), size, (ulong)val);
+	} else {
+		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
+	}
+
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 {
-	unsigned long buid, addr;
 	int ret;
 
 	if (!pdn)
@@ -122,15 +156,8 @@ int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 		return PCIBIOS_SET_FAILED;
 #endif
 
-	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
-	buid = pdn->phb->buid;
-	if (buid) {
-		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
-			BUID_HI(buid), BUID_LO(buid), size, (ulong) val);
-	} else {
-		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
-	}
-
+	ret = rtas_write_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
+				    where, size, val);
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -141,12 +168,20 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 				 unsigned int devfn,
 				 int where, int size, u32 val)
 {
-	struct pci_dn *pdn;
+	struct pci_dn *pdn = pci_get_pdn_by_devfn(bus, devfn);
+	int ret;
 
-	pdn = pci_get_pdn_by_devfn(bus, devfn);
+	if (pdn) {
+		/* Validity of pdn is checked in here. */
+		ret = rtas_write_config(pdn, where, size, val);
+	} else {
+		struct pci_controller *phb = pci_bus_to_host(bus);
 
-	/* Validity of pdn is checked in here. */
-	return rtas_write_config(pdn, where, size, val);
+		ret = rtas_write_raw_config(phb->buid, bus->number, devfn,
+					    where, size, val);
+	}
+
+	return ret;
 }
 
 static struct pci_ops rtas_pci_ops = {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index ef9448a907c6..41a381dfc2a1 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -652,30 +652,29 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 	}
 }
 
-int pnv_pci_cfg_read(struct pci_dn *pdn,
-		     int where, int size, u32 *val)
+static int pnv_pci_cfg_read_raw(u64 phb_id, int busno, unsigned int devfn,
+				int where, int size, u32 *val)
 {
-	struct pnv_phb *phb = pdn->phb->private_data;
-	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
+	u32 bdfn = (busno << 8) | devfn;
 	s64 rc;
 
 	switch (size) {
 	case 1: {
 		u8 v8;
-		rc = opal_pci_config_read_byte(phb->opal_id, bdfn, where, &v8);
+		rc = opal_pci_config_read_byte(phb_id, bdfn, where, &v8);
 		*val = (rc == OPAL_SUCCESS) ? v8 : 0xff;
 		break;
 	}
 	case 2: {
 		__be16 v16;
-		rc = opal_pci_config_read_half_word(phb->opal_id, bdfn, where,
-						   &v16);
+		rc = opal_pci_config_read_half_word(phb_id, bdfn, where,
+						    &v16);
 		*val = (rc == OPAL_SUCCESS) ? be16_to_cpu(v16) : 0xffff;
 		break;
 	}
 	case 4: {
 		__be32 v32;
-		rc = opal_pci_config_read_word(phb->opal_id, bdfn, where, &v32);
+		rc = opal_pci_config_read_word(phb_id, bdfn, where, &v32);
 		*val = (rc == OPAL_SUCCESS) ? be32_to_cpu(v32) : 0xffffffff;
 		break;
 	}
@@ -684,27 +683,28 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 	}
 
 	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		 __func__, pdn->busno, pdn->devfn, where, size, *val);
+		 __func__, busno, devfn, where, size, *val);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int pnv_pci_cfg_write(struct pci_dn *pdn,
-		      int where, int size, u32 val)
+static int pnv_pci_cfg_write_raw(u64 phb_id, int busno, unsigned int devfn,
+				 int where, int size, u32 val)
 {
-	struct pnv_phb *phb = pdn->phb->private_data;
-	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
+	u32 bdfn = (busno << 8) | devfn;
 
 	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		 __func__, pdn->busno, pdn->devfn, where, size, val);
+		 __func__, busno, devfn, where, size, val);
+
 	switch (size) {
 	case 1:
-		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_byte(phb_id, bdfn, where, val);
 		break;
 	case 2:
-		opal_pci_config_write_half_word(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_half_word(phb_id, bdfn, where, val);
 		break;
 	case 4:
-		opal_pci_config_write_word(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_word(phb_id, bdfn, where, val);
 		break;
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
@@ -713,6 +713,24 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+int pnv_pci_cfg_read(struct pci_dn *pdn,
+		     int where, int size, u32 *val)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+
+	return pnv_pci_cfg_read_raw(phb->opal_id, pdn->busno, pdn->devfn,
+				    where, size, val);
+}
+
+int pnv_pci_cfg_write(struct pci_dn *pdn,
+		      int where, int size, u32 val)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+
+	return pnv_pci_cfg_write_raw(phb->opal_id, pdn->busno, pdn->devfn,
+				     where, size, val);
+}
+
 #if CONFIG_EEH
 static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
@@ -748,13 +766,15 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 			       int where, int size, u32 *val)
 {
 	struct pci_dn *pdn;
-	struct pnv_phb *phb;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
 	int ret;
 
 	*val = 0xFFFFFFFF;
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 	if (!pdn)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+		return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
+					    where, size, val);
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -777,12 +797,14 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 				int where, int size, u32 val)
 {
 	struct pci_dn *pdn;
-	struct pnv_phb *phb;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
 	int ret;
 
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 	if (!pdn)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+		return pnv_pci_cfg_write_raw(phb->opal_id, bus->number, devfn,
+					     where, size, val);
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.20.1

