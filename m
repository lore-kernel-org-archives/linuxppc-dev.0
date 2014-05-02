Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D933214013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 21:10:55 +1000 (EST)
Message-ID: <53637D3B.4010205@suse.de>
Date: Fri, 02 May 2014 13:10:51 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction
 for emulation
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-5-git-send-email-mihai.caraman@freescale.com>
 <53636CFA.5050006@suse.de>
 <063D6719AE5E284EB5DD2968C1650D6D0F705051@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F705051@AcuExch.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/02/2014 12:12 PM, David Laight wrote:
> From: Alexander Graf
> ...
>>> +	page = pfn_to_page(pfn);
>>> +	eaddr = (unsigned long)kmap_atomic(page);
>>> +	eaddr |= addr & ~PAGE_MASK;
>>> +	*instr = *(u32 *)eaddr;
>>> +	kunmap_atomic((u32 *)eaddr);
>> I think I'd rather write this as
>>
>>     *instr = *(u32 *)(eaddr | (addr & ~PAGE));
>>     kunmap_atomic((void*)eaddr);
>>
>> to make sure we pass the unmap function the same value we got from the
>> map function.
>>
>> Otherwise looks good to me.
> Is there any mileage in keeping a virtual address page allocated (per cpu)
> for this (and similar) accesses to physical memory?
> Not having to search for a free VA page might speed things up (if that matters).

I like the idea, though I'm not sure how that would best fit into the 
current memory mapping ecosystem.

> You also probably want the page mapped uncached - no point polluting the data
> cache.

Do e500 chips have a shared I/D cache somewhere? If they do, that 
particular instruction would already be there, so no pollution but nice 
performance.


Alex
