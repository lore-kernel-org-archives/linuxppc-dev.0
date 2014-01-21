Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x22f.google.com (mail-qe0-x22f.google.com
 [IPv6:2607:f8b0:400d:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B3EC2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:11:34 +1100 (EST)
Received: by mail-qe0-f47.google.com with SMTP id 5so7271667qeb.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 01:11:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFgQCTuUz-=2Uhi3Zj001-yzSCDe9skCTPkORjCuLW0XSNhjow@mail.gmail.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
 <87d2jm7j3d.fsf@linux.vnet.ibm.com>
 <CAFgQCTt2eWHF4iZP6bx075ZFMx8yhqnZgHnZwm2uLLOOCar+XQ@mail.gmail.com>
 <87ob36ypc0.fsf@linux.vnet.ibm.com>
 <CAFgQCTuUz-=2Uhi3Zj001-yzSCDe9skCTPkORjCuLW0XSNhjow@mail.gmail.com>
Date: Tue, 21 Jan 2014 17:11:31 +0800
Message-ID: <CAFgQCTvN+cuRExFxvZjHSdJC9X7hi+U7-88=SVUZHvLGer1zjw@mail.gmail.com>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Liu ping fan <kernelfans@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 21, 2014 at 5:07 PM, Liu ping fan <kernelfans@gmail.com> wrote:
> On Tue, Jan 21, 2014 at 11:40 AM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Liu ping fan <kernelfans@gmail.com> writes:
>>
>>> On Mon, Jan 20, 2014 at 11:45 PM, Aneesh Kumar K.V
>>> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>>> Liu ping fan <kernelfans@gmail.com> writes:
>>>>
>>>>> On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>>>>>>
>>>>>> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>>>>>
>>>>>>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
>>>>>>>
>>>>>>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>>>>>>> (for which, I still try to get a machine to show nums)
>>>>>>>
>>>>>>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
>>>>>>> which is  well known.
>>>>>>
>>>>>> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
>>>>>>
>>>>> Sorry for the unclear message. After introducing the _PAGE_NUMA,
>>>>> kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
>>>>> should rely on host's kvmppc_book3s_hv_page_fault() to call
>>>>> do_numa_page() to do the numa fault check. This incurs the overhead
>>>>> when exiting from rmode to vmode.  My idea is that in
>>>>> kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
>>>>> there is no need to exit to vmode (i.e saving htab, slab switching)
>>>>
>>>> Can you explain more. Are we looking at hcall from guest  and
>>>> hypervisor handling them in real mode ? If so why would guest issue a
>>>> hcall on a pte entry that have PAGE_NUMA set. Or is this about
>>>> hypervisor handling a missing hpte, because of host swapping this page
>>>> out ? In that case how we end up in h_enter ? IIUC for that case we
>>>> should get to kvmppc_hpte_hv_fault.
>>>>
>>> After setting _PAGE_NUMA, we should flush out all hptes both in host's
>>> htab and guest's. So when guest tries to access memory, host finds
>>> that there is not hpte ready for guest in guest's htab. And host
>>> should raise dsi to guest.
>>
>> Now guest receive that fault, removes the PAGE_NUMA bit and do an
>> hpte_insert. So before we do an hpte_insert (or H_ENTER) we should have
>> cleared PAGE_NUMA bit.
>>
>>>This incurs that guest ends up in h_enter.
>>> And you can see in current code, we also try this quick path firstly.
>>> Only if fail, we will resort to slow path --  kvmppc_hpte_hv_fault.
>>
>> hmm ? hpte_hv_fault is the hypervisor handling the fault.
>>
> After we discuss in irc. I think we should also do the fast check in
> kvmppc_hpte_hv_fault() for the case of HPTE_V_ABSENT,
> and let H_ENTER take care of the rest case i.e. no hpte when pte_mknuma. Right?
>
Or we can delay the quick fix in H_ENTER, and let the host fault
again, so do the fix in kvmppc_hpte_hv_fault()

> Thanks and regards,
> Fan
>> -aneesh
>>
