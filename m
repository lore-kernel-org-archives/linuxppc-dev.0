Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdtwL5LWtzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 18:04:02 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7P7xS48116175
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:03:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cjbscyrvj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:03:58 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 25 Aug 2017 09:03:57 +0100
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
 <1503336930.2195.20.camel@kernel.crashing.org>
 <e1833071-11e0-2cd1-0ec2-f8653a4e6b6c@linux.vnet.ibm.com>
 <1503600479.3814.19.camel@kernel.crashing.org>
 <54852db7-d0aa-2a3e-c8bd-c4977163c4ee@linux.vnet.ibm.com>
 <1503647079.3814.34.camel@kernel.crashing.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 10:03:54 +0200
MIME-Version: 1.0
In-Reply-To: <1503647079.3814.34.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bb01c2cc-f399-6429-7557-18ec6c9babd4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/08/2017 à 09:44, Benjamin Herrenschmidt a écrit :
> On Fri, 2017-08-25 at 06:53 +0200, Frederic Barrat wrote:
>>
>> Le 24/08/2017 à 20:47, Benjamin Herrenschmidt a écrit :
>>> On Thu, 2017-08-24 at 18:40 +0200, Frederic Barrat wrote:
>>>>
>>>> The decrementing part is giving me troubles, and I think it makes sense:
>>>> if I decrement the counter when detaching the context from the capi
>>>> card, then the next TLBIs for the memory context may be back to local.
>>>
>>> Yes, you need to flush the CAPI TLB first.
>>>
>>>> So when the process exits, the NPU wouldn't get the associated TLBIs,
>>>> which spells trouble the next time the same memory context ID is reused.
>>>> I believe this the cause of the problem I'm seeing. As soon as I keep
>>>> the TLBIs global, even after I detach from the capi adapter, everything
>>>> is fine.
>>>>
>>>> Does it sound right?
>>>>
>>>> So to keep the checks minimal in mm_is_thread_local(), to just checking
>>>> the active_cpus count, I'm thinking of introducing a "copro enabled" bit
>>>> on the context, so that we can increment active_cpus only once. And
>>>> never decrement it.
>>>
>>> You can decrement if you flush. Don't you have MMIOs to do directed
>>> flushes ?
>>
>> That's for the nMMU. Last I heard, we don't have MMIOs to flush anything
>> on the nMMU.
>>
>> Side note: for the PSL, we do have MMIOs to flush, but they were
>> perceived as useful only for debug and we don't rely on them, precisely
>> because the nMMU would fall out of sync, so we have to rely on broadcast.
> 
> Well, you can always do a broadcast tlbi to flush the whole PID if you
> decrement... that shouldn't be a very frequent operation.

Arg, yes!
Thanks!

   Fred
