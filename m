Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rczmJ68BjzDqlt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:36 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5QHXpMK114452
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 13:37:34 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23snu2a1u3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 13:37:33 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 03:37:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 35A382CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5QHbStf67043370
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5QHbRaf025824
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:28 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 3/6] powerpc/perf: factor out power8 __init_pmu code
Date: Sun, 26 Jun 2016 23:07:06 +0530
In-Reply-To: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1466962629-30692-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out the power8 pmu init functions to share with
power9. Monitor Mode Control Register S(MMCRS) and
Monitor Mode Control Register H(MMCRH) registers are
dropped in Power9. These registers are added to new
function which are included for power8 init.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119fa8b0..ec8a228df2f6 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -51,6 +51,7 @@ _GLOBAL(__setup_cpu_power8)
 	mflr	r11
 	bl	__init_FSCR
 	bl	__init_PMU
+	bl	__init_PMU_ISA207
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -62,6 +63,7 @@ _GLOBAL(__setup_cpu_power8)
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
+	bl	__init_PMU_HV_ISA207
 	mtlr	r11
 	blr
 
@@ -69,6 +71,7 @@ _GLOBAL(__restore_cpu_power8)
 	mflr	r11
 	bl	__init_FSCR
 	bl	__init_PMU
+	bl	__init_PMU_ISA207
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	mtlr	r11
@@ -81,12 +84,14 @@ _GLOBAL(__restore_cpu_power8)
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
 	bl	__init_PMU_HV
+	bl	__init_PMU_HV_ISA207
 	mtlr	r11
 	blr
 
 _GLOBAL(__setup_cpu_power9)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -97,12 +102,14 @@ _GLOBAL(__setup_cpu_power9)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
+	bl	__init_PMU_HV
 	mtlr	r11
 	blr
 
 _GLOBAL(__restore_cpu_power9)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	mtlr	r11
@@ -114,6 +121,7 @@ _GLOBAL(__restore_cpu_power9)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
+	bl	__init_PMU_HV
 	mtlr	r11
 	blr
 
@@ -208,14 +216,22 @@ __init_tlb_power9:
 __init_PMU_HV:
 	li	r5,0
 	mtspr	SPRN_MMCRC,r5
+	blr
+
+__init_PMU_HV_ISA207:
+	li	r5,0
 	mtspr	SPRN_MMCRH,r5
 	blr
 
 __init_PMU:
 	li	r5,0
-	mtspr	SPRN_MMCRS,r5
 	mtspr	SPRN_MMCRA,r5
 	mtspr	SPRN_MMCR0,r5
 	mtspr	SPRN_MMCR1,r5
 	mtspr	SPRN_MMCR2,r5
 	blr
+
+__init_PMU_ISA207:
+	li	r5,0
+	mtspr	SPRN_MMCRS,r5
+	blr
-- 
1.9.1
