Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 203922C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 21:28:58 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 27 Jan 2014 15:58:50 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8A6113940057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 15:58:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0RASl6T10158494
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 15:58:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0RASjgE021111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 15:58:46 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
In-Reply-To: <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
Date: Mon, 27 Jan 2014 15:58:45 +0530
Message-ID: <87wqhllnvm.fsf@linux.vnet.ibm.com>
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

> On 21.01.2014, at 10:42, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Liu Ping Fan <kernelfans@gmail.com> writes:
>> 
>>> To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
>>> when guest access them, we should force the checking when guest uses hypercall
>>> to setup hpte.
>>> 
>>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> 
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start and
>> mmu_notifier_invalidate_range_end, which will mark existing guest hpte
>> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
>> guest hpte entries. This patch does that. 
>
> So what happens next? We insert a page into the HTAB without
> HPTE_V_VALID set, so the guest will fail to use it. If the guest does
> an H_READ on it it will suddenly turn to V_VALID though?

As per the guest the entry is valid, so yes an hread should return a
valid entry. But in real hpte we would mark it not valid.

>
> I might need a crash course in the use of HPTE_V_ABSENT.

When guest tries to access the address, the host will handle the fault.

kvmppc_hpte_hv_fault should give more info

-aneesh
