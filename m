Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdj0Y3STBzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 22:35:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8KCWuRE105982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 08:35:54 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25jmr0jjua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 08:35:54 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 20 Sep 2016 13:35:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 443E61B08072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 13:37:40 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8KCZn5D10223930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 12:35:49 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8KCZlEQ029504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 06:35:48 -0600
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
To: Nicholas Piggin <npiggin@gmail.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
 <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
 <20160920222732.12301963@roar.ozlabs.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390 <linux-s390@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Sep 2016 14:35:45 +0200
MIME-Version: 1.0
In-Reply-To: <20160920222732.12301963@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c24828e0-9c67-aa48-e62a-f68496c4d8ad@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/20/2016 02:27 PM, Nicholas Piggin wrote:
> On Tue, 20 Sep 2016 13:19:30 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 09/16/2016 10:57 AM, Nicholas Piggin wrote:
>>> Implementing busy wait loops with cpu_relax() in callers poses
>>> some difficulties for powerpc.
>>>
>>> First, we want to put our SMT thread into a low priority mode for the
>>> duration of the loop, but then return to normal priority after exiting
>>> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
>>> cpu_relax() does may have HMT_medium take effect before HMT_low made
>>> any (or much) difference.
>>>
>>> Second, it can be beneficial for some implementations to spin on the
>>> exit condition with a statically predicted-not-taken branch (i.e.,
>>> always predict the loop will exit).
>>>
>>> This is a quick RFC with a couple of users converted to see what
>>> people think. I don't use a C branch with hints, because we don't want
>>> the compiler moving the loop body out of line, which makes it a bit
>>> messy unfortunately. If there's a better way to do it, I'm all ears.
>>>
>>> I would not propose to switch all callers immediately, just some
>>> core synchronisation primitives.  
>> Just a FYA,
>>
>> On s390 we have a private version of cpu_relax that yields the cpu
>> time slice back to the hypervisor via a hypercall.
> 
> The powerpc guest also wants to yield to hypervisor in some busywait
> situations.
> 
>> As this turned out
>> to be problematic in some cases there is also now a cpu_relax_lowlatency.
>>
>> Now, this seems still problematic as there are too many places still 
>> using cpu_relax instead of cpu_relax_lowlatency. So my plan is to do 
>> a change of that, make cpu_relax just be a barrier and add a new 
>> cpu_relax_yield that gives up the time slice. (so that s390 cpu_relax
>> is just like any other cpu_relax)
>>
>> As far as I can tell the only place where I want to change cpu_relax
>> to cpu_relax_lowlatency after that change is the stop machine run 
>> code, so I hope to have no conflicts with your changes.
> 
> I don't think there should be any conflicts, but it would be good to
> make sure busy wait primitives can be usable by s390. So I can add
> _yield variants that can do the right thing for s390.

I was distracted by "more important work" (TM) but I will put you on
CC when ready.
> 
> I need to think more about virtualization, so I'm glad you commented.
> Powerpc would like to be told when a busywait loop knows the CPU it is
> waiting for. So perhaps also a _yield_to_cpu variant as well.

Yes, we also have 2 hypercalls: one that yields somehow and one that yields
to a specific CPU. The latter is strongly preferred.
> 
> Something that will work with mutex_spin_on_owner and similar would be
> nice too. As far as I can tell, powerpc may want to yield to hypervisor
> when the owner's vcpu is scheduled off in that case too.
> 
