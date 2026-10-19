Return-Path: <linuxppc-dev+bounces-29699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57090CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:19:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wk14SlQz30V2;
	Mon, 19 Oct 2026 21:19:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405161;
	cv=none; b=Tj8XLXVXLptLAUR4MsIBnPThm3J6gfmwV7+gyZDNkY5yCrTl64fb2d9zgTeOd0p13efBqL6GV4VxYdM164QR0bS4ry1vzHIEm+RdyBk0E7Th97941s5l35XVkztD0Y8OfLQuC+PuBhQyUYZFnwKOl7y2X3rtIWvgLmK2bQDnA7KAb+jOzpwZ6hV8w9FhyXFll1dtSnCktvL+cuZil3D4c9ipDaCim42x+uy4JZYqztvBuYTgRYa5Re/jg/UichI8A9B48g7qYdCLjMpgq3c8BgE4ZNkONqLNdTRiCyMHiW09vB7kVjBAzUzdWDt6fP4jNKtdE8d7PCSnAKvcM+BTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405161; c=relaxed/relaxed;
	bh=ttWTj2WQ5sU6Dt8NUVOW7LvYepXNg6L8fRu+PxYx6Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KssNh7DBgOWu1Lq98hJ0PHxruhlHDgOsNurrsb2Z7Sb991+HyoI+SY/n6ANSM7JarhWnmjE7+ApDRe185LGn3Z61Qv1Va8chFOaYPkxN8uwIk90Zmw6ZxUpwxy0Ve8ehSQKet0XEzn0sCkSsOyJEuDhM5vsFd9nVJYdhp69ZR2UHgf9t78Oyyjn3eTauWQ8Nrh+pYaxGXNqinfNljgtcywlShrfN6asX7VltegCCmVcj48CyMLDsUWrnQsob+WWw+TY7gxTRN2UYNtfm75P0zkr2jIPPNlR32i64x0UU79jFTvlji9Q8SfsChOHh4/t8zfVYEDzY7Zyhh3/Oovv+cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OTdN9aVG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OTdN9aVG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wk03t5Hz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:19:20 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iM6B3347787;
	Mon, 19 Oct 2026 10:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ttWTj2WQ5sU6Dt8NU
	VOW7LvYepXNg6L8fRu+PxYx6Uk=; b=OTdN9aVGASXFhYK2y2k0fGvmsteZBMoCx
	g20JWrdh2rhqoX1irUvl//v1hgEoI6knL7sSbGger4VY4ohhwYI0bKjZxzvY2IBW
	XoLs5Nbh/hA1g2psDyWyAQpEISI4Dc7oQl1SmIeDQWvSpnIwHQ05q3Me/TIRD4oY
	ie89KzcTwqdXeLIIZbuEuGcftWzAHaIqGBVskuJvCj0p/EG7p5dHSCeoHvLq7DRE
	ojTe4SdEchmncgzmwDJd3LPWA2Il1I2Na2I/uwAhFSvohRpGIDM7F3+roRvHGksK
	5hC1TRRwa7kSXXyE+zn8GM7yh7T3CwHH2sykyiGa+KQlXr1x/Uxkw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvsq7d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Z0Vx3889583;
	Mon, 19 Oct 2026 10:19:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugw5mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAJ5UM49676590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:19:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BAE20065;
	Mon, 19 Oct 2026 10:19:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB622004D;
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v5 4/5] vfio/spapr_tce: Normalize EEH IOA error injection addresses
Date: Mon, 19 Oct 2026 15:48:12 +0530
Message-ID: <20261019101813.45085-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/eDKrTfsehsW
 JqgNhnXGU3zD0DBLKBtypWCLOirIo+PmxoRqw+sJ6gM9QRFvtjEo8IX8p4xnU4W7t+3TOkTlQ53
 NlmnV+mR7Qjc+jt9QqQoVD/jLsEKiww=
X-Proofpoint-ORIG-GUID: LDNNxbHFjBgwfU5oTI-0QlEG5crcsJFA
X-Proofpoint-GUID: S4noOf-vz05zpqUwbQiciNimI9hOcwTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/tEAe4aeVfD8
 ImPvWN4RVQ5D6GrqMNoe7sYcvXjQOJxbM76LehDvXfn9MGV+5rtJbG8gOHvZaWZh6DBxxk4RrHq
 KusM9xlK3xjtPtItSOduHhBsSbPz9L7wNKfuecwQXBDpTnd7v4RxEtEofXJbcRm5g4j0taIffkK
 TznhMn4lN9bW5160aXUzA86KZEb2S9j4sE+XXEQW5h3x1/9Kk7BNJYm6uEU1fAze/hkWihJ9r1J
 O3vcgF/fEm1ZS9s8xngfTVabG9HDujn7GFp+SnoOPEpRSdxVyL6opAze8jLd3N3YEK7gAFe6/Sm
 GOq0ibJo3bNgoWTDypkMazKbEVNW3NSnuTsrkbuzOFZLTDqbeXNxFVoW6+yHshVrTjB50J/4CLW
 GskRcJfLae+yCPt+bI+4KJCO/XuXseUOJgPpTQwaqvKrpshulAtUbLRt2q5zsXxm9G7U4VLNsIf
 UM02tzhPIvfzdDaFwDg==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad5ee9f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=WTuDyPl4slZZHiUw8mUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

VFIO_EEH_PE_INJECT_ERR receives a target address from userspace.  For
userspace such as QEMU, this address may be derived from the host Linux
BAR resource.  The platform EEH backends, however, expect the PCI/IOA
bus address used by firmware error-injection interfaces.

Normalize IOA/MMIO error-injection addresses in the sPAPR VFIO EEH
ioctl path before dispatching to eeh_pe_inject_err().  If the supplied
address is already a PCI bus BAR address it is left unchanged.  If it is
a Linux resource address, translate it to the corresponding PCI bus
address using the BAR-relative offset.

Normalization applies to EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64; other
error types do not carry an IOA bus address.

An address and mask pair of zero represents a no-address injection
(e.g. a function-level error with no specific IOA target) and is passed
through without BAR translation.

Only standard BARs (BAR0..BAR5) are searched; ROM and bridge resources
are not IOA bus-error targets.  Hold pci_rescan_remove_lock while
traversing PE devices and their BAR resources to prevent PCI device
removal from racing the lookup.

A pr_debug() is emitted if the address cannot be matched to any BAR, to
aid debugging without producing noise in the normal path.

Keep the helper local to VFIO so the address semantics of other
in-kernel EEH callers are unchanged.  This provides common handling for
both pseries and PowerNV backends.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 105 ++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..dad9ba54bae6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -774,6 +774,97 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	return ret;
 }
 
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
+			if (!resource_size(res))
+				continue;
+
+			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
+				continue;
+
+			pcibios_resource_to_bus(pdev->bus, &region, res);
+
+			pci_start = region.start;
+			pci_len = resource_size(res);
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
+			res_len = resource_size(res);
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
+		pr_debug("vfio EEH: addr=0x%lx not found in any PCI bus BAR of PE, injection may fail\n",
+			 addr);
+	return rc;
+}
+
 static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 				       unsigned long arg)
 {
@@ -818,6 +909,20 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
 		if (copy_from_user(&op, (void __user *)arg, minsz))
 			return -EFAULT;
 
+		if (op.err.type == EEH_ERR_TYPE_32 ||
+		    op.err.type == EEH_ERR_TYPE_64) {
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


