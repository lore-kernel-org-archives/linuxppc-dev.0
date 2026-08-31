Return-Path: <linuxppc-dev+bounces-26279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A6C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:18:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLW0l99z2yDD;
	Mon, 31 Aug 2026 21:18:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175091;
	cv=none; b=WVhKVnz/lFGEgdo46X62LqzG3WvE8cYTEwL4Ou7OOluSsyNfZCG2GPhrfg4pv4k689JXrXV5nRYUWO9APvIDGAs/hNRYPdQu+BbeKTWrbFIvJcja+03ujFOUV64sbT0GP70rZtVUEOHgfr9j1p4qzF1diBbblDqG2reb2urmdC6Ylyf0TYdZjOhwnO4Ud1LWYZrNPLz98Ez3l52DiaDKGefiOS5u0xMRVsL5RaQlMnTbqAjeYDLuvLaW6X5lmN5/IBxTCzfqALWNbAuQeK2a4W9P9g43oXQnXq7l7/j8lBfeU0PpubWoEgGJSplOxOD/7zIvj00E7e2wJFyOMfYVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175091; c=relaxed/relaxed;
	bh=TLQQZm0vHFSVmBXboFd2RBHeyVJ1jKromlCaPghUta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8dfVMYAfvEP6eM7Of5wYOECk60MklpM4+eS2uSV3v2jmNBTJCsf5q9KFeGb51alGRUWEP68rrilM90g/+q1Tzhvn6n2WO9lGm5Ko8+CK/ipIFLD0rMs8SGQHfaSjIu8zserEITWhxj1vXOT/Y1RUY+PqtVJ0A4LbRdkieJPRjQPLoaD7RmBYBAcWpkOyDZia2/4FSBb4/tW552OVMk1Z/mBB/B9nf/B2hrFAO4VabNoQDBmImF6RoshwyaphZOTnWg6/fQnLNb4xyAADXkmfeY6LeMaR0b0aDOPwjueE6m1yP00E9kne3zQfwwlgAZkJ/A61Tl3mkeO5Ylp63gpOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K4xuwqcx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K4xuwqcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLV2htpz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82B6f3959609;
	Mon, 31 Aug 2026 11:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TLQQZm0vHFSVmBXbo
	Fd2RBHeyVJ1jKromlCaPghUta4=; b=K4xuwqcxGGjn6nMhSrlyBrFRi9FBHYr4J
	lLS2S+HjTfxNEmqWqvrcqx1orCHXG8QAL0X+oTUbQRtBohYMfDLdctbOWmRDQeAg
	HNadMY41X8+rM/0fsPNgFW6Yu2RwH7nrTaugroG4R/puWltaZoCwjpznO0IBBZaY
	G6xWz//bjtLhECBW2JFuLnszB3uPPDWRjPeNziWU4g/c7qsKTSRAxDer9SnVVMDA
	yoilS5P55xQx8jUo/lEI0KdPE2LQC0ERunguP3LQSh293UPlMq1VPG3zzc5CKzPu
	FhE54iHNSg2Uyzlg5vfboN8uIyVK509MhXXqzC4YOX/wwRQVJBEbQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r0u3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDI9x007589;
	Mon, 31 Aug 2026 11:17:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq5pvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBHrOD15860140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:17:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF81320040;
	Mon, 31 Aug 2026 11:17:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2702004D;
	Mon, 31 Aug 2026 11:17:50 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:50 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 03/10] pseries/plpks: improve type consistency and parameter validation
Date: Mon, 31 Aug 2026 16:47:31 +0530
Message-ID: <20260831111738.334857-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9562e6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lkDOvFPUoNuE0DTt1acA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX8hvvMUAuL/Zk
 hX5XbRdsYiifcFiqBd9LV0Z3smdzC56yklbdRDeIm2L+7DSmNhDHL1U56l4kU7/h8qyhzaAD7WS
 Qf3NfFrup9LleR/DcYlpiii1AergkcwNAE8P/A1wtsxIRymn96S7Tj7MRusaM7mfOuQpa7+VOrR
 5qZ1TBxzUa7j1Mf6iOJB//cWnEp6bhDsrH8fpTLV46IxN6gRk47ArnP4WoV42R+meT0JLWoV4cH
 2CM8JOruMP3vIcoiWGX4CxLwh9hkMuq2qWTknKDjShDRUddjUrUqQhyU7WHa0BYgshZ7vENFnsY
 T4NIyoLjkbL4Mrgt18fIH901Gq1afBQIfodNo9oN7NUWKRaCf67sqQL9THsuFymJXr9I6PPaPJi
 qz2pNkY6EDhtqBGNQObJurbmBOv1Zbcdu/Y7DGCy9oI0kTWKBGQAzUlEebP7l2O3xDrZGpGRvfA
 Hlzww2Vd0ISXijkxj7Q==
X-Proofpoint-GUID: HZY2-zbuBSrYHjgR_D_igYlOcwBKPYCk
X-Proofpoint-ORIG-GUID: LblHWECU7VIFdeluzhCpP3vRcbIi4NGQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfXx12cn2rp+aWJ
 006nOBKFhqOp7QJXRSYfDF845W6Ndwgikm5G4VNiNrYb5g1t433AaDyFC3OuMsKoFLlh8zmdfeh
 amNBYV5PKqKhHyWba9guoMQrfcgEgqY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310095

Update plpks_wrap_object() and plpks_unwrap_object() to use u64 length
parameters, matching the underlying hcall data types for consistency.
Update the PKWM consumer, where these interfaces are used, accordingly.

Add explicit casts when copying values from hcall return buffers into
narrower data types. This makes the intended conversion clear and avoids
implicit truncation in PLPKS hcall result handling.

Also validate input pointers in plpks_signed_update_var() and
plpks_read_var() before dereferencing them, addressing missing validation
when reading and updating PLPKS objects.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/include/asm/plpks.h          |  8 ++++----
 arch/powerpc/platforms/pseries/plpks.c    | 22 ++++++++++++++--------
 security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index e87f90e40d4e..8b2ffb27db5a 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -118,11 +118,11 @@ bool plpks_wrapping_is_supported(void);
 
 int plpks_gen_wrapping_key(void);
 
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len);
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len);
 
-int plpks_unwrap_object(u8 **input_buf, u32 input_len,
-			u8 **output_buf, u32 *output_len);
+int plpks_unwrap_object(u8 **input_buf, u64 input_len,
+			u8 **output_buf, u64 *output_len);
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 7bd5c149dd09..45278c5a45c1 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -576,7 +576,7 @@ static int plpks_confirm_object_flushed(struct label *label,
 				 virt_to_phys(auth), virt_to_phys(label),
 				 label->size);
 
-		status = retbuf[0];
+		status = (u8)retbuf[0];
 		if (rc) {
 			timed_out = false;
 			if (rc == H_NOT_FOUND && status == 1)
@@ -637,6 +637,9 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
 	u64 continuetoken = 0;
 	u64 timeout = 0;
 
+	if (!var)
+		return -EINVAL;
+
 	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -822,6 +825,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
+	if (!var)
+		return -EINVAL;
+
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -863,14 +869,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		goto out_copy_policy;
 	}
 
-	if (!var->data || var->datalen > retbuf[0])
-		var->datalen = retbuf[0];
+	if (!var->data || var->datalen > (u16)retbuf[0])
+		var->datalen = (u16)retbuf[0];
 
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
 out_copy_policy:
-	var->policy = retbuf[1];
+	var->policy = (u32)retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
@@ -1015,8 +1021,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len)
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1134,8 +1140,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
-			u32 *output_len)
+int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
+			u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index bf42c6679245..b6b5697426a8 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
 	u8 *input_buf, *output_buf;
-	u32 output_len, input_len;
+	u64 output_len, input_len;
 	int rc;
 
 	options = trusted_options_alloc();
@@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	u8 *input_buf, *output_buf;
-	u32 input_len, output_len;
+	u64 input_len, output_len;
 	int rc;
 
 	input_len = p->blob_len;
-- 
2.52.0


