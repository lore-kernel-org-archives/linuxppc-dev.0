Return-Path: <linuxppc-dev+bounces-25282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF72C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:58:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDLsy1NCKz30DH;
	Tue, 04 Aug 2026 01:57:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785772662;
	cv=none; b=abuyf7qC6n2TAPvKVVzCTmdUATnvRELjfBjSGrqkoozPPuGcoeMCCaKq8YCATLCY+sABdiMFgOwJeWeqJga9QPWwRswW50cgLmqUAMyJHXEBRl+dq8UvzzYZRTjULcXvy2Bavii74hcLwQhIDgWUa/wfz5L8r4Mdo/mEJzyd1mKqCkjznOvjHJxaVV0a1rHUJMZ4K16B1guJ8VM51EHtJGjTkOgZMDx3gi47C/EFzGhXEsAn4dmCockpEw2M3gTXRFU0mOYkgAoZ+Z/+Pg+ZwixEzNENd0jWAk1v+gv37ab3M3xx4JUHlC4T3bzbAfCQ0Q8dHthiCmCF71x+rRsL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785772662; c=relaxed/relaxed;
	bh=JYGa76jdUD/GevLE5EP8mKJsGZL/ZCXOtoiclFUTP1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2IJ8iwpeQ4C4W/7x7O9I1o1nDW60L5+lBi2lathBxRA5GjlCmD6iiqp3Q5e4qYLqKkTPjjGZ04cydqj7TthiQrPDOzigrmiv9e21hVBx/yqQ8m84Qb/lnxSoPn2oa9Of/0xkDy7qmovs3mJ8GhOigzDArDbU8hd8qS+G2Yrtl05HhlNPD88q/stLifZWHJr8CZxTgiSSjZFzH6PxahY82+JAb1qFmS5QHnTbPgipbsSeXOw6xpSosc0/qj2sNUepzE/bWRSP1Zw09YSAlmi/K+PYE/s9tCI7CiRHhzXDwvjfVq7iB+Nwidd0DcdlrVF9uYzsztArbkFm9uGQ7NMWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b/TQHRNK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b/TQHRNK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDLsx2WGSz3bx5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:57:41 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHqn32341552
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 15:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JYGa76jdUD/GevLE5
	EP8mKJsGZL/ZCXOtoiclFUTP1s=; b=b/TQHRNK9LXASHYK0v5IVkHfw3SM068pr
	i+8dzdWaK1bXz8ZhMUBXidQFmLkY5MPwPJogevBzZehWTVaNx3aPir/atxDQ3u4u
	M7TXfxlfXK5lrOl1i50BXI2LYEMIgtKqVG9RjmCCKQuHBFtSIGmkPuM2wrQnUWmF
	74VGGXP42w0YXpSEfq/ry5G8SiFNG816dvS2JaoYIAsStoCGPekkrZQD4uxKswP5
	Rcgeiob0XKbdePuxCeo5sbWv/b5MBrvlJ1H/j+ZVJmoFTh9uobGxkk9YrEGPF0cn
	AY+oIZZR07M+gE67yabZQORA6QOFabC/ythLjBTjKVIVlCuvqFCrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euh9pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:57:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuI5D006967;
	Mon, 3 Aug 2026 15:57:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh61y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:57:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673FvX2949807780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:57:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547582004E;
	Mon,  3 Aug 2026 15:57:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58A1020043;
	Mon,  3 Aug 2026 15:57:31 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.27.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:57:31 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Praveen K Pandey <praveen@linux.ibm.com>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v2 3/4] powerpc: Add Power12 architected mode
Date: Mon,  3 Aug 2026 21:27:23 +0530
Message-ID: <20260803155724.3272052-4-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803155724.3272052-1-mahesh@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _9sJ15lWGqhJx3Z1BcCMZbPt1g-hIr1_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1x7VUoLLU+UZ
 /B+cvhTbR9oLRoOHX+iI/IAR141S2beqqCYJyQ3b1b99ScrQ3nFos7VPaNAoFjVdM5AP1KZSmqD
 jjnPV0WosUlpNuK4yQCXhlTrWI774mg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX46Q7MIya1e3Q
 NNsHvHPGbSC8KY+4jmo5SK1JbAzYFRBO6dyQsS/XKdDoRzXOnOUx2WgAvNGmoUZiGzFUAQZuKbf
 aMRmq/vMnizW8tf7590ApL9w+Bo220hmh7jEd3nOgITuIUuwcdc2NoeCUCn7hpnoLtlxojgpXSe
 gmpIpg7Bv7hlyPFGKWepqxp8BiZWTP3u9lzeo4mU5r0K3iZDtCsflvOnCdWzAfJ/WrM37lw1FKh
 BhO7Oe13dpHn8TTNfdhMY6OywIqzEthvkfZsTOzdh6It1gWqL5r8qFiXoIFkt/Wgc6sDHnXmb36
 kpjYKARKMsjq+KvRT/bDhjSja5IAYZVQ3CWd364DlDnzDCNtqN0SVR7otPGJKB9sokqx+6yO5Px
 J80ialtfqnXyS5ofkG50WYGsmx4zMagyyFbFdyVPP7qDAqdHaTwveM2QkvkYFtQi7oMwGkWF9Tz
 2DGc12HYXnrzbz5ZDQQ==
X-Proofpoint-GUID: utmxmfofvqJuzFGEFuHTT_iFYoajIG1z
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70ba72 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=MTFVyhIjbT-r1TZvI9sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

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
---
 arch/powerpc/include/asm/prom.h           |  1 +
 arch/powerpc/include/uapi/asm/cputable.h  |  1 +
 arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
 arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f4991d10d89ec..cd025c7225ee7 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
 
 #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
 #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
+#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */
 
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
index 6b50870759fd9..7ebfe048f97a2 100644
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


