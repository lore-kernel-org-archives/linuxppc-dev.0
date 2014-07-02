Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35B561A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 21:57:47 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Jul 2014 17:27:44 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5B2953940049
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:27:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s62Bx3VE54788302
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:29:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s62Bvfa5030388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:27:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] KVM: PPC: BOOK3S: Use hpte_update_in_progress to
 track invalid hpte during an hpte update
In-Reply-To: <20140702054156.GD16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140702054156.GD16865@drongo>
Date: Wed, 02 Jul 2014 17:27:41 +0530
Message-ID: <87wqbwm0qy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Sun, Jun 29, 2014 at 04:47:34PM +0530, Aneesh Kumar K.V wrote:
>> As per ISA, we first need to mark hpte invalid (V=0) before we update
>> the hpte lower half bits. With virtual page class key protection mechanism we want
>> to send any fault other than key fault to guest directly without
>> searching the hash page table. But then we can get NO_HPTE fault while
>> we are updating the hpte. To track that add a vm specific atomic
>> variable that we check in the fault path to always send the fault
>> to host.
>
> [...]
>
>> @@ -750,13 +751,15 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  	r &= rcbits | ~(HPTE_R_R | HPTE_R_C);
>>  
>>  	if (be64_to_cpu(hptep[0]) & HPTE_V_VALID) {
>> -		/* HPTE was previously valid, so we need to invalidate it */
>> +		/*
>> +		 * If we had mapped this hpte before, we now need to
>> +		 * invalidate that.
>> +		 */
>>  		unlock_rmap(rmap);
>> -		/* Always mark HPTE_V_ABSENT before invalidating */
>> -		kvmppc_unmap_host_hpte(kvm, hptep);
>>  		kvmppc_invalidate_hpte(kvm, hptep, index);
>>  		/* don't lose previous R and C bits */
>>  		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
>> +		hpte_invalidated = true;
>
> So now we're not setting the ABSENT bit before invalidating the HPTE.
> That means that another guest vcpu could do an H_ENTER which could
> think that this HPTE is free and use it for another unrelated guest
> HPTE, which would be bad...

But henter looks at HPTE_V_HVLOCK, and we keep that set through out. But
I will double the code again to make sure it is safe in the above
scenario.

>
>> @@ -1144,8 +1149,8 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
>>  				npages_dirty = n;
>>  			eieio();
>>  		}
>> -		kvmppc_map_host_hpte(kvm, &v, &r);
>> -		hptep[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
>> +		hptep[0] = cpu_to_be64(v & ~HPTE_V_LOCK);
>> +		atomic_dec(&kvm->arch.hpte_update_in_progress);
>
> Why are we using LOCK rather than HVLOCK now?  (And why didn't you
> mention this change and its rationale in the patch description?)

Sorry, that is a typo. I intend to use HPTE_V_HVLOCK.

-aneesh
