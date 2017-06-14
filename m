Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wncV51XclzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 16:41:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] powerpc64/hw_breakpoints: Handle data breakpoints in
 radix mode
In-Reply-To: <a210ca06-d455-8893-a20b-82f169a1525c@linux.vnet.ibm.com>
References: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
 <87r2yn1d1g.fsf@skywalker.in.ibm.com>
 <20170614051109.GB16085@naverao1-tp.localdomain>
 <a210ca06-d455-8893-a20b-82f169a1525c@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 16:41:16 +1000
Message-ID: <8737b33wc3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> On Wednesday 14 June 2017 10:41 AM, Naveen N. Rao wrote:
>> On 2017/06/14 08:38AM, Aneesh Kumar K.V wrote:
>>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>>>> index ae418b85c17c..17ee701b8336 100644
>>>> --- a/arch/powerpc/kernel/exceptions-64s.S
>>>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>>>> @@ -1411,10 +1411,8 @@ USE_TEXT_SECTION()
>>>>   	.balign	IFETCH_ALIGN_BYTES
>>>>   do_hash_page:
>>>>   #ifdef CONFIG_PPC_STD_MMU_64
>>>> -	andis.	r0,r4,0xa410		/* weird error? */
>>>> +	andis.	r0,r4,0xa450		/* weird error? */
>>>
>>> Can we convert that to a #define value. Ram did try to do that here.
>>>
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-June/158607.html
>> 
>> Hmm... I feel it will be good to do that as part of Ram's series since
>> he has already coded it up :)
>> 
>> Ram's patches will anyway require a rebase and the change I do here for
>> detecting DAWR already has a #define, so it should be a simple matter of
>> including DSISR_DABRMATCH in DSISR_PAGE_FAULT_MASK.
>> 
>> But, if you really feel that I should make that change here, please do
>> let me know and I will re-spin with those changes.
>
> The thing is that change from 0xa410 to 0xa450 is not clear at all. And 
> it needs proper documentation. IMHO the best way to do that is switch to 
> #define name for that constant.

Not in this patch. It needs to be backported, so it should be as minimal
as possible.

The change from 0xa410 to 0xa450 does need a mention in the changelog,
I'll add that.

cheers
