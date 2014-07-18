Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C632A1A0346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 14:10:24 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 22:10:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1E3813E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:10:20 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6I4AKd87995750
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 06:10:20 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6I4AJTs000814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:10:19 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3] Use the POWER8 Micro Partition Prefetch Engine in KVM
 HV on POWER8
In-Reply-To: <53C78161.9040700@suse.de>
References: <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <53C78161.9040700@suse.de>
Date: Fri, 18 Jul 2014 14:10:16 +1000
Message-ID: <m3k37bmhnb.fsf@oc8180480414.ibm.com>
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

Alexander Graf <agraf@suse.de> writes:
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 1eaea2d..5769497 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -305,6 +305,8 @@ struct kvmppc_vcore {
>>   	u32 arch_compat;
>>   	ulong pcr;
>>   	ulong dpdes;		/* doorbell state (POWER8) */
>> +	unsigned long mpp_buffer; /* Micro Partition Prefetch buffer */
>
> Just make this a void*?

get_free_pages returns an unsigned long and free_pages accepts an
unsigned long, so I was just avoiding the cast. Is the style in this
case to do void* rather than unsigned long and cast it everywhere?

In v4 of patch I've gone to void* anyway.

>> @@ -1516,6 +1540,37 @@ static int on_primary_thread(void)
>>   	return 1;
>>   }
>>   
>> +static void ppc_start_saving_l2_cache(struct kvmppc_vcore *vc)
>
> Please use the "kvmppc" name space.

ack, done.

>> +	phys_addr_t phy_addr, tmp;
>> +
>> +	phy_addr = (phys_addr_t)virt_to_phys((void *)vc->mpp_buffer);
>> +
>> +	tmp = phy_addr & PPC_MPPE_ADDRESS_MASK;
>
> I would prefer if you give the variable a more telling name.

ack.

>> +
>> +	mtspr(SPRN_MPPR, tmp | PPC_MPPR_FETCH_ABORT);
>> +
>> +	asm volatile(PPC_LOGMPP(R1) : : "r" (tmp | PPC_LOGMPP_LOG_L2));
>
> Can you move this asm() into a static inline function in generic code 
> somewhere?

okay. It seems the best place may be powerpc/include/asm/cache.h -
simply because it deals with cache things. I'm open to better
suggestions :)

>
>> +
>> +	vc->mpp_buffer_is_valid = true;
>
> Where does this ever get unset? And what point does this variable make? 
> Can't you just check on if (vc->mpp_buffer)?

The problem with having moved the memory allocation for mpp_buffer to
vcore setup is that we'll have vc->mpp_buffer != NULL but have some
random contents in it, so when we first start executing the vcore, we
shouldn't initiate prefetching (hence mpp_buffer_is_valid).

If we point the prefetch engine to random memory contents, we get the
most amazing array of incomprehensible illegal accesses :)

The aborting of saving the L2 contents before starting the reading back
in makes the hardware ensure the content of that buffer is finished
correctly.

The hardware docs don't describe the exact format of what it puts in the
buffer, just that there's an 'end of table' bit set in the last entry.

> Also, a single whitespace line between every instruction you do looks 
> weird ;). When you have the feeling that the code flow is weird enough 
> that you need empty lines between every real line, there's probably 
> something wrong in the code flow :).

ok, looks a bit better with logmpp as func rather than asm block.
