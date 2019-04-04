Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:12:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1787520820
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1787520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZgK55JVZzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 22:12:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZgH91c0QzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 22:11:00 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x34At43l101723
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2019 07:10:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rneg1g0c8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 07:10:56 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Thu, 4 Apr 2019 12:10:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 4 Apr 2019 12:10:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x34BAjOB46792794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Apr 2019 11:10:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A629AE045;
 Thu,  4 Apr 2019 11:10:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC380AE051;
 Thu,  4 Apr 2019 11:10:43 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.71])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  4 Apr 2019 11:10:43 +0000 (GMT)
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To: Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
 <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
 <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Thu, 4 Apr 2019 16:40:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040411-0012-0000-0000-0000030B32F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040411-0013-0000-0000-000021434178
Message-Id: <f535b21a-2441-70c3-e51d-28ec8843de66@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-04_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040076
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
Cc: ego@linux.vnet.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 04/04/2019 03:51 PM, Daniel Lezcano wrote:
> Hi Abhishek,
>
> thanks for taking the time to test the different scenario and give us
> the numbers.
>
> On 01/04/2019 07:11, Abhishek wrote:
>>
>> On 03/22/2019 06:56 PM, Daniel Lezcano wrote:
>>> On 22/03/2019 10:45, Rafael J. Wysocki wrote:
>>>> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
>>>> <huntbag@linux.vnet.ibm.com> wrote:
>>>>> Currently, the cpuidle governors (menu /ladder) determine what idle
>>>>> state
>>>>> an idling CPU should enter into based on heuristics that depend on the
>>>>> idle history on that CPU. Given that no predictive heuristic is
>>>>> perfect,
>>>>> there are cases where the governor predicts a shallow idle state,
>>>>> hoping
>>>>> that the CPU will be busy soon. However, if no new workload is
>>>>> scheduled
>>>>> on that CPU in the near future, the CPU will end up in the shallow
>>>>> state.
>>>>>
>>>>> In case of POWER, this is problematic, when the predicted state in the
>>>>> aforementioned scenario is a lite stop state, as such lite states will
>>>>> inhibit SMT folding, thereby depriving the other threads in the core
>>>>> from
>>>>> using the core resources.
> I can understand an idle state can prevent other threads to use the core
> resources. But why a deeper idle state does not prevent this also?
>
>
>>>>> To address this, such lite states need to be autopromoted. The cpuidle-
>>>>> core can queue timer to correspond with the residency value of the next
>>>>> available state. Thus leading to auto-promotion to a deeper idle
>>>>> state as
>>>>> soon as possible.
>>>> Isn't the tick stopping avoidance sufficient for that?
>>> I was about to ask the same :)
>>>
>>>
>>>
>>>
>> Thanks for the review.
>> I performed experiments for three scenarios to collect some data.
>>
>> case 1 :
>> Without this patch and without tick retained, i.e. in a upstream kernel,
>> It would spend more than even a second to get out of stop0_lite.
>>
>> case 2 : With tick retained(as suggested) -
>>
>> Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
>> it to take 8 sched tick to get out of stop0_lite. Experimentally,
>> observation was
>>
>> ===================================
>> min            max            99percentile
>> 4ms            12ms          4ms
>> ===================================
>> *ms = milliseconds
>>
>> It would take atleast one sched tick to get out of stop0_lite.
>>
>> case 2 :  With this patch (not stopping tick, but explicitly queuing a
>> timer)
>>
>> min            max              99.5percentile
>> ===============================
>> 144us       192us              144us
>> ===============================
>> *us = microseconds
>>
>> In this patch, we queue a timer just before entering into a stop0_lite
>> state. The timer fires at (residency of next available state + exit
>> latency of next available state * 2).
> So for the context, we have a similar issue but from the power
> management point of view where a CPU can stay in a shallow state for a
> long period, thus consuming a lot of energy.
>
> The window was reduced by preventing stopping the tick when a shallow
> state is selected. Unfortunately, if the tick is stopped and we
> exit/enter again and we select a shallow state, the situation is the same.
>
> A solution was previously proposed with a timer some years ago, like
> this patch does, and merged but there were complains about bad
> performance impact, so it has been reverted.
>
>> Let's say if next state(stop0) is available which has residency of 20us, it
>> should get out in as low as (20+2*2)*8 [Based on the forumla (residency +
>> 2xlatency)*history length] microseconds = 192us. Ideally we would expect 8
>> iterations, it was observed to get out in 6-7 iterations.
> Can you explain the formula? I don't get the rational. Why using the
> exit latency and why multiply it by 2?
>
> Why the timer is not set to the next state's target residency value ?
>
The idea behind multiplying by 2 is, entry latency + exit latency = 2* 
exit latency, i.e.,
using exit latency = entry latency
So in effect, we are using target residency + 2 * exit latency for 
timeout of timer.
Latency is generally <=10% of residency. I have tried to be conservative 
by including latency
factor in computation for timeout. Thus, this formula will give slightly 
greater value compared
to directly using residency of target state.

--Abhishek

