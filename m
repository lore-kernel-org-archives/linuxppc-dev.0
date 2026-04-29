Return-Path: <linuxppc-dev+bounces-20269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EAAFF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Crk3Jn3z2yVL;
	Wed, 29 Apr 2026 20:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777457798;
	cv=none; b=gOSikCKUv3TAYCK4IVZnn+dEc4gPiXVWSXJasyVg0Tw8kqQwy3HKbToV9IpoGefpb+tcBaFsCS+iwEoKvz6p94yJjtZuoQi0B2XF7FOB4IghplH6nQeHdjtKH/UmZ3Abe/dgyDurB+YVuhHWigusndYLgKtzd5iOjRc/mLFijefSIa3dLMqZNThXG/Pr3T8V98s9fWH/FTUECH3P87NudIVrLsX8Iq/vSzGWtUKV6eBRYRv3JCFTA+zqvAGz8ZqgfAx7kDZMV8r1DmSm9AOTYWll/+vwu8adsMUV529Q0dN0AODrkqs9958OSo7F1eN+CgYIdwy1BbzYmd22pcuIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777457798; c=relaxed/relaxed;
	bh=F/lT+9gq3vxflXRL0Qzbxq9y7PHWIm46jZMnKsw2Ke4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNJPZT7vMt5nq6fUj622EDv5Q/dw3KYUTIWpddsdRNYgXpVHLYXiLbErRHUMQicB98KhKwnp0QfWAH+Sar8GW3OXiW1syPX41ZX/vFiHOJ8WZK3JN64ddka5XT8/X42V9B30TedrtxH7sgZZfS8w46BgIpqIc5waCpSGe8GsvUKXPgqYNMZqqqQbGtRyaCQFsfG67CExZ2Qz9FsV445/zyjUNpTJY4Ojxa93jJp0PpuJjqeYNMMK1tWc0G4IjbVVr62BWBKvGYZBAP6LNF5Y7WlK2B+LD1+HV26TtMRogR9a4NMLY1pCGp0M26/50TDpiTosLAyGxdnAse7tPy0wkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J66TijRI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J66TijRI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Crj2x0fz2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 20:16:36 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SNJHBM358063;
	Wed, 29 Apr 2026 10:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F/lT+9
	gq3vxflXRL0Qzbxq9y7PHWIm46jZMnKsw2Ke4=; b=J66TijRI2beebcxwBtnUpz
	nkscDZTO4Ci0/M0vagqjAdt6um1m6v1SSK1041tCrR0ucAyi1N1NDoJ6FLhDFBha
	jzvRDXQStOkPcV72qb7wXSBKgKJQSsrK+AgB5AquRXXotQQA9pzHGDIuGcSrWI65
	cGuV8lTmxGwDhQvjrkKGnymp/D0nnnOv83T+HOMrJVEiCFVonKCxumP9xZUpHyhY
	DFZ8eiImFB/PjywFdEkiq+zqyhGOFxuwYF/8qt75oGhvJ5olsF5rkimgcZ5HmUD0
	D5WtFHo+w+cEj93RIJF6wVVpzcBrUWP8UTXfKLzcflZi8TsgJsDKJBwdcJKVvDuA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb59w8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 10:16:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TA8l5G030771;
	Wed, 29 Apr 2026 10:16:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gdpb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 10:16:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TAGTtf7537564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 10:16:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4302458043;
	Wed, 29 Apr 2026 10:16:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C72EB5805D;
	Wed, 29 Apr 2026 10:16:18 +0000 (GMT)
Received: from [9.123.0.247] (unknown [9.123.0.247])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 10:16:18 +0000 (GMT)
Message-ID: <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
Date: Wed, 29 Apr 2026 15:46:09 +0530
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
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, RCU <rcu@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <ae-EP1BpXgnEWCt4@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f1da7f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=VnNF1IyMAAAA:8 a=o1-_AkJ4wEVZsbxAFwQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5OCBTYWx0ZWRfX9/X6ZMaNEKtL
 q/IT55ewwFm4hD09MZ1ALH8c2FESDpfveQ7m8301scb4vjUfSammr8x13vlig9Koe9ZOdsdUPor
 n5V7AffGRjD16DjTOLXXILyBxxkZyJE3rjiyIUpTaUCT0Y4c60qQawTzMh7171RzAA3/d+Dgpwr
 EI8fMAt+TiRmf0a1g3faA5WFiRukLAZLUy5pZltqwZVsIpewEhjBiWwOEvlANrQB9qKnztGObWi
 +BGDsrSit9hpVmpSuQZQN/GCnS98r2JovT2RIvQFy/i4h4A7LRXs6nfMCRaXim6zo7Y6HjRkVRp
 kgxPSe/qmSXBMTngWRuYxO7XelRRAXNFg/079a3KRVNE4/606KTYoiyKG9j0MQ/F3fNd+YrGQ3F
 3q8oDX9aVLg+wn1HdlXjgQRfnH10qeUCvR4D1uxitqg4n1jgddzsWNlP7H1cXOaYVPz+WAkXDvn
 uJQnh92h6nMWnXSd0dg==
X-Proofpoint-GUID: Wpocfkr4VUVxzzU8Hg7kuHWMEsHKFXJX
X-Proofpoint-ORIG-GUID: 7jpyQkmcGJ1EwzTPshgboXQKOhaIFgeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290098


On 27/04/26 9:13 pm, Boqun Feng wrote:
> On Mon, Apr 27, 2026 at 05:00:10PM +0530, Samir M wrote:
> Hi Samir,
>
>> On 27/04/26 3:32 pm, Samir M wrote:
>>> Hi Paul,
>>>
>>> I've been testing the latest upstream kernel on a PowerPC system and
>>> encountered workqueue lockup issues that I've bisected to commit
>>> 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
>>> non-preemptible").
>>> After booting, I'm seeing workqueue lockup warnings for CPUs 81-96,
>>> which are offline on my system. The workqueues remain stuck for over 237
>>> seconds:
>>>
>>> [  243.309302][    C0] BUG: workqueue lockup - pool cpus=81 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309311][    C0] BUG: workqueue lockup - pool cpus=82 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309318][    C0] BUG: workqueue lockup - pool cpus=83 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309326][    C0] BUG: workqueue lockup - pool cpus=84 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309333][    C0] BUG: workqueue lockup - pool cpus=85 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309341][    C0] BUG: workqueue lockup - pool cpus=86 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309348][    C0] BUG: workqueue lockup - pool cpus=87 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309355][    C0] BUG: workqueue lockup - pool cpus=88 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309363][    C0] BUG: workqueue lockup - pool cpus=89 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309370][    C0] BUG: workqueue lockup - pool cpus=90 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309377][    C0] BUG: workqueue lockup - pool cpus=91 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309384][    C0] BUG: workqueue lockup - pool cpus=92 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309392][    C0] BUG: workqueue lockup - pool cpus=93 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309399][    C0] BUG: workqueue lockup - pool cpus=94 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309406][    C0] BUG: workqueue lockup - pool cpus=95 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>> [  243.309413][    C0] BUG: workqueue lockup - pool cpus=96 node=0
>>> flags=0x4 nice=0 stuck for 237s!
>>>
>>> Git bisect identified this as the first bad commit:
>>>
>>> commit 61bbcfb50514a8a94e035a7349697a3790ab4783
>>> Author: Paul E. McKenney <paulmck@kernel.org>
>>> Date:   Fri Mar 20 20:29:20 2026 -0700
>>>
>>>      srcu: Push srcu_node allocation to GP when non-preemptible
>>>
>>>      When the srcutree.convert_to_big and srcutree.big_cpu_lim kernel boot
>>>      parameters specify initialization-time allocation of the srcu_node
>>>      tree for statically allocated srcu_struct structures (for example, in
>>>      DEFINE_SRCU() at build time instead of init_srcu_struct() at
>>> runtime),
>>>      init_srcu_struct_nodes() will attempt to dynamically allocate this
>>> tree
>>>      at the first run-time update-side use of this srcu_struct structure,
>>>      but while holding a raw spinlock. Because the memory allocator can
>>>      acquire non-raw spinlocks, this can result in lockdep splats.
>>>
>>>      This commit therefore uses the same SRCU_SIZE_ALLOC trick that is
>>> used
>>>      when the first run-time update-side use of this srcu_struct structure
>>>      happens before srcu_init() is called. The actual allocation then
>>> takes
>>>      place from workqueue context at the ends of upcoming SRCU grace
>>> periods.
>>>
>>>      [boqun: Adjust the sha1 of the Fixes tag]
>>>
>>>      Fixes: 175b45ed343a ("srcu: Use raw spinlocks so call_srcu() can be
>>> used under preempt_disable()")
>>>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>      Signed-off-by: Boqun Feng <boqun@kernel.org>
>>>
>>>   kernel/rcu/srcutree.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> Reverting this commit resolves the issue.
>>>
>>> The problem appears to be that the workqueue is attempting to execute on
>>> offline CPUs. The commit moves SRCU node allocation to workqueue context
>>> to avoid lockdep issues with memory allocation under raw spinlocks,
>>> which makes sense. However, it seems the workqueue scheduling doesn't
>>> properly account for CPU online/offline state in this code path.
>>>
>>> My test environment:
>>> - Architecture: PowerPC
>>> - Kernel version: Latest upstream (7.1-rc1)
>>> - CPUs 81-96 are offline at boot time
>>>
>>> I suspect the issue might be related to:
>>> 1. Workqueue not checking CPU online status before scheduling SRCU
>>> allocation work
>>> 2. Missing CPU hotplug awareness in the new workqueue-based allocation
>>> path
>>> 3. Possible race condition with CPU hotplug events
>>>
>>> Would it make sense to use queue_work_on() with explicit online CPU
>>> selection, or add CPU hotplug handlers for this workqueue? I'm not
>>> deeply familiar with the workqueue internals, so I might be missing
>>> something.
>>> Please let me know if you need any additional details or if you'd like
>>> me to test any patches.
>>>
>>> If you happen to fix the above issue, then please add below tag.
>>> Reported-by: Samir M <samir@linux.ibm.com>
>>>
>>>
>>> Thanks,
>>> Samir
>> Hi Paul,
>>
>>
>> I worked on fixing the issue and introduced the changes below. With these
>> updates, I no longer observe any workqueue lockup messages for offline CPUs.
>> Could you please review the changes and share your feedback?
>>
>> The commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
>> non-preemptible") introduced workqueue lockups on systems with offline
>> CPUs. The issue occurs because srcu_queue_delayed_work_on() calls
>> queue_work_on() with sdp->cpu, which may be offline, causing the
>> workqueue to spin indefinitely on that CPU.
>>
>> This patch fixes the issue by checking if the target CPU is online
>> before queuing work on it. If the CPU is offline, we fall back to
>> using queue_work() which will schedule the work on any available
>> online CPU.
>>
>> Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
>> non-preemptible")
>>
>> Signed-off-by: Samir <samir@linux.ibm.com>
> Thanks for the patch, but I wonder: have you checked this email thread:
>
> 	https://lore.kernel.org/rcu/ttd89ul@ub.hpns/	
>
> Paul had a fix [1], and TJ had a "fix" [2] on workqueue side.
>
> In general I think we discovered that as long as a CPU has been onlined
> once, it's OK to queue the work on that CPU (which may be offlined) even
> with our TJ's patch (whether we should do that is a different problem
> ;-)). Please do check whether Paul's fix works for your case, thanks!
>
> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
>
> Regards,
> Boqun
>
>> ---
>>   kernel/rcu/srcutree.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 0d01cd8c4b4a..55a90dd4a030 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -869,10 +869,15 @@ static void srcu_delay_timer(struct timer_list *t)
>>   static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
>>   unsigned long delay)
>>   {
>> -       if (!delay) {
>> +       if (!delay && cpu_online(sdp->cpu)) {
>>                  queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>>                  return;
>> +       } else if (!delay) {
>> +               /* CPU is offline, queue on any available CPU */
>> +               queue_work(rcu_gp_wq, &sdp->work);
>> +               return;
>> +       }
>>
>>          timer_reduce(&sdp->delay_work, jiffies + delay);
>>   }
>> --
>>
>>
>> Thanks,
>> Samir
Hi Boqun,

Thank you for pointing me to the existing patches. I have tested both 
Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC system (80 
CPUs), and can confirm that the workqueue lockup issue is not observed.

Test Environment:
- System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online and 
384 possible CPUs)
- Kernel version: Latest upstream (7.1-rc1)

Regression Testing Results:
All tests completed successfully with no issues observed:
- Hackbench
- Kernel selftests
- LTP scheduler tests

The workqueue lockup that was previously occurring is no longer present 
with the patches applied.

References:
[1]: 
https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
[2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/

Best regards,
Samir

