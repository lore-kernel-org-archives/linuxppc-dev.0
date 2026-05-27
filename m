Return-Path: <linuxppc-dev+bounces-21557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8CECD5BDE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:26:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLlM5bcDz2xKh;
	Wed, 27 May 2026 17:26:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779866783;
	cv=none; b=GEmZQ55ceLpfm7tWT27/FDWA9sjY4RvevosLpFvzDsriJk1VM0qkP/2nnGU2WDhOVjlsofnEw3KUDIdDN1EP8sCxjuXIr7x0Pj3rwgpyioKnf25guZ0uRoB5m7Xbs6N+iiq71+WRFmqfBNIz5aaePm2HxPirYW5GzsS92mvoNz/4pbRrNyhMVTqIVkD9EPC4XZ04uq/0xunHadYzsEHw5zi4kkFdMx/hkMEwTxCuDvBIB7UdIDNEJ39KDIiDJ4Ues9+e7hyZlUFkJoF9Z92PWZQ1BWiQOfaT4TDc6QccW7E9npJBxNiL0TGUj51lRWxxRfnztlIspWartkBaITVCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779866783; c=relaxed/relaxed;
	bh=YARufalEVjRqn6s9Loc6JrLF5lN0Q95LYFgAFB9iPVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giHBLnipPZO8zbfWK07WW2MLOH4PJG57QFii9qXBM9FZfFBhQEOxElEMb69nJ87N+c9vJGt+kX6qghIBWsDDuBOJsbVp+sqdPHGGuDCCo0EegmGcQeGwUyOkUrY2gNvnP6LHeaCSDAItCDZCXOE26x3GzQW6prPz5mSSL6oTXcsMpf961xUDouB/eVmTe2Pb6sbu7YOumOBN0iCUukgT8+K+Uz51+kdSVyODPG47UG51lE5MlGQ4R9GP8I5suPFuP1OQCwqROn+D9cNSXZvMEaogtLonZkRH48QH9+LOlHut7euwhLqpgRJb3bR4bzK6JrYzp+EvJjImdcr6onbNHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JXIwFmmW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JXIwFmmW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLlL6TBSz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:26:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4v3S3811228;
	Wed, 27 May 2026 07:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YARufalEVjRqn6s9L
	oc6JrLF5lN0Q95LYFgAFB9iPVc=; b=JXIwFmmWkPzO0Y5BJsrGVt+O3Pw32Qfqw
	MwdZCLkI+KAmqGJo3kdxUMX1d12rqJhap9dw7SEFtEkBPvfGgyc1gXEqL6DscXa2
	vG3gxujsw2GhxCZMvjaHO+b5d8J1NNvjg9FkFOkMbC8zJ5BN0cLg0qjRCW5rztzc
	pFezcC4f9DsuWQsnd+ZrCMl4R14aHE6Jds4Ya+Y8ZG9IgpZm9ggGi0+P4Keoh1I0
	h684xNAAiwoOXXjEWcQflaBd3lEeoIxBtI1QR0h/fhldjlCEDlPRf4yzabiiNmr0
	vqLyOKSYEos/ApErXWlArYyOLXhf/12IJksh4sqZvwrsw+Zxdod7Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc03h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7O4wd025645;
	Wed, 27 May 2026 07:26:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1wd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R7Q6q253477740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:26:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F34CD20043;
	Wed, 27 May 2026 07:26:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80D12005A;
	Wed, 27 May 2026 07:26:02 +0000 (GMT)
Received: from dhcp-9-123-0-29.bl1-in.ibm.com (unknown [9.123.0.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:26:02 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2 4/5] powerpc/pseries: Implement RTAS error injection via pseries_eeh_err_inject
Date: Wed, 27 May 2026 12:54:32 +0530
Message-ID: <20260527072433.94510-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2NyBTYWx0ZWRfX99B63D8VrcSM
 41ewJ/8vADhTkmhF7CdHzZt+vH/MLYAYo/pqj+KYBYEWwYVRFxiEucTQjUFDixBnTVu7ddsrHLj
 vC2RJ4YMMZUlLZJS1HsGjIGsJpyKFwhlHt5wJt4zxaLqMtcn5CIBzDKscrTqhOGtwWuetmcISyv
 1GCElGnGF039wG4/4tbICZ+BKFKpyMevuDdQcbEwEGWx+fmQa6aDbCANdxqQLRbZ88do/E0wdnp
 n2NcHYJ/YLfbHdnjyfjzV4ai9kyXXeyp4jr9QTPbw9m1HI53uky06DN4Y19vsriU7d9YBp4kv/k
 fSAxgsJzUp8FwnTb2YDgKZSWqPeN8THIE5C5xV+0yAc+HEduEu6aEZtJkNgIAz9AwVZGxQwUMJO
 ao6KCIxRbTgPp72wHgNWfur3niUIE4oDs+uFFDTU+sNp/3Qa61cFlNigwU8AwVW47DNy2hoT3O+
 wwvntNv4NnaCRJg0tyg==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a169c94 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yQ1QsqZ-4r5l6USac14A:9
X-Proofpoint-ORIG-GUID: l11vvsLfcwY0IMzOxzIrWrBHcOdAnT3I
X-Proofpoint-GUID: p4AncKl3wjMM99Y6Hcg9-ArBvr0HQji8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270067

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
 arch/powerpc/platforms/pseries/eeh_pseries.c | 168 ++++++++++++++++---
 1 file changed, 147 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index d6f2e0d43b89..6af2a153ec25 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -902,8 +902,7 @@ static int validate_special_event(unsigned long addr, unsigned long mask)
  * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
  */
 
-static int validate_corrupted_page(struct eeh_pe *pe __maybe_unused,
-				   unsigned long addr, unsigned long mask)
+static int validate_corrupted_page(unsigned long addr, unsigned long mask)
 {
 	if (!addr) {
 		pr_err("corrupted-page requires non-zero addr\n");
@@ -978,7 +977,7 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
 		if (addr == 0)
 			return RTAS_INVALID_PARAMETER;
 
-		if (validate_corrupted_page(pe, addr, mask))
+		if (validate_corrupted_page(addr, mask))
 			return RTAS_INVALID_PARAMETER;
 
 		buf32[0] = cpu_to_be32(upper_32_bits(addr));
@@ -1047,6 +1046,97 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
 	return 0;
 }
 
+/**
+ * rtas_open_errinjct_session - Open an RTAS error injection session
+ *
+ * Opens a session with the RTAS ibm,open-errinjct service.
+ *
+ * Return: Positive session token on success, negative error code on failure.
+ */
+static int rtas_open_errinjct_session(void)
+{
+	int open_token, args[2] = {0};
+	int rc, status, session_token = -1;
+
+	open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+	if (open_token == RTAS_UNKNOWN_SERVICE) {
+		pr_err("RTAS: ibm,open-errinjct not available\n");
+		return RTAS_UNKNOWN_SERVICE;
+	}
+
+	/* Call open; original code treated rtas_call return as session token */
+	rc = rtas_call(open_token, 0, 2, args);
+	status = args[1];
+	if (status != 0) {
+		pr_err("RTAS: open-errinjct failed: status=%d args[1]=%d rc=%d\n",
+		       status, args[1], rc);
+		return status ? status : -EIO;
+	}
+
+	session_token = args[0];
+	pr_info("Opened injection session: token=%d\n", session_token);
+	return session_token;
+}
+
+/**
+ * rtas_close_errinjct_session - Close an RTAS error injection session
+ * @session_token: Session token returned from open
+ *
+ * Attempts to close a previously opened error injection session. Best-effort;
+ * logs warnings if close fails or if service is unavailable.
+ */
+
+static void rtas_close_errinjct_session(int session_token)
+{
+	int close_token, args[2] = {0};
+
+	if (session_token <= 0)
+		return;
+
+	close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
+	if (close_token == RTAS_UNKNOWN_SERVICE) {
+		pr_warn("close-errinjct not available\n");
+		return;
+	}
+
+	args[0] = session_token;
+	rtas_call(close_token, 1, 1, args);
+	if (args[0])
+		pr_warn("close-errinjct  args[0]=%d\n", args[0]);
+}
+
+/**
+ * do_errinjct_call - Invoke the RTAS error injection service
+ * @errinjct_token: RTAS token for ibm,errinjct
+ * @type:           RTAS error type
+ * @session_token:  RTAS error injection session token
+ *
+ * Issues the RTAS ibm,errinjct call with the prepared work buffer. Logs errors
+ * on failure.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+
+static int do_errinjct_call(int errinjct_token, int type, int session_token)
+{
+	int rc, status;
+
+	if (errinjct_token == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	/* errinjct takes: type, session_token, workbuf pointer (3 in), returns status */
+	rc = rtas_call(errinjct_token, 3, 1, &status, type, session_token,
+		       rtas_errinjct_buf);
+
+	if (rc || status != 0) {
+		pr_err("RTAS: errinjct failed: rc=%d, status=%d\n", rc, status);
+		return status ? status : -EIO;
+	}
+
+	pr_info("RTAS: errinjct ok: rc=%d, status=%d\n", rc, status);
+	return 0;
+}
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
@@ -1060,30 +1150,66 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
 static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
+	int rc = 0;
+	int session_token = -1;
+	int errinjct_token;
 
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
-		return -EINVAL;
+	/* Validate type */
+	if (!validate_err_type(type)) {
+		pr_err("RTAS: invalid error type 0x%x\n", type);
+		return RTAS_INVALID_PARAMETER;
+	}
+	pr_debug("RTAS: error type 0x%x\n", type);
 
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
+	/* For IOA bus errors we must validate err_func and addr/mask in PE.
+	 * For other types: if addr/mask present we'll still validate BAR range;
+	 * otherwise skip function checks.
+	 */
+	if (type == RTAS_ERR_TYPE_IOA_BUS_ERROR ||
+	    type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64) {
+		/* Validate that addr/mask fall in the PE's BAR ranges */
+		rc = validate_addr_mask_in_pe(pe, addr, mask);
+		if (rc)
+			return rc;
+	} else if (addr || mask) {
+		/* If caller provided addr/mask for a non-IOA type, do a BAR check too */
+		rc = validate_addr_mask_in_pe(pe, addr, mask);
+		if (rc)
+			return rc;
 	}
 
-	return 0;
+	/* Open RTAS session */
+	session_token = rtas_open_errinjct_session();
+	if (session_token < 0)
+		return session_token;
+
+	/* get errinjct token */
+	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
+	if (errinjct_token == RTAS_UNKNOWN_SERVICE) {
+		pr_err("RTAS: ibm,errinjct not available\n");
+		rc = -ENODEV;
+		goto out_close;
+	}
+
+	/* prepare shared buffer while holding lock */
+	spin_lock(&rtas_errinjct_buf_lock);
+	rc = prepare_errinjct_buffer(pe, type, func, addr, mask);
+	if (rc) {
+		spin_unlock(&rtas_errinjct_buf_lock);
+		goto out_close;
+	}
+
+	/* perform the errinjct RTAS call */
+	rc = do_errinjct_call(errinjct_token, type, session_token);
+	spin_unlock(&rtas_errinjct_buf_lock);
+
+out_close:
+	/* always attempt close if we opened a session */
+	rtas_close_errinjct_session(session_token);
+	return rc;
 }
 
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.probe			= pseries_eeh_probe,
-- 
2.54.0


