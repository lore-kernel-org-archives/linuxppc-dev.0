Return-Path: <linuxppc-dev+bounces-28378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCEECA5FA4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:33:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htZML5Ndgz30WS;
	Mon, 28 Sep 2026 18:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790584398;
	cv=none; b=TKheXwnbPvhGNBbc/G0+9WNgrzRiJ9U8cqGJXDCD/z+HBj9josLbXx8hwelwzApFYs5u3W/d5xrJn8TQ/qUolYsJg1/zYjiU6fqtWfsqdhOow+NsVH9AJSC7BDJyc+gwN8CfZGCM+Oa+FSBvh7MATcOO+QDHgQpFUkfCgXCXRvseXktTKogxxVG5SMjHUt4qT95hLuH6D++I/OVpizohTWfiNm5mc1HgfVZ120Vacr24Md62yxU6WgAED4GwCMuh/QOt4VQPb8zJty53IJ9gJigklkkv4eu1Rr6QIMAyDi+47tpdtrM17WiWkS2xjpWdeYMn1Wz5lSUlOhnDNq68Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790584398; c=relaxed/relaxed;
	bh=CCkRCmS19zEA9htpE9e4GGbeUnHYyLQnayb0RP1laFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfadRReu74ogbClwYPwDRv1nSdknOVqFzVG9eoySjCM72muEfmISvhiXF6BRcnu1+n14cWxyoGLpZGPoqAv76BKSTAN+NK5PtsyLzxy6V5OBgMT4oMcJakqv5Q52pdVDuS3+QV/61c48NH4/vQvAWQD5Y48X+v8kScaQgDuuOi15IkIsR0zb/Pyca9BIBMVEFsP4dRciShbbVVu4Chz7dGD6wQtZMZJ3iOyoM4+pvdiDnjajZOzsK/wfii5nGzyIz8PBxxIL48aOYpqdYEVjZZ/+8TRSetQsNyHtM/CoceVnrLSq+C5foxOybWgkpZtar34eA6E2A+OMJeQOy119yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aiS+D5zA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aiS+D5zA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZMK62B7z30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:33:17 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S85SDb595683;
	Mon, 28 Sep 2026 08:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CCkRCmS19zEA9htpE
	9e4GGbeUnHYyLQnayb0RP1laFA=; b=aiS+D5zAIwa7JDbIT3OTzrC1Z2z3CrK9P
	Vz0t91POS0mqwDJl4rV4JnOdwUJtewuyeXXS9e13cq0021M1Fp3MTH5L8HC2ZJvU
	ZzIeBMdtrYbpe/PaHxG1weMLgXmcINLfEgDwx98BHkR9jp176wsn+VAEL0aXTi5q
	NyBIjS+35Hy3d95H1WdMS7T2Y/sscJ1kaQHTqy2STvGv1AUaXK+73Pwm5dRKq5zH
	pWm+kNq45wA8bmt6nTM7ru1OMRWoxsygFE208P9IX/GMip6Aoa+R8nstocAsuraD
	zus5FjZd91Yigf2pIp7qrlTAGZZt8XzWNRo/CayNlx/nkrh6q06LQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s506mj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S82VE04055221;
	Mon, 28 Sep 2026 08:32:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhcbt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S8Wn7c36503890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 08:32:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AC72004B;
	Mon, 28 Sep 2026 08:32:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DD6620040;
	Mon, 28 Sep 2026 08:32:45 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 08:32:44 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
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
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/2] powerpc: add support for Kexec HandOver (KHO)
Date: Mon, 28 Sep 2026 14:02:26 +0530
Message-ID: <20260928083226.107807-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfXx62h7Q83jBIn
 d2V01iCj99IXIR7Td7aDAwSAnsJrzBokntCj8ZLdaGDWNW+t1DPZ8gR6PtOHXmMs1laCV9Zf523
 jL08BdwVcbrjl0HdEyH0dROq7GKDug8=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6aba2636 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=voM4FWlXAAAA:8
 a=itPyUPzOZQCiFHcQqVsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: HxbnxvsmChTkRmuCimQHUfwc6bBNCkkf
X-Proofpoint-ORIG-GUID: 0kIoDGGoCmOXXhETMhn5k3WDSwiqzuYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX1iz38KbaL99q
 Era/atBTzSJA1XBzjTyzhLdqapswT4jPsZWNy8ge5ciNV1JI+bvoVtGdncvONSDkVU5CPPlj4Le
 ELz8tHFOfQuAJGbGYXVKgPumyL0o/GouGHRIRcKDUkIksvuaC5WBrx+lh7ZmslND1IO4Y+gsVu1
 d51u0sy+oFGJWvvX7j8ykFFurbi3FwR2dczZHLgk4r7WrQqxjTpoF5zwEriKPdYzBrnzGn60kNT
 7iLIChXMyQ0AQ3GxTqWdhlwZz/GDCnTFRKvjWQd+1chL5b1u995xhlM/b3F6i4G1SApSHYNkzHf
 0L/FCIK7u3BYR6bvjoBQZVOufaTPp/0rLtUAku8rZ3/gFhqCkcSuwJ2vPyOadA+7w1JWf/IfV2/
 6IS1W9Yb2YW7ZhZraXxrySegFs4Xz8rRn+CRopzkn42rJVjIirth/BwgHhhWyoxWdVxuTXOAeGY
 ZKq05diywjNadbakuGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280032

Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
powerpc.

Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64.

On the boot path, check for KHO information in the device tree before
unflatten_device_tree(). This allows a kernel booted via KHO kexec to
recover the FDT and scratch region left by the previous kernel.

Move early_init_dt_check_kho() out of the device tree implementation
and call it from setup_arch() before the device tree is unflattened.

Note:
Crashkernel reservation impacts KHO scratch reservation. Crashkernel
memory is reserved first using memblock, and this memory is included
when calculating the KHO scratch size. As a result, a large crashkernel
reservation can increase the KHO scratch size and may cause the KHO
scratch reservation to fail.

This issue also exists on other architectures and will be handled
separately.

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
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig               | 3 +++
 arch/powerpc/kernel/setup-common.c | 2 ++
 drivers/of/fdt.c                   | 2 +-
 include/linux/of_fdt.h             | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..3517d74949d0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -716,6 +716,9 @@ config ARCH_SELECTS_CRASH_DUMP
 	depends on CRASH_DUMP
 	select RELOCATABLE if PPC64 || 44x || PPC_85xx
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool PPC64
+
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 	depends on PPC64
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4afaba19b586..53c2f1897bfe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -923,6 +923,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Set a half-reasonable default so udelay does something sensible */
 	loops_per_jiffy = 500000000 / HZ;
 
+	early_init_dt_check_kho();
+
 	/* Unflatten the device-tree passed by prom_init or kexec */
 	unflatten_device_tree();
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..69e6ad868fa3 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -926,7 +926,7 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 /**
  * early_init_dt_check_kho - Decode info required for kexec handover from DT
  */
-static void __init early_init_dt_check_kho(void)
+void __init early_init_dt_check_kho(void)
 {
 	unsigned long node = chosen_node_offset;
 	u64 fdt_start, fdt_size, scratch_start, scratch_size;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 51dadbaa3d63..5e9d6af0c7dd 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -83,6 +83,7 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *dt_virt, phys_addr_t dt_phys);
 extern bool early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys);
 extern void early_init_dt_scan_nodes(void);
+extern void early_init_dt_check_kho(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
-- 
2.55.0


