Return-Path: <linuxppc-dev+bounces-21631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F107CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 11:28:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR4473Rzlz2xLk;
	Thu, 28 May 2026 21:28:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779967703;
	cv=none; b=GI4SAfW9o9FActS/4p9KfuXK4LbFE42Hofnij+L8/4SNBdgy4eFIzrH0jthVxAr1ZjB98/UBmKZ784fkttl6lxCZ1SHeVrS/sGV5AYYYOd2VnoVTkxbDawi1iLm1IxzMP8ArogowC6UEY2pkz/0t+he8IojdLw5tBZmbku6ULMcwp/rpev8SWCa4puXr+BZc8aQmRcTEWguTba0xtS+nJ78QH1cga9xSYrzhOzEaIDt8huaJzqtCvLDPBUHAnOqLD0dN0Jcov1EeYeotU9WWLKdTBQlXUE1j9oABCGhqmhrE0nvDCv3/FnGpAreFFK8rG8KogZIXEVaqGdnfU00yMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779967703; c=relaxed/relaxed;
	bh=LRNxzXa4m0Y9Paq9+GRL/LlA4u3dhgDLAX5h4Pi14a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JufyjdBmCxYDLGAxyNLkQmwCZYf89Dt/ttj3kd3huama5JyXyyHo9Xpi+kWiHdHaK6+vK+TspzydCLp9ErilJzrOtDpMkWMVpsXJI33tzzuvs/35ZrIf4rmRQqlCJ0tWvAkszfqHfxT3WJlUtCny6J6UgT5iwVQBSVdztkre7/3lnWAoRmuINrio+FD7dHuRtg6G/zBU8CY7VkA2hAVZzmQMlj87zOSshCd7d5ALn4Atfylw0MQO9aW47+7CAdZyvsMsnNtidqz2OunGREYNjwk71i2jKhdodsSXUkuGtZrFqCyyR1l55FAlzErjC+DY9t0UG9D9ufUo7d5NPJ5pwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fXRvKHTz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fXRvKHTz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR4460nyJz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 21:28:21 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL78pd3783872;
	Thu, 28 May 2026 11:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LRNxzX
	a4m0Y9Paq9+GRL/LlA4u3dhgDLAX5h4Pi14a8=; b=fXRvKHTzk1NaQI987vyvb2
	G2pNebpczJ46nnWr5WtNQnK3ZWe4Y+w+msoz7MtWn74juARreT+Tqk/NbM0TrMaw
	lIRiM+aurmFeFtILLIEvbXdDTTJIYExpcjI9SMk3YIKzzkqh3M8qg6+n56sX3jyG
	S/uqQvCW+S8OAgg6H4++rauEk/RrH7sjiM23h5U6QP9iAGcnYkECMdK1pJmzMBlm
	STzg0k4nNQgGa/QfHFkBjyuS35eue3cEHwH3FItU7tPBlKNqkWiXRQlY5oNQWpPF
	DxZCXnVAj9EIDiVO3AzvL4bOGQ92Qipp7Y+g3P+sFVFnppyNDAhhzfgqTBBE4wYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889ajkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:28:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SB9Qd1007501;
	Thu, 28 May 2026 11:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7u4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:28:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBRwMT60490138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:27:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F87D2004B;
	Thu, 28 May 2026 11:27:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9909220040;
	Thu, 28 May 2026 11:27:55 +0000 (GMT)
Received: from [9.39.18.196] (unknown [9.39.18.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:27:55 +0000 (GMT)
Message-ID: <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
Date: Thu, 28 May 2026 16:57:54 +0530
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C"
 <yu.c.chen@intel.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3wc5bkbx0KI16kpu_oiDGRHXTg2P4YtW
X-Proofpoint-GUID: 3wc5bkbx0KI16kpu_oiDGRHXTg2P4YtW
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a1826c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=sVCs8T_WoIwSPI0JDxcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExMyBTYWx0ZWRfXwLghwKHTmwWd
 zX1fHuXGuCp6tcWaXw8p0cEL0OSifodoRiwlD2fER0hjGWP5BoPOdYpqh5VWnMFSLuCynO7H07q
 CbpBT6ww8IlpB3wNj90OdHVwHkaADo6oM9mHCz2f8XL+dMVOzmFk0TAM7vjpJ3/Lwwivu41vZB0
 WKUY6YQ+9Ew0ZWoRCld/quTMKVHs2kKFvp7LH2DFdwPpRO/gKkyENCHMJ7XEkEb7pYL3iqkpNHJ
 Z5idTf2jLkhFyLVcVjZl8pOA7PPMUFrmlPgXJZiaGTJs8Ci9qYytkSLwC6b64wWkquKpjOX+crv
 uQ1prRMUMhAafKE/bqFJnavfHXZs7T2sFRiNY2zgMwIHvRKSxpH48kXYO0xBDLPF1VPu+GvDQTb
 Vt9vCoaTGWGtzWmjlFRqLN7hJNUiMltIb8v+Y6/cWzf0JVqZSKFYVSmiula7+kU8YPZ5tS9WmF9
 W8qNUqjRQqRuoKwNd/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280113



On 5/25/26 7:37 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am seeing an early boot kernel panic due to NULL pointer dereference 
> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> 

Hi Venkat, Ritesh,
Could you please try the below diff and see if it helps.
This helps to fix boot problem for SPLPAR for me.

Hi Chenyu,
Let me know if I have to send the patch. Or
if you want to add more comments or change it feel free to pick it up and send it.
Either way is fine. Let me know.

Hi Prateek, Srikar,
I hope the below diff makes sense. Please check.

nit: llc_mask is still under CONFIG_SCHED_MC, for ppc it is set to true
always for SMP systems, and for others it is LLC domain. So not a concern i guess.
---

 From 10e9413cef063446d67dc02c2b44e1ea582e5d53 Mon Sep 17 00:00:00 2001
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Date: Thu, 28 May 2026 06:16:44 -0400
Subject: [PATCH] topology: Provide arch_llc_mask for cache aware scheduling

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
coregroup isn;t supported. In such cases llc_mask was being referrenced
when it was null leading to panic.

on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
domain point to LLC is wrong. Provide a way for archs to say where its
LLC is if it not at MC domain.

Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
Suggested-by: Chen, Yu C <yu.c.chen@intel.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
  arch/powerpc/include/asm/topology.h |  3 +++
  arch/powerpc/kernel/smp.c           | 10 ++++++++++
  kernel/sched/topology.c             |  9 +++++++++
  3 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..bd1db3b1dbb0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -131,6 +131,9 @@ static inline int cpu_to_coregroup_id(int cpu)
  #ifdef CONFIG_SMP
  #include <asm/cputable.h>
  
+const struct cpumask *arch_llc_mask(int cpu);
+#define arch_llc_mask	arch_llc_mask
+
  struct cpumask *cpu_coregroup_mask(int cpu);
  const struct cpumask *cpu_die_mask(int cpu);
  int cpu_die_id(int cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3467f86fd78f..cc8e87d6cae9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1101,6 +1101,16 @@ const struct cpumask *cpu_die_mask(int cpu)
  }
  EXPORT_SYMBOL_GPL(cpu_die_mask);
  
+const struct cpumask *arch_llc_mask(int cpu)
+{
+	/* Power9, CACHE domain is the LLC*/
+	if (shared_caches)
+		return cpu_l2_cache_mask(cpu);
+
+	/* For others, SMT domain is the LLC*/
+	return cpu_smt_mask(cpu);
+}
+
  int cpu_die_id(int cpu)
  {
  	if (has_coregroup_support())
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2ceb54c970..01af3d8f9eb9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2063,7 +2063,16 @@ const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu
  	return cpu_coregroup_mask(cpu);
  }
  
+/*
+ * Majority of architectures have LLC at MC domain level with exception
+ * such as powerpc. Provide a way for arch to specify where its LLC is
+ * if it falls in exception category
+ */
+# ifndef arch_llc_mask
  #define llc_mask(cpu) cpu_coregroup_mask(cpu)
+# else
+#define llc_mask(cpu) arch_llc_mask(cpu)
+# endif
  
  #else
  #define llc_mask(cpu) cpumask_of(cpu)
-- 
2.47.3


