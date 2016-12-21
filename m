Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk0Zr27hSzDwVl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:32:20 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL3U41g139517
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 22:32:18 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fewssryj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 22:32:17 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 13:32:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9FA7F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:32:12 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL3WC5m57016464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:32:12 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL3WBQb025898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 14:32:12 +1100
Subject: Re: [PATCH v4 02/12] powerpc: move set_soft_enabled() and rename
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-3-git-send-email-maddy@linux.vnet.ibm.com>
 <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 09:02:09 +0530
MIME-Version: 1.0
In-Reply-To: <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8e2b36c8-5cb3-0ed4-65f4-45be81da0f4e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 20 December 2016 02:33 PM, Balbir Singh wrote:
>
> On 19/12/16 19:06, Madhavan Srinivasan wrote:
>> Move set_soft_enabled() from powerpc/kernel/irq.c to
>> asm/hw_irq.c, to force updates to paca-soft_enabled
>> done via these access function. Add "memory" clobber
>> to hint compiler since paca->soft_enabled memory is the target
>> here
>> +static inline notrace void soft_enabled_set(unsigned long enable)
>> +{
>> +	__asm__ __volatile__("stb %0,%1(13)"
>> +	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled))
>> +	: "memory");
>> +}
>> +
> Can't we just rewrite this in "C"?
>
> local_paca->soft_enabled = enable

Yes we did discussed this  and parked it to handle in the follow on 
patchset.
Nick did suggest something of this sort,

__asm__ __volatile__("stb %1,%0" : "=m" (local_paca->soft_enabled) : "r" 
(enable));



> Balbir Singh.
>
