Return-Path: <linuxppc-dev+bounces-29697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF4CCCF2DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:19:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wjs60XNz2yfD;
	Mon, 19 Oct 2026 21:19:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405153;
	cv=none; b=FVCeZ2nirJTktbekgMW0DReCfHYZZK+gDAp36oxFIcOkyugwuorv3E9fnBSAXyLrbuyHgfAvlV45tL/QcumOO9pl0S8M9ImdzHW9TnfP3HzhyP/2nDlv9cyK4OKJCVvqkne1RKdjkUukH7neQzn7XEq+Ch4vieLV/GIXfGGbhh/bck0wtOKvv6hW2NjxQIrFuC3rABttw1MTxzNSbzIHY2Vlm4BYrHllHbSQapAKg8OcfKPnpQ4RyF9UMYTR/E8eN0xlaW5yQeM0V8iynGT/s/BB4bEaMZdtN1LotvA75nCFd8+DhZXTDgZfg8wiaTQcS+hnEqNv+QkPmZ6PNaTg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405153; c=relaxed/relaxed;
	bh=cpuTorH7cIsn9Hktso1QghcykuB19NUb2jjVQnq1e+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWJ+VLV+5YkGLDvgAtvNEi5dI+EjYS53hDdr1btIi+GvC/4KBSO3emFNBYIc83I+S+97HWrwWEkgdXbGse2YEo9E/QS/mhrZ4ATu5lg2cdj9m9J8iVoueV6ZDWeJJni+dD3bHik1qdIlNBfhyZbfHOO1vZUlgqSHB8SrgTOZK8HB2PuRyfpJBYTHn8baHj81h0LWF4tED0zSRH9JJwkDzhfzKHfpAUHXvEaFuaii25jAg+SGJg0LHU2pH7nHu2/42lzDJyAoOm5oP1s5FEgSSheN+keHc/uXLZRg3NuT1HbONamxJqW89AJv65K4oT8ghCudWZ6uvOf8kgKRg+Kk0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENY7SC3z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENY7SC3z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wjr5st6z2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:19:12 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iPO23348284;
	Mon, 19 Oct 2026 10:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cpuTorH7cIsn9Hkts
	o1QghcykuB19NUb2jjVQnq1e+M=; b=ENY7SC3z88pkniE0HE5gPs2sYMRHpNRhA
	hFMNWKk0tLekHPsr/arQBZNQn0y7WfGHjJX8OGWsdvErxAFmieJBy6OhvT7ILbti
	26NCZyCn1QEa1uXx+zNimqtdL1fNsDc4Eikvofo/RtcKwJu6WOzo71Im93i/Fcb1
	SaAfZgcu8vzABmMI7mAOrPnqdzW9Gz87wZJf6cJYwePBACY1P2nNmMqgAtUTcbhz
	MmGF50QGFrELUTgrWeIdAw4z0UN1P49nkqrtgU5tNzf8KZHyvoHpgnEmV9Gj9koQ
	DGdynwh6uQdMfLLruOHEmP2161WeDqeA/vdcvro0xc6o3vMwz57Zg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvsq6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YtkR3802627;
	Mon, 19 Oct 2026 10:19:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjw7qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAIvPR33751316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:18:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A2212004F;
	Mon, 19 Oct 2026 10:18:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 864932004D;
	Mon, 19 Oct 2026 10:18:53 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:18:53 +0000 (GMT)
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
Subject: [PATCH v5 2/5] powerpc/pseries/eeh: Add RTAS error injection helpers
Date: Mon, 19 Oct 2026 15:48:10 +0530
Message-ID: <20261019101813.45085-3-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/Vo1a3iQfrZO
 Uq8YXvRvMsEg2VO5aEwvghuAIXvh/tOB1TqZi+mydj4Z+7++phRjnxnBWES1IkCldppVSD4lrJa
 fmGI3QNh/nczZ3mUS+ptpgCkKeFqpdM=
X-Proofpoint-ORIG-GUID: PiF256Jm0zj2WCjwmQdTdUJS_LncWq9t
X-Proofpoint-GUID: hb4rauOvRg0bG5cbF47tmMBorrtuAwnG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfXyD+vJ7tz0yRx
 dhicGpWyLRqITZDLbNoYOACchaH3MVK579RRNsSx1JhX8IPdpAm+eNdlChvCaFsDKuivzUCNK7K
 lzvXr/Lm8gyRoFsvILKdkzUQO12btgxVxxThdJcCemBA9043uHntsv8f03JG9fMtHFZ0Chwpvna
 vsjO2wEOq5laiAxdQT50PxBIN5DJSr4p5sDVt5HetmclVHgbsbRPVLCRqEUQkfSwciptDtptip1
 mclyRMSwmM15QOTjnY6pwuBI1u9V8sqx9K7LMhsoBx5Zh+ryJAU27TXkF2rkPMbvYlPe2x8MF1j
 3219PNwXNEz2G3H8Bi2GfU+GWcP/tUdHM72JZ2fgHnB23f5sUC8x/eEeVONAb9INcBrE5grm5ki
 KvW4W1UNR1lWPX2RTjIpKdosqSTw0CU9+4iYhzSskKT8atfa8aNgsfLlX/pTovjHJuUUA5qrhDu
 ol4/P8Y4S1+QWKdWjuw==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad5ee96 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=0M9ubGd7lOK25v9ljhIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

Prepare the pSeries EEH backend for RTAS error injection by adding
helpers that:

  * map generic EEH error types to RTAS/PAPR error types;
  * validate the error injection parameters;
  * validate IOA addresses against the target PE;
  * build the PAPR ibm,errinjct parameter buffer.

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
address validation.  Returns -EINVAL (Linux errno) rather than a raw
RTAS status.

Add validate_errinjct_args() as a top-level validation wrapper that
checks the PE pointer, maps the generic type, and validates the function
range.  Function-range validation is owned here; prepare_errinjct_buffer()
does not re-check it.

Add prepare_errinjct_buffer() which:
  - guards against NULL buf/pe/pe->phb
  - zeroes the buffer unconditionally with memset()
  - checks 32-bit truncation for the IOA_BUS_ERROR case
  - calls validate_addr_mask_in_pe() for address validation
  - supports only the IOA bus-error types (unreachable non-IOA
    RTAS cases removed)
The caller provides an exclusive per-call RTAS work-area buffer.
Firmware session serialization is left to the caller.

pseries_eeh_err_inject() retains the existing MMIO injection body
unchanged in this patch.  It is replaced by the full RTAS session
implementation in the next patch.  This keeps the patch bisectable:
each commit builds and functions correctly independently.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 220 +++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..999b3065e09b 100644
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
 
@@ -786,6 +789,223 @@ static int pseries_notify_resume(struct eeh_dev *edev)
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
+			if (!resource_size(res))
+				continue;
+
+			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
+				continue;
+
+			pcibios_resource_to_bus(pdev->bus, &region, res);
+
+			bus_start = region.start;
+			bus_len = resource_size(res);
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
+/**
+ * validate_errinjct_args - Top-level validation for RTAS error injection arguments
+ * @pe:   EEH PE for the target device
+ * @type: generic EEH error type
+ * @func: error function selector
+ * @addr: address argument (type-dependent, may be zero)
+ * @mask: mask argument (type-dependent, may be zero)
+ *
+ * Validates all parameters before opening an RTAS injection session.
+ * Returns Linux errno values; does not return raw RTAS status codes.
+ *
+ * Return: 0 if all parameters are valid, negative errno otherwise.
+ */
+static int validate_errinjct_args(struct eeh_pe *pe, int type, int func,
+				  unsigned long addr, unsigned long mask)
+{
+	if (!pe || !pe->phb)
+		return -EINVAL;
+
+	if (pseries_eeh_type_to_rtas(type) < 0)
+		return -EINVAL;
+
+	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
+ * @buf: RTAS error-injection work buffer
+ * @pe: EEH PE associated with the injection target
+ * @rtas_err_type: RTAS firmware error-injection type
+ * @func: Error function selector
+ * @addr: Target PCI bus address
+ * @mask: Address mask passed to firmware
+ *
+ * Zeroes @buf and populates it according to the PAPR layout for the
+ * selected IOA bus-error injection type.
+ *
+ * The caller provides an exclusive per-call RTAS work-area buffer.
+ * Firmware session serialization is handled by pseries_eeh_err_inject().
+ *
+ * Return: 0 on success or a negative errno on invalid input.
+ */
+static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
+				   int rtas_err_type, int func,
+				   unsigned long addr, unsigned long mask)
+{
+	__be64 *buf64 = (__be64 *)buf;
+	__be32 *buf32 = (__be32 *)buf;
+	int rc;
+
+	if (!buf || !pe || !pe->phb)
+		return -EINVAL;
+
+	memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
+
+	switch (rtas_err_type) {
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+		if (upper_32_bits(addr) || upper_32_bits(mask))
+			return -EINVAL;
+
+		rc = validate_addr_mask_in_pe(pe, addr, mask);
+		if (rc)
+			return rc;
+
+		buf32[0] = cpu_to_be32((u32)addr);
+		buf32[1] = cpu_to_be32((u32)mask);
+		buf32[2] = cpu_to_be32(pe->addr);
+		buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[5] = cpu_to_be32(func);
+		break;
+
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+		rc = validate_addr_mask_in_pe(pe, addr, mask);
+		if (rc)
+			return rc;
+
+		buf64[0] = cpu_to_be64(addr);
+		buf64[1] = cpu_to_be64(mask);
+		buf32[4] = cpu_to_be32(pe->addr);
+		buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[7] = cpu_to_be32(func);
+		break;
+
+	default:
+		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_err_type);
+		return -EINVAL;
+	}
+
+	pr_debug("errinjct buffer ready: rtas_err_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
+		 rtas_err_type, func, addr, mask);
+	return 0;
+}
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
-- 
2.54.0


