Return-Path: <linuxppc-dev+bounces-29633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5DCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6VwT600tz303B;
	Sun, 18 Oct 2026 05:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262393;
	cv=none; b=CFAjp7IQh6cxTBchEEGd4FAZQdDXF+RR1aTM3clK2QuEoi+kajzWq56XZ1vQHsEo/9Gkv1zrsE90YOSYpej0fAE/iGMNGZkULGmemj8GbsLquaTFESJOLaNCCpH1H5XIkJY/NVnOHqaw63GBjdZ7fuSML1/OYMtFWq0vMgKHcLkJ2GDQB2J19paiBLt6WN8477uGh31BA2C5PApuNP/FHyBiXQOCL0b2Pyz/hmOoC3t+v2PB8rigKPWEf3jIjz6ntKlNXyj/KsdOJf4tiW3SEpVcBrzcUmnyzOJcV2yZV8j93NnLnpmJm/HB8on2FL71C1uAg4pA1qrQoAO3p0L8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262393; c=relaxed/relaxed;
	bh=NR4whb6KuN7VrMMuw3yl/fgeW9BiGxlE5XdOgxH6ii8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F43KWWgcavlqe38MlH2PFEF8kb/Fo5BE1xXPIPKgxld/bmnFHt7yG4qgM6EohXpC/Pfa4NpZHBIo2H693PNh3Qd8e7rn9uAPPn+wz2jBXvAcYS+CktSLLSSNIPO4PsT7C0lJrHN4CkTACFg3u+/Tck/GTtZw7kRBqW6uuGB6HXX7Bd/7Amzp0sLpGNmkdbYlbjioBvxy0Qd+mN8YbO2ZYZKCPlAc/jhGfyyS1PAhA31HOO7gEgNiEFIn2hwV1+MaGjjVXBrnKJ3vLUf4bHB5J5kKWXTKNQpt9ElPPA2eXXJSl3dvXzJsSRuZNqjQUxNEQfmimGUEjqFg6vftvDS7bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UV76eIWI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UV76eIWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6VwS3yYfz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:39:52 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEKTQ2854656;
	Sat, 17 Oct 2026 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NR4whb6KuN7VrMMuw
	3yl/fgeW9BiGxlE5XdOgxH6ii8=; b=UV76eIWIlWEEYgcM832/ohOwRPriLSRiw
	5qr0TrvR7rIGBe7yCDml9tG0uSZUVNeZB0lYmSv99EJr3awV4+of7EaqN00B5Ux9
	mGsZyJWlbs7st9nnTmgR7ARWNDnbOieS3FxseI5LWx/2KBpcKfqUrnX9KDSWih+K
	KItabf52IcmKx9T4SyQFeN1TDbi+2zEtmUM3x4lUE0SciLq7Lr2eyT7GggrRMWbJ
	Mpumk/9rZcXzECL2gO9j36R7W5wvLy9EfERdZoI3p9iyj/Cz6zMmqcoG+3dH5Noc
	vXoh6Ai1JCJU9WYCS228F7h51erQKmnNngXFMTx5nomjqI/J1LQuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7aqyn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGYx341270733;
	Sat, 17 Oct 2026 18:39:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hbtqcbf18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdZeB35651878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F069D2004B;
	Sat, 17 Oct 2026 18:39:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4179920040;
	Sat, 17 Oct 2026 18:39:27 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:26 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 3/9] pseries/plpks: fix length types for wrapping operations
Date: Sun, 18 Oct 2026 00:08:47 +0530
Message-ID: <20261017183853.596052-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfXycZtIHv2j3bj
 tfrvLDG7ZBCSSvkP7n4SMhsfxuwLDnOp2kprTKV5GquumasVAXScdDsFN6Hben/n8EbezqN1BXl
 DR7OVK6Hl4Tm2YTan88RMSxHBs2HZtM=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad3c0ec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0P1reCDcYORL6uZRMdUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX1cJ2ZGCOjgxG
 vEqstdV7ypZlWROBkJ8msRns2oY+L/uWyezRddfTwunV0pZD716KpjBhkpliG2T6moiZIzmO5lv
 RC2SRjAz4rEdn6XJ/bhptFxv0mQU7DEz/ZfV1i3mrQyOYY6SSqA36UPHmFTKcosx05p1DhNsAVN
 cHCoB0U535Az7CMxJpKK1ivH6Zbl/8oMTJ618twSMSVEwC150BdSILtt59ncf0qYPTEH7Pc7a7c
 Z6gwfQ1iNfh4VjJ3bukb6Gzlo6JFizZsVWh+rBDMmjiwCPaEVZ3BAXUPatTbVJurZntrB/iJ/yW
 sZA8CbJzdPNdd+MYhzWpVVcsHlhow0PtY8uqRaXblkV1emFspuVZw4Eeyl3X0WDk/dZ1xCiwRsx
 RWvtL1OFBnliEnwVfSuwXfLWeHZLDTq3GW+S/s+p+2nvNbikbv18W5JUWGkrDCiR3ZjFmEWDAK+
 F8ZS7AUgIrZ6qzbmJcA==
X-Proofpoint-GUID: zLLvYxt1aPQnF2qj534kTrqlbo5PH4n8
X-Proofpoint-ORIG-GUID: -41wYunei-hjNbc7YzvJN9QcElVVt-sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

The object wrapping and unwrapping hcalls use 64-bit length values, but
plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
input and output length parameters. As a result, the interfaces cannot
represent the full range of values supported by the hcalls.

Use u64 for the length parameters to align them with the underlying hcall
interfaces. Update the PKWM consumer accordingly.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/include/asm/plpks.h          | 8 ++++----
 arch/powerpc/platforms/pseries/plpks.c    | 8 ++++----
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

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
index 584091f9aa08..cedde24b0d3e 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -1023,8 +1023,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
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
@@ -1142,8 +1142,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
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


