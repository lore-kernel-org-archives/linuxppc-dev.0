Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C0111A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 06:42:06 +1000 (EST)
Message-ID: <53A0A819.2070507@suse.de>
Date: Tue, 17 Jun 2014 22:42:01 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 Scott Wood <scottwood@freescale.com>, Alexander Graf <B36701@freescale.com>
Subject: Re: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
References: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>	
 <1403032706.6603.776.camel@snotra.buserror.net>	
 <37af68eb6855437892a438eec213d788@BY2PR03MB508.namprd03.prod.outlook.com>	
 <1403034451.6603.788.camel@snotra.buserror.net>	
 <924c92bfa28a4d4096c3cbe0f7219123@BY2PR03MB508.namprd03.prod.outlook.com>
 <1403035510.6603.801.camel@snotra.buserror.net>
 <074d849370834f748fe442ed851c0dad@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <074d849370834f748fe442ed851c0dad@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.06.14 22:36, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, June 17, 2014 11:05 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation
>> condition on vcpu schedule
>>
>> On Tue, 2014-06-17 at 15:02 -0500, Caraman Mihai Claudiu-B02008 wrote:
>>>> -----Original Message-----
>>>> From: Wood Scott-B07421
>>>> Sent: Tuesday, June 17, 2014 10:48 PM
>>>> To: Caraman Mihai Claudiu-B02008
>>>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>>>> dev@lists.ozlabs.org
>>>> Subject: Re: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation
>>>> condition on vcpu schedule
>>>>
>>>> On Tue, 2014-06-17 at 14:42 -0500, Caraman Mihai Claudiu-B02008
>> wrote:
>>>>>>> -static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
>>>>>>> +static DEFINE_PER_CPU(struct kvm_vcpu * [KVMPPC_NR_LPIDS],
>>>>>> last_vcpu_on_cpu);
>>>>>>
>>>>>> Hmm, I didn't know you could express types like that.  Is this
>>>> special
>>>>>> syntax that only works for typeof?
>>>>> Yes, AFAIK.
>>>>>
>>>>>> No space after *
>>>>> Checkpatch complains about the missing space ;)
>>>> Checkpatch is wrong, which isn't surprising given that this is
>> unusual
>>>> syntax.  We don't normally put a space after * when used to represent
>> a
>>>> pointer.
>>> This is not something new. See [PATCH 04/10] percpu: cleanup percpu
>> array
>>> definitions:
>>>
>>> 	https://lkml.org/lkml/2009/6/24/26
>> I didn't say it was new, just unusual, and checkpatch doesn't recognize
>> it.  Checkpatch shouldn't be blindly and silently obeyed when it says
>> something strange.
> I agree with you about the syntax and I know other cases where checkpatch
> is a moron. For similar corner cases checkpatch maintainers did not wanted
> (or found it difficult) to make an exception. I would also like to see Alex
> opinion on this.

I usually like to apply common sense :).


Alex
