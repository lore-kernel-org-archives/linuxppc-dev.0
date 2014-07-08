Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F6B41A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 08:59:49 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Jul 2014 16:59:46 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 54E2CC90026
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 18:59:37 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s68MxhBK4915692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jul 2014 22:59:43 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s68Mxhqs011488
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jul 2014 18:59:43 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2] Use the POWER8 Micro Partition Prefetch Engine in KVM
 HV on POWER8
In-Reply-To: <53BBCAC7.90904@suse.de>
References: <1404437035-4336-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <53BBCAC7.90904@suse.de>
Date: Wed, 09 Jul 2014 08:59:38 +1000
Message-ID: <m3bnszqwx1.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

Thanks for review, much appreciated!

Alexander Graf <agraf@suse.de> writes:
> On 08.07.14 07:06, Stewart Smith wrote:
>> @@ -1528,6 +1535,7 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>   	int i, need_vpa_update;
>>   	int srcu_idx;
>>   	struct kvm_vcpu *vcpus_to_update[threads_per_core];
>> +	phys_addr_t phy_addr, tmp;
>
> Please put the variable declarations into the if () branch so that the 
> compiler can catch potential leaks :)

ack. will fix.

>> @@ -1590,9 +1598,48 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>   
>>   	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
>>   
>> +	/* If we have a saved list of L2/L3, restore it */
>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
>> +		phy_addr = virt_to_phys((void *)vc->mpp_buffer);
>> +#if defined(CONFIG_PPC_4K_PAGES)
>> +		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
>
> get_free_pages() is automatically aligned to the order, no?

That's what Paul reckoned too, and then we've attempted to find anywhere
that documents that behaviour. Happen to be able to point to docs/source
that say this is part of API?

>> +#endif
>> +		tmp = phy_addr & PPC_MPPE_ADDRESS_MASK;
>> +		tmp = tmp | PPC_MPPE_WHOLE_TABLE;
>> +
>> +		/* For sanity, abort any 'save' requests in progress */
>> +		asm volatile(PPC_LOGMPP(R1) : : "r" (tmp));
>> +
>> +		/* Inititate a cache-load request */
>> +		mtspr(SPRN_MPPR, tmp);
>> +	}
>
> In fact, this whole block up here could be a function, no?

It could, perfectly happy for it to be one. Will fix.

>> +
>> +	/* Allocate memory before switching out of guest so we don't
>> +	   trash L2/L3 with memory allocation stuff */
>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && !vc->mpp_buffer) {
>> +		vc->mpp_buffer = __get_free_pages(GFP_KERNEL|__GFP_ZERO,
>> +						  MPP_BUFFER_ORDER);
>
> get_order(64 * 1024)?
>
> Also, why allocate it here and not on vcore creation?

There's also the possibility of saving/restorting part of the L3 cache
as well, and I was envisioning a future patch to this which checks a
flag in vcore (maybe exposed via sysfs or whatever mechanism is
applicable) if it should save/restore L2 or L2/L3, so thus it makes a
bit more sense allocating it there rather than elsewhere.

There's also no real reason to fail to create a vcore if we can't
allocate a buffer for L2/L3 cache contents - retrying later is perfectly
harmless.

>> +
>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
>> +		phy_addr = (phys_addr_t)virt_to_phys((void *)vc->mpp_buffer);
>> +#if defined(CONFIG_PPC_4K_PAGES)
>> +		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
>> +#endif
>> +		tmp = PPC_MPPE_ADDRESS_MASK & phy_addr;
>> +		tmp = tmp | PPC_MPPE_LOG_L2;
>> +
>> +		/* Abort any existing 'fetch' operations for this core */
>> +		mtspr(SPRN_MPPR, tmp&0x0fffffffffffffff);
>
> pretty magical, no?

Yeah, sorry about that.... I'll hide it in a function at least, and do
something a bit better there... IIRC this magic came from the initial
work that proved the hardware functionality, so I'll go back and re-read
some hardware documentation to see where exactly this came from...

>> +
>> +		/* Finally, issue logmpp to save cache contents for L2 */
>> +		asm volatile(PPC_LOGMPP(R1) : : "r" (tmp));
>> +	}
>
> This too should be a separate function.

ack.
