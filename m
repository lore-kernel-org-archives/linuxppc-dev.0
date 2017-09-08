Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpTc85S6ZzDrWf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 17:34:47 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v887XjXu113704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 03:34:45 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cueahysm0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 03:34:45 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 08:34:43 +0100
Subject: Re: [PATCH v3 2/2] cxl: Enable global TLBIs for cxl contexts
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 alistair@popple.id.au
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
 <20170908165624.22dca915@roar.ozlabs.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 09:34:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170908165624.22dca915@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d7ee68c6-a43d-a3e7-84ab-896ca87cd7e9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/09/2017 à 08:56, Nicholas Piggin a écrit :
> On Sun,  3 Sep 2017 20:15:13 +0200
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:
> 
>> The PSL and nMMU need to see all TLB invalidations for the memory
>> contexts used on the adapter. For the hash memory model, it is done by
>> making all TLBIs global as soon as the cxl driver is in use. For
>> radix, we need something similar, but we can refine and only convert
>> to global the invalidations for contexts actually used by the device.
>>
>> The new mm_context_add_copro() API increments the 'active_cpus' count
>> for the contexts attached to the cxl adapter. As soon as there's more
>> than 1 active cpu, the TLBIs for the context become global. Active cpu
>> count must be decremented when detaching to restore locality if
>> possible and to avoid overflowing the counter.
>>
>> The hash memory model support is somewhat limited, as we can't
>> decrement the active cpus count when mm_context_remove_copro() is
>> called, because we can't flush the TLB for a mm on hash. So TLBIs
>> remain global on hash.
> 
> Sorry I didn't look at this earlier and just wading in here a bit, but
> what do you think of using mmu notifiers for invalidating nMMU and
> coprocessor caches, rather than put the details into the host MMU
> management? npu-dma.c already looks to have almost everything covered
> with its notifiers (in that it wouldn't have to rely on tlbie coming
> from host MMU code).

Does npu-dma.c really do mmio nMMU invalidations? My understanding was 
that those atsd_launch operations are really targeted at the device 
behind the NPU, i.e. the nvidia card.
At some point, it was not possible to do mmio invalidations on the nMMU. 
At least on dd1. I'm checking with the nMMU team the status on dd2.

Alistair: is your code really doing a nMMU invalidation? Considering 
you're trying to also reuse the mm_context_add_copro() from this patch, 
I think I know the answer.

There are also other components relying on broadcasted invalidations 
from hardware: the PSL (for capi FPGA) and the XSL on the Mellanox CX5 
card, when in capi mode. They rely on hardware TLBIs, snooped and 
forwarded to them by the CAPP.
For the PSL, we do have a mmio interface to do targeted invalidations, 
but it was removed from the capi architecture (and left as a debug 
feature for our PSL implementation), because the nMMU would be out of 
sync with the PSL (due to the lack of interface to sync the nMMU, as 
mentioned above).
For the XSL on the Mellanox CX5, it's even more complicated. AFAIK, they 
do have a way to trigger invalidations through software, though the 
interface is private and Mellanox would have to be involved. They've 
also stated the performance is much worse through software invalidation.

Another consideration is performance. Which is best? Short of having 
real numbers, it's probably hard to know for sure.

So the road of getting rid of hardware invalidations for external 
components, if at all possible or even desirable, may be long.

   Fred



> This change is not too bad today, but if we get to more complicated
> MMU/nMMU TLB management like directed invalidation of particular units,
> then putting more knowledge into the host code will end up being
> complex I think.
> 
> I also want to also do optimizations on the core code that assumes we
> only have to take care of other CPUs, e.g.,
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_811068_&d=DwICAg&c=jf_iaSHvJObTbx-siA1ZOg&r=647QnUvvBMO2f-DWP2xkeFceXDYSjpgHeTL3m_I9fiA&m=VaerDVXunKigctgE7NLm8VjaTR90W1m08iMcohAAnPo&s=y25SSoLEB8zDwXOLaTb8FFSpX_qSKiIG3Z5Cf1m7xnw&e=
> 
> Or, another example, directed IPI invalidations from the mm_cpumask
> bitmap.
> 
> I realize you want to get something merged! For the merge window and
> backports this seems fine. I think it would be nice soon afterwards to
> get nMMU knowledge out of the core code... Though I also realize with
> our tlbie instruction that does everything then it may be tricky to
> make a really optimal notifier.
> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
>> ---
>> Changelog:
>> v3: don't decrement active cpus count with hash, as we don't know how to flush
>> v2: Replace flush_tlb_mm() by the new flush_all_mm() to flush the TLBs
>> and PWCs (thanks to Ben)
> 
