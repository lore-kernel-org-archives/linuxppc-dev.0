Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj4YM5HNMzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:28:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Set the valid bit in PE for dedicated mode
In-Reply-To: <87lgm1b6ss.fsf@vajain21.in.ibm.com>
References: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
 <87r2vu27b3.fsf@concordia.ellerman.id.au>
 <87lgm1b6ss.fsf@vajain21.in.ibm.com>
Date: Wed, 30 Aug 2017 22:28:37 +1000
Message-ID: <87mv6h1bpm.fsf@concordia.ellerman.id.au>
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

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> Hi Mpe,
>
> Thanks for reviewing the patch
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>>> +	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
>>> +	/* Make sure the changes to the PE are visible to the card */
>>
>> A barrier orders something vs something else. So what's the something
>> else in this case? Is it the afu_reset() below, what does that actually do?
>>
>
> The issue is with call to afu_enable() after the call to afu_reset that
> would start the AFU. If this load gets reordered and PSL doesnt see the
> valid bit set for this structure then it will result in PSL entering a
> freeze-state.

OK, so it's ordering the store above to ctx->elem->software_state vs the
store to the AFU in afu_enable().

> Though on second thoughts afu_enable() is grabbing a spin-lock before
> doing an mmio to start the AFU that would be forcing a barrier
> anyways. But since that spans the function boundary hence to be safe
> have added a write barrier after populating the process element.

The spin lock doesn't help you, stores are allowed to leak into the
locked region.

But the MMIO is preceeded by a sync.

> Lastly function is not performance critical as it will be usually called
> in the life time of a process only once. So the impact smp_wmb() is
> having would be minimal.

Sure. Performance is not the issue, barriers are subtle so it's
important that they're well documented.


So I don't think you need the barrier, because the out_be64() will do it
for you. But if you really want to add one, I don't mind.

But, you should use wmb(), not smp_wmb(), because the ordering is still
required on non-SMP systems. And please update the comment to capture
all of the above discussion.

cheers
