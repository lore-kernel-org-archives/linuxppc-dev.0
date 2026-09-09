Return-Path: <linuxppc-dev+bounces-26921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F155AC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:33:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg0Zr1QVvz2yqX;
	Wed, 09 Sep 2026 22:33:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788957188;
	cv=none; b=O1bdMfvF0tx9ssQ3hClAW45SkjnLlNHKJO2xqIid2Lh44rt1bea0di/gSNi1HjKXOqM3UmH1zUYuj9vRvKHXXsHiqpkmEuSzjX2hqewTrWy3Bk+LtRn1FCDAryhIdxNkXolVpZlbVT+5mgDvGj87fyWwdRRYXW3vwCpp8vnfb2xiCwF9qZ55lHHwLanwur7toMgegeCEV3ODDQnfunmXQ4FbqeVswlloHWYZfHXqrR8emwVUkvr7qXcwfI8omD61o/c2yftmkg7tqzpZjYLsGWGvxRC0OLuStFzJbmUXWl+vRkIQp+rEyCrq0tpBDJP/mDwel0u1BLjeosjfLRvkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788957188; c=relaxed/relaxed;
	bh=/5vFsGpqEQE0g9vRTtZyj908nzHRVm72LBFbhri3370=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUgc23pS3dHbmu3yoaDlBuXM+PYEaD20Px7roq3tLRILqPWEC4s+/ovjE7kw4MbA2bPtYW5qA1SrtNX2RMBd3HnSZkSydndX3lJoMZ0Pf/J3D4bjN1S/+y7rUV+eKN2z4dpi65B/C+w6eeis9q7xMis7rcbu/vZo4rze6GMbCGaUZVKPsx6iF3ns720o98pLLlew138H6U/HZtSTx5ogEmcpmyi3BEybHFoHrrYmAhoHvX9QqOt4AesV0kl1/gROrWc2iiyBUtI3XFL2GgSHlD4PJXHqZdG06Cc99ycXjzhmIVRg0wPDHaEOhZn2pAF+FLiOSqg8mKx/Ppz+C0uXwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVHciryA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVHciryA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg0Zq2jHKz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 22:33:06 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1Wrr3802331;
	Wed, 9 Sep 2026 12:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/5vFsGpqEQE0g9vRTtZyj908nzHRVm72LBFbhri33
	70=; b=OVHciryAyKIRNulg3oXAtT9Hklswqqiho0cjdulrJbdNpwAoJ76pq7YWR
	P32eBEK5YNbrnryZ/CdbVMatw1w6CwwLyoXx5LjBXRGH0nOVE12W4GjJuHZkFm8B
	6PeNdq2jqrUKJtRkPOEgyQcOp/hfNTZxRl6Hw/1ag0EJiOIrTBRSazCId2RaYnoT
	P+Ke6mlADXfNtSa3RKXJmFs1KTTO0JtOEqXaz+LkUe55vgwOZyuPuSAELJPyqRi4
	pOXxz9RVnND44Tclv4NIq3ZBwn9CRzntZCNjD8pNjCnFcriOtYjOSZYBWphQIFlA
	FnmZetTkXneac3wOlKKa8tkLOexiQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkwu06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 12:32:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689CQEgP032693;
	Wed, 9 Sep 2026 12:32:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yj145-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 12:32:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689CWlU449873268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 12:32:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7F92004F;
	Wed,  9 Sep 2026 12:32:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C309F2004E;
	Wed,  9 Sep 2026 12:32:44 +0000 (GMT)
Received: from dhcp-9-123-0-173.bl1-in.ibm.com (unknown [9.123.0.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 12:32:44 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, mkchauras@gmail.com,
        sshegde@linux.ibm.com, ruanjinjie@huawei.com, ritesh.list@gmail.com,
        riteshh@linux.ibm.com, venkat88@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard
Date: Wed,  9 Sep 2026 18:02:40 +0530
Message-ID: <20260909123240.58786-1-venkat88@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MCBTYWx0ZWRfX6DSkZLpMTFUG
 Y3oeH7cb6vBvZUCaO1Mb7t6OS2AR9040RrFv5tGVyMpDJeBqsoqLX48PFmM45PqDrWiJD5AB2kb
 pzF0WjWo4sOfap7IzXOwVdWfiyslkXs=
X-Proofpoint-ORIG-GUID: 8LZh_vDYpInjXkjqfQHwGpu3cVW7qbJY
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa151f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=GkimHOW0OYmsbx9zQeUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MCBTYWx0ZWRfX40H35b5abnPi
 bOWF5LhmmT07+7V0cB+Th7q9BDeh5cVUmtO79DycCDjYWW3pBW1L2X2fZjDrZA0yms7HcjaPjxm
 U6or/UPWBCl0NUCqcaCO5L+EP2JF98bbLm4OxiGN8XiJRA1zKYDJLpVp+zyKdouDJQ1Tkgu5vrp
 oL2MwwxFPs4Zh7v/XOR2g5rmwTWh5qtc1CUHG9OuPlqRIkNSk2ZHV7NPdIqHBoSaDEnW2bBwZxH
 S8Y0Cs88faYwiefT7bW7P0tdi54N9o6KFXevsa9ZSyNMgUCOLGBl+EcYlAXlCri2yFb0jTgb87l
 UQ012Q9H8eXM9v4TsnFgKUDXJWu9wndNtM8iBXKY1dO7O41O/DGTbk839szL3QO6dRMSrv9Ouuu
 oL5eZRyHjjpz0XaN96pHknNcnhlSt1FcaenS/fsS37pHvdPEZmNwvrkbNV3Tc4M/f6TknBAqnXd
 xMB0GXs1DlP+BBg8a7w==
X-Proofpoint-GUID: PNPskdUCpJasQEKrfqEFAehm3tBYybOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090140

radix_enabled() uses a jump label which is only valid after
setup_feature_keys() is called. Before that point, on a pSeries
hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
cur_cpu_spec->mmu_features, but the jump label has not yet been patched,
so radix_enabled() incorrectly returns true.

The dangerous usage window where it goes wrong in early_setup():

    early_setup:
        configure_exceptions();
        <exceptions can happen now, and handler enter/exit can be invoked>
        <those could use radix_enabled(), which returns stale true>
        setup_feature_keys();
        <jump labels set up; post this it is safe to use radix_enabled()>

If an NMI occurs in this window, !radix_enabled() evaluates to false in
DEFINE_INTERRUPT_HANDLER_NMI. The handler fails to skip NMI entry in real
mode and attempts to access memory outside the Real Mode Area (RMA),
hanging the boot.

Since common interrupt wrappers do not have the context of early or late,
using early_radix_enabled() is the safer option. It does a plain bitmask
check against cur_cpu_spec->mmu_features and is correct at all times.

Console logs from a pSeries HASH guest showing values across boot stages:

[    0.000000] DEBUG: after early_init_devtree: early_radix_enabled=0 radix_enabled=1 (mismatch means NMI real-mode check is unsafe!)
[    0.000000] DEBUG: after configure_exceptions (DANGEROUS WINDOW): early_radix_enabled=0 radix_enabled=1
[    0.000000] DEBUG: after setup_feature_keys (jump labels initialized): early_radix_enabled=0 radix_enabled=0 (should now match!)
[    0.057124] DEBUG: post secondary CPU bringup: early_radix_enabled=0 radix_enabled=0 (should match!)

Console logs from a RADIX guest showing values across boot stages:

[    0.000000] DEBUG: after early_init_devtree: early_radix_enabled=1 radix_enabled=1 (mismatch means NMI real-mode check is unsafe!)
[    0.000000] DEBUG: after configure_exceptions (DANGEROUS WINDOW): early_radix_enabled=1 radix_enabled=1
[    0.000000] DEBUG: after setup_feature_keys (jump labels initialized): early_radix_enabled=1 radix_enabled=1 (should now match!)
[    0.057016] DEBUG: post secondary CPU bringup: early_radix_enabled=1 radix_enabled=1 (should match!)

Add the missing #include <asm/mmu.h> in alphabetical order since
early_radix_enabled() is declared there.

Fixes: 8d0e21012743 ("powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash")
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
---
v3:
 - Clarified early_setup execution flow and race window in changelog.
 - Explained why early_radix_enabled() is required for context-agnostic wrappers.
 - Added console logs for both HASH and RADIX guests in changelog.
v2:
 - Added Fixes: tag referencing commit 8d0e21012743.
 - Included <asm/mmu.h> in alphabetical order.
 - Added Reviewed-by tag from Mukesh.

 arch/powerpc/include/asm/interrupt.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 1b45a49e9bed..355f6bbf9894 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -70,6 +70,7 @@
 #include <linux/irq-entry-common.h>
 
 #include <asm/kprobes.h>
+#include <asm/mmu.h>
 #include <asm/runlatch.h>
 
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
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


