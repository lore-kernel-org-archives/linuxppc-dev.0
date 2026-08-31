Return-Path: <linuxppc-dev+bounces-26227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236BC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 06:55:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYKWV3QR6z2yrT;
	Mon, 31 Aug 2026 16:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788159334;
	cv=none; b=hjjhb+hLyrHADHuHsQ6Qwby++UMwrtF53POeuZkLS7lvQUsIEGP9sqnkiU+/Lgr82NqK/M62slRPmFdkVE2iuKjRQqLprapDFXnGopSf3thEnjNpl4ZqYYRpET7IF5mu+TEWbECGy84peuOY/aynrwp87osB52sPsCl3LntRHUGDZR7Hv5bSCcg7K03x9jIbDZnJSqaeWY5ceUZ1H9lpewH6v9WpvVeuEHQkhZdKz4P6uPTMFu6qa/IfeXUgkmmYP/kAaHG9pS/9GoTBCZotVHBuF1yVWeouLmOkXVc/53uatkf98W2ISwuPDMBJbTzfoqBAbGQW1745PXv9TnPwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788159334; c=relaxed/relaxed;
	bh=K+tCg1Ihtp2CZ9JdHdrN44tNBNWv8aRbyPfZlCyAR+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLKD0ZtABA7XBES95z1DbKAaHQC9ongZmqs877EYb4shS9mbIng3LUjPnnvdaabC2QnLhQJRk4zG8mgeEe+Jca9GMeK0BG2WS5DCqayS457pVtyH/qaHbd80a58hm6cXw1ICc+2PzlbAJn0QPR8YHxLvyKSADOiHe21RJiMTDbwGG/mXhyTxk2E7R1wn+sGm4zvnKJ9XU77dufmLrT3DOY1sbPcbWOU/vIm0evQxZM7UOD5f/XLQ9Ot/o3X4YdlhlOV/DLyklNadNUCTnbi+THDoiRfVUxb6etQKNjeU8XjfuEZeGUp6krKOGHOby1bFkzn4GqmqLDprm+OPWrPspg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FwtUVF/R; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FwtUVF/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYKWS6mR7z2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 16:55:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V53IOu145224;
	Mon, 31 Aug 2026 06:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K+tCg1Ihtp2CZ9JdH
	drN44tNBNWv8aRbyPfZlCyAR+Y=; b=FwtUVF/RETE3YNyZkB4HHrhKk16jgzePj
	d7h6OCEXYqXISXi4CZF0e57jOS/Xr5ioNcvNViNjIF/QMVG/ufHSk2jvm6d1/Acc
	fhxN/8pFqlHn+g6b50B1QU/pdCcVVVlPb6KCbr1LH6DAt/6iinTL6yFpmRwdhcO6
	+Z0Vlyh4QGIsSrwWJ0bmjFohyHMgLE6vbJDk/LO1v3ykhHIc/KuMnTzizSi/2AaM
	rb7MMDNnd2iLOR2ukmme97l3TKk2AutQuqn7xb+sxGADE0gPgo9Gd1Xwgsvl6F8l
	Li5hL/sdaF2J298cDaG4WPtcJsEj5RsRt25LcJDY7fHpZFiJvcieQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudfnq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:55:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V6fSxu020685;
	Mon, 31 Aug 2026 06:55:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h4c4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:55:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V6tG6S50004294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 06:55:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95AF82004B;
	Mon, 31 Aug 2026 06:55:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D9C020040;
	Mon, 31 Aug 2026 06:55:14 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 06:55:13 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, oohall@gmail.com, npiggin@gmail.com,
        tpearson@raptorengineering.com, alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, sourabhjain@linux.ibm.com, harshpb@linux.ibm.com
Subject: [PATCH v4 4/5] powerpc/pseries/eeh: Implement RTAS-based EEH error injection
Date: Mon, 31 Aug 2026 12:24:40 +0530
Message-ID: <20260831065441.48654-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-GUID: 8fsXHVvwz0R7OU9bBplf0on_lRZoGeCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NCBTYWx0ZWRfXxKvfAdCPPALY
 zO56/RDLHVTmTn4u0NxTAsNDyeG51AvxaxsUhljHXXusQUiKIUSQlRFhjrD9mUuqhGYj/CXNQHM
 uUIk/320MMbC5oKnbwfFtNxlSO9z9PsrGyMGGa/vKUyFAvDjUsz1dVhytUpH81W4/rGRCyrOBmj
 UVRyNYgFbLIEk7kNupsqFgwuPGgCWJHfiu85FDkz4Gjc3TFLoN7RYfESb6F3auzdClM2msuky16
 VX7efLzQk/dN5JtVMyxyTVT2z+zrqWX24WviczrA4cw9UX/h8GQf7VszayYmtvs8qw8XOtCDO4f
 ZQ/rZH27rXVFMgYs5hAdmtITdiyQbagGhY7Aqdg4PvODxRm9hl5RkRvmieXMd83cMEEGNsvPBzj
 m/GpB8YHoxXCdx0XPsLNpxMYGe/EtZYfwTtkzXtnPKiJU3D5Z9zVvbkA8GwgyyqdXBR+D+O194M
 MUOP3Tz1HRvi2uK/cVg==
X-Proofpoint-ORIG-GUID: be8-u1EQp_zjVMO8UPQpQZwhQOy62b67
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NCBTYWx0ZWRfX6zoRhm8IH/gm
 wGbFTganpedM7cfQUKIfNpTBawIU9Zy+EAZFlo4kG7/U8AHGnTk12JQdgibDGZhORGLti/Y2rQC
 Hxcky4qQueeDXnaiXeKl17A+XhBrej8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a952559 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-ONQtpLVr4F4_6mk-BEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310054

Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
PAPR-compliant RTAS error injection path using the existing RTAS
work-area allocator.

The mutex is not a buffer lock; it serializes the firmware session
open/inject/close sequence as required by PAPR.  No global buffer
is allocated or used.

VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
the generic EEH error types to RTAS ibm,errinjct encodings via
pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
unchanged; their values are defined in arch/powerpc/include/uapi/asm/eeh.h
and are not renumbered.

Tested with corresponding QEMU patches:
https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 123 ++++++++++++++-----
 1 file changed, 95 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index fafe0004e738..fcb8c560d813 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -25,6 +25,7 @@
 #include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/crash_dump.h>
 
@@ -34,6 +35,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
+#include <asm/rtas-work-area.h>
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -958,8 +960,6 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
 			return -EINVAL;
 
 		if (upper_32_bits(addr) || upper_32_bits(mask)) {
-			pr_err("32-bit IOA injection cannot encode addr=%#lx mask=%#lx\n",
-			       addr, mask);
 			return -EINVAL;
 		}
 
@@ -992,50 +992,117 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
 		break;
 
 	default:
-		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_type);
+		pr_err("unsupported RTAS error injection type 0x%x\n",
+		       rtas_type);
 		return -EINVAL;
 	}
 
-	pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
-		 rtas_type, func, addr, mask);
 	return 0;
 }
 
+/* pseries-local mutex serializes the open/inject/close RTAS session */
+static DEFINE_MUTEX(pseries_errinjct_mutex);
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
+ * A short-lived RTAS work area is allocated per call; no global buffer
+ * is used.  pseries_errinjct_mutex serializes the open/inject/close
+ * session sequence.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
 static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
+	struct rtas_work_area *area;
+	phys_addr_t area_phys;
+	u32 buf_phys;
+	void *buf;
+	int open_token, errinjct_token, close_token;
+	int session_token;
+	int rtas_type;
+	int close_rc;
+	int rc;
+
+	rc = validate_errinjct_args(pe, type, func, addr, mask);
+	if (rc)
+		return rc;
 
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
+	rtas_type = pseries_eeh_type_to_rtas(type);
+	if (rtas_type < 0)
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
+	open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
+	close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
+
+	if (open_token    == RTAS_UNKNOWN_SERVICE ||
+	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
+	    close_token   == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
+	buf  = rtas_work_area_raw_buf(area);
+	area_phys = rtas_work_area_phys(area);
+
+	if (WARN_ON_ONCE(upper_32_bits(area_phys))) {
+		rc = -ERANGE;
+		goto out_free_area;
 	}
 
-	return 0;
+	buf_phys = lower_32_bits(area_phys);
+
+	rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
+	if (rc)
+		goto out_free_area;
+
+	mutex_lock(&pseries_errinjct_mutex);
+
+	do {
+		rc = rtas_call(open_token, 0, 2, &session_token);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+		goto out_unlock;
+	}
+
+	do {
+		rc = rtas_call(errinjct_token, 3, 1, NULL,
+			       rtas_type, session_token, buf_phys);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+	}
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
+	mutex_unlock(&pseries_errinjct_mutex);
+
+out_free_area:
+	rtas_work_area_free(area);
+	return rc;
 }
 
 static struct eeh_ops pseries_eeh_ops = {
-- 
2.51.1


