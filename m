Return-Path: <linuxppc-dev+bounces-21677-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1494CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 03:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRV3N0XRHz2yRl;
	Fri, 29 May 2026 13:59:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780027152;
	cv=none; b=C+NSXlxrEocfQnh4fbwM9AUh5WLhId1NZsvUPMS3iCXyt9SVdtMGqQss0z8De5mrim3zbUsL7SDGZzicxbL3fk02SRvATax50q6WeATqGagQKwNcWScBOqY6Czryob88Ir2Iem8jtDT6bM7/1EANFw9AormDxIQuM1QJcNd9iVbks3VdTHl8tfPV+DILroygWIBT3CHioZcVwycqdKABwUoFIMM6x0c7p6WEUWHgoiVLbQn9FoYqiKCf6F6N16v5i45vxbo+H/NBA0xP3mOIfKSUBpWu/7cxHHKcK0vybSfPBlc9JnU+qqjKY9Akq36x3awXPl+mTPTCg6DSyljWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780027152; c=relaxed/relaxed;
	bh=jZPBf1hknITbjBulQnAkW79M00akmP9Jf8bWCate1KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgHppq9jN0Dc6bC1RZeZ6ruAfZ0CPf0P/B2cEsGKOVv4gbJqYCnQCeLCQx1w1Y+ukgbUCKDsotqQ5X6gugSr0+HCmv+pG+1LNSjj0Smmwb+MR2/xqSfhP2Y8SpziqLqPcKFTn0RRvrwvq4Hp/TYjzUVe9x0OnpU4moWUpys4mQchuJzm8pSOhXHzC1U/JYivM2meJxkG89lH/I08e2LRGIjbpKS07pcuplvw1NoxXFh7FavKPA2ATb/u08qd1G/RpVs9iK+JtNXVD+omHUjnpTMFnhPKRHXTkV+wNe9tNLMM/2JRxrmwbYGA0fCaZPFVxE03OEKX8gMfSyHY84Z/oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C/NfY/kK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C/NfY/kK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRV3L3VLGz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 13:59:09 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLmDTh2134009;
	Fri, 29 May 2026 03:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jZPBf1
	hknITbjBulQnAkW79M00akmP9Jf8bWCate1KM=; b=C/NfY/kKmtZ4NRd0ERUCqx
	BW+MOkgu+C29dZTllRuC1n8xSIMNw+YxyQTcFeIP196LIy0CQ9ns2eU8h9Kt2FRS
	gEqsWRJF21UfvqVAhDkJq6l8yQJUa5Hz7Xy/oq+6mK9fj46lJPWK1BDLDTmrVvhF
	AVAbhnYcaqsUJ2aYoL25OSEoUc91P/Bq2WFGqbHmXv26RD2/RX9mcbQ/u6nwWYqV
	U9VqV5YpSxI7rS8hMOIzoHhKvrT3Mmwrgx2lyDMXCiKHoCRi8EhZKepHQTx3Ubs3
	cB5ceh3QRz9XibUf55jRodEAyDDpk9d9FpKuUPpQ4BF43SoxJAo8Y1DMZTC6xIEg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887p4s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 03:58:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T3sPlA011699;
	Fri, 29 May 2026 03:58:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc3bxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 03:58:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T3wUtj41288156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 03:58:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F372004E;
	Fri, 29 May 2026 03:58:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A24320040;
	Fri, 29 May 2026 03:58:26 +0000 (GMT)
Received: from [9.39.19.35] (unknown [9.39.19.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 03:58:25 +0000 (GMT)
Message-ID: <85ff1fec-632c-4e5a-9b47-5d4b4a70a1a2@linux.ibm.com>
Date: Fri, 29 May 2026 09:28:24 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a190eea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=sVCs8T_WoIwSPI0JDxcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C7mjtAmTbWyDQE8LBcbCEAZeL0YPkx8c
X-Proofpoint-ORIG-GUID: C7mjtAmTbWyDQE8LBcbCEAZeL0YPkx8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMiBTYWx0ZWRfXzhur0em7HVvM
 eC9Q8XrsCSGo4IK/xihRpUWGn50Ma3MBlWZd/mIMmp6KbbETL1V719ZF/lecEyu8Gsr0VKAqPJJ
 oirmGwU2kQbp+Z3D49Gls2rmBfgjDyS/NGRtE8MWch68+NZfen2jvHZ1100/Wxot+9tB1D+aQBq
 4Cj849j+/ratNUliwh3OzruuYnjs6sNMzIpJljt/vX3bCdpO6Ac4rCZLYABy6472A5lxAaA5jIW
 TY2xu2jDovFCeby8kU4JgBmh/0BzFwEA3HQqwztGT+34JPtRVf3uZtGI/WxwEAtohnoswnvYv5o
 jGzXiyXo0BcKWN/L7gYML79PqpCjRODeJMqi6V5hV8ixocWHXSMuzhnoPMHsTuVcyjPg09DeiBN
 IYAF5FLuX5gAUVyqnk+cCVNBhgxkCYeGAidOs0aVWgiRXrVi/9/Q52D8/0Aim69hDnwfMGN6232
 gU/HX2A1Z46SPRfg+3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290032

Hello. Sorry for too many mails.

On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am seeing an early boot kernel panic due to NULL pointer dereference 
> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> 
> 

Based on srikar's suggestion to keep the below,
#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)

which makes it pretty much what chenyu had here
https://lore.kernel.org/all/8d14c844-b4a8-4af6-acab-2cfdd42225be@intel.com/

I added the changelog and comments. removed the changes in !CONFIG_MC case since powerpc
defines it always. I have changed the chenyu tag to Co-developed-by: instead.

I have carried the tested-by and reviewed-by tags since patch is
still more or less the same.

This is based on tip/master at
5c89783224e9  Merge branch into tip/master: 'x86/tdx'
I am planning to send it based on tip tree.
Let me know if has to be against a any different tree.

Please let me know if there are any concerns.
verified below too fixes the panic seen in shared LPAR.

============================================

From: Shrikanth Hegde <sshegde@linux.ibm.com>
Date: Thu, 28 May 2026 23:23:43 -0400
Subject: [PATCH] sched/topology: Provide arch_llc_mask for cache aware scheduling

Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
b5ea300a17e3 ("sched/cache: Make LLC id continuous")

Stacktrace points to llc_mask being null.

NIP [c000000000e58504] _find_first_bit+0x44/0x130
LR [c000000000e58500] _find_first_bit+0x40/0x130
Call Trace:
build_sched_domains+0xad8/0xe50
sched_init_smp+0xa8/0x164
kernel_init_freeable+0x250/0x370
ret_from_kernel_user_thread+0x14/0x1c

On powerpc, cpu_coregroup_mask is available only when the underlying
hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
coregroup isn't supported. In such cases llc_mask was being referenced
when it was null leading to panic.

on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
domain point to LLC is wrong. Provide a way for archs to say where its
LLC is if it not at MC domain.

Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
  arch/powerpc/include/asm/topology.h |  6 ++++++
  kernel/sched/topology.c             | 13 +++++++++++--
  2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..e3de0f3d8b86 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,6 +135,12 @@ struct cpumask *cpu_coregroup_mask(int cpu);
  const struct cpumask *cpu_die_mask(int cpu);
  int cpu_die_id(int cpu);
  
+/* Points to where the LLC is. On power9 this will point at CACHE
+ * domain, On others it will point to SMT domain. In all cases
+ * cpu_l2_cache_mask points to where LLC is.
+ */
+#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
+
  #ifdef CONFIG_PPC64
  #include <asm/smp.h>
  
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2ceb54c970..622e2e01974c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2063,12 +2063,21 @@ const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu
  	return cpu_coregroup_mask(cpu);
  }
  
-#define llc_mask(cpu) cpu_coregroup_mask(cpu)
+/*
+ * Majority of architectures have LLC at MC domain level with exception
+ * such as powerpc. Provide a way for arch to specify where its LLC is
+ * if it falls in exception category
+ */
+# ifndef arch_llc_mask
+#define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
+# endif
  
  #else
-#define llc_mask(cpu) cpumask_of(cpu)
+#define arch_llc_mask(cpu) cpumask_of(cpu)
  #endif
  
+#define llc_mask(cpu) arch_llc_mask(cpu)
+
  const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
  {
  	return cpu_node_mask(cpu);
-- 
2.47.3


