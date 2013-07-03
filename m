Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 11AA22C0312
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:07:35 +1000 (EST)
Subject: Re: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3E93@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 3 Jul 2013 19:07:30 +0200
Message-Id: <098F899F-54BF-4172-958B-C52C015F5142@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3D41@039-SN2MPN1-013.039d.mgd.msft.net>
 <FA08EF79-D31B-4998-B7FE-BB2BFE3FB65E@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3E93@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
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


On 03.07.2013, at 18:49, Caraman Mihai Claudiu-B02008 wrote:

>>>>> +
>>>>> 	if (!vcpu->arch.sane) {
>>>>> 		kvm_run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
>>>>> 		return -EINVAL;
>>>>> @@ -716,6 +750,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
>>>> struct kvm_vcpu *vcpu)
>>>>> 	kvmppc_load_guest_fp(vcpu);
>>>>> #endif
>>>>>=20
>>>>> +#ifdef CONFIG_ALTIVEC
>>>>=20
>>>> /* Switch from user space Altivec to guest Altivec state */
>>>>=20
>>>>> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
>>>>=20
>>>> Why not use your kvmppc_supports_altivec() helper here?
>>>=20
>>> Give it a try ... because Linus guarded this members with
>> CONFIG_ALTIVEC :)
>>=20
>> Huh? You already are in an #ifdef CONFIG_ALTIVEC here. I think it's a
>> good idea to be consistent in helper usage. And the name you gave to =
the
>> helper (kvmppc_supports_altivec) is actually quite nice and tells us
>> exactly what we're asking for.
>=20
> I thought you asking to replace #ifdef CONFIG_ALTIVEC.
>=20
>>>> Do we need to do this even when the guest doesn't use Altivec? =
Can't
>> we
>>>> just load it on demand then once we fault? This code path really
>> should
>>>> only be a prefetch enable when MSR_VEC is already set in guest
>> context.
>>>=20
>>> No we can't, read 6/6.
>>=20
>> So we have to make sure we're completely unlazy when it comes to a =
KVM
>> guest. Are we?
>=20
> Yes, because MSR[SPV] is under its control.

Oh, sure, KVM wants it unlazy. That part is obvious. But does the kernel =
always give us unlazyness? The way I read the code, process.c goes lazy =
when !CONFIG_SMP.

So the big question is why we're manually enforcing FPU giveup, but not =
Altivec giveup? One of the 2 probably is wrong :).


Alex
