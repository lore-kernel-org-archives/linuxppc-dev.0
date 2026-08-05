Return-Path: <linuxppc-dev+bounces-25429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEE4C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:09:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFSNc4Cdzz2ypY;
	Wed, 05 Aug 2026 21:09:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785928176;
	cv=none; b=c0KbeuiaWRhRx7NIY3AiNOEEjd90peqheQixVl3Y9Slaoh8Qg7WZUv4bBGOOtNRynS+wg8THVpeRmzVIKsuAN5cyzOaw8sD7cRcoRMmildyU+kpYyht0MRx5/0DyoN6DT9ZhMHQURxc+e8ecEJ+xkHaklm76RL/C+JnMje5GMKUCx9BLV9HmLXZ9jqHv0qQ5hLLha0RD8CN0Qc2K6f8q4Hk8U5YKLJLYT0klSnu5aAJp0xmdtPMGl7gFb2N8w/r+U80d1k0kTiyRZ570UqMa5bee4lFQaZLIhozcJmn2uPt0siOkUshU50iYqc3UIIDRlXVlRdQ7HRjeC33JdFxwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785928176; c=relaxed/relaxed;
	bh=DJI7wD3CmL6wAXlZ/5HMDqLE8HACUaDnXZLt/VaI2vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D896wioMo4VUXwIo+nkVuijMCkyGbZjpkb2a91gcIm0GA7qyGBD3WmVGwThsmXupF4NaPlT4f685LY5+QmH/FsScN2GIoRnNLiIolM0J+GdfbFe6kfiBgr58fn2ucDM6yKGrFJTGUGXreIUbkTQf8FpVAIFIn6yzBeThSuuB5/iKNGLSfjqIZSSLD4aKulvsznMYlCBr0QsarVSzU15V3cJfIulGbeHLlrMBlIG7atU1SywYol1aWFkslG6f5JJx61/GWiPNIroYTFK1VLIkLIm/n/XduhIEc35kV92mY1Eld5NIhcKMtY4sh1ZFas//J2AxS5gKGz/OUbbfQFlUng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tOiZN7Jd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tOiZN7Jd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFSNb42n8z2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 21:09:35 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lmov1503319
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DJI7wD3CmL6wAXlZ/
	5HMDqLE8HACUaDnXZLt/VaI2vI=; b=tOiZN7JdEgLQwzeFiCDl/9lj6UAlydGDl
	DDqLCF1TCxZnJXAycJOG4r9zLsrXa9N6ctMXIhtz2ytUe9AZMs8P+SohEXQ24sdA
	+dGGt4y9tk9ZNR9NvipNvvy2Km1T9rIPDXoM2UZXCDAKqNXGu/DGX3dCXJYk1zuc
	DFxuJh0Si/o6z2fUwndLRxMLHfo4T9QoB0mzrZzhqIFhtOk6Iz6/cv1d+U6fZsHN
	MvzQF7vtNSvQWlIdh98rLqpS6MdcJ5HbONh5OHFSgAKsSTKQKbNIU5dF1StoPDQQ
	0O90p3wR3b4OVao2oQRs5WRhknWgGtxCEwyTR+OZb0NwNMgOcJqlQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtkd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuFjF020925
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qpby8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:09:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B9S9f27394472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:09:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B070D20040;
	Wed,  5 Aug 2026 11:09:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E022005A;
	Wed,  5 Aug 2026 11:09:27 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.28.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:09:27 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: [PATCH v3 1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation
Date: Wed,  5 Aug 2026 16:39:21 +0530
Message-ID: <20260805110924.3853410-2-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110924.3853410-1-mahesh@linux.ibm.com>
References: <20260805110924.3853410-1-mahesh@linux.ibm.com>
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
X-Proofpoint-GUID: nIUYolAGibiduKikQG8XhynWC4wJ0gXR
X-Proofpoint-ORIG-GUID: nIUYolAGibiduKikQG8XhynWC4wJ0gXR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4hewRaRrbpzb
 YzvclcKVf+y6PwJew5xWu+3O/v/z0lpM/3t8kTYMbyJjKEL7U8n3BY6r76tyYPPnz9zgRKROOq7
 hhp3WFG5bZ0vR2S7vgZQ1Sewd0B+WwU=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7319ed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Ae8wxykVshGZFWyNThcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzEXsrksqb8iI
 9DnQkRxd4bxYRXqYGLuNrrAy4gGXdOExjHcdIYuZM4cwepaEmKvHBntZ9LeDEPE332z2o0D2m+6
 H8Az7tKGHItkinqqsYPFPBbXkKd2Xo3751RzipXuca2wQCdmtzYrcnzhMPiY/YxyQSECFXRqkTG
 mMifzmE2Xt8Dn2Y8e7uD+nywmxqh5HRyJxc5IGB8PHKErP21oUFfreJZHnB4AY+JmQdEVExj/et
 1OLD/L5vv6JNJxt6f4mwRyQA1Z5VjF5yuxT2Va+GMmHR4Nr3j8rkC3MfwOabPIdHv9xtAKHtzeQ
 iNZy077f47sWv2iNsdBY6j2yThi/tRu1Wcsq2C5zxuP0UdvRBluvN1K+YKlc038Mx67LgnVBpyt
 TLA0mlKvsy3DkBnUtHSQAMwX4B88lx4ThtkB82FuMkB6wAj/LTm9XxSGsmdoovDusyAzTOM1tIQ
 HU/gHxix9ZfLqmZ1R7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

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
---
Change in v3:
- Remove unintentional whitespace change.

Change in v2:
- Define a named macro CAS_MAX_PVR_ENTRIES
---
 arch/powerpc/kernel/prom_init.c | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 53503937de0ee..055cb5f2d37f9 100644
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


