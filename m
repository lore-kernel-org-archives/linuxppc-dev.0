Return-Path: <linuxppc-dev+bounces-23824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C8C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLFp6xgRz309r;
	Thu, 09 Jul 2026 00:34:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783521262;
	cv=none; b=dHV7pDNe3erE5cYbASfW6nmJCah7a4RAWS2OBTUQUCjdXvOW+Hr8GlMQ1M1p00r4aGEvoU5OeMjgHjEsU/y8VV76pNdAZTYFRstpRxd1qABaHB4kI7o7SLmwj0dKZtVd3hznxMn9SfuwM4cyZ23PRMTyTvmAR4tAyZxfpua6O5ugmB9wCPMNDGTSAECbhflZXzZqg1oWFE4QnQsxpOiNlwWnnnhAIlBMl7XHa9ixsb0WA+QXRw7S+yJcqoetQ4RfTuPgfIB+bhXB83PxEsRJ286ij6l+eU/LJ26nF97u0k9nca+GVA0J5hEKXStxoDlsPBLRwSSVHeVSuxNtixzf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783521262; c=relaxed/relaxed;
	bh=OMeHnb5x/GvwtvL1gRU7w3UaLipMS500wIoIcT9z+Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjqcOLoqL2OQrDMrRp3zV4EERvotf8yhtD5GNUzfss5ZEgS5qgRxGEZHU3oGmwaBwz1GbNZPWkuf3hHcLEk8NxOVCRKBez+CzZfnLNHGk7NmM9+Yt123Y2pFzBNJrsUlX2FShHmcZGRN7LcpOAXiTIcQYua1BFjy3wdyxEGreSxpgOMH5XNRnrxjdpwHWMvclobdAgUCvQRPQ4PY0C3vjSho38bCxEb3C0vIKDNliWbJkH9arQD831RyFs+xb7GAAtkZ03Sx23jK3vEiyI0rxCLZrK1KmEWdpqvPtiVY30kzWcrVaD5lgvgytgrkYHm5s6iBCQsAif2yMVxm/8456g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K8ftYgqH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K8ftYgqH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLFp1W1xz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:34:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIS0x3389793;
	Wed, 8 Jul 2026 14:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OMeHnb5x/GvwtvL1g
	RU7w3UaLipMS500wIoIcT9z+Uk=; b=K8ftYgqHU25/H/BvNc4Qk5hy0bdPVJF9P
	HHDJnqXnKM5qGLCHcCEzxkFkmjLRnk8QSeda8AQYc5cAvxl/DHK7q26tlaYga8DO
	HNh874qX6w28o56FX6m8p0ikH1PHNeNdWMjZgXMpSyNq6Sf+sRcgyL1JQ/JyziA9
	A1lzUKYGKmbEX6hnY4Gpj+2iuy1ZMcGRyoaaKQlISsMVKm1g6O6sN4CJI6rEBBR4
	RT3s+aDw4SyRFq1aOl+lhrlkLbtnrlebMGqIYPFv1z6pdgb2mNBie+dc4Lbp3Sb/
	Hy0x0l4A33h9hJOXHw10hkSHD1FqA+/kj1qO6mvAAfPRJxLzma9GQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknmcpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJdDj021538;
	Wed, 8 Jul 2026 14:34:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk8ep0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668EY8Og37290408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:34:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4EE820043;
	Wed,  8 Jul 2026 14:34:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D481E20040;
	Wed,  8 Jul 2026 14:34:05 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:34:05 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 1/4] powerpc/mmu: do MMU type discovery before crashkernel reservation
Date: Wed,  8 Jul 2026 20:03:54 +0530
Message-ID: <20260708143357.673251-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e5fe5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nC_Zigu5wQN0fnOdCJgA:9
X-Proofpoint-GUID: Q-p6W70TjHwcI1g1nPfvodvS4jRWW8W9
X-Proofpoint-ORIG-GUID: l_zkd83XZQoRze9OBPMfWQxLO7fQMG5a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX6pcC5Bx3o9Y9
 WDjPA0zwGfPRFYy/7dFTzPm1lKU3Nl6LsfvRy5FHxUkjF4IEh38HVZCfYbWJpY+FqUJuOxa6I0s
 +USwXNFtigE5SF44CAkIhh0ZTzLRKJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfXyYY6T/AYSuwZ
 N7b3QYfEl6M/eB/d6q8CfAa8iQioJBWcADHfcu9cl6HLygw9wM7jxe9GuPl44BcXMFolGeNW9u5
 YiDXzW7tDrU5s9YLnw6ohgTuApY+HGgmhrMU9yUUsQ0VQdlpoFLWfkXXN8R/OVbmXg5KU8zzRiX
 36AobaWsvlw0g/B6vhsh1fr9FFdqzfdE1VSs0jqa9eUo314WM3nRBjTKqYX8bugCl7XzIMv0nyu
 QOnXBUiIdMP+gf/4hha92FdhL6fCoWaP2rAEOaU21vsbipXOVjrx9zY56aaN6Z756NU5FRNuZ3c
 bX6NUlTatN7IahZSaVb3DKBpXPIhP6zhiQ2tTZrWtBknjJgCCVb7psjEKtG7TaAlJ+yQGV7Z/9O
 Q19SjNebBjMo7zkGvowxsLx0OvE0WHxl2yUqzz0bDVsFC6eayfG8WsEbowgrpW77SiNLq1G07go
 rzY+3I3GH1WIAp784FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140

Crashkernel reservation on high memory depends on the MMU type, so
finalize the MMU type before calling arch_reserve_crashkernel().

With the changes introduced here, early_radix_enabled() becomes usable
and will be used in arch_reserve_crashkernel() in the upcoming patch.

early_radix_enabled() depends on cur_cpu_spec->mmu_features to find
out if the radix MMU is enabled. The radix MMU bit in mmu_features is
discovered from the FDT and kernel configs. To make sure the MMU type is
finalized before arch_reserve_crashkernel() is called, the function that
scans the FDT and sets mmu_features, along with some bits from
mmu_early_type_finalize(), has been moved above
arch_reserve_crashkernel().

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/kernel/prom.c               | 28 +++++++++++++-----------
 arch/powerpc/mm/init_64.c                | 27 ++++++++++++++---------
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 48631365b48c..7a3b2ff02041 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
 
 /* MMU initialization */
 void mmu_early_init_devtree(void);
+void mmu_early_type_finalize(void);
 void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 #ifdef CONFIG_PPC_PKEY
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 5f9c5d436e17..c40dc6349e55 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -384,6 +384,7 @@ extern void early_init_mmu_secondary(void);
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
 static inline void mmu_early_init_devtree(void) { }
+static inline void mmu_early_type_finalize(void) { }
 
 static inline void pkey_early_init_devtree(void) {}
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9ed9dde7d231..db1615f26075 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -853,6 +853,21 @@ void __init early_init_devtree(void *params)
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
+	mmu_early_type_finalize();
 #if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/*
 	 * If we fail to reserve memory for firmware-assisted dump then
@@ -884,19 +899,6 @@ void __init early_init_devtree(void *params)
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
index 64f0df5bb5cd..2fd533bc17cc 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -614,8 +614,10 @@ static void __init early_init_memory_block_size(void)
 	of_scan_flat_dt(probe_memory_block_size, &memory_block_size);
 }
 
-void __init mmu_early_init_devtree(void)
+
+void __init mmu_early_type_finalize(void)
 {
+
 	bool hvmode = !!(mfmsr() & MSR_HV);
 
 	/* Disable radix mode based on kernel command line. */
@@ -626,6 +628,20 @@ void __init mmu_early_init_devtree(void)
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
@@ -638,15 +654,6 @@ void __init mmu_early_init_devtree(void)
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
2.52.0


