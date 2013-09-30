Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 4A7342C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 00:54:37 +1000 (EST)
Message-ID: <524990A9.60704@suse.de>
Date: Mon, 30 Sep 2013 16:54:33 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <878uyibkq2.fsf@linux.vnet.ibm.com>
 <48337EF0-471D-4BDB-8088-FC072FF82753@suse.de>
 <87had2bgme.fsf@linux.vnet.ibm.com>
In-Reply-To: <87had2bgme.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@redhat.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2013 03:09 PM, Aneesh Kumar K.V wrote:
> Alexander Graf<agraf@suse.de>  writes:
>
>> On 27.09.2013, at 12:52, Aneesh Kumar K.V wrote:
>>
>>> "Aneesh Kumar K.V"<aneesh.kumar@linux.vnet.ibm.com>  writes:
>>>
>>>> Hi All,
>>>>
>>>> This patch series support enabling HV and PR KVM together in the same kernel. We
>>>> extend machine property with new property "kvm_type". A value of 1 will force HV
>>>> KVM and 2 PR KVM. The default value is 0 which will select the fastest KVM mode.
>>>> ie, HV if that is supported otherwise PR.
>>>>
>>>> With Qemu command line having
>>>>
>>>> -machine pseries,accel=kvm,kvm_type=1
>>>>
>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>> failed to initialize KVM: Invalid argument
>>>> [root@llmp24l02 qemu]# modprobe kvm-pr
>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>> failed to initialize KVM: Invalid argument
>>>> [root@llmp24l02 qemu]# modprobe  kvm-hv
>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>
>>>> now with
>>>>
>>>> -machine pseries,accel=kvm,kvm_type=2
>>>>
>>>> [root@llmp24l02 qemu]# rmmod kvm-pr
>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>> failed to initialize KVM: Invalid argument
>>>> [root@llmp24l02 qemu]#
>>>> [root@llmp24l02 qemu]# modprobe kvm-pr
>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>
>>>> if don't specify kvm_type machine property, it will take a default value 0,
>>>> which means fastest supported.
>>> Related qemu patch
>>>
>>> commit 8d139053177d48a70cb710b211ea4c2843eccdfb
>>> Author: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>
>>> Date:   Mon Sep 23 12:28:37 2013 +0530
>>>
>>>     kvm: Add a new machine property kvm_type
>>>
>>>     Targets like ppc64 support different type of KVM, one which use
>>>     hypervisor mode and the other which doesn't. Add a new machine
>>>     property kvm_type that helps in selecting the respective ones
>>>
>>>     Signed-off-by: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>
>> This really is too early, as we can't possibly run in HV mode for
>> non-pseries machines, so the interpretation (or at least sanity
>> checking) of what values are reasonable should occur in the
>> machine. That's why it's a variable in the "machine opts".
> With the current code CREATE_VM will fail, because we won't have
> kvm-hv.ko loaded and trying to create a vm with type 1 will fail.
> Now the challenge related to moving that to machine_init or later is, we
> depend on HV or PR callback early in CREATE_VM. With the changes we have
>
> int kvmppc_core_init_vm(struct kvm *kvm)
> {
>
> #ifdef CONFIG_PPC64
> 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
> 	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
> #endif
>
> 	return kvm->arch.kvm_ops->init_vm(kvm);
> }
>
> Also the mmu notifier callback do end up calling kvm_unmap_hva etc which
> are all HV/PR dependent.

Yes, so we should verify in the machine models that we're runnable with 
the currently selected type at least, to give the user a sensible error 
message.

>
>
>
>> Also, users don't want to say type=0. They want to say type=PR or
>> type=HV or type=HV,PR. In fact, can't you make this a property of
>> -accel? Then it's truly accel specific and everything should be well.
> If we are doing this as machine property, we can't specify string,
> because "HV"/"PR" are all powerpc dependent, so parsing that is not
> possible in kvm_init in qemu. But, yes ideally it would be nice to be

Well, we could do the "name to integer" conversion in an arch specific 
function, no?

> able to speicy the type using string. I thought accel is a machine
> property, hence was not sure whether I can have additional properties
> against that. I was using it as below.
>
>   -machine pseries,accel=kvm,kvm_type=1
>
> will look into more details to check whether this can be accel property.

Great :).


Alex
