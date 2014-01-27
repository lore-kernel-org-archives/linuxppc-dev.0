Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E18C2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 02:57:19 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 27 Jan 2014 21:27:14 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EF060394003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 21:27:09 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0RFv7KN40501306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 21:27:07 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0RFv9m4018321
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 21:27:09 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
In-Reply-To: <72133741-22DA-4477-B89F-E9C978FA294F@suse.de>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
 <87wqhllnvm.fsf@linux.vnet.ibm.com>
 <72133741-22DA-4477-B89F-E9C978FA294F@suse.de>
Date: Mon, 27 Jan 2014 21:27:08 +0530
Message-ID: <87r47to1t7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Liu Ping Fan <kernelfans@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 27.01.2014, at 11:28, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Alexander Graf <agraf@suse.de> writes:
>> 
>>> On 21.01.2014, at 10:42, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>> 
>>>> Liu Ping Fan <kernelfans@gmail.com> writes:
>>>> 
>>>>> To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
>>>>> when guest access them, we should force the checking when guest uses hypercall
>>>>> to setup hpte.
>>>>> 
>>>>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>>>> 
>>>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> 
>>>> When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start and
>>>> mmu_notifier_invalidate_range_end, which will mark existing guest hpte
>>>> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
>>>> guest hpte entries. This patch does that. 
>>> 
>>> So what happens next? We insert a page into the HTAB without
>>> HPTE_V_VALID set, so the guest will fail to use it. If the guest does
>>> an H_READ on it it will suddenly turn to V_VALID though?
>> 
>> As per the guest the entry is valid, so yes an hread should return a
>> valid entry. But in real hpte we would mark it not valid.
>
> Ah, yes.
>
>> 
>>> 
>>> I might need a crash course in the use of HPTE_V_ABSENT.
>> 
>> When guest tries to access the address, the host will handle the fault.
>> 
>> kvmppc_hpte_hv_fault should give more info
>
> Thanks for the pointer. So we fault it in lazily. Is there any
> particular reason we can't do that on h_enter already? After all this
> just means an additional roundtrip because the guest is pretty likely
> to use the page it just entered, no?

We could get wrong numa fault information if we didn't do h_enter from
the right node from which we faulted.

-aneesh
