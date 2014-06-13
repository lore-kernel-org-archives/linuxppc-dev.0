Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C2051A0458
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 00:44:17 +1000 (EST)
Message-ID: <539B0E38.6050100@suse.de>
Date: Fri, 13 Jun 2014 16:44:08 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Use base page size when comparing
 against slb value
References: <1402644190-15604-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <539ACC62.1040004@suse.de> <87vbs4dgt6.fsf@linux.vnet.ibm.com>
In-Reply-To: <87vbs4dgt6.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 13.06.14 16:28, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>> On 13.06.14 09:23, Aneesh Kumar K.V wrote:
>>> With guest supporting Multiple page size per segment (MPSS),
>>> hpte_page_size returns actual page size used. Add a new function to
>>> return base page size and use that to compare against the the page size
>>> calculated from SLB
>> Why? What does this fix? Is this a bug fix, an enhancement? Don't
>> describe only what you do, but also why you do it.
>>
>>
> This could result in page fault failures (unhandled page fault) because
> even though we have a valid hpte entry mapping a 16MB page, since we
> were comparing actual page size against page size calculated from SLB
> bits kvmppc_hv_find_lock_hpte will fail and return -1. I did not observe
> a failure in real and the bug was found during code audit. That could be
> because with THP we have guest ram backed by hugetlbfs and we always
> find the page in the host linux page table. The will result in do_h_enter always
> inserting HPTE_V_VALID entry and hence we might not really end up calling
> kvmppc_hv_find_lock_hpte.

So why do we need to override to base page size for the VRMA region? 
Also I think you want to change the comment above the line in 
find_lock_hpte you're changing.


Alex
