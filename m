Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A46A92C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:45:38 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 01:45:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8ABE82BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:45:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0KFjI4J8519986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:45:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0KFjUHm020483
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:45:31 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu ping fan <kernelfans@gmail.com>, Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
In-Reply-To: <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
Date: Mon, 20 Jan 2014 21:15:26 +0530
Message-ID: <87d2jm7j3d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu ping fan <kernelfans@gmail.com> writes:

> On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>>
>> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>
>>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
>>>
>>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>>> (for which, I still try to get a machine to show nums)
>>>
>>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
>>> which is  well known.
>>
>> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
>>
> Sorry for the unclear message. After introducing the _PAGE_NUMA,
> kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
> should rely on host's kvmppc_book3s_hv_page_fault() to call
> do_numa_page() to do the numa fault check. This incurs the overhead
> when exiting from rmode to vmode.  My idea is that in
> kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
> there is no need to exit to vmode (i.e saving htab, slab switching)

Can you explain more. Are we looking at hcall from guest  and
hypervisor handling them in real mode ? If so why would guest issue a
hcall on a pte entry that have PAGE_NUMA set. Or is this about
hypervisor handling a missing hpte, because of host swapping this page
out ? In that case how we end up in h_enter ? IIUC for that case we
should get to kvmppc_hpte_hv_fault. 


>
>>> If my suppose is correct, will CCing kvm@vger.kernel.org from next version.
>>
>> This translates to me as "This is an RFC"?
>>
> Yes, I am not quite sure about it. I have no bare-metal to verify it.
> So I hope at least, from the theory, it is correct.
>

-aneesh
