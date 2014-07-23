Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03421A00D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 18:39:40 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <72a612351ec34db5a94cda4f4883e608@BY2PR03MB508.namprd03.prod.outlook.com>
Date: Wed, 23 Jul 2014 10:39:32 +0200
Message-Id: <4803B12E-A3CF-43C4-AF98-2AD87F76D151@suse.de>
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
 <53C7DBC3.2060104@suse.de>
 <9905fb7c7f604bcb966478e3722e8bfc@BY2PR03MB508.namprd03.prod.outlook.com>
 <32d95c415b3f4a69bebd5a208c498e15@BY2PR03MB508.namprd03.prod.outlook.com>
 <53CED5D9.9010609@suse.de>
 <72a612351ec34db5a94cda4f4883e608@BY2PR03MB508.namprd03.prod.outlook.com>
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
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



Am 23.07.2014 um 10:24 schrieb "mihai.caraman@freescale.com" <mihai.caraman@=
freescale.com>:

>> -----Original Message-----
>> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
>> owner@vger.kernel.org] On Behalf Of Alexander Graf
>> Sent: Wednesday, July 23, 2014 12:21 AM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
>> kvm@vger.kernel.org
>> Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail=

>>=20
>>=20
>> On 21.07.14 11:59, mihai.caraman@freescale.com wrote:
>>>> -----Original Message-----
>>>> From: Linuxppc-dev [mailto:linuxppc-dev-
>>>> bounces+mihai.caraman=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
>>>> mihai.caraman@freescale.com
>>>> Sent: Friday, July 18, 2014 12:06 PM
>>>> To: Alexander Graf; kvm-ppc@vger.kernel.org
>>>> Cc: linuxppc-dev@lists.ozlabs.org; kvm@vger.kernel.org
>>>> Subject: RE: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to
>> fail
>>>>=20
>>>>> -----Original Message-----
>>>>> From: Alexander Graf [mailto:agraf@suse.de]
>>>>> Sent: Thursday, July 17, 2014 5:21 PM
>>>>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>>>>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>>>>> Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to
>>>> fail
>>>>>=20
>>>>>> On 17.07.14 13:22, Mihai Caraman wrote:
>>>>>> On book3e, guest last instruction is read on the exit path using
>> load
>>>>>> external pid (lwepx) dedicated instruction. This load operation may
>>>>> fail
>>>>>> due to TLB eviction and execute-but-not-read entries.
>>>>>>=20
>>>>>> This patch lay down the path for an alternative solution to read the
>>>>> guest
>>>>>> last instruction, by allowing kvmppc_get_lat_inst() function to
>> fail.
>>>>>> Architecture specific implmentations of kvmppc_load_last_inst() may
>>>>> read
>>>>>> last guest instruction and instruct the emulation layer to re-
>> execute
>>>>> the
>>>>>> guest in case of failure.
>>>>>>=20
>>>>>> Make kvmppc_get_last_inst() definition common between architectures.
>>>>>>=20
>>>>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>>>>> ---
>>>> ...
>>>>=20
>>>>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
>>>>> b/arch/powerpc/include/asm/kvm_ppc.h
>>>>>> index e2fd5a1..7f9c634 100644
>>>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>>>> @@ -47,6 +47,11 @@ enum emulation_result {
>>>>>>       EMULATE_EXIT_USER,    /* emulation requires exit to user-
>>>> space */
>>>>>>   };
>>>>>>=20
>>>>>> +enum instruction_type {
>>>>>> +    INST_GENERIC,
>>>>>> +    INST_SC,        /* system call */
>>>>>> +};
>>>>>> +
>>>>>>   extern int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct
>> kvm_vcpu
>>>>> *vcpu);
>>>>>>   extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct
>>>> kvm_vcpu
>>>>> *vcpu);
>>>>>>   extern void kvmppc_handler_highmem(void);
>>>>>> @@ -62,6 +67,9 @@ extern int kvmppc_handle_store(struct kvm_run
>> *run,
>>>>> struct kvm_vcpu *vcpu,
>>>>>>                      u64 val, unsigned int bytes,
>>>>>>                      int is_default_endian);
>>>>>>=20
>>>>>> +extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
>>>>>> +                 enum instruction_type type, u32 *inst);
>>>>>> +
>>>>>>   extern int kvmppc_emulate_instruction(struct kvm_run *run,
>>>>>>                                         struct kvm_vcpu *vcpu);
>>>>>>   extern int kvmppc_emulate_mmio(struct kvm_run *run, struct
>> kvm_vcpu
>>>>> *vcpu);
>>>>>> @@ -234,6 +242,23 @@ struct kvmppc_ops {
>>>>>>   extern struct kvmppc_ops *kvmppc_hv_ops;
>>>>>>   extern struct kvmppc_ops *kvmppc_pr_ops;
>>>>>>=20
>>>>>> +static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu,
>>>>>> +                    enum instruction_type type, u32
>> *inst)
>>>>>> +{
>>>>>> +    int ret =3D EMULATE_DONE;
>>>>>> +
>>>>>> +    /* Load the instruction manually if it failed to do so in the
>>>>>> +     * exit path */
>>>>>> +    if (vcpu->arch.last_inst =3D=3D KVM_INST_FETCH_FAILED)
>>>>>> +        ret =3D kvmppc_load_last_inst(vcpu, type, &vcpu-
>>>>>> arch.last_inst);
>>>>>> +
>>>>>> +
>>>>>> +    *inst =3D (ret =3D=3D EMULATE_DONE && kvmppc_need_byteswap(vcpu)=
) ?
>>>>>> +        swab32(vcpu->arch.last_inst) : vcpu->arch.last_inst;
>>>>> This makes even less sense than the previous version. Either you
>> treat
>>>>> inst as "definitely overwritten" or as "preserves previous data on
>>>>> failure".
>>>> Both v4 and v5 versions treat inst as "definitely overwritten".
>>>>=20
>>>>> So either you unconditionally swap like you did before
>>>> If we make abstraction of its symmetry, KVM_INST_FETCH_FAILED is
>> operated
>>>> in host endianness, so it doesn't need byte swap.
>>>>=20
>>>> I agree with your reasoning if last_inst is initialized and compared
>> with
>>>> data in guest endianess, which is not the case yet for
>>>> KVM_INST_FETCH_FAILED.
>>> Alex, are you relying on the fact that KVM_INST_FETCH_FAILED value is
>> symmetrical?
>>> With a non symmetrical value like 0xDEADBEEF, and considering a little-
>> endian guest
>>> on a big-endian host, we need to fix kvm logic to initialize and
>> compare last_inst
>>> with 0xEFBEADDE swaped value.
>>>=20
>>> Your suggestion to unconditionally swap makes sense only with the above
>> fix, otherwise
>>> inst may end up with 0xEFBEADDE swaped value with is wrong.
>>=20
>> Only for *inst which we would treat as "undefined" after the function
>> returned EMULATE_AGAIN.
>=20
> Right. With this do you acknowledge that v5 (definitely overwritten approa=
ch)
> is ok?

I think I'm starting to understand your logic of v5. You write fetch_failed i=
nto *inst unswapped if the fetch failed.

I think that's ok, but I definitely do not like the code flow - it's too har=
d to understand at a glimpse. Just rewrite it to swab at local variable leve=
l, preferably with if()s and comments what this is about and have a single u=
nconditional *inst =3D fetched_inst; at the end of the function.

Alex
