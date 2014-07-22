Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5949D1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 07:21:40 +1000 (EST)
Message-ID: <53CED5D9.9010609@suse.de>
Date: Tue, 22 Jul 2014 23:21:29 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
 <53C7DBC3.2060104@suse.de>
 <9905fb7c7f604bcb966478e3722e8bfc@BY2PR03MB508.namprd03.prod.outlook.com>
 <32d95c415b3f4a69bebd5a208c498e15@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <32d95c415b3f4a69bebd5a208c498e15@BY2PR03MB508.namprd03.prod.outlook.com>
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


On 21.07.14 11:59, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+mihai.caraman=freescale.com@lists.ozlabs.org] On Behalf Of
>> mihai.caraman@freescale.com
>> Sent: Friday, July 18, 2014 12:06 PM
>> To: Alexander Graf; kvm-ppc@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org; kvm@vger.kernel.org
>> Subject: RE: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
>>
>>> -----Original Message-----
>>> From: Alexander Graf [mailto:agraf@suse.de]
>>> Sent: Thursday, July 17, 2014 5:21 PM
>>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to
>> fail
>>>
>>> On 17.07.14 13:22, Mihai Caraman wrote:
>>>> On book3e, guest last instruction is read on the exit path using load
>>>> external pid (lwepx) dedicated instruction. This load operation may
>>> fail
>>>> due to TLB eviction and execute-but-not-read entries.
>>>>
>>>> This patch lay down the path for an alternative solution to read the
>>> guest
>>>> last instruction, by allowing kvmppc_get_lat_inst() function to fail.
>>>> Architecture specific implmentations of kvmppc_load_last_inst() may
>>> read
>>>> last guest instruction and instruct the emulation layer to re-execute
>>> the
>>>> guest in case of failure.
>>>>
>>>> Make kvmppc_get_last_inst() definition common between architectures.
>>>>
>>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>>> ---
>> ...
>>
>>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
>>> b/arch/powerpc/include/asm/kvm_ppc.h
>>>> index e2fd5a1..7f9c634 100644
>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>> @@ -47,6 +47,11 @@ enum emulation_result {
>>>>    	EMULATE_EXIT_USER,    /* emulation requires exit to user-
>> space */
>>>>    };
>>>>
>>>> +enum instruction_type {
>>>> +	INST_GENERIC,
>>>> +	INST_SC,		/* system call */
>>>> +};
>>>> +
>>>>    extern int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu
>>> *vcpu);
>>>>    extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct
>> kvm_vcpu
>>> *vcpu);
>>>>    extern void kvmppc_handler_highmem(void);
>>>> @@ -62,6 +67,9 @@ extern int kvmppc_handle_store(struct kvm_run *run,
>>> struct kvm_vcpu *vcpu,
>>>>    			       u64 val, unsigned int bytes,
>>>>    			       int is_default_endian);
>>>>
>>>> +extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
>>>> +				 enum instruction_type type, u32 *inst);
>>>> +
>>>>    extern int kvmppc_emulate_instruction(struct kvm_run *run,
>>>>                                          struct kvm_vcpu *vcpu);
>>>>    extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu
>>> *vcpu);
>>>> @@ -234,6 +242,23 @@ struct kvmppc_ops {
>>>>    extern struct kvmppc_ops *kvmppc_hv_ops;
>>>>    extern struct kvmppc_ops *kvmppc_pr_ops;
>>>>
>>>> +static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu,
>>>> +					enum instruction_type type, u32 *inst)
>>>> +{
>>>> +	int ret = EMULATE_DONE;
>>>> +
>>>> +	/* Load the instruction manually if it failed to do so in the
>>>> +	 * exit path */
>>>> +	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
>>>> +		ret = kvmppc_load_last_inst(vcpu, type, &vcpu-
>>>> arch.last_inst);
>>>> +
>>>> +
>>>> +	*inst = (ret == EMULATE_DONE && kvmppc_need_byteswap(vcpu)) ?
>>>> +		swab32(vcpu->arch.last_inst) : vcpu->arch.last_inst;
>>> This makes even less sense than the previous version. Either you treat
>>> inst as "definitely overwritten" or as "preserves previous data on
>>> failure".
>> Both v4 and v5 versions treat inst as "definitely overwritten".
>>
>>> So either you unconditionally swap like you did before
>> If we make abstraction of its symmetry, KVM_INST_FETCH_FAILED is operated
>> in host endianness, so it doesn't need byte swap.
>>
>> I agree with your reasoning if last_inst is initialized and compared with
>> data in guest endianess, which is not the case yet for
>> KVM_INST_FETCH_FAILED.
> Alex, are you relying on the fact that KVM_INST_FETCH_FAILED value is symmetrical?
> With a non symmetrical value like 0xDEADBEEF, and considering a little-endian guest
> on a big-endian host, we need to fix kvm logic to initialize and compare last_inst
> with 0xEFBEADDE swaped value.
>
> Your suggestion to unconditionally swap makes sense only with the above fix, otherwise
> inst may end up with 0xEFBEADDE swaped value with is wrong.

Only for *inst which we would treat as "undefined" after the function 
returned EMULATE_AGAIN. last_inst stays  unmodified.


Alex
