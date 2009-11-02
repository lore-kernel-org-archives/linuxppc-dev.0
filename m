Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8B36FB7C28
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Nov 2009 20:26:40 +1100 (EST)
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-12-git-send-email-agraf@suse.de>
	<7786.1257118763@neuling.org>
Message-Id: <463AF0FC-6573-445F-89C5-F5C21D2332AB@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <7786.1257118763@neuling.org>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7A341)
Subject: Re: [PATCH 11/27] Add book3s_64 Host MMU handling
Date: Mon, 2 Nov 2009 10:26:30 +0100
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm-ppc <kvm-ppc@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Avi Kivity <avi@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bphilips@suse.de" <bphilips@suse.de>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 02.11.2009 um 00:39 schrieb Michael Neuling <mikey@neuling.org>:

> <snip>
>> +static void invalidate_pte(struct hpte_cache *pte)
>> +{
>> +    dprintk_mmu("KVM: Flushing SPT %d: 0x%llx (0x%llx) -> 0x%llx\n",
>> +            i, pte->pte.eaddr, pte->pte.vpage, pte->host_va);
>> +
>> +    ppc_md.hpte_invalidate(pte->slot, pte->host_va,
>> +                   MMU_PAGE_4K, MMU_SEGSIZE_256M,
>> +                   false);
>
> Are we assuming 256M segments here (and elsewhere)?

Yes, on the host we only create 256MB segments. What the guest uses is  
a different question.

>
> <snip>
>> +static int kvmppc_mmu_next_segment(struct kvm_vcpu *vcpu, ulong  
>> esid)
>> +{
>> +    int i;
>> +    int max_slb_size = 64;
>> +    int found_inval = -1;
>> +    int r;
>> +
>> +    if (!get_paca()->kvm_slb_max)
>> +        get_paca()->kvm_slb_max = 1;
>> +
>> +    /* Are we overwriting? */
>> +    for (i = 1; i < get_paca()->kvm_slb_max; i++) {
>> +        if (!(get_paca()->kvm_slb[i].esid & SLB_ESID_V))
>> +            found_inval = i;
>> +        else if ((get_paca()->kvm_slb[i].esid & ESID_MASK) == esid)
>> +            return i;
>> +    }
>> +
>> +    /* Found a spare entry that was invalidated before */
>> +    if (found_inval > 0)
>> +        return found_inval;
>> +
>> +    /* No spare invalid entry, so create one */
>> +
>> +    if (mmu_slb_size < 64)
>> +        max_slb_size = mmu_slb_size;
>
> Can we just use the global mmu_slb_size eliminate max_slb_size?

Hm, for a strange reason I wanted to have at most 64 slb entries.  
Maybe the struct can't hold more? I'll check again as soon as I'm on a  
notebook again.

Alex

>
> <snip>
>
> Mikey
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
