Return-Path: <linuxppc-dev+bounces-25431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AD0C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFSNl2ZXcz2yMl;
	Wed, 05 Aug 2026 21:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785928183;
	cv=none; b=G4GobZT6rlnN9RIPqkIkgL37UN8UuWkXVaT/ym72K2aC2GJ1Ucz3IYdeoMes+XIuc3ohpKp7MJ3T+mF/xtVUtuiYO4W1gaLSPpvxlxJL1PTHHRMEDvr+tNeiLrBW+mxwdfrS4VzmtpVsSIH4QxKnAKBngcucC4wuZO3RB85Ln3ILr9tt4SUu/uevaMFyuRsZlCjOlJbcOFJgVUnJbdDoyuu9KXfZP+89wD/8BDFydKWqBFdC5X9h+kS43scWZtxZMpZtMjh9zxTOPAN8Gzy/5Wcvo//sRs9SwJ/s8eJNDfCcXpEbLw5/hfTA5Yt1dtwo3/xcvNZq5/tKrIBddGCGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785928183; c=relaxed/relaxed;
	bh=tzmiy70glEknNlhqdG3cuNp76HnS5fiMIduI1ZyrOGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8pEt1aN5740td4vsFuvVPDphHY9ieu/zRM1I2zmY+MBoGpFFmOUfauYoOwaReqmSmeqyAcp/h2S6ifjmN+mmLYXY3DL1+fluaYrqUN8zHUjehhzXvh8tczkT5rlmWYnEYycLSB3KmjR5Y/yvh0zere+jsBGQsRa4IzmEw4Fo7uBIKzQI4kpFhnBncDmJf58taAzGfqKzonawgrD2lube3Ljz6LbzUdT/nxYWRbWUkH7aROBFzQVpb/Ul/912NRtWowlabrumau/Z1CDZaVx/FK5LYc73Tjjk/W9ojswv/nzn9b4g9dQkYXEL9woT5A/XRjnlU1c8KJBVYPjgaEUkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S2Ui4MLp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S2Ui4MLp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFSNk48vvz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 21:09:42 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lnB13438008
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 11:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tzmiy70glEknNlhqd
	G3cuNp76HnS5fiMIduI1ZyrOGE=; b=S2Ui4MLpGxwPg+eAs3A8iYi6Vf4a1ePkW
	IwnPTotra9qGtbY1iY87AcMdJcaTqjV2pVB4ZS9S96PdWGxQeFyXHq2bpq4w14Kr
	bphbklg2NZ+iL1vhxKkr8zK0/Gf12ElHbLeTGhXErFrmH5wnQVo2vjERbYmym4ea
	uUgOJEZu1ts1fulz/Va4J4fR3LIUF/RxPZr+Lqb53ebyc/L8WV1jHiJoC6zf9LfS
	w845/+CHwqxhctMyJ4TQaGm5kf+Hf0FamZxGVchvm6AxbXHUt5qYSTS8y+cdK7Cd
	fp0sg2z0MRi42jAOsxt/O1KfsL4NsxUG/SgNbSpNBr71ZZYpGF1Jw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:09:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuPYt003438;
	Wed, 5 Aug 2026 11:09:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6ax6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:09:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B9YPV50987304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:09:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B862004D;
	Wed,  5 Aug 2026 11:09:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05CFC2004B;
	Wed,  5 Aug 2026 11:09:32 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.28.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:09:31 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v3 3/4] powerpc: Add Power12 architected mode
Date: Wed,  5 Aug 2026 16:39:23 +0530
Message-ID: <20260805110924.3853410-4-mahesh@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -BgIdm7S9teDEu3vNbnnsvcPQYQPIAch
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX1lsiG/z2i/6S
 7x79ZDs+F+pNf5gFiVMe+uLhFK4JFFJeyrVTDMRXw7xruTfqwL0/Is3+7RCalt1KEAiW7Z8M7f7
 bp2s6TQ+JTjRKOa66ZjZXLTLMX7KSmQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX+zxH1iAKV4uV
 jpIjr89/ymPIzPSjMOd4qVA5YYuk0hqaH3K3Aq003LUfPTvd3VHnw8pjQA62QjpcmANtI+83o+w
 CubOrh8Js+pJdJ6QVQ/p/1/UnYFixLFIS/k4OoryPsYs6s/8vRkqmSESNfeOx2NBuUjEGmH05f2
 7ZHSvwl0U9EWLXhE+nhoXv9aipqAWhZ1JAeGKDLbnmr/dcmU1iJW4LBbNsKlYiubQVvtX3x6wyp
 UcXwFQ4Xu7IuQfnjLOj2XURJMBTr6tltkvmdH1fKKAsrjt9QAJD/RVOF4y0Oilw+5WuPxWqkqQM
 tF/0hYUOIsr7YqXcjo84Tvi5szFwG9TfoBRAIBhsvYzJlh/eUtZfdb84ODkCw7h+XUaKfmRh6/J
 /AFWpuPlCM9UOXKeieGrLs08M0T8PaTFKo+DYeQruzrMG/KVAG1+++AzEOE33h5FYAsphM45Zjn
 NRlval0/INCXtCDSVyA==
X-Proofpoint-GUID: AbWce_k-HwUjLzpLIZpzs_Z1330jtAzR
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7319f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=YNslrm-srcORgUkRIzAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
Power12). This is used by phyp and kvm when booting as a pseries guest
to detect the presence of new Power12 features and to enable the
appropriate hwcap and facility bits.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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
index f4991d10d89ec..2076852e6c2ef 100644
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
index bc9bd225f5876..68215b7ce67e6 100644
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
index 7619dd157646f..26fa40aa34db2 100644
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
index 055cb5f2d37f9..eb9f556b0937e 100644
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


