Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x22b.google.com (mail-qa0-x22b.google.com
 [IPv6:2607:f8b0:400d:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9DC02C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 13:07:17 +1100 (EST)
Received: by mail-qa0-f43.google.com with SMTP id cm18so1221477qab.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 18:07:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7536FFB1-D186-42AC-9DF5-A46A72CB8F1D@suse.de>
References: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <7536FFB1-D186-42AC-9DF5-A46A72CB8F1D@suse.de>
Date: Fri, 8 Nov 2013 10:07:11 +0800
Message-ID: <CAFgQCTt1+A+pmQJuvZhmFqSKWSn7=awRuab+=+1RM3fEGfG=Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/kvm: fix rare but potential deadlock scene
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
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

On Thu, Nov 7, 2013 at 5:54 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 07.11.2013, at 07:22, Liu Ping Fan <kernelfans@gmail.com> wrote:
>
>> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>> realmode, so it can trigger the deadlock.
>>
>> Suppose the following scene:
>>
>> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of v=
cpus.
>>
>> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched o=
ut,
>> and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be caugh=
t in
>> realmode for a long time.
>>
>> What makes things even worse if the following happens,
>>  On cpuM, bitlockX is hold, on cpuN, Y is hold.
>>  vcpu_B_2 try to lock Y on cpuM in realmode
>>  vcpu_A_2 try to lock X on cpuN in realmode
>>
>> Oops! deadlock happens
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>
> Very nice catch :).
>
> I think it makes a lot of sense to document the fact that kvmppc_hv_find_=
lock_hpte() should be called with preemption disabled in a comment above th=
e function, so that next time when someone potentially calls it, he knows t=
hat he needs to put preempt_disable() around it.
>
Ok, I will document them in v3

> Thanks a lot for finding this pretty subtle issue. May I ask how you got =
there? Did you actually see systems deadlock because of this?
>
Intuition :). then I begin try to model a scene which causes the
deadlock. And fortunately, I find a case to verify my suspension.

Regards,
Pingfan
>
> Alex
>
>> ---
>> arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book=
3s_64_mmu_hv.c
>> index 043eec8..dbc1478 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> @@ -474,10 +474,13 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kv=
m_vcpu *vcpu, gva_t eaddr,
>>       }
>>
>>       /* Find the HPTE in the hash table */
>> +     preempt_disable();
>>       index =3D kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
>>                                        HPTE_V_VALID | HPTE_V_ABSENT);
>> -     if (index < 0)
>> +     if (index < 0) {
>> +             preempt_enable();
>>               return -ENOENT;
>> +     }
>>       hptep =3D (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
>>       v =3D hptep[0] & ~HPTE_V_HVLOCK;
>>       gr =3D kvm->arch.revmap[index].guest_rpte;
>> @@ -485,6 +488,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_=
vcpu *vcpu, gva_t eaddr,
>>       /* Unlock the HPTE */
>>       asm volatile("lwsync" : : : "memory");
>>       hptep[0] =3D v;
>> +     preempt_enable();
>>
>>       gpte->eaddr =3D eaddr;
>>       gpte->vpage =3D ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff)=
;
>> --
>> 1.8.1.4
>>
>
