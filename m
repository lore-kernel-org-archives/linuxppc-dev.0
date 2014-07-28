Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F90E1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 22:30:49 +1000 (EST)
Message-ID: <53D64273.3060701@suse.de>
Date: Mon, 28 Jul 2014 14:30:43 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3] Use the POWER8 Micro Partition Prefetch Engine in
 KVM HV on POWER8
References: <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <53C78161.9040700@suse.de> <m3k37bmhnb.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3k37bmhnb.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.07.14 06:10, Stewart Smith wrote:
> Alexander Graf <agraf@suse.de> writes:
>>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>>> index 1eaea2d..5769497 100644
>>> --- a/arch/powerpc/include/asm/kvm_host.h
>>> +++ b/arch/powerpc/include/asm/kvm_host.h
>>> @@ -305,6 +305,8 @@ struct kvmppc_vcore {
>>>    	u32 arch_compat;
>>>    	ulong pcr;
>>>    	ulong dpdes;		/* doorbell state (POWER8) */
>>> +	unsigned long mpp_buffer; /* Micro Partition Prefetch buffer */
>> Just make this a void*?
> get_free_pages returns an unsigned long and free_pages accepts an
> unsigned long, so I was just avoiding the cast. Is the style in this
> case to do void* rather than unsigned long and cast it everywhere?
>
> In v4 of patch I've gone to void* anyway.

It's probably just a matter of personal taste, but I personally prefer 
to keep pointers to memory locations in pointers.

>
>>> @@ -1516,6 +1540,37 @@ static int on_primary_thread(void)
>>>    	return 1;
>>>    }
>>>    
>>> +static void ppc_start_saving_l2_cache(struct kvmppc_vcore *vc)
>> Please use the "kvmppc" name space.
> ack, done.
>
>>> +	phys_addr_t phy_addr, tmp;
>>> +
>>> +	phy_addr = (phys_addr_t)virt_to_phys((void *)vc->mpp_buffer);
>>> +
>>> +	tmp = phy_addr & PPC_MPPE_ADDRESS_MASK;
>> I would prefer if you give the variable a more telling name.
> ack.
>
>>> +
>>> +	mtspr(SPRN_MPPR, tmp | PPC_MPPR_FETCH_ABORT);
>>> +
>>> +	asm volatile(PPC_LOGMPP(R1) : : "r" (tmp | PPC_LOGMPP_LOG_L2));
>> Can you move this asm() into a static inline function in generic code
>> somewhere?
> okay. It seems the best place may be powerpc/include/asm/cache.h -
> simply because it deals with cache things. I'm open to better
> suggestions :)
>
>>> +
>>> +	vc->mpp_buffer_is_valid = true;
>> Where does this ever get unset? And what point does this variable make?
>> Can't you just check on if (vc->mpp_buffer)?
> The problem with having moved the memory allocation for mpp_buffer to
> vcore setup is that we'll have vc->mpp_buffer != NULL but have some
> random contents in it, so when we first start executing the vcore, we
> shouldn't initiate prefetching (hence mpp_buffer_is_valid).
>
> If we point the prefetch engine to random memory contents, we get the
> most amazing array of incomprehensible illegal accesses :)

I see :). That makes a lot of sense indeed. Maybe rename the variable to 
mpp_content_is_valid to indicate that we are not looking at a valid 
buffer, but valid content?


Alex
