Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEA621A0010
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 02:43:34 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 14 Jun 2014 02:43:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D6BD22CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 02:43:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5DGLP379306490
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 02:21:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5DGhSdG002882
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 02:43:28 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Use base page size when comparing
 against slb value
In-Reply-To: <539B0E38.6050100@suse.de>
References: <1402644190-15604-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <539ACC62.1040004@suse.de> <87vbs4dgt6.fsf@linux.vnet.ibm.com>
 <539B0E38.6050100@suse.de>
Date: Fri, 13 Jun 2014 22:13:24 +0530
Message-ID: <87zjhgsqtv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 13.06.14 16:28, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>>
>>> On 13.06.14 09:23, Aneesh Kumar K.V wrote:
>>>> With guest supporting Multiple page size per segment (MPSS),
>>>> hpte_page_size returns actual page size used. Add a new function to
>>>> return base page size and use that to compare against the the page size
>>>> calculated from SLB
>>> Why? What does this fix? Is this a bug fix, an enhancement? Don't
>>> describe only what you do, but also why you do it.
>>>
>>>
>> This could result in page fault failures (unhandled page fault) because
>> even though we have a valid hpte entry mapping a 16MB page, since we
>> were comparing actual page size against page size calculated from SLB
>> bits kvmppc_hv_find_lock_hpte will fail and return -1. I did not observe
>> a failure in real and the bug was found during code audit. That could be
>> because with THP we have guest ram backed by hugetlbfs and we always
>> find the page in the host linux page table. The will result in do_h_enter always
>> inserting HPTE_V_VALID entry and hence we might not really end up calling
>> kvmppc_hv_find_lock_hpte.
>
> So why do we need to override to base page size for the VRMA region?

slb encoding should be derived based on base page size. 

> Also I think you want to change the comment above the line in 
> find_lock_hpte you're changing.
>

Will do that.

-aneesh
