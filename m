Return-Path: <linuxppc-dev+bounces-24576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F3EC4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435v1wxKz2yT0;
	Tue, 21 Jul 2026 13:39:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605155;
	cv=none; b=erSWQztKmrBWIjS6bUkCk9dFgnEgaCf6AWBNDp2fzdRwl3/FfXlRpBN0+lpfT+xb/FvNqUYykLAOEDZFhVO7/WLdnB7OMzOgdKHERVuKly/Q9CTETeUmKWU3WplsK24qbjCHdFgTPo7cTyXYhNP8flHWpURNLYWIAtP2K34ff5MAef0D9VQrCJoqMh1GUnexmZ/KSYcfljKm2izKmbe//nOhWbIFP6XYNzajKdwCFrgC+b2HsLlAjkhKtokdduXAZ/BkYrDfkwqHJi3Y5Q5Jb6nN56HO3Y5T6N1ejq+xdp5UfBBFsFCeGfpeVdA0Qa0iUkFucQ9cVs8xgQVPojwvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605155; c=relaxed/relaxed;
	bh=M+ArTTK3rRQq8hGmDiq2UKONODHvGtnmzeY3btjlVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3JNgMBg128/Tfkeoyd7g5lxDTYwr72sB3jClYgxppGLekBxOXoMk2DQ4bHrgLRNbS7TxkEdsTrcMl4wCAFmeFQqHxi2DxPKvHZCRzfSw3ZeWji3rnnx9x4RPIrCX1X267cAn7lJ2JEyTNYx98g3ljA5N4k4sJj9/RmU4Enpkvm2U1xFV0VP3btGhXQ4k8uNub4hXmK6uZ7AyYfbVmbQ26CA+ZKBvEXyUpATg4o+XaXs6Yuus4xgskLHFCyYXJI3MbUnX+jZmIWATz20BpKqp6rc0mpVdtjfwztlv1KcQfvgvi6QO0dBq38mLADjRZD6OMoJ1ZbHZvarcvGlMsM2jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cw3S9R5K; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cw3S9R5K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435t3Mnsz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:39:14 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCsEj3553374;
	Tue, 21 Jul 2026 03:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M+ArTTK3rRQq8hGmD
	iq2UKONODHvGtnmzeY3btjlVuI=; b=cw3S9R5Kt/Ni6vCqMKdWHLOwdYOhqHoF8
	JON10OmKepUuqVNSsv2n5RL/5zn0kWapBdFqogdb6h99WO/m/DTdz8Y5LL5+0Pqx
	De76DIRJbOtqb/as1hC9ezFG/MJLM02KOGqMZGinVwA0ntmsnULfBmPCExM32Qa8
	lp+tH34gjyMnTyPnpjPFSGmTrqRpw+/D87+21LHT3/zw6rJS01QvvMyMDQtISKgY
	uiECVtkQGoiJFNwAO9TJX7l1B+8Xuk2Vs9R2rK661DBGZ1iOug9vixpaL05DdzlN
	L91CpRf08fAA/0avggtH7dEW5iatRyeBqlAqy+nilH3DBxeEzFEag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abaph1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:39:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3Ygab024866;
	Tue, 21 Jul 2026 03:38:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjrj8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3crWg51773794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1615820043;
	Tue, 21 Jul 2026 03:38:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B751E20040;
	Tue, 21 Jul 2026 03:38:48 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:48 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 4/5] powerpc/pseries/eeh: Implement RTAS-based EEH error injection
Date: Tue, 21 Jul 2026 09:08:04 +0530
Message-ID: <20260721033815.5300-5-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXyYJKLi8cyWiX
 BU5AjOYah565M7/wrNM1cumNii7FB9KvZ1J/1Dbubpoj3jPalgxHP/VrQXCGYlnHtwuNNZQNbZt
 2pbBpx07+VkTE+fv3OvDta0cIe+o/xlLTMr+c/ue3DisClN/25gwVtJA1sd4GQzzpPYfGgWAjbo
 NRsCDAXfMka8lApJgsO2gd8UxyyUps0wgPUkv5e6g9CcI3dk4JBP8uonDAIdtvLOuDeVi9A9UMW
 wkPToVzKpfILzmlhjK9z99l07TkYizW8KGPF3q/NoqDknttZAmda1wd/F5OlaEEa23b2EGLuqG3
 WwffF5cWzOeF33Lip/bg5/FZ6ScZmR3kFR6p25k92bfOzH2D3KMkOSsYnvqPK1Zz6jDXQnOGXU2
 QB8g/l5hBm44KdIXr2q5hjeGOZyI5vLrHEaUyzROvvrg6xeMkjtDfWJeDP9IX+L3tkiy+Opbs89
 UFspfAvxqXNiWyaJFAg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5ee9d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YebC9Fa3sO9M_NWgr1QA:9
X-Proofpoint-ORIG-GUID: eRRAsaCgx9EtwqYigp9i_cazDhonYEZu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfXxxkkzS1o/WRc
 eiH9fX9VgVbNHXwKr1Y+HS96VLdkweHzgA7kx30ulfqcxAC18QPsqk3MzOIOjQDeMqi24Iuir29
 kDVMlDZwo093KxgNcQUUvknXowjRxUE=
X-Proofpoint-GUID: spDIAL4xHVg28RlAt5mnn85tueNZtKMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210030

Replace legacy MMIO error injection with full PAPR-compliant RTAS error
injection supporting 14+ error types via
  - ibm,open-errinjct
  - ibm,errinjct
  - ibm,close-errinjct.

Key features:
  - Complete open-session-inject-close cycle management
  - Special handling for ibm,open-errinjct output format (token,status)
  - Comprehensive buffer preparation per PAPR layouts
  - All pr_* logging uses pr_fmt("EEH: ") prefix

Tested with corresponding QEMU patches:
https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 121 +++++++++++++++----
 1 file changed, 95 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 25aad86c696d..d32a84009fdc 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -1037,40 +1037,109 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
 }
 
 /**
- * pseries_eeh_err_inject - Inject specified error to the indicated PE
- * @pe: the indicated PE
- * @type: error type
- * @func: specific error type
- * @addr: address
- * @mask: address mask
- * The routine is called to inject specified error, which is
- * determined by @type and @func, to the indicated PE
+ * pseries_eeh_err_inject - Inject specified error into the indicated PE
+ * @pe:   the indicated PE
+ * @type: generic EEH error type (EEH_ERR_TYPE_*)
+ * @func: error function selector (EEH_ERR_FUNC_*)
+ * @addr: target address, if applicable
+ * @mask: address mask, if applicable
+ *
+ * Implements the EEH error-injection callback for pseries using the RTAS
+ * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct firmware services.
+ *
+ * Generic EEH error types are translated to RTAS firmware type codes via
+ * pseries_eeh_type_to_rtas() before the injection session is opened.
+ * Unsupported generic types are rejected with -EINVAL before any RTAS call
+ * is made.  Existing userspace is unaffected.
+ *
+ * Return: 0 on success, negative errno or RTAS error code on failure.
  */
 static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
-
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
-		return -EINVAL;
+	int open_token, errinjct_token, close_token;
+	int session_token = 0;
+	bool session_open = false;
+	void *buf;
+	u32 buf_phys;
+	int rc;
+	int rtas_type;
 
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
+	/* Guard: buffer must fit in 32 bits for RTAS */
+	if (WARN_ON_ONCE(upper_32_bits(rtas_errinjct_buf)))
 		return -ERANGE;
+
+	/* Map generic EEH ABI to RTAS-internal error type */
+	rtas_type = pseries_eeh_type_to_rtas(type);
+	if (rtas_type < 0) {
+		pr_err("unsupported EEH error type %#x\n", type);
+		return rtas_type;
 	}
 
-	return 0;
+	/* Verify all three RTAS tokens are available before touching firmware */
+	open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
+	close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
+
+	if (open_token    == RTAS_UNKNOWN_SERVICE ||
+	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
+	    close_token   == RTAS_UNKNOWN_SERVICE) {
+		pr_err("ibm,open/errinjct/close-errinjct not available\n");
+		return -ENODEV;
+	}
+
+	buf      = __va(rtas_errinjct_buf);
+	buf_phys = lower_32_bits(rtas_errinjct_buf);
+
+	mutex_lock(&rtas_errinjct_mutex);
+
+	/* Step 1: open injection session */
+	do {
+		rc = rtas_call(open_token, 0, 2, &session_token);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
+		goto out_unlock;
+	}
+	session_open = true;
+
+	/* Step 2: prepare the work buffer */
+	rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
+	if (rc) {
+		pr_err("failed to prepare errinjct buffer: rc=%d\n", rc);
+		goto out_close;
+	}
+
+	/* Step 3: inject the error */
+	do {
+		rc = rtas_call(errinjct_token, 3, 1, NULL,
+			       rtas_type, session_token, buf_phys);
+	} while (rtas_busy_delay(rc));
+
+	if (rc)
+		pr_err("ibm,errinjct failed: status=%d\n", rc);
+
+out_close:
+	/* Step 4: always close the session */
+	{
+		int close_rc;
+
+		if (session_open) {
+			do {
+				close_rc = rtas_call(close_token, 1, 1, NULL,
+						     session_token);
+			} while (rtas_busy_delay(close_rc));
+
+			if (close_rc)
+				pr_warn("ibm,close-errinjct failed: status=%d\n",
+					close_rc);
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&rtas_errinjct_mutex);
+	return rc;
 }
 
 static struct eeh_ops pseries_eeh_ops = {
-- 
2.54.0


