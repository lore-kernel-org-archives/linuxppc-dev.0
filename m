Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF6606A33D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AT1MkZiU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9vxZ3v2Zz2yjN;
	Fri, 23 Oct 2026 18:37:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792741058;
	cv=none; b=FhVXuXYedYmOPrfVJafxzlv698udeUQ1czvqHhZpx8TYeUPtnyqLyBNLSaYngQ/fGt0bKRwcsLubN2NGjrLYUFsgds9KIPyt43uQSQgmRpSVaBPlCL18DGwL9i8IFXRKQ5Mnw+EKY3FneOI6feg9eRvjkQFU2KYwaMDOlxEAVXjIlHImvL1QoqsDSftunPV6S1AALFpsW0z+9Blec0fYA3dC5O6OCcari4RrMDkcawUCJ32b7UoNt078OzfLyWAgZcLU+bEcDD4b49EjL762KDMXtBExJgUGUlCzh/nx3gBhWhUkZrwTLg+40eiaYaqnWti0Wn00asB5c6ZDx+Zd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792741058; c=relaxed/relaxed;
	bh=VhAPmuWATkVRj2OsG40YY/ERu2CYkOcK8xH8+dfAmwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk4sABSNtth3dd6wnBOiKb6OjWdGj5DgAuZhxB+cRsQmf+QsEgMV9JzfcqBEcjS0kNopr80Y7BWZK5CEicd1R7hVBkXrcWVPygEVQxS0aAyA/wMgMyjeSGbOWKrQ4OP6ELJJpXGuQhoyWIS/+hpoVXySbQIvHoTcMQLu8HL8UdpK15yy2hYUFS5SKqkJg1ho9FDLwnGT3js0vkj1PHKgKlpvbd29KpXs68NGwtVhXoCF4d9eUZ7Y7l5mNl4b1Z+RC8dML0rehoRbU9o9KyBlrophOJj9kfLOL1w2eTMHEJBBksSE8C50fUHixECHsRiOAuSyHaK4f+Ikp7CqIGTcfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AT1MkZiU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AT1MkZiU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9vxY3367z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 18:37:36 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Ejol2248194;
	Fri, 23 Oct 2026 07:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VhAPmuWATkVRj2OsG
	40YY/ERu2CYkOcK8xH8+dfAmwo=; b=AT1MkZiUykuIc9X+uw53LOrRcpJmw+7Sh
	B2iIPHiCVrbrkkKt0HWSKFjb/heTpli1JUJFK47tjvAO2mp8uIQFrElhZT1psuVM
	UBB4LXKeLqEU5rbHJ9O4HBAfBgRUDRIfXTrWerMzCDsWnEyzzC2vCAHGdGdwfFLd
	Qgfa3HqLBzJoEmbExZdsekrnP4nwUePUKsPUg3VOqxELWBwEAEyi8ftuoe5JmFMr
	o7kGrD6AdIPMVZ9kkAbCUxOoDaT3V6ClzbHRLHs7FsE9N9mv2IliJ+mFp3fKC4aL
	tTZbs/X125vNVkWtdcghECDCY5YG0EFhzVMscn9bfUiqpiXoimFEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5akt2g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7JvVm556165;
	Fri, 23 Oct 2026 07:37:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefssbqcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7bN4t39191004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:37:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4744120043;
	Fri, 23 Oct 2026 07:37:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA5720040;
	Fri, 23 Oct 2026 07:37:19 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.18.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:37:19 +0000 (GMT)
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
Subject: [PATCH v6 2/5] powerpc/pseries/eeh: Add RTAS error injection helpers
Date: Fri, 23 Oct 2026 13:06:39 +0530
Message-ID: <20261023073642.59657-3-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX6+IRyg2CKbeI
 f0/pWxtsEjtBv69qYvB3Zqv0MUxziqG8y/skQZWn4EsGXLlMSEFM4J6rGUc0Pv5JM+EtNY+eo6v
 bUHWoOBQl2XPrE6PmsLgUusQ4cbzriM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX8lw6rh59HvKc
 AoAHuLKPeJrCS9q22cYWZ2yzi8VP5l7QMnXJGQGRuzKvrI2pnwzgyh00D1exvbFbTRYE5AwZBPQ
 homAnFe69UgPc6QA8EedJmxtqy3zjTjLfZv9rgddikoOKvHFeSJXVISARHGWFGVwpj/etTkOk4c
 KMHC12NBeo2RfffiDzjCVkZ9/5/72TYXc2y8uKcz4VDccHKna+0FSzhcEeJLJqxOZWE7p3rn6Ds
 zFz3Cq/9cGMMlmIMbKl93rbnKkjBhCERGdw0mg8SFIpVR4fpUr4kU3CuYeFW0sLx4HFCqORB95O
 PkW1wX04JVk41oec/UW9196tWfS3Txov7ClmcYZ8/TvizsqvQ7+0FJgmjVZeMhTPd3Js/qDgQuk
 ZNMCnFWOuK/u3YFbSvJ/khOsSiUX+gqEinUs96dZHkxS+qFq7dwaJSyHatU8DTv8sqUifhmi9P0
 zVjP8EtO84wrOvPgWlw==
X-Proofpoint-GUID: VdL4s94SBocieH3p6y_YluQAvfxkEXvK
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb0eb8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=ENKtBXonfzOWWT7N3w4A:9
X-Proofpoint-ORIG-GUID: yy9llBtGBV6PbgmgLDYGT0U4zEi2VxeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare the pSeries EEH backend for RTAS error injection by adding
helpers that:

  * map generic EEH error types to RTAS/PAPR error types;
  * validate IOA addresses against the target PE.

Define pr_fmt unconditionally at the top of eeh_pseries.c so all
pr_*() calls carry the "EEH: " prefix.

Define RTAS firmware error-type encodings as file-local constants.
Only the two IOA bus-error types are supported; other PAPR encodings
are not reachable through the generic EEH_ERR_TYPE_* UAPI:

  RTAS_ERR_TYPE_IOA_BUS_ERROR     0x07
  RTAS_ERR_TYPE_IOA_BUS_ERROR_64  0x0f

Add RTAS_ERRINJCT_BUF_SIZE for the ibm,errinjct work buffer size.

Add pseries_eeh_type_to_rtas() to translate the two generic EEH error
types (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64) into the corresponding RTAS
ibm,errinjct encodings.

Add validate_addr_mask_in_pe() to verify that a caller-provided address
falls within a BAR of some device in the PE.  RTAS IOA bus-error
injection requires a PCI/IOA bus address; validate_addr_mask_in_pe()
accepts only PCI bus addresses.  VFIO userspace resource addresses are
normalized to PCI bus addresses in vfio_iommu_spapr_tce.c before
reaching this backend; no resource-address fallback is added here.

Use pcibios_resource_to_bus() to convert each BAR resource to PCI bus
address space before validating the address.  Only standard BARs
(BAR0..BAR5) are searched; ROM and bridge resources are not IOA
bus-error targets.  Hold pci_rescan_remove_lock while traversing PE
devices and their BAR resources so PCI device removal cannot race the
address validation.

Skip unassigned or disabled BARs explicitly: on pseries,
pcibios_fixup_resources() zero-bases unassigned BARs (start=0,
end=size-1) and sets IORESOURCE_UNSET, so resource_size() is non-zero
for them and pcibios_resource_to_bus() treats them as bus address zero.
Use pci_resource_len() (which returns 0 when end==0) instead of
resource_size(), and reject BARs with IORESOURCE_UNSET or
IORESOURCE_DISABLED set.

Returns -EINVAL (Linux errno) rather than a raw RTAS status.

validate_errinjct_args() and prepare_errinjct_buffer() are introduced
in the next patch alongside their callers so each intermediate commit
builds cleanly with CONFIG_WERROR.

pseries_eeh_err_inject() retains the existing MMIO injection body
unchanged in this patch.  It is replaced by the full RTAS session
implementation in the next patch.  This keeps the patch bisectable:
each commit builds and functions correctly independently.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 134 +++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..28b1fd19e8bc 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -12,6 +12,8 @@
  * Copyright Linas Vepstas 2005, 2006
  */
 
+#define pr_fmt(fmt) "EEH: " fmt
+
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/export.h>
@@ -23,6 +25,7 @@
 #include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/crash_dump.h>
 
@@ -786,6 +789,137 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 }
 #endif
 
+/*
+ * RTAS firmware error-type encodings (PAPR).  These are pseries-private;
+ * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
+ * Only IOA bus-error types are supported; other PAPR encodings are not
+ * reachable through the generic EEH_ERR_TYPE_* UAPI.
+ */
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
+
+/* Size of the ibm,errinjct work buffer as defined by PAPR */
+#define RTAS_ERRINJCT_BUF_SIZE			SZ_1K
+
+/**
+ * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS encoding
+ * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
+ *
+ * Translates the generic VFIO/EEH error type passed from userspace into
+ * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
+ *
+ * Return: RTAS error type on success, -EINVAL for unknown types.
+ */
+static int pseries_eeh_type_to_rtas(int type)
+{
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
+	case EEH_ERR_TYPE_64:
+		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * validate_addr_mask_in_pe - Validate addr against PCI bus BAR addresses in PE
+ * @pe:   EEH PE containing one or more PCI devices
+ * @addr: PCI bus address to validate
+ * @mask: address mask (passed to firmware unchanged)
+ *
+ * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI resources
+ * are CPU/resource addresses and may differ on pseries due to PHB window
+ * translation.  Convert each BAR resource to PCI bus address space before
+ * validating @addr.
+ *
+ * Zero addr and mask are accepted without BAR lookup (no-address injection).
+ *
+ * Return: 0 if valid, -EINVAL on invalid input.
+ */
+static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
+				    unsigned long mask)
+{
+	struct pci_bus_region region;
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	struct resource *res;
+	resource_size_t bus_start;
+	resource_size_t bus_len;
+	bool found = false;
+	int bar;
+
+	if (!addr && !mask)
+		return 0;
+
+	if (!pe)
+		return -EINVAL;
+
+	/*
+	 * RTAS IOA bus-error injection uses PCI bus addresses. Linux PCI
+	 * resources are CPU/resource addresses and may differ on pseries due
+	 * to PHB window translation. Convert each BAR resource to PCI bus
+	 * address space before validating @addr.
+	 *
+	 * Hold pci_rescan_remove_lock across the traversal to protect pdev
+	 * lifetime: pci_stop_and_remove_bus_device() requires this lock.
+	 */
+	pci_lock_rescan_remove();
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		/*
+		 * Validate against standard BARs (BAR0..BAR5) only.
+		 * ROM and bridge resources are not IOA bus-error targets.
+		 */
+		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+			res = &pdev->resource[bar];
+
+			/*
+			 * Skip unassigned or disabled BARs.  On pseries,
+			 * pcibios_fixup_resources() zero-bases unassigned BARs
+			 * (start=0, end=size-1) and sets IORESOURCE_UNSET.
+			 * resource_size() is non-zero for such BARs, and
+			 * pcibios_resource_to_bus() treats them as bus address
+			 * zero, so they must be excluded explicitly.
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
+			bus_start = region.start;
+			bus_len = pci_resource_len(pdev, bar);
+
+			if ((resource_size_t)addr >= bus_start &&
+			    ((resource_size_t)addr - bus_start) < bus_len) {
+				pr_debug("addr=0x%lx mask=0x%lx validated in PCI bus BAR[%d] of %s: bus range 0x%llx-0x%llx\n",
+					 addr, mask, bar, pci_name(pdev),
+					 (unsigned long long)region.start,
+					 (unsigned long long)region.end);
+				found = true;
+				goto done;
+			}
+		}
+	}
+done:
+	pci_unlock_rescan_remove();
+
+	if (!found)
+		pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of any device in PE\n",
+		       addr, mask);
+	return found ? 0 : -EINVAL;
+}
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
-- 
2.54.0


