Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF42C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91F02082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91F02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDv26X4hzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DDqD3LwlzDqjR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 07:16:08 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBAKDuH3106547
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 15:16:06 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9vh573q1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 15:16:06 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 10 Dec 2018 20:16:05 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 20:16:03 -0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBAKG2gk17498264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 20:16:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 748EB6A057;
 Mon, 10 Dec 2018 20:16:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7C7A6A04D;
 Mon, 10 Dec 2018 20:16:01 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.223])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 20:16:01 +0000 (GMT)
Subject: Re: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, ego@linux.vnet.ibm.com
References: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
 <87a7li5zv2.fsf@morokweng.localdomain> <20181207104311.GA11431@in.ibm.com>
 <20181207120346.GB11431@in.ibm.com> <87va443fm3.fsf@morokweng.localdomain>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Mon, 10 Dec 2018 14:16:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va443fm3.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121020-0004-0000-0000-000014C0240E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010209; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129873; UDB=6.00587069; IPR=6.00910006; 
 MB=3.00024644; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 20:16:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121020-0005-0000-0000-000089CE4796
Message-Id: <06dfb955-6af9-ae23-3919-9bee447cfcdc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100180
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I have asked Scott Mayes to take a look at one of these crashes from
the phyp side.  I will let you know if he finds anything notable.

Michael

On 12/07/2018 08:40 PM, Thiago Jung Bauermann wrote:
> 
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
>> On Fri, Dec 07, 2018 at 04:13:11PM +0530, Gautham R Shenoy wrote:
>>> Sure. I will test the patch and report back.
>>
>> I added the following debug patch on top of your patch, and after an
>> hour's run, the system crashed. Appending the log at the end.
> 
> Thank you very much for testing! Your debug patch was very helpful as
> well.
> 
>> I suppose we still need to increase the number of tries since we wait
>> only for 2.5ms looping before giving up.
> 
> Do you think it would have helped? In the debug output you posted I
> would have expected the following message to show up if the loop
> finished too early, and it didn't:
> 
> "Querying DEAD? cpu %i (%i) shows %i\n"
> 
> So I don't think increasing the loop length would have made a
> difference. In fact, the call to smp_query_cpu_stopped() always
> succeeded on the first iteration.
> 
> I think there is something else going on which we don't fully understand
> yet. From your other email:
> 
>> I agree that the Kernel has to respect RTAS's restriction. The PAPR
>> v2.8.1, Requirement R1-7.2.3-8 under section 7.2.3 says the following:
>>
>>     "The stop-self service needs to be serialized with calls to the
>>      stop-self, start-cpu, and set-power-level services. The OS must
>>      be able to call RTAS services on other processors while the
>>      processor is stopped or being stopped"
>>
>> Thus the onus is on the OS to ensure that there are no concurrent rtas
>> calls with "stop-self" token.
> 
> As you say perhaps there's another call to stop-self, start-cpu or
> set-power-level being made concurrently. I don't currently see how more
> than one stop-self or start-cpu call could be in flight at the same time
> given that there are a number of locks being grabbed during CPU hotplug
> and unplug. OTOH the CPU that actually calls stop-self doesn't seem to
> grab any locks itself so it's a possibility.
> 
> As for set-power-level, it's only used in the case of PCI hotplug from
> what I can see, and that isn't part of the picture in this case, right?
> 
> We could address this problem directly by adding another lock separate
> from rtas.lock to serialize just these calls. The challenge is with
> stop-self, because the CPU calling it will never return to release the
> lock. Is it possible to grab a lock (or down a semaphore) in the CPU
> calling stop-self and then release the lock (or up the semaphore) in the
> CPU running pseries_cpu_die()?
> 
>>> There's also a race between the CPU driving the unplug and the CPU
>>> being unplugged which I think is not easy for the CPU being
>>> unplugged to win, which makes the busy loop in pseries_cpu_die() a
>>> bit fragile. I describe the race in the patch description.
>>>
>>> My solution to make the race less tight is to make the CPU driving
>>> the unplug to only start the busy loop only after the CPU being
>>> unplugged is in the CPU_STATE_OFFLINE state. At that point, we know
>>> that it either is about to call RTAS or it already has.
>>
>> Ah, yes this is good optimization. Though, I think we ought to
>> unconditionally wait until the target CPU has woken up from CEDE and
>> changed its state to CPU_STATE_OFFLINE. After if PROD failed, then we
>> would have caught it in dlpar_offline_cpu() itself.
> 
> I recently saw a QEMU-implemented hcall (H_LOGICAL_CI_LOAD) return
> success when it had been given an invalid memory address to load from,
> so my confidence in the error reporting of hcalls is a bit shaken. :-)
> 
> In that case the CPU would wait forever for the CPU state to change. If
> you believe 100 ms is too short a timeout, we could make it 500 ms or
> even 1s. What do you think?
> 
>> cpu 112 (hwid 112) Ready to die...
>> [DEBUG] Waited for CPU 112 to enter rtas: tries=0, time=65
>> cpu 113 (hwid 113) Ready to die...
>> [DEBUG] Waited for CPU 113 to enter rtas: tries=0, time=1139
>> cpu 114 (hwid 114) Ready to die...
>> [DEBUG] Waited for CPU 114 to enter rtas: tries=0, time=1036
>> cpu 115 (hwid 115) Ready to die...
>> [DEBUG] Waited for CPU 115 to enter rtas: tries=0, time=133
>> cpu 116 (hwid 116) Ready to die...
>> [DEBUG] Waited for CPU 116 to enter rtas: tries=0, time=1231
>> cpu 117 (hwid 117) Ready to die...
>> [DEBUG] Waited for CPU 117 to enter rtas: tries=0, time=1231
>> cpu 118 (hwid 118) Ready to die...
>> [DEBUG] Waited for CPU 118 to enter rtas: tries=0, time=1231
>> cpu 119 (hwid 119) Ready to die...
>> [DEBUG] Waited for CPU 119 to enter rtas: tries=0, time=1131
>> cpu 104 (hwid 104) Ready to die...
>> [DEBUG] Waited for CPU 104 to enter rtas: tries=0, time=40
> 
> Interesting, so 1.2 ms can pass before the dying CPU actually gets close
> to making the stop-self call. And even in those cases the retry loop is
> succeeding on the first try! So this shows that changing the code to
> wait for the CPU_STATE_OFFLINE state is worth it.
> 
>> ******* RTAS CALL BUFFER CORRUPTION *******
>> 393: rtas32_call_buff_ptr=
>>     0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
>>     0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
>>     0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
>>     0000 0060 0800 E07F ACA7 0000 0000 00C0 [...`............]
>>     2500 0000 0000 0000 0000 0000 0000 0000 [%...............]
>>     0000 0000 0000 0000 0000 0000 306E 7572 [............0nur]
>>     4800 0008 .... .... .... .... .... .... [H...........0nur]
>> 394: rtas64_map_buff_ptr=
>>     0000 0000 5046 5743 0000 0000 4F44 4500 [....PFWC....ODE.]
>>     0000 0000 6000 0000 0000 0000 0000 0069 [....`..........i]
>>     0000 0000 0000 0000 0000 0000 0000 0000 [................]
>>     0000 0000 0000 0005 0000 0000 0000 0001 [................]
>>     0000 0000 1A00 0000 0000 0000 0000 0000 [................]
>>     0000 0000 8018 6398 0000 0000 0300 00C0 [......c.........]
>>     0000 0000 .... .... .... .... .... .... [......c.........]
> 
> Ah! I never saw this error message. So indeed the kernel is causing RTAS
> to blow up. Perhaps it would be useful to instrument more RTAS calls
> (especially start-cpu and set-power-level) to see if it's one of them
> that is being called at the time this corruption happens.
> 
>> cpu 105 (hwid 105) Ready to die...
>> Bad kernel stack pointer 1fafb6c0 at 0
>> Oops: Bad kernel stack pointer, sig: 6 [#1]
>> LE SMP NR_CPUS=2048 NUMA pSeries
>> Modules linked in:
>> CPU: 105 PID: 0 Comm: swapper/105 Not tainted 4.20.0-rc5-thiago+ #45
>> NIP:  0000000000000000 LR: 0000000000000000 CTR: 00000000007829c8
>> REGS: c00000001e63bd30 TRAP: 0700   Not tainted  (4.20.0-rc5-thiago+)
>> MSR:  8000000000081000 <SF,ME>  CR: 28000004  XER: 00000010
>> CFAR: 000000001ec153f0 IRQMASK: 8000000000009033
>> GPR00: 0000000000000000 000000001fafb6c0 000000001ec236a0 0000000000000040
>> GPR04: 00000000000000c0 0000000000000080 00046c4fb4842557 00000000000000cd
>> GPR08: 000000000001f400 000000001ed035dc 0000000000000000 0000000000000000
>> GPR12: 0000000000000000 c00000001eb5e480 c0000003a1b53f90 000000001eea3e20
>> GPR16: 0000000000000000 c0000006fd845100 c00000000004c8b0 c0000000013d5300
>> GPR20: c0000006fd845300 0000000000000008 c0000000019d2cf8 c0000000013d6888
>> GPR24: 0000000000000069 c0000000013d688c 0000000000000002 c0000000013d688c
>> GPR28: c0000000019cecf0 0000000000000348 0000000000000000 0000000000000000
>> NIP [0000000000000000]           (null)
>> LR [0000000000000000]           (null)
>> Call Trace:
>> Instruction dump:
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 60000000 60000000 60000000
>> ---[ end trace 1aa3b4936949457e ]---
> 
> Ok, so at about the time CPU 105 makes the stop-self call there is this
> RTAS call buffer corruption and this bad kernel stack pointer in CPU 105.
> We need to understand better what is causing this.
> 
>> Bad kernel stack pointer 1fafb4b0 at 1ec15004
>> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> rcu:    88-...!: (0 ticks this GP) idle=2ce/1/0x4000000000000000 softirq=28076/28076 fqs=78
>> rcu:    (detected by 72, t=10866 jiffies, g=180529, q=2526)
>> Sending NMI from CPU 72 to CPUs 88:
>> CPU 88 didn't respond to backtrace IPI, inspecting paca.
>> irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 22978 (drmgr)
>> Back trace of paca->saved_r1 (0xc0000006f94ab750) (possibly stale):
>> Call Trace:
>> [c0000006f94ab750] [c0000006f94ab790] 0xc0000006f94ab790 (unreliable)
>> [c0000006f94ab930] [c0000000000373f8] va_rtas_call_unlocked+0xc8/0xe0
>> [c0000006f94ab950] [c000000000037a98] rtas_call+0x98/0x200
>> [c0000006f94ab9a0] [c0000000000d7d28] smp_query_cpu_stopped+0x58/0xe0
>> [c0000006f94aba20] [c0000000000d9dbc] pseries_cpu_die+0x1ec/0x240
>> [c0000006f94abad0] [c00000000004f284] __cpu_die+0x44/0x60
>> [c0000006f94abaf0] [c0000000000d8e10] dlpar_cpu_remove+0x160/0x340
>> [c0000006f94abbc0] [c0000000000d9184] dlpar_cpu_release+0x74/0x100
>> [c0000006f94abc10] [c000000000025a74] arch_cpu_release+0x44/0x70
>> [c0000006f94abc30] [c0000000009bd1bc] cpu_release_store+0x4c/0x80
>> [c0000006f94abc60] [c0000000009ae000] dev_attr_store+0x40/0x70
>> [c0000006f94abc80] [c000000000495810] sysfs_kf_write+0x70/0xb0
>> [c0000006f94abca0] [c00000000049453c] kernfs_fop_write+0x17c/0x250
>> [c0000006f94abcf0] [c0000000003ccb6c] __vfs_write+0x4c/0x1f0
>> [c0000006f94abd80] [c0000000003ccf74] vfs_write+0xd4/0x240
>> [c0000006f94abdd0] [c0000000003cd338] ksys_write+0x68/0x110
>> [c0000006f94abe20] [c00000000000b288] system_call+0x5c/0x70
> 
> So CPU 88 is the one driving the hot unplug and waiting for CPU 105 to
> die. But it is stuck inside RTAS. Perhaps because of the call buffer
> corruption?
> 
>> rcu: rcu_sched kthread starved for 10709 jiffies! g180529 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=72
>> rcu: RCU grace-period kthread stack dump:
>> rcu_sched       I    0    11      2 0x00000808
>> Call Trace:
>> [c0000000061ab840] [c0000003a4a84800] 0xc0000003a4a84800 (unreliable)
>> [c0000000061aba20] [c00000000001e24c] __switch_to+0x2dc/0x430
>> [c0000000061aba80] [c000000000e5fb94] __schedule+0x3d4/0xa20
>> [c0000000061abb50] [c000000000e6022c] schedule+0x4c/0xc0
>> [c0000000061abb80] [c000000000e64ffc] schedule_timeout+0x1dc/0x4e0
>> [c0000000061abc80] [c0000000001af40c] rcu_gp_kthread+0xc3c/0x11f0
>> [c0000000061abdb0] [c00000000013c7c8] kthread+0x168/0x1b0
>> [c0000000061abe20] [c00000000000b658] ret_from_kernel_thread+0x5c/0x64
> 
> I don't know what to make of CPU 72. :-)  Perhaps it's the one making
> the other "rogue" RTAS call interfering with stop-self in CPU 105?
> 
> It must be some RTAS call made with rtas_call_unlocked, because CPU 88
> is holding the RTAS lock.
> 
> -- Thiago Jung Bauermann
> IBM Linux Technology Center
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

