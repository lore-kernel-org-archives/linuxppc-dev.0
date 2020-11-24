Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE2C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 10:14:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6353206FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 10:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phTPyTa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6353206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgKcZ48mfzDqX0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:14:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=clombard@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=phTPyTa5; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgKGw31GrzDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 20:58:47 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AO9WB0j011832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 04:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FUkWs0ZFsUQHLZYnuMsTAVM1E0BmNMq6vhyTFsxjVFc=;
 b=phTPyTa5q8xyz7090XQHGG40KgiJOwB410MnEQKw+CeDHfEe6GaVJD+WDjq+sTYiVdIP
 JFx2+ufgRZQ/LAD0lqCJlxCsLtBS8MgK/PFxh0K6CQ5bp8pMXW1XKltNsvyLR9ktyZz5
 0iAF8Sm5CE0wi0PKzppJt9BUyOnAtTjlQ0GcJUez3JCsKHoMbFO0jXH8MOMVZ6Eau49Z
 xcpkoXuARU4OIz1u7jul2cF1klx7z4Pz7Y4Lkn4Vt+mjkCh5FDq7K/9eZrJnTqf00R/2
 slS6BUOw2SQx0sxLnsmRmto2TUuytN+hzxFWdwH2uNrgVK4b+C5ZmJ60MHwI+bPgHaKn jA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 350rkp5p05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 04:58:44 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9vVxS012416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 09:58:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 34xth89s5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 09:58:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0AO9wd4H35193298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2020 09:58:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E75EA52052;
 Tue, 24 Nov 2020 09:58:38 +0000 (GMT)
Received: from lombard-p52.ibmuc.com (unknown [9.171.68.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE48F52054;
 Tue, 24 Nov 2020 09:58:38 +0000 (GMT)
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 ajd@linux.ibm.com
Subject: [PATCH V3 1/5] ocxl: Assign a register set to a Logical Partition
Date: Tue, 24 Nov 2020 10:58:34 +0100
Message-Id: <20201124095838.18665-2-clombard@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124095838.18665-1-clombard@linux.vnet.ibm.com>
References: <20201124095838.18665-1-clombard@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-24_03:2020-11-24,
 2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240056
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Platform specific function to assign a register set to a Logical Partition.
The "ibm,mmio-atsd" property, provided by the firmware, contains the 16
base ATSD physical addresses (ATSD0 through ATSD15) of the set of MMIO
registers (XTS MMIO ATSDx LPARID/AVA/launch/status register).

For the time being, the ATSD0 set of registers is used by default.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h   |  3 ++
 arch/powerpc/platforms/powernv/ocxl.c | 45 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index d37ededca3ee..60c3c74427d9 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -28,4 +28,7 @@ int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask, void **p
 void pnv_ocxl_spa_release(void *platform_data);
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
 
+int pnv_ocxl_map_lpar(struct pci_dev *dev, uint64_t lparid,
+		      uint64_t lpcr, void __iomem **arva);
+void pnv_ocxl_unmap_lpar(void __iomem *arva);
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index ecdad219d704..57fc1062677b 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -483,3 +483,48 @@ int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
+
+int pnv_ocxl_map_lpar(struct pci_dev *dev, uint64_t lparid,
+		      uint64_t lpcr, void __iomem **arva)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u64 mmio_atsd;
+	int rc;
+
+	/* ATSD physical address.
+	 * ATSD LAUNCH register: write access initiates a shoot down to
+	 * initiate the TLB Invalidate command.
+	 */
+	rc = of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
+					0, &mmio_atsd);
+	if (rc) {
+		dev_info(&dev->dev, "No available ATSD found\n");
+		return rc;
+	}
+
+	/* Assign a register set to a Logical Partition and MMIO ATSD
+	 * LPARID register to the required value.
+	 */
+	rc = opal_npu_map_lpar(phb->opal_id, pci_dev_id(dev),
+			       lparid, lpcr);
+	if (rc) {
+		dev_err(&dev->dev, "Error mapping device to LPAR: %d\n", rc);
+		return rc;
+	}
+
+	*arva = ioremap(mmio_atsd, 24);
+	if (!(*arva)) {
+		dev_warn(&dev->dev, "ioremap failed - mmio_atsd: %#llx\n", mmio_atsd);
+		rc = -ENOMEM;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_map_lpar);
+
+void pnv_ocxl_unmap_lpar(void __iomem *arva)
+{
+	iounmap(arva);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_unmap_lpar);
-- 
2.28.0

