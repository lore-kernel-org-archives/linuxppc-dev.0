Return-Path: <linuxppc-dev+bounces-24575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30AAC4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435k4VVzz3090;
	Tue, 21 Jul 2026 13:39:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605146;
	cv=none; b=Ial3z0/TawOODOglsBixmRhiLXiL9fpQecKPyWKrGBrVhPcPSWk2ti5TpDwxHzLdJy7XxpWn0mrp8aX3f9ATYWbGugS5NNmd5pO8/IecJu5h7K4RECsRcQpscBh/GHECYHyUXPLinic7g8yZ+F2al2cRvm0cM6sOW969Rkb3ialA/JYC66MuX6w0d4bafb5mRdVY7cMdApieCeBvZMY1XUwKkmdvnrsddCg1Q+az4KnPFrpYxqzH99DLLsXt7orxO1GN+pKTLv7Q/q8gD//OFPdxSHDafYLfWKbiu6GdwA7UKkL2MxB5MdlXnTpIPCtMg1JixiMC+96+w3Aox7yq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605146; c=relaxed/relaxed;
	bh=reVgyFxZkSRxYcsiOYD0gCtTM9X6pTksaZdCJNKqIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsfoCJOrZ1QuSYZBEic4O6mv5bYAvSrolTnOBEApjOPv8XexSXmQAFjt5ak9z+q6TztigA1Kkz1EEAvInZtBMuuN3ytbm5jQ9vkvllYW0zOvXrZjaMXh2Rhnywd4usft3LpetTDywbERDx7IPWHqNBdUV+X6nMEyJL2ZG/HoenQ4dzdMg4bujSjKHDAlAIjWHPoiQ43TaCwDbs+YGIv5EKMmHWeE6MuS4wECl13/1MKDx+Xlps6xL2lCKQWUtfC0L+juhwFGH+EkMLwiVRrHIJRVP539PasTq/0Mc/wq5k2O1w7o482hgdvVnrjPrYtr1R+1XM9dnXvTJNOpqI0QlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MiRn/R4G; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MiRn/R4G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435j4lG1z2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:39:05 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDX183564509;
	Tue, 21 Jul 2026 03:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=reVgyFxZkSRxYcsiO
	YD0gCtTM9X6pTksaZdCJNKqIJk=; b=MiRn/R4Gx/J6PArrc5Og2+KWWI6xaYDZ8
	lSL22p6knn3y7sQZqZy0KcbHQbFo6YORap0IfAnDDe0HvhPs1BMgGC/FArXpZdvQ
	VMY8wyN9eFNsR+oPm1KKhKvvF++eyW41L2j1rBO+BKXX/5Iqm8uwlm2HYqvxEvB+
	pyUqlYQneQSL2oe+198OvL4Wa0xjl5YJEscVipxXFOZN/86JTuNNsePaFDwRqRE7
	JrwKm15M4TtqeKO+waoNn3JkC21XDkAV/81LH6MKVShF9494AnSsKCt6wNht0QSt
	XvKWYNminiyoUMFCzGWJMyow3CRFtoj+P2KJh6yoDgxe8tLI2W4Qg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790tp28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3Z2xc016180;
	Tue, 21 Jul 2026 03:38:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g8c9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3cmu415204616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5328520043;
	Tue, 21 Jul 2026 03:38:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 189D120040;
	Tue, 21 Jul 2026 03:38:44 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:43 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 3/5] powerpc/pseries/eeh: Add RTAS error validation helpers
Date: Tue, 21 Jul 2026 09:08:03 +0530
Message-ID: <20260721033815.5300-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PURSLLYc4Aa32kfoFZzcF4HFc4gyM8T5
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5ee9cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=1AdQuVhvgp6spBBsLJAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXwJIIVwKkQISO
 8dBRIzqOGWnbLp4JsNzFvcdV9QlRCGDdGMMN6aw4u62WyYHwDf/wKd8SJ9wzzvNPEtnl7Isjqxw
 kMaK9TlKAGp/TUwliOKd9CizPosTzdw=
X-Proofpoint-GUID: l_d5IZRII66fHPNzV_uq7W9esFNkGjC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXyl1R/jXufulR
 4QHFIkQU4/1D6+T6K/dG4+kI6p4FWYC57eUnELmEOHJMXTI9+gJurh+r2w0h+OchY4pvE7t5k40
 Ze4hgHJiX35YvYbvvE3/yPJhg8M7eQMqdC5tHL/Xshumw2q8acA5hkCGPeXRKtaB4afzO+ofDGp
 m4QLqzY+9Ew8WQLN1KSS1TNll2hFFwl55qbwDwctay2N7/qecoj7wkp/EIzKzWQMD08aMe7R3Ww
 3/HbyogCCdPk1N40oxBYR9yqo0LJMzJrUAbcB0HLxMqcT1tIwN15aKH83SaJzm6duJQnrnGoFWa
 LqOmMmvmB1LWn52krILDYCsH8s+Mys49V7GlZuNZ5lVokquwIL/SCSCxisNiyJl2N6GZbCAB++W
 VgYVOR2tp4NqWVvheIN5q6IlHCv1nXdPmr7+ON4NpqWYYbfuA4FVUd/rwfRVyn3HH1TZtItHMjT
 VssEk6FaDDxDIOzI6Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210030

Add validation helpers and buffer-preparation infrastructure used by
the RTAS-based EEH error injection implementation.

Changes relative to the original submission:
 - pr_fmt unconditionally defined at the top of the file, not wrapped
   in an #ifndef guard.
 - RTAS error-type constants (RTAS_ERR_TYPE_*) are defined as file-local
   macros in eeh_pseries.c, not in the UAPI header.  They are internal
   PAPR firmware type codes, not generic EEH ABI values.
 - validate_corrupted_page() drops the unused 'pe' parameter entirely
   (no __maybe_unused).  The mask value is silently accepted since it
   is not meaningful for this error type.
 - validate_ioa_bus_error() is removed; callers invoke
   validate_addr_mask_in_pe() directly.
 - validate_err_type() and validate_special_event() and
   validate_corrupted_page() are marked static inline.
 - prepare_errinjct_buffer() takes an explicit 'void *buf' pointer
   (kernel virtual address) instead of accessing rtas_errinjct_buf
   directly, making it easier to test and keeping the global out of
   the helper.
 - kernel-doc added for prepare_errinjct_buffer() including a Locking:
   line stating the caller must hold rtas_errinjct_mutex.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/eeh.h          |  24 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 250 +++++++++++++++++++
 2 files changed, 271 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
index 3b5c47ff3fc4..2680b22f8917 100644
--- a/arch/powerpc/include/uapi/asm/eeh.h
+++ b/arch/powerpc/include/uapi/asm/eeh.h
@@ -15,9 +15,27 @@
 #define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only	*/
 #define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
 
-/* EEH error types and functions */
-#define EEH_ERR_TYPE_32			0       /* 32-bits error	*/
-#define EEH_ERR_TYPE_64			1       /* 64-bits error	*/
+/*
+ * EEH error types.
+ *
+ * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the original ABI values and must
+ * not be renumbered.  The additional types below are generic identifiers for
+ * error-injection types supported by pSeries RTAS.  Platform backends may
+ * return -EOPNOTSUPP for valid generic types that are not supported by their
+ * firmware.
+ */
+#define EEH_ERR_TYPE_32				0       /* 32-bits error	*/
+#define EEH_ERR_TYPE_64				1       /* 64-bits error	*/
+#define EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT	0x03
+#define EEH_ERR_TYPE_CORRUPTED_PAGE		0x04
+#define EEH_ERR_TYPE_CORRUPTED_DCACHE_START	0x09
+#define EEH_ERR_TYPE_CORRUPTED_DCACHE_END	0x0a
+#define EEH_ERR_TYPE_CORRUPTED_ICACHE_START	0x0b
+#define EEH_ERR_TYPE_CORRUPTED_ICACHE_END	0x0c
+#define EEH_ERR_TYPE_CORRUPTED_TLB_START	0x0d
+#define EEH_ERR_TYPE_CORRUPTED_TLB_END		0x0e
+
+/* EEH error functions */
 #define EEH_ERR_FUNC_MIN		0
 #define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
 #define EEH_ERR_FUNC_LD_MEM_DATA	1
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..25aad86c696d 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#define pr_fmt(fmt) "EEH: " fmt
 /*
  * The file intends to implement the platform dependent EEH operations on pseries.
  * Actually, the pseries platform is built based on RTAS heavily. That means the
@@ -31,8 +32,27 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
+#include <linux/mutex.h>
 #include <asm/rtas.h>
 
+/*
+ * PAPR RTAS firmware error-injection type codes.
+ *
+ * These are internal firmware encodings used by ibm,errinjct.  They are
+ * NOT generic EEH ABI values.  Only the types actually handled by
+ * prepare_errinjct_buffer() are defined here.
+ */
+#define RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT	0x03
+#define RTAS_ERR_TYPE_CORRUPTED_PAGE		0x04
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
+#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_START	0x09
+#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_END	0x0a
+#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_START	0x0b
+#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_END	0x0c
+#define RTAS_ERR_TYPE_CORRUPTED_TLB_START	0x0d
+#define RTAS_ERR_TYPE_CORRUPTED_TLB_END		0x0e
+#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
+
 /* RTAS tokens */
 static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
@@ -786,6 +806,236 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 }
 #endif
 
+/**
+ * validate_addr_mask_in_pe() - Validate that addr+mask fall within PE BARs
+ * @pe:   EEH PE containing one or more PCI devices
+ * @addr: Address to validate
+ * @mask: Address mask to validate
+ *
+ * Checks that @addr is mapped into a BAR/MMIO region of any device
+ * belonging to the PE.  If @mask is non-zero, ensures it is consistent
+ * with @addr.
+ *
+ * Return: 0 if valid, RTAS_INVALID_PARAMETER on failure.
+ */
+static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
+				    unsigned long mask)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	int bar;
+	resource_size_t bar_start, bar_len;
+	bool valid = false;
+
+	/* nothing to validate */
+	if (addr == 0 && mask == 0)
+		return 0;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		for (bar = 0; bar < PCI_NUM_RESOURCES; bar++) {
+			bar_start = pci_resource_start(pdev, bar);
+			bar_len   = pci_resource_len(pdev, bar);
+
+			if (!bar_len)
+				continue;
+
+			if (addr >= bar_start && addr < (bar_start + bar_len)) {
+				if ((addr & mask) != addr) {
+					pr_err("Mask 0x%lx invalid for addr 0x%lx in BAR[%d] range 0x%llx-0x%llx\n",
+					       mask, addr, bar,
+					       (unsigned long long)bar_start,
+					       (unsigned long long)(bar_start + bar_len));
+					return RTAS_INVALID_PARAMETER;
+				}
+				pr_debug("addr=0x%lx mask=0x%lx validated in BAR[%d] of %s\n",
+					 addr, mask, bar, pci_name(pdev));
+				valid = true;
+			}
+		}
+	}
+
+	if (!valid) {
+		pr_err("addr=0x%lx not within any BAR of any device in PE\n",
+		       addr);
+		return RTAS_INVALID_PARAMETER;
+	}
+
+	return 0;
+}
+
+/**
+ * validate_special_event() - Validate parameters for special-event injection
+ * @addr: Address parameter (must be zero for this type)
+ * @mask: Mask parameter (must be zero for this type)
+ *
+ * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
+ */
+static inline int validate_special_event(unsigned long addr, unsigned long mask)
+{
+	if (addr || mask) {
+		pr_err("special-event injection must not specify addr/mask\n");
+		return RTAS_INVALID_PARAMETER;
+	}
+	return 0;
+}
+
+/**
+ * validate_corrupted_page() - Validate parameters for corrupted-page injection
+ * @addr: Physical page address (required, must be non-zero)
+ *
+ * The mask value is not meaningful for this error type and is ignored.
+ *
+ * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
+ */
+static inline int validate_corrupted_page(unsigned long addr)
+{
+	if (!addr) {
+		pr_err("corrupted-page injection requires non-zero addr\n");
+		return RTAS_INVALID_PARAMETER;
+	}
+	return 0;
+}
+
+/**
+ * pseries_eeh_type_to_rtas() - Map a generic EEH error type to its RTAS encoding.
+ * @type: Generic EEH error type (EEH_ERR_TYPE_*)
+ *
+ * Translates a userspace-visible generic EEH error type to the corresponding
+ * PAPR RTAS firmware type code.  Every supported value appears as an explicit
+ * case; coincidental equality between generic EEH and RTAS values is not relied
+ * upon.
+ *
+ * Return: RTAS_ERR_TYPE_* value on success, -EINVAL for unsupported types.
+ */
+static int pseries_eeh_type_to_rtas(int type)
+{
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
+	case EEH_ERR_TYPE_64:
+		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
+	case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+		return RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT;
+	case EEH_ERR_TYPE_CORRUPTED_PAGE:
+		return RTAS_ERR_TYPE_CORRUPTED_PAGE;
+	case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
+		return RTAS_ERR_TYPE_CORRUPTED_DCACHE_START;
+	case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
+		return RTAS_ERR_TYPE_CORRUPTED_DCACHE_END;
+	case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
+		return RTAS_ERR_TYPE_CORRUPTED_ICACHE_START;
+	case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
+		return RTAS_ERR_TYPE_CORRUPTED_ICACHE_END;
+	case EEH_ERR_TYPE_CORRUPTED_TLB_START:
+		return RTAS_ERR_TYPE_CORRUPTED_TLB_START;
+	case EEH_ERR_TYPE_CORRUPTED_TLB_END:
+		return RTAS_ERR_TYPE_CORRUPTED_TLB_END;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
+ * @buf: RTAS error-injection work buffer (kernel virtual address)
+ * @pe: EEH PE associated with the injection target
+ * @rtas_type: PAPR firmware error-injection type after generic EEH-to-RTAS
+ *             translation (RTAS_ERR_TYPE_*)
+ * @func: Error function selector
+ * @addr: Target address, if applicable
+ * @mask: Address mask, if applicable
+ *
+ * Zeroes @buf and populates it according to the PAPR layout for @rtas_type.
+ * Performs inline parameter validation for each error type.
+ *
+ * Locking: Caller must hold rtas_errinjct_mutex.
+ *
+ * Return: 0 on success, RTAS_INVALID_PARAMETER on invalid input.
+ */
+static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
+				   int rtas_type, int func,
+				   unsigned long addr, unsigned long mask)
+{
+	__be64 *buf64 = (__be64 *)buf;
+	__be32 *buf32 = (__be32 *)buf;
+
+	memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
+
+	switch (rtas_type) {
+	case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+		/* func: 1 = non-persistent, 2 = persistent */
+		if (func < 1 || func > 2)
+			return RTAS_INVALID_PARAMETER;
+		if (validate_special_event(addr, mask))
+			return RTAS_INVALID_PARAMETER;
+		buf32[0] = cpu_to_be32(func);
+		break;
+
+	case RTAS_ERR_TYPE_CORRUPTED_PAGE:
+		if (validate_corrupted_page(addr))
+			return RTAS_INVALID_PARAMETER;
+		buf32[0] = cpu_to_be32(upper_32_bits(addr));
+		buf32[1] = cpu_to_be32(lower_32_bits(addr));
+		break;
+
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+		if (func < EEH_ERR_FUNC_LD_MEM_ADDR || func > EEH_ERR_FUNC_MAX)
+			return RTAS_INVALID_PARAMETER;
+		if (upper_32_bits(addr) || upper_32_bits(mask)) {
+			pr_err("32-bit IOA injection cannot encode addr=%#lx mask=%#lx\n",
+			       addr, mask);
+			return RTAS_INVALID_PARAMETER;
+		}
+		if (validate_addr_mask_in_pe(pe, addr, mask))
+			return RTAS_INVALID_PARAMETER;
+		buf32[0] = cpu_to_be32((u32)addr);
+		buf32[1] = cpu_to_be32((u32)mask);
+		buf32[2] = cpu_to_be32(pe->addr);
+		buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[5] = cpu_to_be32(func);
+		break;
+
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+		if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
+			return RTAS_INVALID_PARAMETER;
+		if (validate_addr_mask_in_pe(pe, addr, mask))
+			return RTAS_INVALID_PARAMETER;
+		buf64[0] = cpu_to_be64(addr);
+		buf64[1] = cpu_to_be64(mask);
+		buf32[4] = cpu_to_be32(pe->addr);
+		buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[7] = cpu_to_be32(func);
+		break;
+
+	case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
+	case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
+	case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
+	case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
+		buf32[0] = cpu_to_be32(lower_32_bits(addr));
+		buf32[1] = cpu_to_be32(lower_32_bits(mask));
+		break;
+
+	case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
+	case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
+		buf32[0] = cpu_to_be32(lower_32_bits(addr));
+		break;
+
+	default:
+		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_type);
+		return RTAS_INVALID_PARAMETER;
+	}
+
+	pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
+		 rtas_type, func, addr, mask);
+	return 0;
+}
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
-- 
2.54.0


