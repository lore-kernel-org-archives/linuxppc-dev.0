Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C592B6FBE
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 13:20:24 +1100 (EST)
Subject: Re: [PATCH v4 2/3] KVM: PPC: epapr: Add idle hcall support for host
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4CA99838F21AB847ACC344051E2317090571EB39@039-SN2MPN1-022.039d.mgd.msft.net>
Date: Fri, 17 Feb 2012 03:20:19 +0100
Message-Id: <D74699B5-5DA1-4E9D-8FDB-4A0C18613C21@suse.de>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <F0023B33-6AF3-4805-B50E-2ED285F8B1B0@suse.de>
 <4CA99838F21AB847ACC344051E2317090571EB39@039-SN2MPN1-022.039d.mgd.msft.net>
To: Liu Yu-B13201 <B13201@freescale.com>
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.02.2012, at 03:13, Liu Yu-B13201 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, February 16, 2012 6:20 PM
>> To: Liu Yu-B13201
>> Cc: <kvm-ppc@vger.kernel.org>; <kvm@vger.kernel.org>; <linuxppc-
>> dev@ozlabs.org>; Wood Scott-B07421; Liu Yu-B13201
>> Subject: Re: [PATCH v4 2/3] KVM: PPC: epapr: Add idle hcall support =
for
>> host
>>=20
>>=20
>>=20
>> On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:
>>=20
>>> And add a new flag definition in kvm_ppc_pvinfo to indicate whether
>>> host support EV_IDLE hcall.
>>>=20
>>> Signed-off-by: Liu Yu <yu.liu@freescale.com>
>>> ---
>>> v4:
>>> no change
>>>=20
>>> arch/powerpc/include/asm/kvm_para.h |   14 ++++++++++++--
>>> arch/powerpc/kvm/powerpc.c          |    8 ++++++++
>>> include/linux/kvm.h                 |    2 ++
>>> 3 files changed, 22 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/include/asm/kvm_para.h
>>> b/arch/powerpc/include/asm/kvm_para.h
>>> index 7b754e7..81a34c9 100644
>>> --- a/arch/powerpc/include/asm/kvm_para.h
>>> +++ b/arch/powerpc/include/asm/kvm_para.h
>>> @@ -75,9 +75,19 @@ struct kvm_vcpu_arch_shared { };
>>>=20
>>> #define KVM_SC_MAGIC_R0        0x4b564d21 /* "KVM!" */
>>> -#define HC_VENDOR_KVM        (42 << 16)
>>> +
>>> +#include <asm/epapr_hcalls.h>
>>> +
>>> +/* ePAPR Hypercall Vendor ID */
>>> +#define HC_VENDOR_EPAPR        (EV_EPAPR_VENDOR_ID << 16)
>>> +#define HC_VENDOR_KVM        (EV_KVM_VENDOR_ID << 16)
>>> +
>>> +/* ePAPR Hypercall Token */
>>> +#define HC_EV_IDLE        EV_IDLE
>>> +
>>> +/* ePAPR Hypercall Return Codes */
>>> #define HC_EV_SUCCESS        0
>>> -#define HC_EV_UNIMPLEMENTED    12
>>> +#define HC_EV_UNIMPLEMENTED    EV_UNIMPLEMENTED
>>>=20
>>> #define KVM_FEATURE_MAGIC_PAGE    1
>>>=20
>>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>>> index 0e21d15..03ebd5d 100644
>>> --- a/arch/powerpc/kvm/powerpc.c
>>> +++ b/arch/powerpc/kvm/powerpc.c
>>> @@ -81,6 +81,10 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>>>=20
>>>       /* Second return value is in r4 */
>>>       break;
>>> +    case HC_VENDOR_EPAPR | HC_EV_IDLE:
>>> +        r =3D HC_EV_SUCCESS;
>>> +        kvm_vcpu_block(vcpu);
>>> +        break;
>>>   default:
>>>       r =3D HC_EV_UNIMPLEMENTED;
>>>       break;
>>> @@ -746,6 +750,10 @@ static int kvm_vm_ioctl_get_pvinfo(struct
>> kvm_ppc_pvinfo *pvinfo)
>>>   pvinfo->hcall[2] =3D inst_sc;
>>>   pvinfo->hcall[3] =3D inst_nop;
>>>=20
>>> +#ifdef CONFIG_BOOKE
>>> +    pvinfo->flags |=3D KVM_PPC_PVINFO_FLAGS_EV_IDLE; #endif
>>> +
>>>   return 0;
>>> }>=20
>>=20
>> Why limit it to booke? The less ifdefs our code has, the better :)
>=20
> The code here tells userspace that kvm support ev_idle.
> But I'm not sure if the ev_idle code works for other platforms.
>=20
> So I think we should keep the ifdef until other platform test the code =
:)

But the implementation is in generic code and is not #ifdef'ed, so a =
guest could still call it just fine. It looks simple enough to work =
without major testing on different platforms, so I'd say just expose it =
and be done :)


Alex
