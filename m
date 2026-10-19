Return-Path: <linuxppc-dev+bounces-29698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E38CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wjx4vYsz30PJ;
	Mon, 19 Oct 2026 21:19:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405157;
	cv=none; b=ldY/2u72zhrpWmyQfCrYHHYGE4SDhVIqINbTZsCgg1WYdBa2e7KbmWlYY8Dq14HLmsLZv7BoKE/vWiOSqBzQxaAjdNWKcezxfctDs1JkoL8oIWMUQJpgE0aJ6+cCgJC2FC6oePf1Xd60P2x1cVhfEKLgPtVxfxGUfpuuitT/QFfyfdHUXT7FwIXqds2U0etp9bSzuHNYVwTZm2bFfkVm1Pf60Q+unNhAzZ1B7ZyA5GJ90Fs3/zV9h+Ee/WefbHZZwLGHZESnVsHfE/VhRsTlkw11HmJyQUqFvB1/z8S09ggHCgHVxtHfVH2QRT5LxFqshpcYHC604Xv8QLXW/T9cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405157; c=relaxed/relaxed;
	bh=LYOdpVEC0izHFA83jZHUvAEP7bEsslT2ZePrzH2r214=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDccFg07W9uRJVvP4bySKctVKthvI6HCyOpvaMCZrpziJYfNaFfNW5jAcnRAcj7ochwHH/PDh+Zu1swwlpRb/DTlwhAmMYVJwujO0GKT5sLNMcbKdDJJuTxKIAGndpfOciD1CMeeWm+IELBreeyEQJ3ZvkP6tl4z4cUbwJac0lTkjz9ddljCYZOEBf5kTpLmOtbgFQFwUVGjSo06e1/cj2LqjphvS+8PWHxnp0GMxRu77UheiCMWSkMDXm6dp7d3MviXQ+RTUvwW+bUPmM2SIUE/sBGTP7z/2gIpAQGom6CUo+ekKQQboNhsUByK38ZFWKwjg+Ec2HxCoXON9hyhkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AA+2yoP3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AA+2yoP3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wjw5qqRz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:19:16 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iJwA3250808;
	Mon, 19 Oct 2026 10:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LYOdpVEC0izHFA83j
	ZHUvAEP7bEsslT2ZePrzH2r214=; b=AA+2yoP3Xt4FnDx/UZYFRvoSiPhiQfYpz
	BiG3HNZzrF4Fnrmc9uV25wAc6vhSeJSjWrnCdfk7rRR0owcQSjzvJ59eXjbCXFjy
	MmJiUHUqNXOKjARRzogedlt+SHvdGYxr4i5fUtbgIXjIHKWbLsqRmozF82RrUK99
	fbMgmY0osy99EG5FnkZiI5tuGBq9UxYoLnKqkY6lZc8nFpIF/+9g1UtlhQd/BwSz
	Qan+AdUmk1ebjeY5ja+zAQC/juthvZMes1vcsOHwwJ4CrU/zZfQwUWxmewwSejaC
	kBei0Qfq8XogTffYAoQSZcPZdF8OPDM+b/tZkHf1C0gnWJLUf9hnA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxeht4h0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YuRR2651397;
	Mon, 19 Oct 2026 10:19:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgw1w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAJ1pk48038304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:19:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F482005A;
	Mon, 19 Oct 2026 10:19:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 920BF2004D;
	Mon, 19 Oct 2026 10:18:57 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:18:57 +0000 (GMT)
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
Subject: [PATCH v5 3/5] powerpc/pseries/eeh: Implement RTAS-based EEH error injection
Date: Mon, 19 Oct 2026 15:48:11 +0530
Message-ID: <20261019101813.45085-4-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX13FAXfgYiaoz
 AxSfWyDSdWkEdmLb7ZKD8QTTcp75zsLokXvdiRY1fVUliaCFA8gsdzrxi7wXQDAiYAXdMKq56Yb
 uZ+F9MiwkhhCf6Gpu+lhk+Dsr3DVRH55BIqq+qwxkDzsuxfqQaFD2bQdXV+EJ6YX/KAt7FyE5xl
 RfhNuuNB8bj06BthHznQNIv1qa5h1Cg/IJ3tqeEzC4stA4/NThDSaIr+rXzRCqzpfGcIrdq/juH
 uAPqdKXpt/vRurr1orTY+0tlPBPuwxaSw7T94FXzjdIJaAi3QmygWEO9UPfBSjg+2l138WONXdU
 MyD7xyt83MGj754iBUG93JryFYcesMgcJZwaH9pTaPvuXqE6ACjg1cBlFJBmPAg0UAu7BI/Nc/E
 7hwLwlyAm0lDYQJkrnVeZPpY2E3W1KyMYeJA5pmijk2p4pposPGFsTj9I99vsKvcFcJGZmdvfsn
 pI8FhHmZFh3gV5ejT+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX/D+XiF0d2VAd
 g1lpl97Je0EpufG6YwXsZSVNDxIEG46DpYcuTC7y+fAjcJEmFOKVhpvQRLjKsjq9DKU4Mf6Y8YU
 N/OeJEBo2xySk4EImg2d+6WfdjeofYE=
X-Proofpoint-GUID: NGTSjjIvyhMK1itwEZmU1EsFwvspNKyu
X-Proofpoint-ORIG-GUID: 12im-ohpbBP--KLqTP8wzrxrZ-tVHAPD
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad5ee9a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bPTTwr8VSQXA1ycvqXoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
PAPR-compliant RTAS error injection path.

Serialize each ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
session with errinjct_mutex because RTAS maintains state between these
calls.

Once ibm,open-errinjct succeeds, ibm,close-errinjct is attempted
after parameter preparation or ibm,errinjct failures.  The RTAS work
area is allocated after a successful open to avoid holding it while
waiting for the mutex or if open fails.

VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
the generic EEH error types to RTAS ibm,errinjct encodings via
pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
unchanged; their values are defined in arch/powerpc/include/uapi/asm/eeh.h
and are not renumbered.

The RTAS work-area allocator guarantees that returned memory is within
the range accessible by RTAS (below min(ppc64_rma_size,
RTAS_INSTANTIATE_MAX), which is at most RTAS_INSTANTIATE_MAX = 1 GiB),
so the physical address fits in the 32-bit RTAS argument without
truncation.

Remove the now-unused eeh_pe_inject_mmio_error() helper and its
declaration; this patch removes its only caller.

Tested with corresponding QEMU patches:
https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   2 -
 arch/powerpc/kernel/eeh.c                    |   5 -
 arch/powerpc/platforms/pseries/eeh_pseries.c | 114 +++++++++++++++----
 3 files changed, 91 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b7ebb4ac2c71..083ac58e7eb7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -310,8 +310,6 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
 int eeh_pe_configure(struct eeh_pe *pe);
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 		      unsigned long addr, unsigned long mask);
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
-
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..369aad298f75 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1664,11 +1664,6 @@ static int eeh_break_device(struct pci_dev *pdev)
 	return 0;
 }
 
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
-{
-	return eeh_break_device(pdev);
-}
-
 #ifdef CONFIG_DEBUG_FS
 
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 999b3065e09b..52d001042663 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -24,6 +24,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/sched.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
@@ -35,6 +36,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
+#include <asm/rtas-work-area.h>
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -1006,41 +1008,107 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
 	return 0;
 }
 
+/* Serializes the open/inject/close RTAS error injection session */
+static DEFINE_MUTEX(errinjct_mutex);
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
- * @type: error type
- * @func: specific error type
- * @addr: address
- * @mask: address mask
- * The routine is called to inject specified error, which is
- * determined by @type and @func, to the indicated PE
+ * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
+ * @func: specific error function
+ * @addr: address argument (type-dependent, may be zero)
+ * @mask: address mask (type-dependent, may be zero)
+ *
+ * Implements PAPR-compliant error injection using:
+ *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
+ *
+ * errinjct_mutex serializes the open/inject/close session sequence
+ * because RTAS maintains state between these calls.  A short-lived
+ * RTAS work area is allocated after a successful open and freed before
+ * close.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
 static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
+	struct rtas_work_area *area;
+	phys_addr_t area_phys;
+	void *buf;
+	int open_token, errinjct_token, close_token;
+	int session_token;
+	int rtas_err_type;
+	int close_rc;
+	int rc;
+
+	rc = validate_errinjct_args(pe, type, func, addr, mask);
+	if (rc)
+		return rc;
 
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
+	rtas_err_type = pseries_eeh_type_to_rtas(type);
+	if (rtas_err_type < 0)
 		return -EINVAL;
 
-	switch (func) {
-	case EEH_ERR_FUNC_LD_MEM_ADDR:
-	case EEH_ERR_FUNC_LD_MEM_DATA:
-	case EEH_ERR_FUNC_ST_MEM_ADDR:
-	case EEH_ERR_FUNC_ST_MEM_DATA:
-		/* injects a MMIO error for all pdev's belonging to PE */
-		pci_lock_rescan_remove();
-		list_for_each_entry(pdev, &pe->edevs, entry)
-			eeh_pe_inject_mmio_error(pdev->pdev);
-		pci_unlock_rescan_remove();
-		break;
-	default:
-		return -ERANGE;
+	open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
+	close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
+
+	if (open_token == RTAS_UNKNOWN_SERVICE ||
+	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
+	    close_token == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	mutex_lock(&errinjct_mutex);
+
+	do {
+		rc = rtas_call(open_token, 0, 2, &session_token);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+		goto out_unlock;
 	}
 
-	return 0;
+	area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
+	buf = rtas_work_area_raw_buf(area);
+	area_phys = rtas_work_area_phys(area);
+
+	rc = prepare_errinjct_buffer(buf, pe, rtas_err_type, func, addr, mask);
+	if (rc)
+		goto out_free_area;
+
+	/*
+	 * RTAS work areas are allocated below RTAS_INSTANTIATE_MAX, so
+	 * area_phys fits in the 32-bit RTAS argument.
+	 */
+	do {
+		rc = rtas_call(errinjct_token, 3, 1, NULL,
+			       rtas_err_type, session_token,
+			       (u32)area_phys);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+	}
+
+out_free_area:
+	rtas_work_area_free(area);
+
+	do {
+		close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
+	} while (rtas_busy_delay(close_rc));
+
+	if (close_rc) {
+		pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
+		if (!rc)
+			rc = rtas_error_rc(close_rc);
+	}
+
+out_unlock:
+	mutex_unlock(&errinjct_mutex);
+	return rc;
 }
 
 static struct eeh_ops pseries_eeh_ops = {
-- 
2.54.0


