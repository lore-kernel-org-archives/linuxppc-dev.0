Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL3R80rF0zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:31:15 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7Q1TP4l113787
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:31:13 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2525tvw4q7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:31:13 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 11:31:10 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2C5012CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:31:07 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7Q1V7gD12058762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:31:07 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7Q1V6p0017879
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:31:06 +1000
Subject: Re: [RFC PATCH v3 00/12] powerpc: "paca->soft_enabled" based local
 atomic operation implementation
To: Nicholas Piggin <npiggin@gmail.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160825171543.7b23ec01@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 07:01:00 +0530
MIME-Version: 1.0
In-Reply-To: <20160825171543.7b23ec01@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9339e74d-012e-6bd9-6a0a-f1e82ff5618d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 25 August 2016 12:45 PM, Nicholas Piggin wrote:
> On Thu, 25 Aug 2016 11:59:51 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Local atomic operations are fast and highly reentrant per CPU counters.
>> Used for percpu variable updates. Local atomic operations only guarantee
>> variable modification atomicity wrt the CPU which owns the data and
>> these needs to be executed in a preemption safe way.
> This is looking really nice. I like how you're able to specify
> the mask nicely in the handler, and test the mask without adding
> any instructions to fastpaths.

Thanks.

>
> So far, I only have a few trivial nitpicks as you can see. I'll
> apply the series and give it a more careful look tomorrow.
Yes. Please.

Also, just noticed that i broke the Booke build, will fix that and 
respin it right away.
Thanks for the review

Maddy

> Thanks,
> Nick
>
