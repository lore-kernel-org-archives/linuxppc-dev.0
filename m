Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CB60A262A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n4IzMemd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9vxj5rQYz30DY;
	Fri, 23 Oct 2026 18:37:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792741065;
	cv=none; b=X+R8ijjhUsRDyn3Jr4dcDj6SLer9zOmf7K0m9E4+lQvPdFAD2UQ/7c9pUhJXm4IWtgItWvbB4xDh+p7Il7kvyVjb07nqM5wR2asKhYicNnTEilLkKemUl0VOpwnliUGZl1f7DMPoBPgLT/nlp7TPHC1a8tkTyWOhphk6fWsr/F2DtVi3rKhUOkK8Hhpugl0jBBT5l3bDokCg3cQ68v1xfJ7FsdbGf5edqsq82KXghuKBpg5yJ8CE0SEyVqktsr/orfSYilh2pKRk4M+1cKiAj7vKiMoDN4up8xaU82/5HphY38olDUavbiBC1JM7tIhJOT+eEHx+7ffHo+I2XPGCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792741065; c=relaxed/relaxed;
	bh=B0qRB9tiya6oAyzlk26/4xpYKCHyzzTgpSsFISWFf2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hObksLle+0GN9yFs18MayIRTHiqh8AbUmZbm4/PHaQ89Un4RWTjnvXBsoRqUfPMdnwKH6q77kPB7XrLaGW6IZTpbXt8K6kGCzD/q4TIqLvgjOd9tk+0loqNiSNPJ/KTtZA34cmujigt5RH4RDTwKR+zZ6gUre4DeaoeYPwcuznqvku1FZhXw/B3kmSkHOqIBywBWy05QzMfbjPurQkmxsoE/BtohLBW3+JOCniuiEvdhjCf2rDsOtGjmEqNTBbVZVsKVsAhpHyPdSSC2EMO+JigqeJAAFuatrbkhma0HN7cMmhARxLK3tsYDmjr7ZzcJRRU1gVZVAXbpNYRaM44r5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n4IzMemd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n4IzMemd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9vxj0S6Kz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 18:37:44 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F47R579337;
	Fri, 23 Oct 2026 07:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B0qRB9tiya6oAyzlk
	26/4xpYKCHyzzTgpSsFISWFf2E=; b=n4IzMemd4XY8+SAztA3FoRJiqabIQE5/r
	Udzjc3KAsXF4dLbkYLgKux6+zS+02/0s/prFpYcZt5bN3h1ely50iqcBcqNY5GGV
	z9k49/Fu3zsuZKcdIu11bGnLvjpbU6xuho9bjWK8pY3wD57MxYUxa3swp8gu0oGV
	K4R57fYpeTNO2l/3IViICcHgEQaJPJ1lIUjb4glxwJVNv0Otme3s3M/wM36KXthQ
	luhnwT+Qikmc/kieQ5Q4TbhOYv1/g1uMCzIhjeceqTni6cuD6LAmhCS+Fkv/7TpC
	khj0zxwE0VO5CUJpTRvfBeV39sOCZ1NJiZtBdtrWajl63/XncDUIQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5buxd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7JtkH1800650;
	Fri, 23 Oct 2026 07:37:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn3fpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7bVR432834044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:37:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3D720040;
	Fri, 23 Oct 2026 07:37:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CFC2004B;
	Fri, 23 Oct 2026 07:37:27 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.18.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:37:27 +0000 (GMT)
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
Subject: [PATCH v6 4/5] vfio/spapr_tce: Normalize EEH IOA error injection addresses
Date: Fri, 23 Oct 2026 13:06:41 +0530
Message-ID: <20261023073642.59657-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-GUID: 4-FLsnO9Tw3-m87jhzJWS-z1NJk76D6y
X-Proofpoint-ORIG-GUID: Zr40t_N3heYFWbQwEAfQWFs8XnvYtYVP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX+TDADW92cgUH
 /gu/HESN2Y+Jy9eR8e04H5jx90VCXkndN7n8I5daHf4L5rHTxKemsinTuWbrLoV45/ef57Yz/WB
 qDEoeVndnUqXf84gtYrIRvSKcXn3g9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfXyrT4GIIul1Pg
 mCM9xoGrDYIDltScjHFDblmhCfrjBv7macaW6OXmEwAezM0nAJG3PfJceX8J6FqrYb1VSDlM1MO
 LZV/KpbdkNC2MhDC2AT3aFeMFBKnSZNdUPfU/EJbUT90I+FkAs7mndqNCz6wKEwg+smfjFoLexk
 Vt+oK8g04FYYjFLMbR+HRpGKWROWWjH0iJLFdmFdlJnhxyioUL+yzO7+tvETL6snGW7/bXhJwY8
 l/X+NVhxn1PfPN1mQNCd670djNG4Rrjb0isRgvbo1hZO/lz3Sj2KPBwpn2JqzpUEd3Mh2HqtoFd
 ip97hzorCGqDcLzpunZAn4bwYer8lOAR2LEvbu/SACiKg0PO4i8UZryQs0G0ugW6OcNTx/JxbqW
 UVPZKaLLS1kozs2J9gjyd935L62P8guoOU+AChT7lDEN4n4HGcJEF8pWnOdEdVSfYRKE9GJ+dSY
 /DIz0MwaiWc9DGvUFgg==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb0ec0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=duwtGrM1Pp2SbY59MasA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VFIO_EEH_PE_INJECT_ERR receives a target address from userspace.  For
userspace such as QEMU, this address may be derived from the host Linux
BAR resource.  The platform EEH backends, however, expect the PCI/IOA
bus address used by firmware error-injection interfaces.

Normalize IOA/MMIO error-injection addresses in the sPAPR VFIO EEH
ioctl path before dispatching to eeh_pe_inject_err().  If the supplied
address is already a PCI bus BAR address it is left unchanged.  If it is
a Linux resource address, translate it to the corresponding PCI bus
address using the BAR-relative offset.

Normalization applies only to EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 error
types whose error function targets a memory or IO BAR (load/store memory
and load/store IO functions, func 0-3 and 6-9).  Config-space functions
carry PCI config register offsets and DMA functions carry IOVA/TCE
addresses; these address domains are not PCI BAR addresses and must not
be translated.  Applying BAR normalization to them would incorrectly
return -EINVAL, blocking injection entirely for those function codes.

An address and mask pair of zero represents a no-address injection
(e.g. a function-level error with no specific IOA target) and is passed
through without BAR translation.

Only standard BARs (BAR0..BAR5) are searched; ROM and bridge resources
are not IOA bus-error targets.  Unassigned or disabled BARs are skipped:
pci_resource_len() returns 0 for zero-initialized BARs, and the
IORESOURCE_UNSET and IORESOURCE_DISABLED flags are checked explicitly to
avoid false matches against unassigned resources.  Hold
pci_rescan_remove_lock while traversing PE devices and their BAR
resources to prevent PCI device removal from racing the lookup.

A pr_debug() is emitted if the address cannot be matched to any BAR, to
aid debugging without producing noise in the normal path.

Keep the helper local to VFIO so the address semantics of other
in-kernel EEH callers remain unchanged.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 140 ++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..d831adaa69fb 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -774,6 +774,131 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	return ret;
 }
 
+/*
+ * eeh_func_needs_bar_addr - return true for error functions whose addr
+ * argument is a PCI MMIO or IO BAR address.
+ *
+ * Memory and IO load/store functions target specific BAR addresses.
+ * Config-space functions carry PCI config register offsets, and DMA
+ * functions carry IOVA/TCE addresses; neither requires BAR translation.
+ */
+static bool eeh_func_needs_bar_addr(int func)
+{
+	switch (func) {
+	case EEH_ERR_FUNC_LD_MEM_ADDR:
+	case EEH_ERR_FUNC_LD_MEM_DATA:
+	case EEH_ERR_FUNC_LD_IO_ADDR:
+	case EEH_ERR_FUNC_LD_IO_DATA:
+	case EEH_ERR_FUNC_ST_MEM_ADDR:
+	case EEH_ERR_FUNC_ST_MEM_DATA:
+	case EEH_ERR_FUNC_ST_IO_ADDR:
+	case EEH_ERR_FUNC_ST_IO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
+					 unsigned long addr,
+					 unsigned long mask,
+					 unsigned long *normalized)
+{
+	struct pci_bus_region region;
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	struct resource *res;
+	resource_size_t pci_start, pci_len;
+	resource_size_t res_start, res_len;
+	resource_size_t offset;
+	int bar, rc = -EINVAL;
+
+	if (!pe || !normalized)
+		return -EINVAL;
+
+	/*
+	 * addr == 0 and mask == 0 indicates a no-address injection (e.g.
+	 * function-level error with no specific IOA target).  No BAR
+	 * translation needed.
+	 */
+	if (!addr && !mask) {
+		*normalized = addr;
+		return 0;
+	}
+
+	/*
+	 * Walk standard BARs (BAR0..BAR5) of all devices in the PE.
+	 * Hold pci_rescan_remove_lock to protect pdev lifetime during the
+	 * traversal: pci_stop_and_remove_bus_device() requires this lock.
+	 * ROM and bridge resources are not IOA bus-error targets, so the
+	 * search is limited to PCI_STD_NUM_BARS.
+	 */
+	pci_lock_rescan_remove();
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+			res = &pdev->resource[bar];
+
+			/*
+			 * Skip unassigned or disabled BARs.  On pseries,
+			 * pcibios_fixup_resources() zero-bases unassigned BARs
+			 * (start=0, end=size-1) and sets IORESOURCE_UNSET.
+			 * Use pci_resource_len() which returns 0 when end==0.
+			 */
+			if (!pci_resource_len(pdev, bar))
+				continue;
+
+			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
+				continue;
+
+			if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+				continue;
+
+			pcibios_resource_to_bus(pdev->bus, &region, res);
+
+			pci_start = region.start;
+			pci_len = pci_resource_len(pdev, bar);
+
+			/*
+			 * Case 1: userspace already supplied PCI/IOA
+			 * bus address.
+			 */
+			if ((resource_size_t)addr >= pci_start &&
+			    ((resource_size_t)addr - pci_start) < pci_len) {
+				*normalized = addr;
+				rc = 0;
+				goto done;
+			}
+
+			/*
+			 * Case 2: userspace supplied Linux resource/CPU
+			 * address.  Convert it back to PCI/IOA bus address
+			 * before calling the platform EEH backend.
+			 */
+			res_start = res->start;
+			res_len = pci_resource_len(pdev, bar);
+
+			if ((resource_size_t)addr >= res_start &&
+			    ((resource_size_t)addr - res_start) < res_len) {
+				offset = (resource_size_t)addr - res_start;
+				*normalized = region.start + offset;
+				rc = 0;
+				goto done;
+			}
+		}
+	}
+done:
+	pci_unlock_rescan_remove();
+
+	if (rc)
+		pr_debug("vfio EEH: addr=0x%lx not found in any PCI bus BAR of PE\n",
+			 addr);
+	return rc;
+}
+
 static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 				       unsigned long arg)
 {
@@ -818,6 +943,21 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 		if (copy_from_user(&op, (void __user *)arg, minsz))
 			return -EFAULT;
 
+		if ((op.err.type == EEH_ERR_TYPE_32 ||
+		     op.err.type == EEH_ERR_TYPE_64) &&
+		    eeh_func_needs_bar_addr(op.err.func)) {
+			unsigned long normalized;
+			int ret;
+
+			ret = vfio_spapr_eeh_normalize_addr(pe, op.err.addr,
+							    op.err.mask,
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


