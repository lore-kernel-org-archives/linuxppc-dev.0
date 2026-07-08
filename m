Return-Path: <linuxppc-dev+bounces-23827-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAB4C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLG340fZz3bwk;
	Thu, 09 Jul 2026 00:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783521275;
	cv=none; b=kiwgOKjB55hKnMSVp81sfstBjBSXaUkVQi4q1PwblAdkfgHPGCC2fDG/omWKU7A6DAUyB/y1/1zMBJEjb9SgH75d09rEMlNfyRzLDn0bq+Bmq5wKT6T0rMkCpQiEWx0pWBw+gkmFP5MDdolldzrC3pM/JKcebXR3nMpsabY7/CPzANJsVJwaFjvsUVxcwDG0vxLqEjugh6uzJNk+UO0c3xFzmxz1U7Nz70yHsR7MUvjBuLf0G6ApKn22Ylut/FFZ4YuhhpaNyO9SXBM6dRBzuzFk5XzNEjrTeJvpPQUcrJA2tm8/Rf9gpYwKoiPWkzfw4tAFkCPsLA0oCw7v+BPM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783521275; c=relaxed/relaxed;
	bh=XB34Xdn5iqtQB9PeJvhCld93eLuEO+a1k24nWxHqs0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqY0lloo6n9N1F4cMdEPkTEWzesfAgEcgYZOfnIQs8h7Uzj/8jz+SMgqoOFPiM3Y67RawcT0FvxxBLHIimFs3foa0Xqlq9zJIX8Ul1MmFjiIT8sdAXDMKLQ2155kJYI0LuETuXRpe7L8b93Cw6JxVBCj5OKfMgaa0k+37aKkmjW+YX1C6s8r4s1VZFy+vQXtSbzyzNkqPBGKTluCX+Na7i4mlPL/WWPIKf2nU/En0N7gZP0yS4CcPH1PboOqN8DKkl4lX3IR3j3u2UA9qMWNeNVKQU4d+PRR2YDaA3/wARZ5PlpoPTNknH/3XkoW+4u65gmlqOA2SvlprMDB/3aWNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n4YHT3mT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n4YHT3mT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLG265YXz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:34:34 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIRhx3748310;
	Wed, 8 Jul 2026 14:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XB34Xdn5iqtQB9PeJ
	vhCld93eLuEO+a1k24nWxHqs0Y=; b=n4YHT3mTB6kiwfjOmvajYjlc7RMwTCzAe
	xTJjNzciUh1nbMJ7BMBYmVOQ2MoiKt8/JsAocnXVfcH49o3wR/qqeWzOYWNJM5vy
	F9l2zd0hQOPPMHrmaKgfY3RamBdp5jZ+4aAVMzFmIggRzWZZDwM1QiVet3ykrwGM
	qx6UaQJvtPf1+1oXsRMWIe163opF79PE5i5SnIJlgbOIDFzNHQKD6UbBcPisCH5C
	ZZdAvpaJsJvh6gD+TvyIM6lZ2p6o6YsV4RD/8Tn0Am5Nrp9jq7+HKyEKG9zShIvr
	GW++fcVnpztionjI8YFBOEl0iI7Upv6cmHd9RTj9ksP7RaQMpT2CA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqvjt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJasW023455;
	Wed, 8 Jul 2026 14:34:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y83v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668EYNlI25952888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:34:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C025B20043;
	Wed,  8 Jul 2026 14:34:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE72D20040;
	Wed,  8 Jul 2026 14:34:20 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:34:20 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 4/4] powerpc/kdump: add support for high crashkernel reservation
Date: Wed,  8 Jul 2026 20:03:57 +0530
Message-ID: <20260708143357.673251-5-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX/d6+mTBGe+H7
 V7dKK0/IPgfIgN+fu2mDK16B+dhR0NuFUPTT68ItrnhXqvnzo5au3RF9Eu6OacW488+ncompt4R
 62qnaKOXQTFIH7V0L1KQ0r9w3LtGPjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX/OC34SRBpADO
 Foj+rK9DqJaMvGn3tL0p/TtBOmomjTTgukWLgwkkgmgUsqq2mjYbTVw1NsCMWVYi7SLAYYv/v0q
 IiS0JPZyaL5yoU7ysuV8ee465b43X59SShWdHagyq1WjigNVaoTorR9sm8nfXuPf0JCcswiN63g
 oNiSh3qcuycjjetZy+RFJlcr0hnhWCAYpvFtbJzGQD8T7Nh1zHmUaAEUuGOd5FpruQ22bOZYUfQ
 ZnQCyBjXj+rLiJAzRO8xyQuIHAEJGWz33nfpYGZm68YYFECQnJAoRaEOUfsW63vwXIvupJU/iBh
 BFwgbHUJ7jfZetrIrjQfVd+Ektmm8ZVi3qgvCqPVvbxoky9QXQV2ODjhr/A7sdiERxJ1+zjXiJ1
 IxpFBibDtUBZ1t8XPwVt8rw+OvsKr9ROMXw2JX1UH5LdKspIoGPiuRO3rtMRdEBFeTCIpqT0VIw
 pmngz0RziG4GEDq115Q==
X-Proofpoint-GUID: tTMRUBMU-aYWuEvQXtE5ZjFtkvyqnW1E
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e5ff4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=xxU2pcodL4BFR_vyWlEA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: zvMA0bYzcqjr9NhLn1lj7rJqVkVsveZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140

With this changes included crashkernel=xxM,high will be supported on
powerpc. This allow user to allocated crashkernel memory on higer memory
region and keeping the low memory allocation minimal.

The low memory reservation is by default set to 64 MB and it is reserved
below RTAS_INSTANTIATE_MAX (1G) to make sure rtas instantiation work
properly.

powerpc uses generic crashkernel parser and reserve functions and they
are capable of handling high crashkernel reservtion so
arch_reserve_crashkernel() is updated call generic crashkernel praser
and reserve function with resptive options to make
crashkernel=XXM,high prase and make crashkernel memory get reserved on
higher memory regions.

Note: High crashkernel is supported only on PPC 64-bit systems when
64-bit RTAS is instantiated and Radix MMU is enabled; otherwise, the
crashkernel reservation falls back to the default, even if the kernel
command includes crashkernel=XXM,high.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/crash_reserve.h |  6 ++++
 arch/powerpc/include/asm/kexec.h         |  1 +
 arch/powerpc/include/asm/rtas.h          |  9 +++++
 arch/powerpc/kexec/core.c                | 45 +++++++++++++++++-------
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/crash_reserve.h b/arch/powerpc/include/asm/crash_reserve.h
index d1b570ddbf98..4f2096984736 100644
--- a/arch/powerpc/include/asm/crash_reserve.h
+++ b/arch/powerpc/include/asm/crash_reserve.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_CRASH_RESERVE_H
 #define _ASM_POWERPC_CRASH_RESERVE_H
 
+#include <asm/rtas.h>
+
 /* crash kernel regions are Page size agliged */
 #define CRASH_ALIGN             PAGE_SIZE
 
@@ -12,5 +14,9 @@ static inline bool arch_add_crash_res_to_iomem(void)
 }
 #define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
 #endif
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_64M
+
+#define CRASH_ADDR_LOW_MAX	RTAS_INSTANTIATE_MAX
+#define CRASH_ADDR_HIGH_MAX	memblock_end_of_DRAM()
 
 #endif /* _ASM_POWERPC_CRASH_RESERVE_H */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index e02710d6a2e1..9e676bd3bf03 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -118,6 +118,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 int __init overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void arch_reserve_crashkernel(void);
 extern void kdump_cma_reserve(void);
+unsigned long long __init get_crash_base(unsigned long long crash_base);
 #else
 static inline void arch_reserve_crashkernel(void) {}
 static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index aaa4c3bc1d61..d290437d8131 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -561,6 +561,14 @@ static inline int page_is_rtas_user_buf(unsigned long pfn)
 	return 0;
 }
 
+static inline bool is_rtas_high_crashkernel_capable(void)
+{
+	if (rtas_64)
+		return true;
+
+	return false;
+}
+
 /* Not the best place to put pSeries_coalesce_init, will be fixed when we
  * move some of the rtas suspend-me stuff to pseries */
 void pSeries_coalesce_init(void);
@@ -569,6 +577,7 @@ void rtas_initialize(void);
 static inline int page_is_rtas_user_buf(unsigned long pfn) { return 0;}
 static inline void pSeries_coalesce_init(void) { }
 static inline void rtas_initialize(void) { }
+static inline bool is_rtas_high_crashkernel_capable(void) { return true; }
 #endif
 
 #ifdef CONFIG_HV_PERF_CTRS
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index dc44f11be353..81fc437377c8 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/ftrace.h>
 
+#include <asm/rtas.h>
 #include <asm/kdump.h>
 #include <asm/machdep.h>
 #include <asm/pgalloc.h>
@@ -64,7 +65,7 @@ void machine_kexec(struct kimage *image)
 
 static unsigned long long crashk_cma_size;
 
-static unsigned long long __init get_crash_base(unsigned long long crash_base)
+unsigned long long __init get_crash_base(unsigned long long crash_base)
 {
 
 #ifndef CONFIG_NONSTATIC_KERNEL
@@ -104,35 +105,55 @@ static unsigned long long __init get_crash_base(unsigned long long crash_base)
 #endif
 }
 
+static bool high_crashkernel_supported(void)
+{
+#if defined(CONFIG_PPC64) && (defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV))
+	if (early_radix_enabled() && is_rtas_high_crashkernel_capable())
+		return true;
+#endif
+	return false;
+}
+
 void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, crash_end;
+	unsigned long long crash_size, crash_base, crash_end, low_size = 0;
 	unsigned long long kernel_start, kernel_size;
 	unsigned long long total_mem_sz;
+	bool high = false;
 	int ret;
 
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, total_mem_sz, &crash_size,
-				&crash_base, NULL, &crashk_cma_size, NULL);
+				&crash_base, &low_size, &crashk_cma_size, &high);
 
 	if (ret)
 		return;
 
-	crash_base = get_crash_base(crash_base);
-	crash_end = crash_base + crash_size - 1;
+	if (high && !high_crashkernel_supported()) {
+		high = false;
+		low_size = 0;
+		pr_warn("High crashkernel unsupported, using standard reservation");
+	}
 
-	kernel_start = __pa(_stext);
-	kernel_size = _end - _stext;
+	if (high) {
+		crash_base = 0;
+	} else {
+		crash_base = get_crash_base(crash_base);
+		crash_end = crash_base + crash_size - 1;
 
-	/* The crash region must not overlap the current kernel */
-	if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
-		pr_warn("Crash kernel can not overlap current kernel\n");
-		return;
+		kernel_start = __pa(_stext);
+		kernel_size = _end - _stext;
+
+		/* The crash region must not overlap the current kernel */
+		if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
+			pr_warn("Crash kernel can not overlap current kernel\n");
+			return;
+		}
 	}
 
-	reserve_crashkernel_generic(crash_size, crash_base, 0, false);
+	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
 }
 
 void __init kdump_cma_reserve(void)
-- 
2.52.0


