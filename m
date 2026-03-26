Return-Path: <linuxppc-dev+bounces-18794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA7109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:12:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhD2y2bnVz2xlM;
	Thu, 26 Mar 2026 17:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774505562;
	cv=none; b=EDBmpmSoFUJ3Eo7xCdDsNVucpD1Cd0NTE46siaIVlU9FYDwPQvudgdOOFhQ7ErKsI8QAGVo+pyGfLi9MebOAZoBXoPdtX7m6u9mrQP+d7PB9I31JNrc9Sxq/BIfNogYn9k2blHvsNhBa2R5n/Vu9bwQFb78LO0YNdnYONVfBv4l1yRSFh5mm2awBDtAa0W3c0IxTDRwOWjmDbdOBVIqLBlo/XUyrOJx7jKIyuGczXZ00DPwXEYSXiAFw3nKp3q3WqWVsWGeVyQy+xNdIhe6Urjxc31OYc0ha6Cp45cbso5Tx/NKn7tk3VOJJXMjn0pCp7n0afcTj1PRaV1oyvbG4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774505562; c=relaxed/relaxed;
	bh=KeozJ0Yl4nEaPROBhBdaZoDtza9zntMECzpCTJXoTWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9aDu4/tqsh5mnVJ0iJ0qXJ9jlXrw42OslCAfLtxDTFeoJXn2YTjhNRi5nD+mNfjH1KqpZP0G41546A//+LEmrEzOVdj8D5fvdgrvuo+fClVNJu3lBCg9yb+bth8z/+XhorKUYm0IPpBmfZCFAqXSUpg4J4iqn1P+COXNhiHGrk4DBwA7URyGfOl7xtolbAmVWChxWH84FE8AXdroTP4UcjkaCU8cguN55CNV2Gf4JCm8Rg62cc3YAHlMrB3YsEwg90TsumrK7RY+9P3Pzrh7wss8XWcAZR1sdtCbCr/2rVtGkdCDJDd1O2nGFg7O3/7QEmYCnVS0TgFMkr3XM+kbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OzVITTsM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OzVITTsM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhD2x1WV9z2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:12:40 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q3Chud669847;
	Thu, 26 Mar 2026 06:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KeozJ0
	Yl4nEaPROBhBdaZoDtza9zntMECzpCTJXoTWk=; b=OzVITTsM0/u9BbOffqkS+r
	5huYBRtoZcDsTShPCYoikLaIcnBo3EYqhgqunDneROmGADo85bUmTqKyT3c+TSXN
	tRcOxORQiQhBFxKsFzaD1pqayidJGVNCl8Y6e2KKiukT6jGYorf6Y87VWU9Py6RB
	jGy/35rIX+5xffbzvHshwfKMQdT2Kh0IQ3PaW+lPtzOXzLykTevVg+NGl7z7eYCQ
	SaABQ3PCIoW0E8Z7simUn3Qi6cfgkHm0VrTX9T1sMqaeOJkrvu/IEiJ37ykOsuur
	ldnLIbpTk7Hbqntzqt2pFjbVSfH1c7AKFmLR7GrpcG/JKacMTs8Wy7Hp2MRGbSoQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv2wqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 06:12:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q1wAem026771;
	Thu, 26 Mar 2026 06:11:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m1n0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 06:11:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q6BtKD49283394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 06:11:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C72E20043;
	Thu, 26 Mar 2026 06:11:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D82820040;
	Thu, 26 Mar 2026 06:11:51 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 06:11:50 +0000 (GMT)
Message-ID: <2dc4d116-edea-4bef-b10a-e9a71c6e1594@linux.ibm.com>
Date: Thu, 26 Mar 2026 11:41:50 +0530
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
Subject: Re: [PATCH 00/17] Paravirt CPUs and push task for less vCPU
 preemption
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, kprateek.nayak@amd.com,
        vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com,
        christophe.leroy@csgroup.eu, kernellwp@gmail.com
References: <20251119124449.1149616-1-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251119124449.1149616-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ExTMGBaEW7_hNXIHEvXDLOpM53XgsmUs
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c4ce30 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=-R1cmi0paiBohlNiqWMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA0MiBTYWx0ZWRfX6Y1flZ15GMG4
 lScUZzpEKAXUmuxudSWKkn7wM8g9/yk3b3GweYOW1jb4LplqGznjawEE1IVhTrr2Upj5hxMY2Py
 w8fsEIAUw5gvI/wykiVty12iW9XEQMUtttelkazaKyE2itFNUuUcuHcjrqX3XRCFtpNEiwQ4bvL
 UXc56/Jw/+Wa+Z16cRUIxrqp2HzqMWHZMoH/bJyAJYyHQfR8F7sGJAJox3KsKttT7gv0VEnrkl+
 Rq88QWm6ToX8fwNwhIX5Q2Vw0qh5lkBuRnUgycMw7Id8B/teFwMUJ6+TjU54vg8+NyITwFsw32m
 nNBUx7BuZJeCAyqrmPRQrjtfoBclMLoVCPTrAmp4yCxPu+xlR3JIpUPWCtmoXpHmXFk1J5grw1a
 ZGm89EvufdsTA8xAWmUeLBBHIfUa1JLE28g6Xrai6y4bQXhlhl7JhFLG/jKJhyTvQnknOIrMBQ3
 pJiCws7jItH/ZTuBl+w==
X-Proofpoint-GUID: aY_ea5AMmaj1IrGWZQAg078R_XoK0Jcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260042



On 11/19/25 6:14 PM, Shrikanth Hegde wrote:
> Detailed problem statement and some of the implementation choices were
> discussed earlier[1].
> 
> [1]: https://lore.kernel.org/all/20250910174210.1969750-1-sshegde@linux.ibm.com/
> 
> This is likely the version which would be used for LPC2025 discussion on
> this topic. Feel free to provide your suggestion and hoping for a solution
> that works for different architectures and it's use cases.
> 
> All the existing alternatives such as cpu hotplug, creating isolated
> partitions etc break the user affinity. Since number of CPUs to use change
> depending on the steal time, it is not driven by User. Hence it would be
> wrong to break the affinity. This series allows if the task is pinned
> only paravirt CPUs, it will continue running there.
> 
> Changes compared v3[1]:
> 
> - Introduced computation of steal time in powerpc code.
> - Derive number of CPUs to use and mark the remaining as paravirt based
>    on steal values.
> - Provide debugfs knobs to alter how steal time values being used.
> - Removed static key check for paravirt CPUs (Yury)
> - Removed preempt_disable/enable while calling stopper (Prateek)
> - Made select_idle_sibling and friends aware of paravirt CPUs.
> - Removed 3 unused schedstat fields and introduced 2 related to paravirt
>    handling.
> - Handled nohz_full case by enabling tick on it when there is CFS/RT on
>    it.
> - Updated helper patch to override arch behaviour for easier debugging
>    during development.
> - Kept
> 
> Changes compared to v4[2]:
> - Last two patches were sent out separate instead of being with series.
>    That created confusion. Those two patches are debug patches one can
>    make use to check functionality across acrhitectures. Sorry about
>    that.
> - Use DEVICE_ATTR_RW instead (greg)
> - Made it as PATCH since arch specific handling completes the
>    functionality.
> 
> [2]: https://lore.kernel.org/all/20251119062100.1112520-1-sshegde@linux.ibm.com/
> 
> TODO:
> 
> - Get performance numbers on PowerPC, x86 and S390. Hopefully by next
>    week. Didn't want to hold the series till then.
> 
> - The CPUs to mark as paravirt is very simple and doesn't work when
>    vCPUs aren't spread out uniformly across NUMA nodes. Ideal would be splice
>    the numbers based on how many CPUs each NUMA node has. It is quite
>    tricky to do specially since cpumask can be on stack too. Given
>    NR_CPUS can be 8192 and nr_possible_nodes 32. Haven't got my head into
>    solving it yet. Maybe there is easier way.
> 
> - DLPAR Add/Remove needs to call init of EC/VP cores (powerpc specific)
> 
> - Userspace tools awareness such as irqbalance.
> 
> - Delve into design of hint from Hyeprvisor(HW Hint). i.e Host informs
>    guest which/how many CPUs it has to use at this moment. This interface
>    should work across archs with each arch doing its specific handling.
> 
> - Determine the default values for steal time related knobs
>    empirically and document them.
> 
> - Need to check safety against CPU hotplug specially in process_steal.
> 
> 
> Applies cleanly on tip/master:
> commit c2ef745151b21d4dcc4b29a1eabf1096f5ba544b
> 
> 
> Thanks to srikar for providing the initial code around powerpc steal
> time handling code. Thanks to all who went through and provided reviews.
> 
> PS: I haven't found a better name. Please suggest if you have any.
> 

Sorry for the long delay in coming with next steps. Largely it was due to me
not have worked on it, partially due to lack of system being available.

I have been wondering how to proceed for next version. Your comments are highly
appreciated.

- One of the idea vincent's suggested was to use CPU Capacity.
   I made poc[1] around it and it works, But it doesn't seems to efficient
   for me. The reason being,
   - in sched_balance_rq it would be better to not to spread load into a
     CPU marked as paravirt as sched_tick would trying the same thing, specially
     for active_balance.
   - Would need a notion of which CPUs are marked as not be used. Computing them
     in sched_balance_rq is going to be costly.
   - So, if we are going to need a cpumask which maintains that state. If have that cpumask
     already, CPU CAPACITY need not be changed. There will be separation between the two.
     So that they won't fight with each other IMO. Feel free to correct me.

- I have been thinking, the steal time is generic property across archs. why have the
   arch specific handling, when it could be in generic code. I know CPU numbers could be
   tricky, but how about having steal time handling governers. Default governer would take
   out last set of cores. (I still need to figure out splicing numa across NUMA nodes)
   i.e in sched_tick, we periodically call a schedule_work to handle the steal time, if steal time
   is greater than configurable threshold step up/down approach can be taken. (same as current
   powerpc logic)

- Regarding the cpuset way, it would still need sched domain rebuilds, on large systems
   i think it is still expensive to do. Though steal time changes are not that frequent,
   it would be better if the infra is lightweight. Also, different cgroup version are there,
   I don't know how to fit into all those cases.

- I went through the cover-letter of "Semantics-aware vCPU scheduling for oversubscribed KVM",
   - My take is this would help reduce the context of lock holder preemption as it aims to
     reduce the steal time by stacking the tasks on lesser set of CPUs. Once the lock holder runs,
     it would disable preemption and run to completion.

- Debug some of the cases discussed at LPC. schbench regression was gone after
   modifying it. Hackbench had in some cases regressions. Setting up the systems to do.
   Let me see if i can re-create that in powerpc

- I still need to figure out irq related stuff. How to force or migrate irq from
   CPU's marked as paravirt. irqbalance is one thing, but how to do so when irqbalance
   is not running.

- How about the name as "usable" CPUs. ??


[1]: https://lore.kernel.org/all/b8d6d83c-00d8-4b66-8470-62cc528e1d6b@linux.ibm.com/
[2]: https://lore.kernel.org/all/20251219035334.39790-1-kernellwp@gmail.com/

