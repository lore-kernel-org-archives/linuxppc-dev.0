Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFC1A1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 11:26:08 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 16 Mar 2015 10:26:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EAC9B3578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 11:26:03 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2G0Pto532112766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 11:26:03 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2G0PTge009381
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 11:25:30 +1100
Message-ID: <550622E2.7020307@au1.ibm.com>
Date: Mon, 16 Mar 2015 11:25:06 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
 <1426230541.23806.5.camel@ellerman.id.au>
 <1426230888.17565.164.camel@kernel.crashing.org>
In-Reply-To: <1426230888.17565.164.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/03/15 18:14, Benjamin Herrenschmidt wrote:
> On Fri, 2015-03-13 at 18:09 +1100, Michael Ellerman wrote:
>> On Thu, 2015-03-12 at 22:13 +1100, Benjamin Herrenschmidt wrote:
>>> On Thu, 2015-03-12 at 18:55 +0800, Kevin Hao wrote:
>>>> I know Torsten Duwe has tried to add the ticket spinlock for powerpc
>>>> one year ago [1]. But it make no progress due to the conflict between
>>>> PPC_SPLPAR and lockref. We still don't find a better way to handle
>>>> this. But instead of waiting forever for a perfect solution, can't we
>>>> just use the ticket spinlock for the !CONFIG_PPC_SPLPAR?
>>>>
>>>> This is a very rough patch based on arm64 codes. I want to make sure
>>>> that this is acceptable before going step further. This just passed
>>>> build and boot test on a fsl t4240rdb board. I have done a simple
>>>> performance benchmark by running the following command ten times before
>>>> and after applying this patch:
>>>> 	./perf bench sched messaging
>>>>
>>>>                                 Before        After
>>>>     Averaged total time [sec]:  0.403         0.367
>>>>
>>>> So we can see a ~9% performance enhancing. This patch depends on this
>>>> one [2].
>>>
>>> I would do the ifdef'ing differently, something like
>>>
>>> CONFIG_PPC_HAS_LOCK_OWNER
>>>
>>> CONFIG_PPC_TICKET_LOCKS depends on !PPC_HAS_LOCK_OWNER
>>>
>>> and use these two in the code... with SPLPAR select'ing HAS_LOCK_OWNER
>>  
>>
>> Sam was doing some work looking at CONFER, and I think so far he hasn't found
>> that it is much of a benefit. Hopefully he can chime in with his observations.
>>
>> So the question is, should we just drop the directed CONFER and switch
>> wholesale to ticket locks?

Confer certainly helps in some situations, although I think it will be
strongly workload and configuration dependent and I haven't tried to do
much realistic testing.

Also, being able to use confer depends on both knowing the lock owner
and also that the lock owner's VCPU is not currently running (which is
done via the yield count, which is also part of the lock token at the
moment). With just the yield count we could still use an undirected
confer (which might be almost as good as a directed one), but without it
we would have to drop it entirely.

>> We can still do CONFER on SPLPAR, we just tell the hypervisor we don't know who
>> to confer to.
>>
>> There is still the drawback that we loose the lock owner for debugging, but
>> that might be worth it. And I think you can get it back with appropriate debug
>> options?
> 
> Another possibility would be to change the order of the count and the
> lock in lockref and defined it to be packed. That might allow us to have
> our lock contain the ticket first and the count next and "fit" ...
> 
>> cheers
>>
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
