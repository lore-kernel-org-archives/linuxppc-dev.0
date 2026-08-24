Return-Path: <linuxppc-dev+bounces-26062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF276C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 08:12:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT3YV4hWVz2y8f;
	Mon, 24 Aug 2026 18:12:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787559150;
	cv=none; b=aZOMAiNRsa3VvtrltsuK1cWVJWf+XIsq2Drm+vGwzDykqjEwAaYzAKIhI8Y5zvTubeAQSNnjLMdKFxPUrXqZ8ztCpMIjX179TVpwCzM9pY78KQZqLAUtwOwdOGUj5vLnOKzkYDFN9FtTuEqnLdhOYjMPuaZrVq27NTZidTE2Z5m6aRXkKw8V/LHtVIa+z+FoS1lfc9mZ9/FGrgqtFzZ+c8fKyBmQegG5hd1FAFYMLMI+/aJo/M5901U++4sexaJJeMKIjuNaC+vlY3XwQqVmzw5qvttO7axHhkuy/Xeeb05DJEwjBAQzrRKI6Puiy3oxB43+d2TkMjE3hSCJnMSNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787559150; c=relaxed/relaxed;
	bh=tE0ryYXs8jHLsaVAu5JwnfVH4BaBNTwA4PoCXMDtNAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEibCbi7VItlGZl+RC1qn7szIEG7cvefwandKsw0lpiqpSSRY9aGNP4KxKnjLQZkanNXtW1FLPxbHjTFlbIZpjlM/MwhS4wOa6mKN5aLwujF9aHDrEU8rtIThprrrnsehAaNpfPxrmtZ00lcTpY17Dp78Y8RaeiEIOs32fpr6zRKXXbHj6+U2ihBOuSFYk+oz8x28/pvXx48vlluQefkwqJGVT4PB+vkDMsCcaofBgrd9rgE3pEGlf14frQGipOg19M1EbcNpWbfzpPCNEXOl5K9QF7qZjMC/s0PBpvkIKNnrRMuxCjUpSQpNdRS2jlGJMXGGx/Cir0LXGnQjy4d0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g6RdEpcm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g6RdEpcm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT3YT0Sbgz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 18:12:28 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5W9iv858587;
	Mon, 24 Aug 2026 08:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tE0ryYXs8jHLsaVAu
	5JwnfVH4BaBNTwA4PoCXMDtNAg=; b=g6RdEpcmZRKyo+JkbI5cDZokz3I5MvYfH
	nMI021fnNePknJTNp5+ZHAQXP10AT6S6YNS4tmEtZo9tod1IzIeprJU/1wJxPPp+
	vYI4ZF4daF64I5MNS/mkrWSxb+gmOkSwmUJH956N7iQgSvISTAy06raHm40qLVXj
	/ic13V+2fP1yduyVsVmR62NOShhn4/1yf/vA/XUzdKWVhOLRdqEvGP8w8IG1F0cB
	g9Y0u9Kd1EghWzx0br3t87/7D9o7i3TfboH4MRLKubgAjC3lFYWPR1jd6B0hLADW
	6ulRvd1KSJYZ+kN9yRvpFE+ej3VPbK45jOz8idke3ac6o3G+GC8mQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hg8ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8BIEf031919;
	Mon, 24 Aug 2026 08:12:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jmrqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8C6IT34800068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:12:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A70E22004B;
	Mon, 24 Aug 2026 08:12:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C190120043;
	Mon, 24 Aug 2026 08:12:03 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:12:03 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 1/4] powerpc/mmu: do MMU type discovery before crashkernel reservation
Date: Mon, 24 Aug 2026 13:41:59 +0530
Message-ID: <20260824081202.264913-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
References: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX3icGCukCjVyJ
 0d4sBvVAY1KumuhdLlxTSln8IIaIH5miIT0HoWW/l9OqDk15obkTAm+7sNsxFiYx0jfLr3VNCtl
 nd1PDKNDN9stAPAcV5/Fc/FXZ+410Zo=
X-Proofpoint-GUID: h8BPRvXNJVw2yVZsVC3Bmkt0FCroMtnm
X-Proofpoint-ORIG-GUID: ROvQMZqEcrUTT5EI-yta49BvObeClHqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX2bYx/Chj+kCj
 OacxktlkapwX9YDY9ibSJlWlVE1ZtwxTulOaBLslgE0pOKvce0C8hvx07Y40eSfQIol77kUAPtC
 ko+sbqSfOs+i5+9ils+1IeSoEjll6V2hBchsxCXf9ebWk5jd5muAaKpkUmVR8W7OGP4bWTEAI7n
 S4FwxtFfYdCVt7l9skAGKGCYmh8VRWkGkazDTNbAFJLOYk0fHvFrKlzmhDyEgqooyZQP+GlN0aC
 rT5lflMkzoeE/lFbTHA1mst7CnMZGzyfWHN2WElbrQAV+/kYw0NiBBUrAHAq0bGZareqyX6blYR
 /JOlnXgtAkZsEm5gft7eTYz/3T7kQVN5yCkP2/w6BuFzZ6RQy1tXu3L+IktWYjwlqW4tGbjH0Ni
 HzB4173GYHRKUXztnMeyBeN9yDnXXn3tJqtRt3JS52E9vHd0MxKj1mbIiIv50Z82cKpaGtEoiG6
 WuK2HNfMsNK1BK+z5Dw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8bfcdc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=bbawtwL6tTt_ul8dUhYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240070

Crashkernel reservation on high memory depends on the MMU type. In
particular, arch_reserve_crashkernel() needs to know whether the radix
MMU is enabled when selecting the crashkernel reservation.

arch_reserve_crashkernel() is intentionally called early during boot.
The crashkernel memory needs to be reserved before other components
make memory reservations, as those reservations could interfere with
finding a suitable region for the crashkernel at the required offset.
Therefore, moving arch_reserve_crashkernel() to a later point is not a
suitable solution.

Instead, make the MMU type available before arch_reserve_crashkernel()
is called. The MMU type is determined from the FDT and kernel
configuration and is recorded in cur_cpu_spec->mmu_features.

early_radix_enabled() uses cur_cpu_spec->mmu_features to determine
whether the radix MMU is enabled. However, the MMU type discovery was
previously performed as part of mmu_early_init_devtree(), which runs
after arch_reserve_crashkernel(). Split the MMU type discovery from the
rest of mmu_early_init_devtree() and perform it before
arch_reserve_crashkernel().

This makes early_radix_enabled() usable from
arch_reserve_crashkernel(), which will be used by the following patch
to select the appropriate crashkernel reservation on high memory.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/kernel/prom.c               | 29 +++++++++++++-----------
 arch/powerpc/mm/init_64.c                | 26 +++++++++++++--------
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 48631365b48c..d820640f2739 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
 
 /* MMU initialization */
 void mmu_early_init_devtree(void);
+void mmu_early_init_type(void);
 void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 #ifdef CONFIG_PPC_PKEY
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 5f9c5d436e17..da0b498bd475 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -384,6 +384,7 @@ extern void early_init_mmu_secondary(void);
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
 static inline void mmu_early_init_devtree(void) { }
+static inline void mmu_early_init_type(void) { }
 
 static inline void pkey_early_init_devtree(void) {}
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9ed9dde7d231..4fc53129e6ee 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -853,6 +853,22 @@ void __init early_init_devtree(void *params)
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, int_vector_size);
 	reserve_kdump_trampoline();
+
+	DBG("Scanning CPUs ...\n");
+
+	dt_cpu_ftrs_scan();
+
+	/* Retrieve CPU related informations from the flat tree
+	 * (altivec support, boot CPU ID, ...)
+	 */
+	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
+	if (boot_cpuid < 0) {
+		printk("Failed to identify boot CPU !\n");
+		BUG();
+	}
+
+	mmu_early_init_type();
+
 #if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/*
 	 * If we fail to reserve memory for firmware-assisted dump then
@@ -884,19 +900,6 @@ void __init early_init_devtree(void *params)
 	 * FIXME .. and the initrd too? */
 	move_device_tree();
 
-	DBG("Scanning CPUs ...\n");
-
-	dt_cpu_ftrs_scan();
-
-	/* Retrieve CPU related informations from the flat tree
-	 * (altivec support, boot CPU ID, ...)
-	 */
-	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
-	if (boot_cpuid < 0) {
-		printk("Failed to identify boot CPU !\n");
-		BUG();
-	}
-
 	save_fscr_to_task();
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 64f0df5bb5cd..4916ed230600 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -614,7 +614,8 @@ static void __init early_init_memory_block_size(void)
 	of_scan_flat_dt(probe_memory_block_size, &memory_block_size);
 }
 
-void __init mmu_early_init_devtree(void)
+
+void __init mmu_early_init_type(void)
 {
 	bool hvmode = !!(mfmsr() & MSR_HV);
 
@@ -626,6 +627,20 @@ void __init mmu_early_init_devtree(void)
 			pr_warn("WARNING: Ignoring cmdline option disable_radix\n");
 	}
 
+	/*
+	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
+	 * When running bare-metal, we can use radix if we like
+	 * even though the ibm,architecture-vec-5 property created by
+	 * skiboot doesn't have the necessary bits set.
+	 */
+	if (!hvmode)
+		early_check_vec5();
+}
+
+void __init mmu_early_init_devtree(void)
+{
+	bool hvmode = !!(mfmsr() & MSR_HV);
+
 	of_scan_flat_dt(dt_scan_mmu_pid_width, NULL);
 	if (hvmode && !mmu_lpid_bits) {
 		if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
@@ -638,15 +653,6 @@ void __init mmu_early_init_devtree(void)
 			mmu_pid_bits = 20; /* POWER9-10 */
 	}
 
-	/*
-	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
-	 * When running bare-metal, we can use radix if we like
-	 * even though the ibm,architecture-vec-5 property created by
-	 * skiboot doesn't have the necessary bits set.
-	 */
-	if (!hvmode)
-		early_check_vec5();
-
 	early_init_memory_block_size();
 
 	if (early_radix_enabled()) {
-- 
2.55.0


