Return-Path: <linuxppc-dev+bounces-26653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBDC79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hddK53Bwsz2yvY;
	Mon, 07 Sep 2026 17:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788764489;
	cv=none; b=bclTnEDIkAo91WUjwlx31YdHrY81TUUJRM3sBqgTqnHDRQXKa2O/J2Oj4FtJN3GJhdNhza4Nqsnq73GdSelFVKotSmuMlqSIycgbAchdSw0E0YXvn3a2dBOAAYGiSbQVIockguoSxD0ziTVe0fF0qFQrzFqajg/A8MTOwHoA+9YMGlv2uZHLeaDOwC0Lj+507crr6Oz2SIGxvOiYOTS8vB9BEXZ1iqkScWO4jXCcf7kW0mJ1AuhDARhE8wTrFvGs5zZrr5touy1TC6EuwTVVPYl+C3M14jl9XeWAcm6NjRC1hPy3lWgS3ArPF9h7Sxn6NKmGDfpXPNf2tN+cOQ3Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788764489; c=relaxed/relaxed;
	bh=v8di2ReL4fJeqRZ238VxsSIj62HayuEaxotlyw13MFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ofks2XxOd77LxyVXXDRPHOFXHDWUrNEnIeLQCqEtEyhPLOSoe/9XGtmxbjzQrK2IhfJRMAxmqmxIW8fR2CqQPOhdbTXGTB+Mxh/1iEtSu8e+iFYv/A1KRVSdODjiopbF+MxhHZ6FL9lxr6p873hS7+5qWhw280WwOfr7oYlTVeOXwD0yWyAKiBjZ5zFaN9Tj6/8UTuvOTLzGg/gw/Bh5mnD7nIvGmR/GJhClkNFe1KRT0aChdcO/K+dxdO3YqW4vV8a0rP08aP7QtRAmqaQyPTzER1GLKyyvkh/AiWFZr6Ga4aO8vLFLBMM+2uUU4osUps6wIUt1YnRUd11UQrqO0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tWgMKxGw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tWgMKxGw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hddK42m1Hz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 17:01:27 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68741bZv3104714;
	Mon, 7 Sep 2026 07:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=v8di2ReL4fJeqRZ238VxsSIj62HayuEaxotlyw13M
	Fs=; b=tWgMKxGwsFiXBU9Z4K4mRIJdS0ntDSHxn5k1qrPz5fhyFY2eBxGbbOw9v
	EQ3n3EMSzyUKB/UqH3vyTU1h9yaNbt5LzB4by9/ywtmXWbNFJ1YzEIZoV5erreH0
	Hjr22QCy5sCOk5B0aO9vv/TtgSO4e5Kf7MaDTvQ36oV9LRSDkSZgsOTWyomN+Wa+
	egn9TJdyT14APIgd3bx6LEX61XtGLO34DRxrH64E/yo+1Fs0Wlf7O88AazLYx5Cn
	BiTQiOEg2bIE3DGyhz63XNyJ3YjXK2U7uel7S2DpIYLH/3RnDR9HUF/06nKO8YcO
	gDYap0WF0Ta9/s9+o3H9dFHn/4vFQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjq2wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 07:01:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6876uFJI016207;
	Mon, 7 Sep 2026 07:01:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y47vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 07:01:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687719IX35062144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 07:01:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F3D2004B;
	Mon,  7 Sep 2026 07:01:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D207D2004F;
	Mon,  7 Sep 2026 07:01:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.246.56])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 07:01:03 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, mkchauras@gmail.com,
        sshegde@linux.ibm.com, ruanjinjie@huawei.com, ritesh.list@gmail.com,
        riteshh@linux.ibm.com, venkat88@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard
Date: Mon,  7 Sep 2026 12:30:58 +0530
Message-ID: <20260907070058.26338-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-ORIG-GUID: 2Fps_JePDCXjmmOstfv-_lAJwGP-2RU-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3NCBTYWx0ZWRfXybpmLHr7Bqck
 EPjaj+0efPArnyXtHAAA20mwXMtMNdluPFbNY6GUqwbXkg8OgTbtRBp4rQd30rbJD2i4hYT8qvt
 qh4Eblg9zXjExiTfc1+6C1bijEYxtYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3NCBTYWx0ZWRfX8CFmN7ZS5Ya0
 gj7ZwCjXZ9RcgtiPRENxb2K7pa1BEFhMOyHNHbGVKkv5/8+7/tpKucyitAHABgd53H3qiCqus6b
 vMbcGy4nM5CkTKazAQU5nz8AkQg9r/2V30pB/qHWMH8b1WQ258M/fzjC4V4w4Q7LEA6I9qLaOZh
 8UrZIcYh/hE9f8RAE5suzUNjpdp93SfEBKNZu8U+GzuJ1Ixr97a82foaUzpZEyd9/r2u31UPB8t
 rFpc7DMyvDknLq8XMgp4l2T8j8D7pNkbAhyL4w1no4nHexzTDATPjq/6D0JElK/nzK3MgswGI4Q
 6rUAOQCM+xlGB6HQLckcCG4VZ0wv4Q/PGsnBnkk/Ir+gRdaoYmWaQPVWIeHRvjl+g94+r/dddrV
 R42pZkQtWrVSc3EKaolo6Dv9aIXQZUWv0plAgQFxq/WXEtK9bq0UY71Clf9wYH4fFiy3fGgW9QC
 fmpWEuOgsfuGqwhxfXw==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e613a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gZpiDA7bhwe5fsxDx_8A:9
X-Proofpoint-GUID: MWdhOWnnSkoJLfRMe_OTuiHmUgXA5o60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070074

radix_enabled() uses a jump label which is only valid after
mmu_feature_keys_init() is called. Before that point, on a pSeries
hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
cur_cpu_spec->mmu_features but the jump label has not yet been patched,
so radix_enabled() incorrectly returns true.

Replace radix_enabled() with early_radix_enabled() which does a plain
bitmask check against cur_cpu_spec->mmu_features and is correct at all
times, including before jump label initialization.

Add the missing #include <asm/mmu.h> since early_radix_enabled() is
declared there.

Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 arch/powerpc/include/asm/interrupt.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 1b45a49e9bed..36a654e780f7 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -71,6 +71,7 @@
 
 #include <asm/kprobes.h>
 #include <asm/runlatch.h>
+#include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 /*
@@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
 		state = irqentry_nmi_enter(regs);			\
 	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
 		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
-		   !radix_enabled()) {					\
+		   !early_radix_enabled()) {				\
 		/* no nmi_entry for a pseries hash guest		\
 		 * taking a real mode exception */			\
 	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
@@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
 		irqentry_nmi_exit(regs, state);				\
 	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
 		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
-		   !radix_enabled()) {					\
+		   !early_radix_enabled()) {				\
 		/* no nmi_exit for a pseries hash guest			\
 		 * taking a real mode exception */			\
 	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
-- 
2.45.2


