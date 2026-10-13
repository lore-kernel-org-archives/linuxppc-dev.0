Return-Path: <linuxppc-dev+bounces-29348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E61CC6B10
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:59:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3qYR3t7Xz3br5;
	Tue, 13 Oct 2026 20:59:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791885547;
	cv=none; b=H7b2o6TmC6CFGGt1uqhhfjU2nbNu08TE0JUvs7uxKNpEaaOuxPofpIDCUtdJYUFaZKEKrwUM8TXtCqprto8V9Bb03Gs4ecgslh7mMG7DzdnSSMp/ijGYFnxk5MfC4ZGr2nDgWyPuZLZXwYQjvbak1v4uOMQuQ2MLUoHozRl0KfOEVxqc5h7aBeEpvAOHL8O0rMJBC3ugOgtnO/wYJFdvtF1LN9An3Tve6wf7uE+qw374o0h2BXTh1rvzww5iywhDBD/KMug949JQZ7A3KksaJ8EGwWTs2tylEzQ10B9sg3yETV75RT6PymxI7MXVQcsRihQJG3mzQrZTES81IjNV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791885547; c=relaxed/relaxed;
	bh=NJ8tXYQSPboSDMyNtnaiCexVh6DJ8MlokRCqNdsihLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e53cqc89B4k/bo2WxAgQ70puKTciiYgyXkR2gAYMhPittY4lAahXVa8LS/RnOcB5jFMvxmrMZ+f0SmOhF7VpWnvMYbOkKvGVTcCzYadDCkz68VdBCIeBZShSaBf+fgZ5srwZVfaii3dtfOT2Zi4YR8kiX/GFudwwjiD6i/neoLKiNZLD7hBivhkKh+Mf/p6BtXITqQe7Fm87y0aMotYSyRWIJqRpafWl4xdkuKEX+HwSAbbvy4P7Hi0s60Sc6isXUlwcEtYNC213A0VotNKgaAJNaW9+/eMjpyGN8DIqti8Dq1RQo0RzdBqz7Eho1pYkcwRoupbLz84a/r20zsOQyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aucDJChA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aucDJChA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3qYQ2KPBz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 20:59:05 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EIlV1774554;
	Tue, 13 Oct 2026 09:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NJ8tXY
	QSPboSDMyNtnaiCexVh6DJ8MlokRCqNdsihLY=; b=aucDJChAOK5cS6ZMMBgB4l
	a6VbIV1bDOiKobgRK5f82iS+rHRq4EdtkzsxIQfDaKsoc/b97Rwat3VTAPlZ8+Bb
	Neri2untfdcObJvEMRixsG3gFrIoGDfsUNyw37fyiDoXYfHUpz9JLciC4f+9Ng1Z
	ZUMR9sMhIdruGXsPaJz6m+g4C6a6uUdcXiLaxs/iaK1P+t3l15GAWx4cGaDZ+aOz
	tc8E2zN/FqAc5TVbOWTemfHZmu2FQ+QrTCbx3Q9Ckvh52MF/OpuX78lNPzO4NgAX
	h+gTzuRIhmuPzTIr8aCQ36doE6IR7wfSV39zSVrMaqpBkj840ei/EHgZJB2wRDmw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhvxmf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:58:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Tv3I2644067;
	Tue, 13 Oct 2026 09:58:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjs5a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:58:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D9wVDZ52298034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 09:58:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1AA20040;
	Tue, 13 Oct 2026 09:58:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE17620043;
	Tue, 13 Oct 2026 09:58:26 +0000 (GMT)
Received: from [9.39.27.235] (unknown [9.39.27.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 09:58:26 +0000 (GMT)
Message-ID: <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
Date: Tue, 13 Oct 2026 15:28:25 +0530
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
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
To: Tim Chen <tim.c.chen@linux.intel.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, peterz@infradead.org
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        vineethr@linux.ibm.com, vincent.guittot@linaro.org,
        srikar@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX4pC8ZOeJaJVG
 OTY0fBn2S9Vbm3Dn0BGS+bAnjvj4n9w2S/j5KLGhJneCxVWIbrXX7uqdcudT1N27IBnvQDh6ZGb
 VJ7Ne0nmDxaWmE7qnJCCOAMyz5fB4T2YQ/qItJe6feJ3OW6mLDxF20EuGKlTl5IxK/dAtW3OvFu
 WIFiHVjK7V5UWWVEPqbBtSKvTRQ7GhQD5cYDXYfFL9ZUG/vvSBM8lHlxvOdsXoYouGXc3Lz6FKK
 hkETIos9ypGW6srDHBERThgu/QbAJ0qjJsIdn/app3j/A2yguGgRYaGLECY6Q8HHJgYq/BkniNl
 yiTRUj8nvN4yikcgl1XtWuDPi/ywswGzXK2KmZbOiWdZEbu037Aj6wzWq6AqtiGk/i9XduhakfN
 GbAZpGmVOcuU0VHbtyLQP47N5vsA6pT9m+gczzGhwMxS/SoRssTDI/LFM0PGvKresN0jcej4JBF
 TKFlzPMiEzQ+34L+qlg==
X-Proofpoint-GUID: tOU3g9CFxMU0adCdQZ97G7nsc4qB6hDD
X-Proofpoint-ORIG-GUID: IF37tyWFD9MEi2djcMGGrVUR_F6F5wPj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX6FMZf/iuVDx9
 TyHpo4U4x1PQh60IWPINvYJUO9WUXWV0fPpdnXXcn5bHSuwT539OJJRVsuVglfPq/JIQYkqUUKl
 aKTQVmlwmbitTqFycgV+g5jivGCdNpY=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace00cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=MLKLHRpHX2oh2FcDP8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130038

Hi Tim, Thanks for taking a look and findings.

On 10/13/26 2:45 AM, Tim Chen wrote:
> On Mon, 2026-10-12 at 15:50 +0530, Shrikanth Hegde wrote:
>> There is a new feature in scheduler called as Cache Aware Scheduling [1].
>> It tries to keep related tasks within the same LLC domain while
>> keeping the system reasonably balanced.
>>
>> Cache Aware Scheduling assumes that the scheduler LLC domain is large enough
>> to be a useful placement target. This is true on many systems where an LLC spans
>> several cores, but not on PowerPC systems where the scheduler-visible LLC is at
>> the SMT level. In that case, sd_llc_size is effectively the SMT width.
>>
>> This becomes visible in the capacity check:
>>          return !fits_capacity((mm->sc_stat.nr_running_avg * cpu_smt_num_threads),
>>                                scale * per_cpu(sd_llc_size, cpu));
>>
>> As a result, Cache aware scheduling may be enabled but has no room to operate.
>>
>> Hence provide a debugfs option to set LLC at specific domain so that
>> one can try experiment their workload with cache aware scheduling.
>> This also provides ways to explore it on system with SMT=4 to see if
>> there are any opportunities to improve or uncover bugs if there is any.
>>
>> Note it is a debug option and it is recommended to keep it disabled.
>> There is no performance guarantees across different values.
>>
>> [1]: https://lore.kernel.org/all/cover.1778703694.git.tim.c.chen@linux.intel.com/
> 
> Shrikanth,
> 
> This is an interesting idea. One question from a quick look at the code.
> 
> The override moves sd_llc, sd_llc_size and sd_llc_shared, but not
> sd_llc_id. The id comes from arch_llc_mask(), which is
> cpu_l2_cache_mask() on powerpc, so after your patches it is still
> unique per core. It is also sticky: build_sched_domains() assigns it
> only when it is -1, and it is reset only on CPU offline. So a rebuild
> from the knob keeps the old ids.
> 
> Cache aware scheduling uses this id as the identity of an LLC:
> p->preferred_llc, nr_pref_dst_llc/llc_counts[], and the
> llc_id(cpu) == llc_id(grp->cpu) check in task_cache_work(). In that
> loop the occupancy is now summed over the MC span, but the id check
> rarely matches and is broken.
> 
> To make this work, arch_llc_mask() needs to follow the override, and
> the llc ids need to be reset when the topology is forced to rebuild.
> 

Thanks for catching this. I missed to see that.

One way to fix it is with a change like below.
But more thoughts after the patch.

---
  arch/powerpc/include/asm/topology.h |  7 +------
  arch/powerpc/kernel/smp.c           | 23 +++++++++++++++++++++++
  include/linux/sched.h               |  2 +-
  kernel/sched/topology.c             |  7 +++++++
  4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 44ec416fa489..f4555632e692 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,12 +135,7 @@ struct cpumask *cpu_coregroup_mask(int cpu);
  const struct cpumask *cpu_die_mask(int cpu);
  int cpu_die_id(int cpu);
  
-/*
- * Points to where the LLC is. On power9 this will point at CACHE
- * domain, On others it will point to SMT domain. In all cases
- * cpu_l2_cache_mask points to where LLC is
- */
-#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
+const struct cpumask *arch_llc_mask(int cpu);
  
  #ifdef CONFIG_PPC64
  #include <asm/smp.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6a4ee7d3b8e5..139c54fc3e2d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1864,6 +1864,28 @@ void __noreturn arch_cpu_idle_dead(void)
  
  #endif
  
+/*
+ * Points to where the LLC is. On power9 this will point at CACHE
+ * domain, On others it will point to SMT domain. In all cases
+ * cpu_l2_cache_mask points to where LLC is.
+ *
+ * If there is llc_override debug knob, return appropriate mask
+ */
+const struct cpumask *arch_llc_mask(int cpu)
+{
+	switch (READ_ONCE(llc_override)) {
+	case LLC_OVERRIDE_SMT:
+		return cpu_smt_mask(cpu);
+	case LLC_OVERRIDE_MC:
+		return cpu_coregroup_mask(cpu);
+	case LLC_OVERRIDE_PKG:
+		return cpu_die_mask(cpu);
+	case LLC_OVERRIDE_DISABLED:
+	default:
+		return cpu_l2_cache_mask(cpu);
+	}
+}
+
  int arch_update_cpu_topology(void)
  {
  	if (READ_ONCE(llc_override_changed)) {
@@ -1923,6 +1945,7 @@ static ssize_t llc_override_set(struct file *file, const char __user *ubuf,
  		pr_info("sched LLC override set to %s. Rebuilding sched domains\n",
  			llc_override_str[override]);
  
+		sched_reset_llc_id();
  		rebuild_sched_domains();
  	}
  
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7b91cae4a59c..4d7e2ee841a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2505,5 +2505,5 @@ extern void migrate_enable(void);
  #endif /* MODULE */
  
  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
-
+void sched_reset_llc_id(void);
  #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dd2b1d70ec9d..63c9bca4c5eb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3087,6 +3087,13 @@ void sched_domains_free_llc_id(int cpu)
  	sched_domains_mutex_unlock();
  }
  
+void sched_reset_llc_id(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		sched_domains_free_llc_id(cpu);
+}
  /*
   * Build sched domains for a given set of CPUs and attach the sched domains
   * to the individual CPUs
-- 
2.52.0



Another way to avoid all this is with kernel parameter i think.
That would fix the LLC at specific domain and this reset/rebuild of llc_id
won't be necessary. If one is happy to change the debugfs, i guess they
would okay with rebooting the kernel with specific parameter too.
And at this point, I think that would mean the code will be arch/powerpc/
contained too.
(Yes, that would need updating arch_llc_mask, but no need to do the rebuilding
the sd_llc_id stuff)


So two ways.

- debugfs way with above changes.
- kernel parameters way.


Tim, Peter, Maddy, What do you guys suggest?
>>
>> Tim, Chenyu, Peter,
>> Are there any selftest or patches which is used for
>> functional validation of cache aware scheduling?
> 
> We haven't created one. We validate mostly with workloads such as
> hackbench, schbench and yogini (which can vary the number of threads
> over time and track CPU assignment). I agree they are not ideal for
> functional checks of the load balance path.
> 
>> per-LLC occupancy in /proc/{PID}/schedstat may not tell the full
>> story when there are multiple processes and multiple LLC's.
>>
>> Atleast for functional verification, we might need one if there is
>> not one already. The reason being,
>> - At present, we may need a custom workload. hackbench/schbench are
>>    wakeup intensive and typically bail out even before load balance.
>> - stress-ng is per process. So doesn't get cache aware scheduling.
>> - A selftest could spwan specific number of threads till llc size etc
>>    and ensure packing happens till core_count(llc_size) by default.
>>    This could also be used for tunable verfifications.
>> - Provide an ability to observe how much of the workload was contained
>>    within the LLC due to cache aware scheduling or number of load
>>    balances stopped due to preferred llc.
> 
> A selftest would be great and much welcomed.
> 

Cool. Will give it a try. but only after start implementing
will come to know the challenges. LLM's are there to help anyway!.

> Tim
> 

