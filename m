Return-Path: <linuxppc-dev+bounces-25473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959B4C55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwP41MTXz30DK;
	Thu, 06 Aug 2026 15:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785993096;
	cv=none; b=IY9BrHnKnUqODPNvl4vQ4F+eXuUhxV1TKAvY6kMDpYlOLirJmWyM+DgGnWb+4dQOL0y7kFR+Mrk+yZ8Bagsgxd4tyDWey4+DPcAOBqBcHBc9pbu9IbmoUuUlECWLAwx0zFZZ8SiExXOwsN96aAGuj7vFrsFWjLvlp4gD9nN2uFAfzwC5TjNDrpfL+8ToGLTBOPKHxjm07OkMmMXlZMH9vTH61k8pZh+4E+ifEIJfh9Bg4RC9XPTBk5W9eY5V7iofSslcftfi4jZJQR0lUkIu1cKR2VL+lYkB1sqx3IoOmMgbZ3ZS+LqdpfZYZbPN64SRVc1+9g0s77OKQBUiSSkKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785993096; c=relaxed/relaxed;
	bh=cLV4a1+BUpjnIGFfx6FqvIXMUcBXb8eCTqrCSL0oYPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWBZMc9wE7PLlkS0jZxwFCQ+I9slrjsSpdDIoFmIY6e/jdoBLiag3PmPcRrFjLbZweXro3cRDLPjPeIT60+EJp9CPQN1zC1Mjg0dzEmJt7/o7wu4nt09PkepkHSRrxvFe6iSKiK6lmyulq2bof1y1O5geQTj1Yt3NbRWQ7IFpp0p9jLtPOb0AKOehPQ/A24+sjSQUIzERD0h9bFGXTP4m2iVg88kgrbAUxzvvALI/7AbeqCSO4dXgZ6eUwj2BlpUpguETdXoWnMI1fSes9y7qlplB5QBInJ8hdGld85iCV7TzW40DQqZHjQpOkv5mfMDT9clOdwzZEBXzCBNIWvO+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hzp1M3kG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hzp1M3kG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwP30rmgz30FB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:11:34 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nmh031144369
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2026 05:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cLV4a1+BUpjnIGFfx
	6FqvIXMUcBXb8eCTqrCSL0oYPQ=; b=hzp1M3kG1uaHTDjYTQbK+aeXI3XHUIceG
	ltFitboHhipKL+0PrTjgBkF72lYlsLofxnr6rzgFLQs/7H3MWuZJYaZovkxfdesK
	LknWIQlqnl+63FHrtg60cA7X2X//DyuLFpfG6Jxhav3yfg7j4KpekkuBgwLWJrHB
	9X15L3IqIjJXd2JIqZcswK+8eSaMLH2FrtC2Y8h5R78sV4/lqlZQQwwD6bjSd8h9
	7z+T5mlnoe2NBiLP1bcn7nYs/TCRx6T5CXx7QQki53CqNGJN9xUz0uGXisbm3leW
	kdjotVwSC7VRQ8COOhE3PxVxlYXm7iSotNzR5Dsf2YxrE4bfvuT4Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euwvky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:11:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765BN9O018378;
	Thu, 6 Aug 2026 05:11:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtysh4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:11:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765BR2g51970524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:11:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EFD120043;
	Thu,  6 Aug 2026 05:11:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D7E820040;
	Thu,  6 Aug 2026 05:11:26 +0000 (GMT)
Received: from jupiter.j9d-in.ibm.com (unknown [9.123.91.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:11:25 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v4 3/4] powerpc: Add Power12 architected mode
Date: Thu,  6 Aug 2026 10:41:19 +0530
Message-ID: <20260806051120.3703698-4-mahesh@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: J4f-gUYymyyz8duppQNMxEgEFF9VCqIb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfXzhyttUIZZY1Q
 R3BbHeCmQ9HHBVcgTAepI5h6TRcxLFYplNOra1OxoAgQzFcVLtNfVjTgXNuubv4MK1IBDKUSLSY
 imH3GPyNwL0A/NI6Q1KNvOdp+3jFaok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMyBTYWx0ZWRfX13cKkNv2A9lW
 JQRfIMXXvYXJETYIN0X96LWl7e0Bh7lDCHEhB7y4IwKz5qMnqbML0Apq6l47Qh9qb6mxFmJp1Q/
 v2jBd93qz0N2G9tdAJ9wsewUs82EV5cJ5jNEMlYE3TTGs1MeJTmOW4d2lZPbGNKlPxNLCsExgCI
 glZGfczdLJjxCYj01VqL2fz6J9j8hdQVySij59mwYRNTVlQ22Pi0AbL6pmpPxs4wyXfFIOl2/Fk
 XsPT3VpMxmOyZPrgseoCSkuqvf+0l+tvwrh7P2f4qOX5PxA/ytwXk3wDrZ/ZNTTw6SVwnTaaWIK
 2TTPxoYBI4p3VS8IZTeKHP5iIn+bfJlImlT+3bO9G+VF1P3xmKknGCNfdgsHAy5b8H6KbckwQXU
 GyKJi1cQFEfLNqRyeVIQ7sIXtTiyEHH5lTkYbwi9bRI8t9suxz7VklwNO+UPUr2hLGCD1LPl1Qv
 gR49skfTV2VwQu2UBHg==
X-Proofpoint-GUID: N7fGwIsljjP-3D6efkZZhjt5jG-vRG7o
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a741784 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=YNslrm-srcORgUkRIzAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060033

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
Power12). This is used by phyp and kvm when booting as a pseries guest
to detect the presence of new Power12 features and to enable the
appropriate hwcap and facility bits.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v3:
- Remove extra tab in #define to maintain visual alignment.
---
 arch/powerpc/include/asm/prom.h           |  3 ++-
 arch/powerpc/include/uapi/asm/cputable.h  |  1 +
 arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
 arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f4991d10d89e..2076852e6c2e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -117,7 +117,8 @@ extern unsigned int boot_cpu_node_count;
 #define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
 
 #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
-#define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
+#define OV1_PPC_3_1		0x40	/* set if we support PowerPC 3.1 */
+#define OV1_PPC_3_2		0x20	/* set if we support PowerPC 3.2 */
 
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index bc9bd225f587..68215b7ce67e 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -53,6 +53,7 @@
 #define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
 #define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Assist */
 #define PPC_FEATURE2_ARCH_3_2		0x00010000 /* ISA 3.2 */
+#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */
 
 /*
  * IMPORTANT!
diff --git a/arch/powerpc/kernel/cpu_specs_book3s_64.h b/arch/powerpc/kernel/cpu_specs_book3s_64.h
index 7619dd157646..26fa40aa34db 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_64.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_64.h
@@ -303,6 +303,20 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.cpu_restore		= __restore_cpu_power10,
 		.platform		= "power11",
 	},
+	{	/* 3.2-compliant processor, i.e. Power12 "architected" mode */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000008,
+		.cpu_name		= "Power12 (architected)",
+		.cpu_features		= CPU_FTRS_POWER12,
+		.cpu_user_features	= COMMON_USER_POWER12,
+		.cpu_user_features2	= COMMON_USER2_POWER12,
+		.mmu_features		= MMU_FTRS_POWER12,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.cpu_setup		= __setup_cpu_power12,
+		.cpu_restore		= __restore_cpu_power12,
+		.platform		= "power12",
+	},
 	{	/* Power7 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003f0000,
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 055cb5f2d37f..eb9f556b0937 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -953,7 +953,7 @@ struct option_vector7 {
 } __packed;
 
 struct ibm_arch_vec {
-	struct { __be32 mask, val; } pvrs[16];
+	struct { __be32 mask, val; } pvrs[18];
 
 	u8 num_vectors;
 
@@ -1021,6 +1021,14 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.mask = cpu_to_be32(0xffff0000), /* POWER11 */
 			.val  = cpu_to_be32(0x00820000),
 		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER12 */
+			.val  = cpu_to_be32(0x00830000),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 3.2-compliant */
+			.val  = cpu_to_be32(0x0f000008),
+		},
 		{
 			.mask = cpu_to_be32(0xffffffff), /* P11 compliant */
 			.val  = cpu_to_be32(0x0f000007),
@@ -1054,7 +1062,7 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 		.byte1 = 0,
 		.arch_versions = OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 				 OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
-		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1,
+		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1 | OV1_PPC_3_2,
 	},
 
 	.vec2_len = VECTOR_LENGTH(sizeof(struct option_vector2)),
-- 
2.55.0


