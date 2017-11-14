Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybkCt0MgKzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 21:25:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/8] powerpc/mm: Separate ibm,
 dynamic-memory data from DT format
In-Reply-To: <91f1c54a-a7cd-5ccb-a7f8-f9714d8f06fc@linux.vnet.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <150850572658.9118.9227271506499547385.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87vaifwtu5.fsf@concordia.ellerman.id.au>
 <91f1c54a-a7cd-5ccb-a7f8-f9714d8f06fc@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 21:25:13 +1100
Message-ID: <87375hw41i.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 11/12/2017 06:43 AM, Michael Ellerman wrote:
...
>> The bigger problem we have though is that you're trying to allocate
>> memory, in order to find out what memory we have :)
>> 
>> I suspect it works in some cases because you hit the memory@0 node first
>> in the device tree, and add that memory to memblock, which means
>> init_drmem_lmbs() *can* allocate memory, and everything's good.
>> 
>> But if we hit init_drmem_lmbs() first, or there's not enough space in
>> memory@0, then allocating memory in order to discover memory is not
>> going to work.
>> 
>> I'm not sure what the best solution is. One option would be to
>> statically allocate some space, so that we can discover some of the LMBs
>> without doing an allocation. But we wouldn't be able to guarantee that
>> we had enough space i nthat static allocation, so the code would need to
>> handle doing that and then potentially finding more LMBs later using a
>> dynamic alloc. So that could be a bit messy.
>> 
>> The other option would be for the early_init_dt_scan_drmem_lmbs() code
>> to still work on the device tree directly, rather than using the
>> drmem_info array. That would make for uglier code, but may be necessary.
>
> I have been thinking about my initial approach, and the more I look at it
> the more I do not like trying to do the bootmem allocation. As you mention
> there is just too much that could go wrong with that.
>
> I have started looking at a design where an interface similar to
> walk_memory_range() is used for the prom and numa code so we do not have to rely
> on making the allocation for the lmb array early in boot. The lmb array
> could then be allocated in the late_initcall in drmem.c at which point
> the general kernel allocator is available.
>
> I'm still working on getting this coded up and when send out a new patch set
> once it's ready unless anyone has objections to this approach.

Thanks. That sounds like it could work.

I definitely liked this version in that it removed a lot of code that
was looking directly at the device tree and abstracted it to just
operate on the LMBs.

If we can end up with something similar but without needing to do the
allocation before we have memory, that'd be great.

cheers
