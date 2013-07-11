Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id AAFFE2C029E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 21:15:26 +1000 (EST)
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=koi8-r
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <51DE8EE9.2000508@ozlabs.ru>
Date: Thu, 11 Jul 2013 13:15:19 +0200
Message-Id: <C6BC1E27-4C9C-4A18-A64A-052202DA64B5@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru> <51DC4228.7010607@suse.de>
 <51DCEA76.9070808@ozlabs.ru> <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de>
 <51DE3ECB.7080803@ozlabs.ru> <43E93931-F213-47CC-ADCF-D3A6D6BC4372@suse.de>
 <51DE8EE9.2000508@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.07.2013, at 12:54, Alexey Kardashevskiy wrote:

> On 07/11/2013 08:11 PM, Alexander Graf wrote:
>>=20
>> On 11.07.2013, at 07:12, Alexey Kardashevskiy wrote:
>>=20
>>> On 07/10/2013 08:05 PM, Alexander Graf wrote:
>>>>=20
>>>> On 10.07.2013, at 07:00, Alexey Kardashevskiy wrote:
>>>>=20
>>>>> On 07/10/2013 03:02 AM, Alexander Graf wrote:
>>>>>> On 07/06/2013 05:07 PM, Alexey Kardashevskiy wrote:
>>>>>>> This adds real mode handlers for the H_PUT_TCE_INDIRECT and
>>>>>>> H_STUFF_TCE hypercalls for QEMU emulated devices such as IBMVIO
>>>>>>> devices or emulated PCI.  These calls allow adding multiple =
entries
>>>>>>> (up to 512) into the TCE table in one call which saves time on
>>>>>>> transition to/from real mode.
>>>>>>=20
>>>>>> We don't mention QEMU explicitly in KVM code usually.
>>>>>>=20
>>>>>>> This adds a tce_tmp cache to kvm_vcpu_arch to save valid TCEs
>>>>>>> (copied from user and verified) before writing the whole list =
into
>>>>>>> the TCE table. This cache will be utilized more in the upcoming
>>>>>>> VFIO/IOMMU support to continue TCE list processing in the =
virtual
>>>>>>> mode in the case if the real mode handler failed for some =
reason.
>>>>>>>=20
>>>>>>> This adds a guest physical to host real address converter
>>>>>>> and calls the existing H_PUT_TCE handler. The converting =
function
>>>>>>> is going to be fully utilized by upcoming VFIO supporting =
patches.
>>>>>>>=20
>>>>>>> This also implements the KVM_CAP_PPC_MULTITCE capability,
>>>>>>> so in order to support the functionality of this patch, QEMU
>>>>>>> needs to query for this capability and set the "hcall-multi-tce"
>>>>>>> hypertas property only if the capability is present, otherwise
>>>>>>> there will be serious performance degradation.
>>>>>>=20
>>>>>> Same as above. But really you're only giving recommendations =
here. What's
>>>>>> the point? Please describe what the benefit of this patch is, not =
what some
>>>>>> other random subsystem might do with the benefits it brings.
>>>>>>=20
>>>>>>>=20
>>>>>>> Signed-off-by: Paul Mackerras<paulus@samba.org>
>>>>>>> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
>>>>>>>=20
>>>>>>> ---
>>>>>>> Changelog:
>>>>>>> 2013/07/06:
>>>>>>> * fixed number of wrong get_page()/put_page() calls
>>>>>>>=20
>>>>>>> 2013/06/27:
>>>>>>> * fixed clear of BUSY bit in kvmppc_lookup_pte()
>>>>>>> * H_PUT_TCE_INDIRECT does realmode_get_page() now
>>>>>>> * KVM_CAP_SPAPR_MULTITCE now depends on CONFIG_PPC_BOOK3S_64
>>>>>>> * updated doc
>>>>>>>=20
>>>>>>> 2013/06/05:
>>>>>>> * fixed mistype about IBMVIO in the commit message
>>>>>>> * updated doc and moved it to another section
>>>>>>> * changed capability number
>>>>>>>=20
>>>>>>> 2013/05/21:
>>>>>>> * added kvm_vcpu_arch::tce_tmp
>>>>>>> * removed cleanup if put_indirect failed, instead we do not even =
start
>>>>>>> writing to TCE table if we cannot get TCEs from the user and =
they are
>>>>>>> invalid
>>>>>>> * kvmppc_emulated_h_put_tce is split to kvmppc_emulated_put_tce
>>>>>>> and kvmppc_emulated_validate_tce (for the previous item)
>>>>>>> * fixed bug with failthrough for H_IPI
>>>>>>> * removed all get_user() from real mode handlers
>>>>>>> * kvmppc_lookup_pte() added (instead of making lookup_linux_pte =
public)
>>>>>>>=20
>>>>>>> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
>>>>>>> ---
>>>>>>> Documentation/virtual/kvm/api.txt       |  25 +++
>>>>>>> arch/powerpc/include/asm/kvm_host.h     |   9 ++
>>>>>>> arch/powerpc/include/asm/kvm_ppc.h      |  16 +-
>>>>>>> arch/powerpc/kvm/book3s_64_vio.c        | 154 =
++++++++++++++++++-
>>>>>>> arch/powerpc/kvm/book3s_64_vio_hv.c     | 260
>>>>>>> ++++++++++++++++++++++++++++----
>>>>>>> arch/powerpc/kvm/book3s_hv.c            |  41 ++++-
>>>>>>> arch/powerpc/kvm/book3s_hv_rmhandlers.S |   6 +
>>>>>>> arch/powerpc/kvm/book3s_pr_papr.c       |  37 ++++-
>>>>>>> arch/powerpc/kvm/powerpc.c              |   3 +
>>>>>>> 9 files changed, 517 insertions(+), 34 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/Documentation/virtual/kvm/api.txt
>>>>>>> b/Documentation/virtual/kvm/api.txt
>>>>>>> index 6365fef..762c703 100644
>>>>>>> --- a/Documentation/virtual/kvm/api.txt
>>>>>>> +++ b/Documentation/virtual/kvm/api.txt
>>>>>>> @@ -2362,6 +2362,31 @@ calls by the guest for that service will =
be passed
>>>>>>> to userspace to be
>>>>>>> handled.
>>>>>>>=20
>>>>>>>=20
>>>>>>> +4.86 KVM_CAP_PPC_MULTITCE
>>>>>>> +
>>>>>>> +Capability: KVM_CAP_PPC_MULTITCE
>>>>>>> +Architectures: ppc
>>>>>>> +Type: vm
>>>>>>> +
>>>>>>> +This capability means the kernel is capable of handling =
hypercalls
>>>>>>> +H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into =
the user
>>>>>>> +space. This significanly accelerates DMA operations for PPC KVM =
guests.
>>>>>>=20
>>>>>> significanly? Please run this through a spell checker.
>>>>>>=20
>>>>>>> +The user space should expect that its handlers for these =
hypercalls
>>>>>>=20
>>>>>> s/The//
>>>>>>=20
>>>>>>> +are not going to be called.
>>>>>>=20
>>>>>> Is user space guaranteed they will not be called? Or can it still =
happen?
>>>>>=20
>>>>> ... if user space previously registered LIOBN in KVM (via
>>>>> KVM_CREATE_SPAPR_TCE or similar calls).
>>>>>=20
>>>>> ok?
>>>>=20
>>>> How about this?
>>>>=20
>>>> The hypercalls mentioned above may or may not be processed =
successfully in the kernel based fast path. If they can not be handled =
by the kernel, they will get passed on to user space. So user space =
still has to have an implementation for these despite the in kernel =
acceleration.
>>>>=20
>>>> ---
>>>>=20
>>>> The target audience for this documentation is user space KVM API =
users. Someone developing kvm tool for example. They want to know =
implications specific CAPs have.
>>>>=20
>>>>>=20
>>>>> There is also KVM_CREATE_SPAPR_TCE_IOMMU but it is not in the =
kernel yet
>>>>> and may never get there.
>>>>>=20
>>>>>=20
>>>>>>> +In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in =
the guest,
>>>>>>> +the user space might have to advertise it for the guest. For =
example,
>>>>>>> +IBM pSeries guest starts using them if "hcall-multi-tce" is =
present in
>>>>>>> +the "ibm,hypertas-functions" device-tree property.
>>>>>>=20
>>>>>> This paragraph describes sPAPR. That's fine, but please document =
it as
>>>>>> such. Also please check your grammar.
>>>>>=20
>>>>>>> +
>>>>>>> +Without this capability, only H_PUT_TCE is handled by the =
kernel and
>>>>>>> +therefore the use of H_PUT_TCE_INDIRECT and H_STUFF_TCE is not =
recommended
>>>>>>> +unless the capability is present as passing hypercalls to the =
userspace
>>>>>>> +slows operations a lot.
>>>>>>> +
>>>>>>> +Unlike other capabilities of this section, this one is always =
enabled.
>>>>>>=20
>>>>>> Why? Wouldn't that confuse older user space?
>>>>>=20
>>>>>=20
>>>>> How? Old user space won't check for this capability and won't tell =
the
>>>>> guest to use it (via "hcall-multi-tce"). Old H_PUT_TCE is still =
there.
>>>>>=20
>>>>> If the guest always uses H_PUT_TCE_INDIRECT/H_STUFF_TCE no matter =
what,
>>>>> then it is its problem - it won't work now anyway as neither QEMU =
nor host
>>>>> kernel supports these calls.
>>>=20
>>>=20
>>>> Always assume that you are a kernel developer without knowledge
>>>> of any user space code using your interfaces. So there is the =
theoretical
>>>> possibility that there is a user space client out there that =
implements
>>>> H_PUT_TCE_INDIRECT and advertises hcall-multi-tce to the guest.=20
>>>> Would that client break? If so, we should definitely have
>>>> the CAP disabled by default.
>>>=20
>>>=20
>>> No, it won't break. Why would it break? I really do not get it. This =
user
>>> space client has to do an extra step to get this acceleration by =
calling
>>> ioctl(KVM_CREATE_SPAPR_TCE) anyway. Previously that ioctl only had =
effect
>>> on H_PUT_TCE, now on all three hcalls.
>>=20
>> Hrm. It's a change of behavior, it probably wouldn't break, yes.
>=20
>=20
> Aaand?


And that's bad. Jeez, seriously. Don't argue this case. We enable new =
features individually unless we're 100% sure we can keep everything =
working. In this case an ENABLE_CAP doesn't hurt at all, because user =
space still needs to handle the hypercalls if it wants them anyways. But =
you get debugging for free for example.

>=20
>=20
>>>> But really, it's also as much about consistency as anything else.
>>>> If we leave everything as is and always extend functionality
>>>> by enabling new CAPs, we're pretty much guaranteed that we
>>>> don't break anything by accident. It also makes debugging easier
>>>> because you can for example disable this particular feature
>>>> to see whether something has bad side effects.
>>>=20
>>>=20
>>> So I must add one more ioctl to enable MULTITCE in kernel handling. =
Is it
>>> what you are saying?
>>>=20
>>> I can see KVM_CHECK_EXTENSION but I do not see KVM_ENABLE_EXTENSION =
or
>>> anything like that.
>>=20
>> KVM_ENABLE_CAP. It's how we enable sPAPR capabilities too.
>=20
>=20
> Yeah, Paul already explained. It is platform specific but ok.
> And does not have "EXTENSION" in the name for some reason but ok too.
>=20
> KVM_ENABLE_CAP is vcpu ioctl. So kvm_arch_vcpu_ioctl() enables VCPU's
> capabilities while KVM_CAP_SPAPR_MULTITCE is KVM (or more precisely
> SPAPR-TCE/LIOBN but I really do not want it to be that specific) =
capability.
>=20
> Sure I can add to kvm_arch_vcpu_ioctl():
>=20
> case KVM_CAP_SPAPR_MULTITCE:
>        r =3D 0;
>        vcpu->kvm->arch.spapr_multitce_enabled =3D cap->args[0];
>        break;
>=20
> But I suspect you and Ben will call it ugly. SO do I have to implement
> KVM_ENABLE_CAP in kvm_arch_vm_ioctl and change the api.txt that it is =
not
> just about vcpu ioctl anymore? Or my brand new ioctl for this?


There are 2 ways of dealing with this:

  1) Call the ENABLE_CAP on every vcpu. That way one CPU may handle this =
hypercall in the kernel while another one may not. The same as we handle =
PAPR today.

  2) Create a new ENABLE_CAP for the vm.

I think in this case option 1 is fine - it's how we handle everything =
else already.

>=20
>=20
>=20
>=20
>>>>>>> +
>>>>>>> +
>>>>>>> 5. The kvm_run structure
>>>>>>> ------------------------
>>>>>>>=20
>>>>>>> diff --git a/arch/powerpc/include/asm/kvm_host.h
>>>>>>> b/arch/powerpc/include/asm/kvm_host.h
>>>>>>> index af326cd..20d04bd 100644
>>>>>>> --- a/arch/powerpc/include/asm/kvm_host.h
>>>>>>> +++ b/arch/powerpc/include/asm/kvm_host.h
>>>>>>> @@ -180,6 +180,7 @@ struct kvmppc_spapr_tce_table {
>>>>>>>    struct kvm *kvm;
>>>>>>>    u64 liobn;
>>>>>>>    u32 window_size;
>>>>>>> +    struct { struct { unsigned long put, indir, stuff; } rm, =
vm; } stat;
>>>>>>=20
>>>>>> You don't need this.
>>>>>>=20
>>>>>>>    struct page *pages[0];
>>>>>>> };
>>>>>>>=20
>>>>>>> @@ -609,6 +610,14 @@ struct kvm_vcpu_arch {
>>>>>>>    spinlock_t tbacct_lock;
>>>>>>>    u64 busy_stolen;
>>>>>>>    u64 busy_preempt;
>>>>>>> +
>>>>>>> +    unsigned long *tce_tmp_hpas;    /* TCE cache for =
TCE_PUT_INDIRECT
>>>>>>> hcall */
>>>>>>> +    enum {
>>>>>>> +        TCERM_NONE,
>>>>>>> +        TCERM_GETPAGE,
>>>>>>> +        TCERM_PUTTCE,
>>>>>>> +        TCERM_PUTLIST,
>>>>>>> +    } tce_rm_fail;            /* failed stage of request =
processing */
>>>>>>> #endif
>>>>>>> };
>>>>>>>=20
>>>>>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
>>>>>>> b/arch/powerpc/include/asm/kvm_ppc.h
>>>>>>> index a5287fe..fa722a0 100644
>>>>>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>>>>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>>>>>> @@ -133,8 +133,20 @@ extern int kvmppc_pseries_do_hcall(struct =
kvm_vcpu
>>>>>>> *vcpu);
>>>>>>>=20
>>>>>>> extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>>>>>>                struct kvm_create_spapr_tce *args);
>>>>>>> -extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned =
long liobn,
>>>>>>> -                 unsigned long ioba, unsigned long tce);
>>>>>>> +extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
>>>>>>> +        struct kvm_vcpu *vcpu, unsigned long liobn);
>>>>>>> +extern long kvmppc_emulated_validate_tce(unsigned long tce);
>>>>>>> +extern void kvmppc_emulated_put_tce(struct =
kvmppc_spapr_tce_table *tt,
>>>>>>> +        unsigned long ioba, unsigned long tce);
>>>>>>> +extern long kvmppc_vm_h_put_tce(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce);
>>>>>>> +extern long kvmppc_vm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce_list, unsigned long npages);
>>>>>>> +extern long kvmppc_vm_h_stuff_tce(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce_value, unsigned long npages);
>>>>>>> extern long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
>>>>>>>                struct kvm_allocate_rma *rma);
>>>>>>> extern struct kvmppc_linear_info *kvm_alloc_rma(void);
>>>>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c
>>>>>>> b/arch/powerpc/kvm/book3s_64_vio.c
>>>>>>> index b2d3f3b..99bf4e5 100644
>>>>>>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>>>>>>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>>>>>>> @@ -14,6 +14,7 @@
>>>>>>> *
>>>>>>> * Copyright 2010 Paul Mackerras, IBM Corp.<paulus@au1.ibm.com>
>>>>>>> * Copyright 2011 David Gibson, IBM Corporation<dwg@au1.ibm.com>
>>>>>>> + * Copyright 2013 Alexey Kardashevskiy, IBM =
Corporation<aik@au1.ibm.com>
>>>>>>> */
>>>>>>>=20
>>>>>>> #include<linux/types.h>
>>>>>>> @@ -36,8 +37,10 @@
>>>>>>> #include<asm/ppc-opcode.h>
>>>>>>> #include<asm/kvm_host.h>
>>>>>>> #include<asm/udbg.h>
>>>>>>> +#include<asm/iommu.h>
>>>>>>> +#include<asm/tce.h>
>>>>>>>=20
>>>>>>> -#define TCES_PER_PAGE    (PAGE_SIZE / sizeof(u64))
>>>>>>> +#define ERROR_ADDR      ((void *)~(unsigned long)0x0)
>>>>>>>=20
>>>>>>> static long kvmppc_stt_npages(unsigned long window_size)
>>>>>>> {
>>>>>>> @@ -50,6 +53,20 @@ static void release_spapr_tce_table(struct
>>>>>>> kvmppc_spapr_tce_table *stt)
>>>>>>>    struct kvm *kvm =3D stt->kvm;
>>>>>>>    int i;
>>>>>>>=20
>>>>>>> +#define __SV(x) stt->stat.x
>>>>>>> +#define __SVD(x) (__SV(rm.x)?(__SV(rm.x)-__SV(vm.x)):0)
>>>>>>> +    pr_debug("%s stat for liobn=3D%llx\n"
>>>>>>> +            "--------------- realmode ----- virtmode ---\n"
>>>>>>> +            "put_tce       %10ld     %10ld\n"
>>>>>>> +            "put_tce_indir %10ld     %10ld\n"
>>>>>>> +            "stuff_tce     %10ld     %10ld\n",
>>>>>>> +            __func__, stt->liobn,
>>>>>>> +            __SVD(put), __SV(vm.put),
>>>>>>> +            __SVD(indir), __SV(vm.indir),
>>>>>>> +            __SVD(stuff), __SV(vm.stuff));
>>>>>>> +#undef __SVD
>>>>>>> +#undef __SV
>>>>>>=20
>>>>>> All of these stat points should just be trace points. You can do =
the
>>>>>> statistic gathering from user space then.
>>>>>>=20
>>>>>>> +
>>>>>>>    mutex_lock(&kvm->lock);
>>>>>>>    list_del(&stt->list);
>>>>>>>    for (i =3D 0; i<  kvmppc_stt_npages(stt->window_size); i++)
>>>>>>> @@ -148,3 +165,138 @@ fail:
>>>>>>>    }
>>>>>>>    return ret;
>>>>>>> }
>>>>>>> +
>>>>>>> +/* Converts guest physical address to host virtual address */
>>>>>>> +static void __user *kvmppc_vm_gpa_to_hva_and_get(struct =
kvm_vcpu *vcpu,
>>>>>>=20
>>>>>> Please don't distinguish _vm versions. They're the normal case. =
_rm ones
>>>>>> are the special ones.
>>>>>>=20
>>>>>>> +        unsigned long gpa, struct page **pg)
>>>>>>> +{
>>>>>>> +    unsigned long hva, gfn =3D gpa>>  PAGE_SHIFT;
>>>>>>> +    struct kvm_memory_slot *memslot;
>>>>>>> +
>>>>>>> +    memslot =3D search_memslots(kvm_memslots(vcpu->kvm), gfn);
>>>>>>> +    if (!memslot)
>>>>>>> +        return ERROR_ADDR;
>>>>>>> +
>>>>>>> +    hva =3D __gfn_to_hva_memslot(memslot, gfn) + (gpa&  =
~PAGE_MASK);
>>>>>>=20
>>>>>> s/+/|/
>>>>>>=20
>>>>>>> +
>>>>>>> +    if (get_user_pages_fast(hva&  PAGE_MASK, 1, 0, pg) !=3D 1)
>>>>>>> +        return ERROR_ADDR;
>>>>>>> +
>>>>>>> +    return (void *) hva;
>>>>>>> +}
>>>>>>> +
>>>>>>> +long kvmppc_vm_h_put_tce(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce)
>>>>>>> +{
>>>>>>> +    long ret;
>>>>>>> +    struct kvmppc_spapr_tce_table *tt;
>>>>>>> +
>>>>>>> +    tt =3D kvmppc_find_tce_table(vcpu, liobn);
>>>>>>> +    /* Didn't find the liobn, put it to userspace */
>>>>>>=20
>>>>>> Unclear comment.
>>>>>=20
>>>>>=20
>>>>> What detail is missing?
>>>>=20
>>>=20
>>>> Grammar wise "it" in the second half of the sentence refers to =
liobn.
>>>> So you "put" the "liobn to userspace". That sentence doesn't
>>>> make any sense.
>>>=20
>>>=20
>>> Removed it. H_TOO_HARD itself says enough already.
>>>=20
>>>=20
>>>> What you really want to say is:
>>>>=20
>>>> /* Couldn't find the liobn. Something went wrong. Let user space =
handle the hypercall. That has better ways of dealing with errors. */
>>>>=20
>>>>>=20
>>>>>=20
>>>>>>> +    if (!tt)
>>>>>>> +        return H_TOO_HARD;
>>>>>>> +
>>>>>>> +    ++tt->stat.vm.put;
>>>>>>> +
>>>>>>> +    if (ioba>=3D tt->window_size)
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    ret =3D kvmppc_emulated_validate_tce(tce);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>> +    kvmppc_emulated_put_tce(tt, ioba, tce);
>>>>>>> +
>>>>>>> +    return H_SUCCESS;
>>>>>>> +}
>>>>>>> +
>>>>>>> +long kvmppc_vm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce_list, unsigned long npages)
>>>>>>> +{
>>>>>>> +    struct kvmppc_spapr_tce_table *tt;
>>>>>>> +    long i, ret =3D H_SUCCESS;
>>>>>>> +    unsigned long __user *tces;
>>>>>>> +    struct page *pg =3D NULL;
>>>>>>> +
>>>>>>> +    tt =3D kvmppc_find_tce_table(vcpu, liobn);
>>>>>>> +    /* Didn't find the liobn, put it to userspace */
>>>>>>> +    if (!tt)
>>>>>>> +        return H_TOO_HARD;
>>>>>>> +
>>>>>>> +    ++tt->stat.vm.indir;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * The spec says that the maximum size of the list is 512 =
TCEs so
>>>>>>> +     * so the whole table addressed resides in 4K page
>>>>>>=20
>>>>>> so so?
>>>>>>=20
>>>>>>> +     */
>>>>>>> +    if (npages>  512)
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    if (tce_list&  ~IOMMU_PAGE_MASK)
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    if ((ioba + (npages<<  IOMMU_PAGE_SHIFT))>  =
tt->window_size)
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    tces =3D kvmppc_vm_gpa_to_hva_and_get(vcpu, tce_list,&pg);
>>>>>>> +    if (tces =3D=3D ERROR_ADDR)
>>>>>>> +        return H_TOO_HARD;
>>>>>>> +
>>>>>>> +    if (vcpu->arch.tce_rm_fail =3D=3D TCERM_PUTLIST)
>>>>>>> +        goto put_list_page_exit;
>>>>>>> +
>>>>>>> +    for (i =3D 0; i<  npages; ++i) {
>>>>>>> +        if (get_user(vcpu->arch.tce_tmp_hpas[i], tces + i)) {
>>>>>>> +            ret =3D H_PARAMETER;
>>>>>>> +            goto put_list_page_exit;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        ret =3D =
kvmppc_emulated_validate_tce(vcpu->arch.tce_tmp_hpas[i]);
>>>>>>> +        if (ret)
>>>>>>> +            goto put_list_page_exit;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    for (i =3D 0; i<  npages; ++i)
>>>>>>> +        kvmppc_emulated_put_tce(tt, ioba + (i<<  =
IOMMU_PAGE_SHIFT),
>>>>>>> +                vcpu->arch.tce_tmp_hpas[i]);
>>>>>>> +put_list_page_exit:
>>>>>>> +    if (pg)
>>>>>>> +        put_page(pg);
>>>>>>> +
>>>>>>> +    if (vcpu->arch.tce_rm_fail !=3D TCERM_NONE) {
>>>>>>> +        vcpu->arch.tce_rm_fail =3D TCERM_NONE;
>>>>>>> +        if (pg&&  !PageCompound(pg))
>>>>>>> +            put_page(pg); /* finish pending realmode_put_page() =
*/
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +long kvmppc_vm_h_stuff_tce(struct kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn, unsigned long ioba,
>>>>>>> +        unsigned long tce_value, unsigned long npages)
>>>>>>> +{
>>>>>>> +    struct kvmppc_spapr_tce_table *tt;
>>>>>>> +    long i, ret;
>>>>>>> +
>>>>>>> +    tt =3D kvmppc_find_tce_table(vcpu, liobn);
>>>>>>> +    /* Didn't find the liobn, put it to userspace */
>>>>>>> +    if (!tt)
>>>>>>> +        return H_TOO_HARD;
>>>>>>> +
>>>>>>> +    ++tt->stat.vm.stuff;
>>>>>>> +
>>>>>>> +    if ((ioba + (npages<<  IOMMU_PAGE_SHIFT))>  =
tt->window_size)
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    ret =3D kvmppc_emulated_validate_tce(tce_value);
>>>>>>> +    if (ret || (tce_value&  (TCE_PCI_WRITE | TCE_PCI_READ)))
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    for (i =3D 0; i<  npages; ++i, ioba +=3D IOMMU_PAGE_SIZE)
>>>>>>> +        kvmppc_emulated_put_tce(tt, ioba, tce_value);
>>>>>>> +
>>>>>>> +    return H_SUCCESS;
>>>>>>> +}
>>>>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>>>>> b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>>>>> index 30c2f3b..cd3e6f9 100644
>>>>>>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>>>>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>>>>> @@ -14,6 +14,7 @@
>>>>>>> *
>>>>>>> * Copyright 2010 Paul Mackerras, IBM Corp.<paulus@au1.ibm.com>
>>>>>>> * Copyright 2011 David Gibson, IBM Corporation<dwg@au1.ibm.com>
>>>>>>> + * Copyright 2013 Alexey Kardashevskiy, IBM =
Corporation<aik@au1.ibm.com>
>>>>>>> */
>>>>>>>=20
>>>>>>> #include<linux/types.h>
>>>>>>> @@ -35,42 +36,243 @@
>>>>>>> #include<asm/ppc-opcode.h>
>>>>>>> #include<asm/kvm_host.h>
>>>>>>> #include<asm/udbg.h>
>>>>>>> +#include<asm/iommu.h>
>>>>>>> +#include<asm/tce.h>
>>>>>>>=20
>>>>>>> #define TCES_PER_PAGE    (PAGE_SIZE / sizeof(u64))
>>>>>>> +#define ERROR_ADDR      (~(unsigned long)0x0)
>>>>>>>=20
>>>>>>> -/* WARNING: This will be called in real-mode on HV KVM and =
virtual
>>>>>>> - *          mode on PR KVM
>>>>>>=20
>>>>>> What's wrong with the warning?
>>>>>=20
>>>>>=20
>>>>> It belongs to kvmppc_h_put_tce() which is not called in virtual =
mode anymore.
>>>>=20
>>>> I thought the comment applied to the whole file before? Hrm. Maybe =
I misread it then.
>>>>=20
>>>>> It is technically correct for kvmppc_find_tce_table() though. =
Should I put
>>>>> this comment before every function which may be called from real =
and
>>>>> virtual modes?
>>>>=20
>>>> Yes, please. Otherwise someone might stick an access to a =
non-linear address
>>>> in there by accident.
>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>> +/*
>>>>>>> + * Finds a TCE table descriptor by LIOBN
>>>>>>> */
>>>>>>> +struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct =
kvm_vcpu *vcpu,
>>>>>>> +        unsigned long liobn)
>>>>>>> +{
>>>>>>> +    struct kvmppc_spapr_tce_table *tt;
>>>>>>> +
>>>>>>> +    list_for_each_entry(tt,&vcpu->kvm->arch.spapr_tce_tables, =
list) {
>>>>>>> +        if (tt->liobn =3D=3D liobn)
>>>>>>> +            return tt;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return NULL;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
>>>>>>> +
>>>>>>> +#ifdef DEBUG
>>>>>>> +/*
>>>>>>> + * Lets user mode disable realmode handlers by putting big =
number
>>>>>>> + * in the bottom value of LIOBN
>>>>>>=20
>>>>>> What? Seriously? Just don't enable the CAP.
>>>>>=20
>>>>>=20
>>>>> It is under DEBUG. It really, really helps to be able to disable =
real mode
>>>>> handlers without reboot. Ok, no debug code, I'll remove.
>>>>=20
>>>> Debug code is good, but #ifdefs are bad. For you, an #ifdef reads =
like
>>>> "code that doesn't do any hard when disabled". For me, #ifdefs read
>>>> "code that definitely breaks because nobody turns the #define on".
>>>>=20
>>>> So please, avoid #ifdef'ed code whenever possible. Switching the =
CAP on and
>>>> off is a much better debug approach in this case.
>>>>=20
>>>>>=20
>>>>>=20
>>>>>>> + */
>>>>>>> +#define kvmppc_find_tce_table(a, b) \
>>>>>>> +        ((((b)&0xffff)>10000)?NULL:kvmppc_find_tce_table((a), =
(b)))
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Validates TCE address.
>>>>>>> + * At the moment only flags are validated as other checks will
>>>>>>> significantly slow
>>>>>>> + * down or can make it even impossible to handle TCE requests =
in real mode.
>>>>>>=20
>>>>>> What?
>>>>>=20
>>>>>=20
>>>>> What is missing here (besides good english)?
>>>>=20
>>>> What badness could slip through by not validating everything?
>>>=20
>>>=20
>>> I cannot think of any good check which could be done in real mode =
and not
>>> be "more than 2 calls deep" (c) Ben. Check that the page is =
allocated at
>>> all? How? Don't know.
>>=20
>=20
>> If you say that our validation doesn't validate everything, that =
makes
>> me really weary.
>=20
>=20
> It checks that TCE does not have any bit set in bits 2..12. If they =
are
> set, something went very wrong. Better than nothing.
>=20
>=20
>> Could the guest use it to maliciously inject anything?
>> Could a missing check make our code go berserk?
>=20
>=20
> No. KVM does not do anything with those addresses, just puts them to =
the
> table and lets QEMU or a guest deal with it.
>=20
>=20
>> What checks exactly would you do in addition when this was virtual =
mode?
>=20
>=20
> Check that TCE is within RAM boundaries. Or check that the page was
> allocated. find_linux_pte_or_hugepte? It can fail in real mode but in
> virtual mode I can call get_user_fast_page and confirm that the =
address is
> ok. Not sure, did not think much about it. Compare page flags with TCE
> flags if both or neither have "write" set, this kind of stuff.
>=20
> I am not really sure we need any of those checks for emulated TCE at =
all.
>=20
> Remove the comment then?

No, extend it. Explain what we could check and that we rely on =
surroundings to ensure everything's fine.

>=20
>=20
>>>>>>> + */
>>>>>>> +long kvmppc_emulated_validate_tce(unsigned long tce)
>>>>>>=20
>>>>>> I don't like the naming scheme. Please turn this around and make =
it
>>>>>> kvmppc_tce_validate().
>>>>>=20
>>>>>=20
>>>>> Oh. "Like"... Ok.
>>>>=20
>>>> Yes. Like.
>>>>=20
>>>>>=20
>>>>>=20
>>>>>>> +{
>>>>>>> +    if (tce&  ~(IOMMU_PAGE_MASK | TCE_PCI_WRITE | =
TCE_PCI_READ))
>>>>>>> +        return H_PARAMETER;
>>>>>>> +
>>>>>>> +    return H_SUCCESS;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(kvmppc_emulated_validate_tce);
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Handles TCE requests for QEMU emulated devices.
>>>>>>=20
>>>>>> We still don't mention QEMU in KVM code. And does it really =
matter whether
>>>>>> they're emulated by QEMU? Devices could also be emulated by KVM.
>>>>>>=20
>>>>>>> + * Puts guest TCE values to the table and expects QEMU to =
convert them
>>>>>>> + * later in a QEMU device implementation.
>>>>>>> + * Called in both real and virtual modes.
>>>>>>> + * Cannot fail so kvmppc_emulated_validate_tce must be called =
before it.
>>>>>>> + */
>>>>>>> +void kvmppc_emulated_put_tce(struct kvmppc_spapr_tce_table *tt,
>>>>>>=20
>>>>>> kvmppc_tce_put()
>>>>>>=20
>>>>>>> +        unsigned long ioba, unsigned long tce)
>>>>>>> +{
>>>>>>> +    unsigned long idx =3D ioba>>  SPAPR_TCE_SHIFT;
>>>>>>> +    struct page *page;
>>>>>>> +    u64 *tbl;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * Note on the use of page_address() in real mode,
>>>>>>> +     *
>>>>>>> +     * It is safe to use page_address() in real mode on ppc64 =
because
>>>>>>> +     * page_address() is always defined as =
lowmem_page_address()
>>>>>>> +     * which returns __va(PFN_PHYS(page_to_pfn(page))) which is =
arithmetial
>>>>>>> +     * operation and does not access page struct.
>>>>>>> +     *
>>>>>>> +     * Theoretically page_address() could be defined different
>>>>>>> +     * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
>>>>>>> +     * should be enabled.
>>>>>>> +     * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
>>>>>>> +     * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and =
only
>>>>>>> +     * if CONFIG_HIGHMEM is defined. As =
CONFIG_SPARSEMEM_VMEMMAP
>>>>>>> +     * is not expected to be enabled on ppc32, page_address()
>>>>>>> +     * is safe for ppc32 as well.
>>>>>>> +     */
>>>>>>> +#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
>>>>>>> +#error TODO: fix to avoid page_address() here
>>>>>>> +#endif
>>>>>>=20
>>>>>> Can you extract the text above, the check and the page_address =
call into a
>>>>>> simple wrapper function?
>>>>>=20
>>>>>=20
>>>>> Is this function also too big? Sorry, I do not understand the =
comment.
>>>>=20
>>>> All of the comment and #if here only deal with the fact that you
>>>> have a real mode hack to call page_address() that happens
>>>> to work under specific circumstances.
>>>>=20
>>>> There's nothing kvmppc_tce_put() specific about this.
>>>> The page_address() code happens to get called here, sure.
>>>> But if I read the kvmppc_tce_put() function I don't care about
>>>> these details - I want to understand the code flow that ends
>>>> up writing the TCE.
>>>>=20
>>>>>>> +    page =3D tt->pages[idx / TCES_PER_PAGE];
>>>>>>> +    tbl =3D (u64 *)page_address(page);
>>>>>>> +
>>>>>>> +    /* udbg_printf("tce @ %p\n",&tbl[idx % TCES_PER_PAGE]); */
>>>>>>=20
>>>>>> This is not an RFC, is it?
>>>>>=20
>>>>>=20
>>>>> Any debug code is prohibited? Ok, I'll remove.
>>>>=20
>>>> Debug code that requires code changes is prohibited, yes.
>>>> Debug code that is runtime switchable (pr_debug, trace points, etc)
>>>> are allowed.
>>>=20
>>>=20
>>> Is there any easy way to enable just this specific udbg_printf (not =
all of
>>> them at once)? Trace points do not work in real mode as we figured =
out.
>>=20
>> You can enable pr_debug by file IIRC.
>=20
>=20
> On already running kernel? :-/ Wow. How?

=
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/dynamic-debug-howto.txt?id=3DHEAD


Alex
