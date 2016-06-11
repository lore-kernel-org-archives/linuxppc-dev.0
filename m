Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRVm32NymzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:19:31 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5B7IVZX060949
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 03:19:29 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23g1e6f424-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 03:19:28 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sat, 11 Jun 2016 17:19:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1AFF3578052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:19:05 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5B7It5e33357950
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:18:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5B7IT2E025289
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:18:29 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@ozlabs.au.ibm.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/perf: Initialise PMU related regs on POWER9
Date: Sat, 11 Jun 2016 12:48:12 +0530
Message-Id: <1465629495-17166-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add two new init functions __init_PMU_300 and __init_PMU_HV_300
to initialise PMU related regs on POWER9.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119fa8b0..a2080fde0cc5 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -87,6 +87,7 @@ _GLOBAL(__restore_cpu_power8)
 _GLOBAL(__setup_cpu_power9)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU_300
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -97,12 +98,14 @@ _GLOBAL(__setup_cpu_power9)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
+	bl	__init_PMU_HV_300
 	mtlr	r11
 	blr
 
 _GLOBAL(__restore_cpu_power9)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU_300
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	mtlr	r11
@@ -114,6 +117,7 @@ _GLOBAL(__restore_cpu_power9)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
+	bl	__init_PMU_HV_300
 	mtlr	r11
 	blr
 
@@ -219,3 +223,16 @@ __init_PMU:
 	mtspr	SPRN_MMCR1,r5
 	mtspr	SPRN_MMCR2,r5
 	blr
+
+__init_PMU_HV_300:
+	li	r5,0
+	mtspr	SPRN_MMCRC,r5
+	blr
+
+__init_PMU_300:
+	li	r5,0
+	mtspr	SPRN_MMCRA,r5
+	mtspr	SPRN_MMCR0,r5
+	mtspr	SPRN_MMCR1,r5
+	mtspr	SPRN_MMCR2,r5
+	blr
-- 
1.9.1
