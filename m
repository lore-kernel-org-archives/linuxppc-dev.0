Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4D01A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 21:50:03 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Jul 2014 17:19:58 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 930DA125805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:19:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s62BpGWf61603976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:21:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s62BnrLp001484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:19:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/6] KVM: PPC: BOOK3S: HV: Use new functions for
 mapping/unmapping hpte in host
In-Reply-To: <20140702042831.GB16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140702042831.GB16865@drongo>
Date: Wed, 02 Jul 2014 17:19:53 +0530
Message-ID: <87zjgsm13y.fsf@linux.vnet.ibm.com>
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

> On Sun, Jun 29, 2014 at 04:47:33PM +0530, Aneesh Kumar K.V wrote:
>> We want to use virtual page class key protection mechanism for
>> indicating a MMIO mapped hpte entry or a guest hpte entry that is swapped out
>> in the host. Those hptes will be marked valid, but have virtual page
>> class key set to 30 or 31. These virtual page class numbers are
>> configured in AMR to deny read/write. To accomodate such a change, add
>> new functions that map, unmap and check whether a hpte is mapped in the
>> host. This patch still use HPTE_V_VALID and HPTE_V_ABSENT and don't use
>> virtual page class keys. But we want to differentiate in the code
>> where we explicitly check for HPTE_V_VALID with places where we want to
>> check whether the hpte is host mapped. This patch enables a closer
>> review for such a change.
>
> [...]
>
>>  		/* Check for pending invalidations under the rmap chain lock */
>>  		if (kvm->arch.using_mmu_notifiers &&
>>  		    mmu_notifier_retry(kvm, mmu_seq)) {
>> -			/* inval in progress, write a non-present HPTE */
>> -			pteh |= HPTE_V_ABSENT;
>> -			pteh &= ~HPTE_V_VALID;
>> +			/*
>> +			 * inval in progress in host, write host unmapped pte.
>> +			 */
>> +			host_unmapped_hpte = 1;
>
> This isn't right.  We already have HPTE_V_VALID set here, and you now
> don't clear it here, and it doesn't get cleared by the
> __kvmppc_unmap_host_hpte() call below either.


Ok missed that. Will fix that in the next update. In the earlier version
I had kvmppc_unmap_host_hpte always clearing V_VALID. 

-aneesh
