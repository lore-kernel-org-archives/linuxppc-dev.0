Return-Path: <linuxppc-dev+bounces-26030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB8C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 10:57:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRHLj2qkTz3bsX;
	Fri, 21 Aug 2026 20:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787309821;
	cv=none; b=g9/EV/cKViOymzFdWcYWOmSaWXY7cVJGsKnNkHj1Gc3WP6kndrDPBGU6GRSA7q4V8qwtLxAwiY0fq3mS3l2vJ/+5OP8EkOgYNUVN1Q7fMBbsucynbsbhOFN+2YfGvFlR1Is0tndpWb7qNN49pZp8OaKnw4RUDFgkTZw0OcnKdeNia5wqb+1a6TTOFfm2f251QVcOUj1G2naU+BpVHBJhnTzcSktI2WilDo2TEZTb0FDoRbdMGIX8FOG/U6B9qKr7tEFfE1ndc9CZR1xHb7ccgWTwULzRtofFJbUwnBcFf3FhTwAb/F3T3BMDvtXAz5DJ6Ifiof3jGBxmiSD9D1nULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787309821; c=relaxed/relaxed;
	bh=l1/PRbvxVpG/kkBXP4vtSgYcjOL7TzzVy0fwt7dmyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycd3mLtgjZj3E9I8bx37qpLDEQVsFczRE5c0WoI486lTS6KQAKXP+Tco2qwqX2sLJj3nYUu7ZhicSD/C1qAPpBeWQtMmWJ74YPSM3BKTkZY6DrINcEig5IFJtwnEMNQUjLxodJAAIsKuDfXvFoDdleXK4rPyRXjo5AZDjskoz+1KaaI/jWBjBDPhNv1NUXIJboi13QbTWDVaVYhoFNwEpjEZGTTvqMiLWWU6meRZ1tr9/Lq3NuAtnt/y4EqV+xabWAis8vVsMXGb00Au5k09855I2v+kmi/GPtKNvQStMeip7t150OgCUxiNTAbcp9Qjm5bCLvqLFNiK7+3Lyia8Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ojZgsgsR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ojZgsgsR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRHLh4JB9z3brL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 20:57:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9VhKd997642;
	Fri, 21 Aug 2026 10:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l1/PRbvxVpG/kkBXP
	4vtSgYcjOL7TzzVy0fwt7dmyOQ=; b=ojZgsgsRtdqg+fedWMahJ0t2H0LHafr4e
	iOV07ivbrXrpalFf2m+JJhfQ8H7JAJqUzaiyVV3eRFBAp0t/UKhUGRS4BbsMDmJL
	QU+1j5ACOiFC4EUtHibPsJrjq/1HVt48g6wILx2CY7iOF8WTA3iADH+NKSFZzB6t
	vzo8BPhNdccnCSeaH/OTrpqj5CduefXLFz+QH9TRQa+C/mrqV4CTVTLzBadfDB6Q
	7Ok57R/HqEMpRw5K30rWnfFDrRu47b+pLrF7ARw8BtiOSYF9WnZ6BTjJYfwaDxKn
	aYZRfftar3WeBeuym5P8KqTTuvZepZ/DMYvX6rnRWiSIGFp1O5i3Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4grby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuKai031771;
	Fri, 21 Aug 2026 10:56:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yuvsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAuXhm45941134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B11320040;
	Fri, 21 Aug 2026 10:56:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E7320043;
	Fri, 21 Aug 2026 10:56:29 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:28 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
Date: Fri, 21 Aug 2026 16:26:08 +0530
Message-ID: <20260821105609.983622-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX1UZr3WVhLsII
 JgnHjVTBxRl2wS8au7AtRSNqJXUORIK8rLppkrlMuy7Cm8p7oq/4Lj76QHf6CGZ7lzxI3B+WyaH
 5k21FvVzudy7seYK1gDbJShe2HrKfOc=
X-Proofpoint-GUID: Qp-Uhemg2TMjj5ye8J16H-uB8zn6cFY6
X-Proofpoint-ORIG-GUID: hy-RthS8sA4u59zqfeUxOXLwlj2jhkPE
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a882ee6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=yLEcGKxZXAQCiR2e-PUA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX+TtWI84NRmif
 vB3gdjbGTyMy9OtnmOtD5SX4/3uOqijROhN23ygPWDAblfdYNt4HI+A7xnqMjDMJqRxMA2JOQLb
 ncG5dkFj4Pmf1nbC4iLeHubRnkWH7m+C/DBNzHDjmsG53UFpnLP7TOqDxVJQKUWseoSSt1Ugk81
 CTb0vA5N5q058RMRnZHPJbf7A/1c69S9haMpPIHRrwy21JaabU0c+NK6KQvttEXstTCVcdrh2bN
 Gz52+GZqnk5pWphHP85J4p68ry1FEcgTpNfwt/Xy8NCKxu04jQ38Uaw47O4WZQD17c58NA7oae/
 xB2oVsGkm4PMJYHLEV8U+SzkDpb80JgQMwPUaSpuzoTByc96N5R0imK9YgSd7yrpwgH1j8/CR72
 wEKFrywDAzONni5IeI+wzFL6YZpcJK/yrKquVjgb7phfxM82ddR6FHm2JAmVYkQ0CQJNkXixj5b
 vo0OdKVIdb5P/gOthTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078

Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
powerpc.

Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.

On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
properties from /chosen and pass them to kho_populate(). This lets a
kernel booted via KHO kexec recover the FDT and scratch region left
behind by the previous kernel. The call is placed early in
setup_arch(), before unflatten_device_tree().

Open issues:
============

This patch also adds "depends on !CRASH_DUMP" to
ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
conflict between crashkernel reservation and KHO scratch reservation
on powerpc.

Crashkernel memory is reserved very early in boot, from arch-specific
code: head.S -> early_setup() -> early_init_devtree() ->
arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
region is reserved later, from generic code: start_kernel() ->
mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
memory is always reserved first.

This ordering causes a real failure. In the common case, crashkernel
reservation on powerpc starts at a 512M offset (the exact offset can
vary, but 512M is typical). So with crashkernel=3G, the reservation
occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
4G area.

Since crashkernel reservation always happens first, that 3G is
already committed by the time kho_memory_init() runs. It then tries
to reserve a low scratch region sized at 200% of whatever is already
reserved below 4G. With ~75% of that 4G area already taken by
crashkernel memory, 200% of that easily exceeds the remaining space
-- and since the low scratch region is itself capped at 4G, there's
no room left to fit it. The reservation fails.

To work around this and get KHO working on powerpc, this patch:

1. Makes KHO usable on powerpc only when CRASH_DUMP is disabled.
2. Calls kho_populate() from setup_arch(), so it runs before
   kho_memory_init() reserves the scratch region.

The real fix would be to reserve the KHO scratch region before
crashkernel memory instead of after. But scratch reservation happens
in generic code (kho_memory_init(), called from mm_core_init()), so
this isn't something powerpc can address on its own -- it needs
discussion on how to influence the ordering between generic scratch
reservation and arch-specific crashkernel reservation. This patch
doesn't attempt that; it's meant as a starting point for that
discussion.

Together with patch 3, this gets CONFIG_TEST_KEXEC_HANDOVER passing
on powerpc.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig               |  5 +++++
 arch/powerpc/kernel/setup-common.c | 33 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..61350d3e7a19 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -716,6 +716,11 @@ config ARCH_SELECTS_CRASH_DUMP
 	depends on CRASH_DUMP
 	select RELOCATABLE if PPC64 || 44x || PPC_85xx
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool y
+	depends on PPC64
+	depends on !CRASH_DUMP
+
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 	depends on PPC64
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4afaba19b586..1fee743abdf2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,6 +35,8 @@
 #include <linux/of_irq.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/libfdt.h>
+#include <linux/kexec_handover.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
@@ -910,6 +912,33 @@ static void __init smp_setup_pacas(void)
 }
 #endif
 
+#ifdef CONFIG_PPC64
+static void __init init_kho(const void *fdt)
+{
+	unsigned long node;
+	u64 fdt_start, fdt_size, scratch_start, scratch_size;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		return;
+
+	/* Find and verify the /chosen node, same as early_init_dt_scan_chosen() does */
+	node = fdt_path_offset(fdt, "/chosen");
+	if ((long)node < 0)
+		node = fdt_path_offset(fdt, "/chosen@0");
+	if ((long)node < 0)
+		return;
+
+	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
+				      &fdt_start, &fdt_size))
+		return;
+	if (!of_flat_dt_get_addr_size(node, "linux,kho-scratch",
+				      &scratch_start, &scratch_size))
+		return;
+
+	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
+}
+#endif
+
 /*
  * Called into from start_kernel this initializes memblock, which is used
  * to manage page allocation until mem_init is called.
@@ -923,6 +952,10 @@ void __init setup_arch(char **cmdline_p)
 	/* Set a half-reasonable default so udelay does something sensible */
 	loops_per_jiffy = 500000000 / HZ;
 
+#ifdef CONFIG_PPC64
+	init_kho(initial_boot_params);
+#endif
+
 	/* Unflatten the device-tree passed by prom_init or kexec */
 	unflatten_device_tree();
 
-- 
2.55.0


