Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB094C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 05:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A9720856
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 05:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A9720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XgTw3b2DzDqP6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XgS65hb2zDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 16:11:49 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3159Ac2054003
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Apr 2019 01:11:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rka9ym8vv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 01:11:47 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 1 Apr 2019 06:11:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Apr 2019 06:11:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x315Bf5441746650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Apr 2019 05:11:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B31B0A405D;
 Mon,  1 Apr 2019 05:11:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2052EA4053;
 Mon,  1 Apr 2019 05:11:38 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.85.70.33])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  1 Apr 2019 05:11:37 +0000 (GMT)
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Mon, 1 Apr 2019 10:41:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040105-0008-0000-0000-000002D4AD02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040105-0009-0000-0000-00002240B281
Message-Id: <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-01_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010038
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/22/2019 06:56 PM, Daniel Lezcano wrote:
> On 22/03/2019 10:45, Rafael J. Wysocki wrote:
>> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
>> <huntbag@linux.vnet.ibm.com> wrote:
>>> Currently, the cpuidle governors (menu /ladder) determine what idle state
>>> an idling CPU should enter into based on heuristics that depend on the
>>> idle history on that CPU. Given that no predictive heuristic is perfect,
>>> there are cases where the governor predicts a shallow idle state, hoping
>>> that the CPU will be busy soon. However, if no new workload is scheduled
>>> on that CPU in the near future, the CPU will end up in the shallow state.
>>>
>>> In case of POWER, this is problematic, when the predicted state in the
>>> aforementioned scenario is a lite stop state, as such lite states will
>>> inhibit SMT folding, thereby depriving the other threads in the core from
>>> using the core resources.
>>>
>>> To address this, such lite states need to be autopromoted. The cpuidle-
>>> core can queue timer to correspond with the residency value of the next
>>> available state. Thus leading to auto-promotion to a deeper idle state as
>>> soon as possible.
>> Isn't the tick stopping avoidance sufficient for that?
> I was about to ask the same :)
>
>
>
>
Thanks for the review.
I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained(as suggested) -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally, 
observation was

===================================
min            max            99percentile
4ms            12ms          4ms
===================================
*ms = milliseconds

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a 
timer)

min            max              99.5percentile
===============================
144us       192us              144us
===============================
*us = microseconds

In this patch, we queue a timer just before entering into a stop0_lite
state. The timer fires at (residency of next available state + exit
latency of next available state * 2).
Let's say if next state(stop0) is available which has residency of 20us, it
should get out in as low as (20+2*2)*8 [Based on the forumla (residency +
2xlatency)*history length] microseconds = 192us. Ideally we would expect 8
iterations, it was observed to get out in 6-7 iterations.
Even if let's say stop2 is next available state(stop0 and stop1 both are
unavailable), it would take (100+2*10)*8 = 960us to get into stop2.

So, We are able to get out of stop0_lite generally in 150us(with this 
patch) as
compared to 4ms(with tick retained). As stated earlier, we do not want 
to get
stuck into stop0_lite as it inhibits SMT folding for other sibling 
threads, depriving
them of core resources. Current patch is using auto-promotion only for 
stop0_lite,
as it gives performance benefit(primary reason) along with lowering down 
power
consumption. We may extend this model for other states in future.

--Abhishek

