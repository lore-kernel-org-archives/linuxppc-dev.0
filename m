Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641E606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oq8n4Uy9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY02H6STvz30WS;
	Mon, 23 Nov 2026 19:47:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795423671;
	cv=none; b=IraexmCSKAn/gsf4+bvMDHrVY2as5o2RpVTg9tJNbMNjB0u/jOUfbyM6Pvzb4eu0tD0wrVyhFakJa5Y52TeQSC+fOGsx3FniN0TqnHwnQFR1lhmTfbtJXbh2tfSDiygdtJIAVwaevaTm5P+OKW10vtjI+3Bb2EZX5g5FehZeEjfdnmnZX7DTJF/k1jOO+JNv+Bh6tXl4uanHf34jCy9BMqXXRHXDRTvZhBgeFlIuyZYEsVhc1Pd+9gSjrRjnrEYGSINHopsUizsnMLF6KyCbU6UotcJ6HMnPF4Y4w8F0qlROd1h3KpO8zcx88lhPKCm8UzdHUnSon6JTSkdrXYKxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795423671; c=relaxed/relaxed;
	bh=wpDaWMBSigyyX3qQj3g5pzISsgLs4qVp/n7EpqzqoHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMDFJC7Z4G8HYohAh1OyAu788C+nc8A6uJQQupEDE3iLJTgTdgQvZJrFGxzYt3u5lM+euuHkwxX1eHNNuwfUVgkcFd4oVlm67g2IhY22zUuM7U0ya2he6JKSaa8D74ByORw8wh6jT3KMJe7nyTuxuFk2HZb5ppRvyETIkp6V4ylDjLnyPGlNNZaMg1MAN/0qM+KPr5TDlm6W+EhuNQX4qbv7XAwjkmPqW7eKGXnO12DgP3GChRbtfUK8Cg0Wo6ykMgXixZZACt9F1sogaomAmcd7zlvgLrv7zeftMFqh3P5eo2N9r1bCD/rDOJjwptUwJMZnOw5TaFfXOyMiH+Q1VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oq8n4Uy9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oq8n4Uy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY02G6YTPz2yhV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 19:47:50 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54bYP981914;
	Mon, 23 Nov 2026 08:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wpDaWMBSigyyX3qQj
	3g5pzISsgLs4qVp/n7EpqzqoHg=; b=oq8n4Uy9mnvg3yCgpey/lK5K+DVwuZhFw
	JOGI+lUUPILv+Aqn0SErignqIPfw6iLaTCyyhXbt42pxLAIGsqYX7CYvLaNVGJ6m
	FZMiTbNm1bG1jP3xXlyOAv3H34hPPfZXNgiyO0Kr845RtM0JIT5opYndG4Z/+s66
	I7X7HwCwY1GgZtXzD/1bpSdS2j04YtTvSscNbUp0/bCI+1lXt448pJAHR7WiyaHq
	HQODzb50psqkb8NcEoi6YGRUuS80gBAb7r7HPGdqGT93tIxQRzLoPPeRrvS5C7fs
	xwQ+lypnSykJ0k9iZ+BK8QC/9mITuymoP/sn94r6wu1F1DnqMZ7/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g329cq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54SmN1436617;
	Mon, 23 Nov 2026 08:47:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3raydpk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN8lQoE54591984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 08:47:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C802004D;
	Mon, 23 Nov 2026 08:47:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140DF2005A;
	Mon, 23 Nov 2026 08:47:23 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 08:47:22 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v7 3/4] vfio/spapr_tce: Normalize EEH IOA error injection addresses
Date: Mon, 23 Nov 2026 14:17:01 +0530
Message-ID: <20261123084658.61330-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03fda3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=EGYj-OwPAAAA:8
 a=Y26Cy7KvGLPL97oF5_IA:9 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX+SmPOp+jg4xg
 32iV8nxH1vln+/wMVbIQyA/gB6+42ZjjYYwlXQPn1iQRe054AOCMj6M1xDQgKxui1CYhAlriyqX
 QPAy/52vfJPz1Jo91mSAgy/wU7237/w=
X-Proofpoint-ORIG-GUID: Jk0yBDI1m9gTe0nX-kHCde_pcVcFUjJF
X-Proofpoint-GUID: zAc_RjBPdLcus-aRYc0I2YZPc_A6ZQi-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXwaw0+x07XQLZ
 e/mFrpJx0HeY9HYC1r45mD/dhOQVgjQzomVvRRRrrla1XsprZbzagMYIOmECFMNKfBKqXZ+0DN9
 rvj78KX4A5V33XtUApyHDaqarUANulH7U8pGbKH6MnjOcT4dRwkUeOv+UUhOqP7iTllQ46llbXp
 wrbwYed1J67k0wHG0qDJsYsqyC3ttbAXFq5Z1dfrjYYtHmNkBoHoFyFRYsQKapWZ7wkb/fIXZ+K
 yyG4McLTiySN1gfTDWt7NNUK0A6jwOoKP9oo1kLKLD0fGwdRCz9Q7WtpUf7xz5Haf/IkPwsen4u
 orZB9i6AAaCpef/SitcpkIvtLauBf9NhkX1xoYZPm7Z9uEqq/E5OAM2BeszW8Az5MsKyoEIY+KX
 NotylfDa6fsXRlpdh8/JpVl7l3R7fRzkO+h7Oy3EImeGoLJZzST9aGboMBhJw5KPNt993fmS/S2
 Vti63rrE0DKJT5a+6IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On pseries, RTAS error injection takes a PCI bus address for memory and
I/O load/store functions.  VFIO_EEH_PE_INJECT_ERR callers such as QEMU
pass an address within a BAR as the sysfs "resource" file exports it: a
CPU address for a memory BAR and a PCI bus address for an I/O BAR.  A
CPU address can differ from the PCI bus address because of PHB window
translation.

On pseries, convert the address before calling eeh_pe_inject_err() to the
PCI bus address of the matching standard BAR (BAR0-BAR5) of a device in
the IOMMU group, keeping its offset.  Memory functions match memory BARs
and I/O functions match I/O BARs.  Unassigned and disabled BARs are never
matched, and an address that matches no BAR fails with -EINVAL.

Config-space and DMA functions, requests with address and mask both zero,
and requests on other platforms are not changed.  The mask is never
modified.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 131 +++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..c56b649d7094 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -23,9 +23,11 @@
 #include <linux/mm.h>
 #include "vfio.h"
 
+#include <asm/eeh.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/mmu_context.h>
+#include <asm/machdep.h>
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
@@ -774,12 +776,116 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	return ret;
 }
 
+/*
+ * Look for @addr in the standard BARs (BAR0-BAR5) of @pdev whose resource
+ * type is @res_type, and translate it to the PCI bus address RTAS expects,
+ * keeping the offset into the BAR. Expansion ROM, SR-IOV resources and
+ * bridge windows are not supported.
+ *
+ * @addr is in the domain the sysfs "resource" file exports: the CPU address
+ * for a memory BAR and the PCI bus address for an I/O BAR.  Each type has a
+ * single domain, so a match is unambiguous.
+ *
+ * Unassigned BARs are zero-based and flagged IORESOURCE_UNSET on pseries,
+ * so they are skipped, as are disabled ones.
+ */
+static bool vfio_spapr_eeh_normalize_pdev_addr(struct pci_dev *pdev,
+					       unsigned long res_type,
+					       unsigned long addr,
+					       unsigned long *normalized)
+{
+	struct pci_bus_region region;
+	struct resource *res;
+	resource_size_t len, start;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		res = &pdev->resource[bar];
+
+		if (resource_type(res) != res_type)
+			continue;
+
+		if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+			continue;
+
+		len = pci_resource_len(pdev, bar);
+		if (!len)
+			continue;
+
+		pcibios_resource_to_bus(pdev->bus, &region, res);
+		start = res_type == IORESOURCE_IO ? region.start : res->start;
+
+		if (addr >= start && addr - start < len) {
+			*normalized = region.start + (addr - start);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+struct vfio_spapr_eeh_addr_lookup {
+	unsigned long res_type;
+	unsigned long addr;
+	unsigned long normalized;
+	bool found;
+};
+
+static int vfio_spapr_eeh_match_dev(struct device *dev, void *data)
+{
+	struct vfio_spapr_eeh_addr_lookup *lookup = data;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	if (vfio_spapr_eeh_normalize_pdev_addr(pdev, lookup->res_type,
+					       lookup->addr,
+					       &lookup->normalized)) {
+		lookup->found = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Convert @addr to a PCI bus address using the BARs of type @res_type of the
+ * devices in @group.
+ */
+static int vfio_spapr_eeh_normalize_addr(struct iommu_group *group,
+					 unsigned long res_type,
+					 unsigned long addr,
+					 unsigned long *normalized)
+{
+	struct vfio_spapr_eeh_addr_lookup lookup = {
+		.res_type = res_type,
+		.addr = addr,
+	};
+	int ret;
+
+	ret = iommu_group_for_each_dev(group, &lookup,
+				       vfio_spapr_eeh_match_dev);
+	if (ret < 0)
+		return ret;
+
+	if (lookup.found) {
+		*normalized = lookup.normalized;
+		return 0;
+	}
+
+	pr_debug("vfio EEH: addr=0x%lx not found in any matching BAR of group\n",
+		 addr);
+	return -EINVAL;
+}
+
 static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 				       unsigned long arg)
 {
 	struct eeh_pe *pe;
 	struct vfio_eeh_pe_op op;
-	unsigned long minsz;
+	unsigned long minsz, res_type;
 
 	pe = eeh_iommu_group_to_pe(group);
 	if (!pe)
@@ -818,6 +924,29 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 		if (copy_from_user(&op, (void __user *)arg, minsz))
 			return -EFAULT;
 
+		/*
+		 * Only the pSeries RTAS backend takes a PCI bus address, so
+		 * PowerNV requests are passed through unchanged.  Config and
+		 * DMA functions do not carry BAR addresses, and an address
+		 * and mask of zero carries no address.
+		 */
+		res_type = eeh_err_func_to_res_type(op.err.func);
+		if (machine_is(pseries) && res_type &&
+		    (op.err.type == EEH_ERR_TYPE_32 ||
+		     op.err.type == EEH_ERR_TYPE_64) &&
+		    (op.err.addr || op.err.mask)) {
+			unsigned long normalized;
+			int ret;
+
+			ret = vfio_spapr_eeh_normalize_addr(group, res_type,
+							    op.err.addr,
+							    &normalized);
+			if (ret)
+				return ret;
+
+			op.err.addr = normalized;
+		}
+
 		return eeh_pe_inject_err(pe, op.err.type, op.err.func,
 					 op.err.addr, op.err.mask);
 	default:
-- 
2.54.0


