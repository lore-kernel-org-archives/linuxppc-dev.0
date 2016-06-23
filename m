Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb2XD2FdszDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 23:35:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NDThkc020347
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 09:35:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23qd1jcq66-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 09:35:19 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 23:35:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A65052BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 23:35:14 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NDZEPs12124490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 23:35:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NDZEpI003203
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 23:35:14 +1000
Date: Thu, 23 Jun 2016 19:05:11 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
CC: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com> <576BB395.5050502@linaro.org>
In-Reply-To: <576BB395.5050502@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <576BE58F.9030303@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/23/2016 03:31 PM, Daniel Lezcano wrote:
> On 06/23/2016 11:28 AM, Balbir Singh wrote:
> 
> [ ... ]
> 
>>> cpuidle_enter_state()
>>> {
>>>     [...]
>>>     time_start = local_clock();
>>>     [enter idle state]
>>>     time_end = local_clock();
>>>     /*
>>>           * local_clock() returns the time in nanosecond, let's shift
>>>           * by 10 (divide by 1024) to have microsecond based time.
>>>           */
>>>          diff = (time_end - time_start) >> 10;
>>>     [...]
>>>     dev->last_residency = (int) diff;
>>> }
>>>
>>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%
> 
> I am surprised the last_residency is 2.3% exactly less. The difference
> between >>10 and /1000 is 2.34%.
> 
> What is the next target residency value ?
> 
Target residency of the next idle state is 100 microseconds.
When snooze times out after 100 microseconds, last_residency value
calculated is typically 97 or 98 microseconds.

> Does it solve the issue if you replace >>10 by /1000 ?
> 

Yes it does.

--Shreyas
