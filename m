Return-Path: <linuxppc-dev+bounces-26133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2561EC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:24:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVs1K5xZLz2yh4;
	Thu, 27 Aug 2026 16:24:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787811861;
	cv=none; b=Aw/AOW7e1nxPJx6jSF2rCj9OWupW0MYxa7p++3RdeP8lRUeI7vq8LYpJ9pzXittvw5SjPmaWQhZn6rmMebs544n7D8qA5+skzm5UkiUv+l66GzSmSeuZL2AODN9eV+4Ic4Js5ZnX2JrJj8INBlUZD3cRJvNs0A4gbaQhH0aUnrHeVYFQam/hV1zXoCz1efWsWOeYk49SlAuxdpb996Fv6gg5krP2VtZ8g6mGFIpP/v2FGcL+EQFXBmIPmUV3J7iUp0qYSmnj2IzMuvZ+FTJ8eJfQcxvn/I7GaaxyZevLdtsO6pH63Tt0pv9UzSNeBEDcnqgc1cfej7V/qHXlagjbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787811861; c=relaxed/relaxed;
	bh=1La7cD0eYNIXwOypee2b6JhRgxYPQoqE00wTeUx+ofI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJcbtMMDBF5D56Tf/JiC2QLBWeLrMdLiSmnu/1UbQKkANqKd+/epyUiRA6fhMY/RuiOwYxq8aQ2LXA4MexOwM2rcHkn4bZFwlFm5o6mdxnKGxBBDRQJgV/mknT1wDDQICtmJBsn2uN64sW69SCwruF1Z6p3cuHr0awXWM/ybfBF8V4zNs/IH7OP2TGGw4qe9fULV4rHFo5nPEEUR8ceoe7guAzHgiCWBILsQp00CIBPyXYwngkzdtw3ICLYEsFpaQFv/532BqBnVGfoJ01Pzk5ZoNJX8OP6MP3XesM+zRmd82Byrqb0DvlAEmSZ1ME0V9N465JjIphX6XY9tPM4ZXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eTFA0Z5U; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eTFA0Z5U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVs1J73qWz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:24:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VdpT4139849;
	Thu, 27 Aug 2026 06:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1La7cD0eYNIXwOype
	e2b6JhRgxYPQoqE00wTeUx+ofI=; b=eTFA0Z5UQzksliIfEp+vRHQW6okgKXSy6
	x9UMo67tjKsprLtRDYBMqQGRVO02LWyxvMfBHjzrIzff6VnUMWjK4GKFbjdePz5N
	oBGMCqYWLyeeSAR3dRY0mWRJLUwhJ2y2JumrkLke1rf0eZiQyNJtiRRbTR4D8EDr
	mS/hPgORqsOna3Ebvh6gALIxdSdc4iD6xPWbzT9NkXG4a6/5mHoiOR5rScNQb4eU
	TSmxpSkjydbsVQ9QHbEDrGM3ofFH3j2OFk4okWgB0uTKNGjJUGpDIOVoIf3usbZ7
	Q4jJuQvxsdVWH0yQPLD8H6NoF/5Z2E1sFNNZehGLSXLPxkBqYrsWw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er3h7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BKS2000516;
	Thu, 27 Aug 2026 06:24:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qeq23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6O4KP12059012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:24:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F25992004E;
	Thu, 27 Aug 2026 06:24:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9486020040;
	Thu, 27 Aug 2026 06:23:51 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:23:50 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 3/8] pseries/plpks: improve type consistency and parameter validation
Date: Thu, 27 Aug 2026 11:53:03 +0530
Message-ID: <20260827062309.724808-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
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
X-Proofpoint-GUID: iiicmCC5pDUR9BOlYozzW-dnzi95fTbk
X-Proofpoint-ORIG-GUID: cBB_1eG88gbzUY5EK5MQV0pNEoR6zCfH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfXyj0OBP2d6dmR
 Mvpc0p7VmD+jgDV4SOFaSocg5n0mM+2hFvSUUnp8x1qjs/PjX5F4i1+osIgaDFfl3ugDamxbYfn
 i5hoKQNKjZkJpVeQ5FWiLP+G0KOCXdKD1e9gvS3hazYv1OlMLR6veZlk9YUq1BlplF6rA8Qgt0i
 ahyZnAWg4yypQNfcAXhAata837Nt+9ibJwqp3s/LIWCO57ACMbIbc6W2Ma0Lk2B2tAeZ4VU2Jpj
 MtJcmT01aJrrZznvDC+plpD60Q9Ds0u5m9YNxDCBDiy5ZoqKCiJ2IG4wsDyUchKhUj7Wfys2bqV
 Bkzg93rxLW8rr4Oxx4b+rOomWm4HxvNYSJpEJBI/C9HzP8wCV/RCFB8P+eu4xcPrP5W6vAEf+gw
 9f44azRv2qD11RjzJGDGpKpzCcnbIljSAPDmY85TaX3K5T63SqPDj4v5o+5eYYq1TnvY6r3LI/x
 OEu0JqaYpxKxIAgHClA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8fd809 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lkDOvFPUoNuE0DTt1acA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX6sd2acnUrM64
 Xh1vESIbDRzHKd4bK9DBNLF7DH4jK7ZTGRrEElN7S9m2c4P3dGnl2Iijl7VbckQR9IGum2gPrjT
 2e/yvakiVJlLCvJuGMhiKqjPn3N3vDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

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


