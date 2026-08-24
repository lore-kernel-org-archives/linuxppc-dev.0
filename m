Return-Path: <linuxppc-dev+bounces-26064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF6FC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 08:12:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT3YY4dXZz2ytj;
	Mon, 24 Aug 2026 18:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787559153;
	cv=none; b=QNq608Rkyxu/lCazqug02Jlta9jMNRYG3V73X3N4htKV+1cbxKi19DpV5lePJ4SyBeNTKgnZLJKqrYqXnf6+SHLym8bLkla+SuZB+2icpAoigXZJYSC+yZRqq2S/hIHt8IzYKAmPZW/rWayZkE59M/S1MR6oMIvyNP8sXmSt/V9dN+lgwsqFI8D4Xz2cVgbIgq0BBOGqBCfjSEPmVtNJduDzON4FlMzZQO3px4A5mp7hQZoWHcCRdSWaVEj7iI9fR6UrDNnrltoHQuJ9o8JFFzpg4ea/OGdviju9iDatNA6WtPjjmwzMdgewe0iXMtlgDbUDjo33Nrr0oANWKPScGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787559153; c=relaxed/relaxed;
	bh=vKy4BP6E6zvsWYXY527Psvehy6mIE9FXn/OhnGv4HIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaDHPOVGXB2gyjSXS2dMnACFuyVujUw9ymRuS3PpvF/PnAMGQ8G+BIs8qf6kV4Wn/bWOONYX7D/dMVLfEZKmx8pj8nyBMSt+dLGb/crXXqNb4Oyym+N5AFGww07BYzz1Kt0K5iG5I92VRlrFUydtJIPV7zW0d3YDKxEbIhuXcjvAWMN2lGYPX5UUXySZygI9OMdB6Sj4zpUuRZo6vn8Bv4UWkOP4g0Vk46ft/nqX8l2L/0Qf59OB3euq76pdiupHhhEJx5Mp+N8Re7Vgi0pYGLvqmlKkOyu6+rgKuUe1enC2g/ULmNY+Go3pCD2I5sr844/86mARfv/+bF61oJpfag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T64Wqi7V; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T64Wqi7V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT3YX5jp0z2yps
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 18:12:32 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VgM3856904;
	Mon, 24 Aug 2026 08:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vKy4BP6E6zvsWYXY5
	27Psvehy6mIE9FXn/OhnGv4HIQ=; b=T64Wqi7VZRPNIQBCU+ek+OMP/On5Sfi0Q
	CLl4oiLfRW03ofIqLBZh3rOPCIGxEuJFegHEmKDet+UdKXwEbEd4ay8fXPq+13P1
	a1ZqkhQHPi7Ah9ZKuffo1VTZz/b4bbAubkD2FrauG1H7QZxvVdr43Gk56lcTQBeu
	KDNrq5ZJfPwhnNzRVMV6Q23GCb4+A8OMaJZRPhuynHp60B7YJTWCAFgp7waHwwgt
	qOnl6SMf069Jpy8V1tRF2hCaWG3q3crwRkUZGW6V+WuKiShIc/LUh2GUDKUF6j4H
	9SeBITw1R8fYo8afYKZ8b9PuDErG3Y6/gqwNk+9AHb+x5wBfTNp1g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hg8b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8BMdV001788;
	Mon, 24 Aug 2026 08:12:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvvuwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8CICx52560196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:12:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B92020040;
	Mon, 24 Aug 2026 08:12:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C07420043;
	Mon, 24 Aug 2026 08:12:15 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:12:15 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 4/4] powerpc/kdump: add support for high crashkernel reservation
Date: Mon, 24 Aug 2026 13:42:02 +0530
Message-ID: <20260824081202.264913-5-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX4hsWZP+8l3et
 Eu5psaXcxTJBkvNL0HJaMJS6+8DB/05ZCZ9hIivQmieKlZWGdnD0oDsT5FAwNFMcXp7EPSF43Lt
 vYdDdYNEKjC8I5fWhm7rSx1qHGmIAOE=
X-Proofpoint-GUID: rtZVk5kIj6Yrq3H9IogmYCvPzhNm-YZF
X-Proofpoint-ORIG-GUID: lnJ6pzNXVjul1cv5nYXZmo0BDdIPHknu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX3k5Ve/CXpBbD
 Zkfp8kX4P7LWzQcZBP+RFjzQNHHaNli8Pbc5k91wOtUNAunEWi8ej9ZLGBXdxwWigLoShJC79ZR
 JFJjitZnb/ilZFxOcphC6bfHJpD8WVVjajv4ziXwv67fJaqfwqIOVWvMVzPae3/YmMA3QVAcsqk
 Zlqo2dqgZBMzMvgT9ZgyCqAr4wXLhN2KKcXDYWAdQm+WlWVS01+8ciRPBrlnTizWpgI86RgbM8/
 vit3NMNe51LLPHFXIWWA6nmmyw1Cc7pYPUjKkaGcRhxvsNf/HeRcv7rPYu3jPv80vVR7UJi/nOR
 VEVe20IBaUypctMFryCwwyLU/y/VBgUDsFfVS+oZVUcLYUuIWVzTbYciOFEngWPsg/yFla3clVi
 FmFEqRcTjwnr6j9DuOhxRLIGQN3pClONAObhWw71dX6s9h0IRRoecC53hhx5H1UbyZVcUljjDsx
 ZMS8kawWnYHxOIfo2bA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8bfce7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xxU2pcodL4BFR_vyWlEA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240070

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
 arch/powerpc/include/asm/crash_reserve.h |  6 +++
 arch/powerpc/include/asm/kexec.h         |  1 +
 arch/powerpc/include/asm/rtas.h          |  8 ++++
 arch/powerpc/kexec/core.c                | 48 ++++++++++++++++++------
 4 files changed, 51 insertions(+), 12 deletions(-)

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
index aaa4c3bc1d61..86f211bdcd50 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -561,6 +561,14 @@ static inline int page_is_rtas_user_buf(unsigned long pfn)
 	return 0;
 }
 
+static inline bool is_rtas_64bit(void)
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
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index dc44f11be353..022c97bbab32 100644
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
@@ -104,35 +105,58 @@ static unsigned long long __init get_crash_base(unsigned long long crash_base)
 #endif
 }
 
+static bool high_crashkernel_supported(void)
+{
+	if (!IS_ENABLED(CONFIG_PPC64) ||
+	    !(IS_ENABLED(CONFIG_PPC_PSERIES) || IS_ENABLED(CONFIG_PPC_POWERNV)))
+		return false;
+
+	if (!early_radix_enabled())
+		return false;
+
+	return !IS_ENABLED(CONFIG_PPC_RTAS) || is_rtas_64bit();
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
+
+	if (high) {
+		crash_base = 0;
+	} else {
+		crash_base = get_crash_base(crash_base);
+		crash_end = crash_base + crash_size - 1;
 
-	kernel_start = __pa(_stext);
-	kernel_size = _end - _stext;
+		kernel_start = __pa(_stext);
+		kernel_size = _end - _stext;
 
-	/* The crash region must not overlap the current kernel */
-	if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
-		pr_warn("Crash kernel can not overlap current kernel\n");
-		return;
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
2.55.0


