Return-Path: <linuxppc-dev+bounces-25471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032FC55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwP051wMz2yPR;
	Thu, 06 Aug 2026 15:11:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785993092;
	cv=none; b=Pnfe3mjtL/b+LYZz+FKZgztaBG0S0ZOM7w2ZjNtd7z6d4gkiMTYUS3rjUv4mutFwenioLftxWYyMfvNOez7+4P57NPbKL+13u8+qyN5dThYrCGK5NfXObdEDFpFActL5QtihIDdM62jz9fxB5mrutaQKAjqa1GX6OYaYfMIHixU6QAga97gEPX1tl6l1McHm9dAhZN0DKxYujywvM5VdKzwbGq1pBX64uoCFph/UEttj12/VMzFiHtPTw0Xd5CC+0SAgwsW3HRl6HI7DSYh1un0qJmOivzdiJiDAx0Spz7nY07MOLRSIP/Gl5UI6zyb/3hjGs6XqInDlUj69JU0oRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785993092; c=relaxed/relaxed;
	bh=P5vj0Uhpho0CZExqGtihc/PT+eolIFVC0GhWzWuog7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaPzI5ZgP1RGkRVF196EFm5MSrBu6oGdLU0ipvYkERSpAr8xfRh20jyQ7hp2rERaeBnHZbnvUQvwv8204ycfJc7mqHEjlKUGxrbRt3TqA4nkVUCRULWSrloDMKuWf+g+NXDqzJ67tpwmwr08Yh2j78dPe/R1YnG9Je28q0e6vxSswZR3+VTIHDW/2x9GlbRF5/orYlxUf771RFPf+V2zDOW+vVahK7xvm0V68fCN4rNxMM+4ucHwqc53C9B4tUnctrsBgxay1l15wSND/Pm1GGuBpDT4I5eJWsKgnhF5cKHRBuXahpdYSHINn4kUFWNM9YdVmxB4Ks402UDsKw5jiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kunDskQa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kunDskQa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwNz5FtJz308Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:11:31 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlmiT993791
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P5vj0Uhpho0CZExqG
	tihc/PT+eolIFVC0GhWzWuog7w=; b=kunDskQaMavHcspZ9anl4sjAxzDIq1oPy
	j493js8zWrVP3aF25yFlEtOCKCvOe15wyKL5uW5NAujEtu7tDr/2fz3lZl3mzTUR
	VkMadMYAYCES4Uy2MMglcywzcFiFRmdAFyky/KjTRcNw8/sPl9CB0uw501bwix+K
	DY3POKPBgNFsH4N7BJjhopLpHe7T1JvFLtRaJXs2UMcWE7sGc7BysimUFZGOpWZY
	T2sJvLeEghMlzqnpSNFvkElSwli1sPnSYOMCAflZzkEE2IPNF1978c/mQr3B0ZG9
	CkSmMTEFWFhuUqvRopWKO7DizuzIhO7MdHv+WCFcvfZBmj+qdb3sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hx6jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 05:11:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765BPlD003149
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhhp0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 05:11:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765BOJQ49283412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:11:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14AF20043;
	Thu,  6 Aug 2026 05:11:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09E2720040;
	Thu,  6 Aug 2026 05:11:23 +0000 (GMT)
Received: from jupiter.j9d-in.ibm.com (unknown [9.123.91.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:11:22 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation
Date: Thu,  6 Aug 2026 10:41:17 +0530
Message-ID: <20260806051120.3703698-2-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806051120.3703698-1-mahesh@linux.ibm.com>
References: <20260806051120.3703698-1-mahesh@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX2duMrGUf4LTm
 yKaRqE623tu9cUeUC9X6xlCk7ZyiHZLW9u4MeHHTNzlb+fKBqjf9akvRixFQxQfaHfE1q8vOey1
 /7mJpY8Jco6ibiKGLRESJa51VW8Ax5g=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a741780 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ae8wxykVshGZFWyNThcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX9B5fSARN8kjr
 do45Me9fLqbp8rNWwCwa/a/dKs8ECiQ3RD0kvA67HjoljG6r7VOOL2ec6owp73gwVEaBaJnbGle
 ymZdXBSaO4uOtOd3Mj/vGZsb7N6ylGzLzIN7cLKpBNj2Fs9Iqn0ZUxRECg7vP/CN/EtzFp/vaQt
 wUOXb/Te+kQ6slinYHqlg1ah43e9n1VaIalKcnHUWJCNSNq+WTKGDrmlrZ2DlI8dUMcGvFn6QWY
 HxVaN5JmtJQ8EWU5COZXd/H0XPgeX6al92ShqmIOvgkTlEsGgRtHYZvIsaJEIHzAKMthovS2vcI
 4iYBHQuUr1IAIh2+nh+Izk4m9sN+R4TCJMyuTTWg+fSu46GXt5lbX5zgP7rZb5xmxcwx6chhwob
 PIQszC663GMUjOOEougzzC6FeUTHdOgUnlaP7c4qYY7lJNZjwhGHTzKrK3/lXmHISMD7ulq2wzl
 5HZtI+uFJOMxpw3m07g==
X-Proofpoint-ORIG-GUID: Wxv0AdIVIZlBojx7qlWJLocxebJGLD_h
X-Proofpoint-GUID: Wxv0AdIVIZlBojx7qlWJLocxebJGLD_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060033

Current Power system firmware caps the PVR list array size at 16 entries
during CAS (Client Architecture Support) negotiation. Passing more than
capped size to older firmware could cause an undefined behaviour and
breaks compatibility.

Future Power system firmware releases will lift this restriction and
support greater than 16 array entries.

Ensure that when running on Power11 or below hardware, the number
of PVR entries passed during CAS negotiation does not exceed the
firmware-imposed limit of 16.

In prom_send_capabilities(), compute start_index to skip the oldest
leading pvrs[] entries when running on Power11 or below hardware, so
that the pointer passed to ibm,client-architecture-support points to
ibm_architecture_vec.pvrs[start_index], presenting exactly 16 entries to
firmware.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
Change in v3:
- Remove unintentional whitespace change.

Change in v2:
- Define a named macro CAS_MAX_PVR_ENTRIES
---
 arch/powerpc/kernel/prom_init.c | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 53503937de0e..055cb5f2d37f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -86,6 +86,12 @@
  */
 #define ADDR(x)		(u32)(unsigned long)(x)
 
+/*
+ * Current Power system firmware caps the PVR list array size at 16 entries
+ * during CAS (Client Architecture Support) negotiation.
+ */
+#define CAS_MAX_PVR_ENTRIES	16
+
 #ifdef CONFIG_PPC64
 #define OF_WORKAROUNDS	0
 #else
@@ -979,6 +985,10 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
 			.val  = cpu_to_be32(0x003a0000),
 		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 2.04-compliant and earlier */
+			.val  = cpu_to_be32(0x0f000001),
+		},
 		{
 			.mask = cpu_to_be32(0xffff0000), /* POWER6 */
 			.val  = cpu_to_be32(0x003e0000),
@@ -1032,13 +1042,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.val  = cpu_to_be32(0x0f000003),
 		},
 		{
-			.mask = cpu_to_be32(0xffffffff), /* all 2.05-compliant */
+			.mask = cpu_to_be32(0xfffffffd), /* all 2.05-compliant */
 			.val  = cpu_to_be32(0x0f000002),
 		},
-		{
-			.mask = cpu_to_be32(0xfffffffe), /* all 2.04-compliant and earlier */
-			.val  = cpu_to_be32(0x0f000001),
-		},
 	},
 
 	.num_vectors = NUM_VECTORS(6),
@@ -1403,6 +1409,22 @@ static void __init prom_send_capabilities(void)
 	ihandle root;
 	prom_arg_t ret;
 	u32 cores;
+	int start_index = 0;
+
+	/*
+	 * Ensure that when running on Power11 or below hardware, the number
+	 * of PVR entries passed during CAS negotiation does not exceed the
+	 * firmware-imposed limit of 16.
+	 *
+	 * Compute the start_index to skip the oldest leading pvrs[] entries
+	 * when running on Power11 or below hardware, so that the pointer
+	 * passed to ibm,client-architecture-support points to
+	 * ibm_architecture_vec.pvrs[start_index], presenting exactly 16
+	 * entries to firmware.
+	 */
+	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > CAS_MAX_PVR_ENTRIES) &&
+	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
+		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - CAS_MAX_PVR_ENTRIES;
 
 	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
 	prom_check_platform_support();
@@ -1427,7 +1449,7 @@ static void __init prom_send_capabilities(void)
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
 				  root,
-				  ADDR(&ibm_architecture_vec)) == 0) {
+				  ADDR(&ibm_architecture_vec.pvrs[start_index])) == 0) {
 			/* the call exists... */
 			if (ret)
 				prom_printf("\nWARNING: ibm,client-architecture"
-- 
2.55.0


