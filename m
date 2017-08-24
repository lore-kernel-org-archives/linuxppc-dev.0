Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdVQz5qJzzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 02:40:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7OGdbG7095929
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 12:40:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cj0jpfx81-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 12:40:39 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 17:40:37 +0100
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
 <1503336930.2195.20.camel@kernel.crashing.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 18:40:34 +0200
MIME-Version: 1.0
In-Reply-To: <1503336930.2195.20.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e1833071-11e0-2cd1-0ec2-f8653a4e6b6c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/08/2017 à 19:35, Benjamin Herrenschmidt a écrit :
> On Mon, 2017-08-21 at 19:27 +0200, Frederic Barrat wrote:
>> Hi Ben,
>>
>> Le 24/07/2017 à 06:28, Benjamin Herrenschmidt a écrit :
>>> Instead of comparing the whole CPU mask every time, let's
>>> keep a counter of how many bits are set in the mask. Thus
>>> testing for a local mm only requires testing if that counter
>>> is 1 and the current CPU bit is set in the mask.
>>
>>
>> I'm trying to see if we could merge this patch with what I'm trying to
>> do to mark a context as requiring global TLBIs.
>> In http://patchwork.ozlabs.org/patch/796775/
>> I'm introducing a 'flags' per memory context, using one bit to say if
>> the context needs global TLBIs.
>> The 2 could co-exist, just checking... Do you think about using the
>> actual active_cpus count down the road, or is it just a matter of
>> knowing if there are more than one active cpus?
> 
> Or you could just incrementer my counter. Just make sure you increment
> it at most once per CXL context and decrement when the context is gone.

The decrementing part is giving me troubles, and I think it makes sense: 
if I decrement the counter when detaching the context from the capi 
card, then the next TLBIs for the memory context may be back to local. 
So when the process exits, the NPU wouldn't get the associated TLBIs, 
which spells trouble the next time the same memory context ID is reused. 
I believe this the cause of the problem I'm seeing. As soon as I keep 
the TLBIs global, even after I detach from the capi adapter, everything 
is fine.

Does it sound right?

So to keep the checks minimal in mm_is_thread_local(), to just checking 
the active_cpus count, I'm thinking of introducing a "copro enabled" bit 
on the context, so that we can increment active_cpus only once. And 
never decrement it.

   Fred
