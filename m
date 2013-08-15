Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0C7922C015A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 17:24:22 +1000 (EST)
Subject: Re: [PATCH 03/10] KVM: PPC: reserve a capability and ioctl numbers
 for realmode VFIO
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=koi8-r
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <520C81BE.70002@ozlabs.ru>
Date: Thu, 15 Aug 2013 09:24:13 +0200
Message-Id: <552A034A-CD3F-4737-B08A-E892E6420B83@suse.de>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-4-git-send-email-aik@ozlabs.ru>
 <ED8250FB-B0A8-4C32-A960-20ADB5742D2B@suse.de> <520C81BE.70002@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.08.2013, at 09:22, Alexey Kardashevskiy wrote:

> On 08/15/2013 05:16 PM, Alexander Graf wrote:
>>=20
>> On 01.08.2013, at 06:44, Alexey Kardashevskiy wrote:
>>=20
>>> This is to reserve a capablity number for upcoming support
>>> of VFIO-IOMMU DMA operations in real mode.
>>>=20
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>=20
>>> ---
>>> Changes:
>>> 2013/07/16:
>>> * changed the number
>>>=20
>>> 2013/07/11:
>>> * changed order in a file, added comment about a gap in ioctl number
>>>=20
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> include/uapi/linux/kvm.h | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>=20
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 99c2533..53c3f1f 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
>>> #define KVM_CAP_IRQ_XICS 92
>>> #define KVM_CAP_ARM_EL1_32BIT 93
>>> #define KVM_CAP_SPAPR_MULTITCE 94
>>> +#define KVM_CAP_SPAPR_TCE_IOMMU 95
>>>=20
>>> #ifdef KVM_CAP_IRQ_ROUTING
>>>=20
>>> @@ -933,6 +934,9 @@ struct kvm_s390_ucas_mapping {
>>> #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct =
kvm_arm_device_addr)
>>> /* Available with KVM_CAP_PPC_RTAS */
>>> #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct =
kvm_rtas_token_args)
>>> +/* 0xad and 0xaf are already taken */
>>=20
>> so 0xad and 0xaf are already taken? where?
>=20
> Mistype :( s/af/ae/
>=20
> They are taken in this file:
>=20
> 1016 /* VM is being stopped by host */
> 1017 #define KVM_KVMCLOCK_CTRL         _IO(KVMIO,   0xad)
> 1018 #define KVM_ARM_VCPU_INIT         _IOW(KVMIO,  0xae, struct =
kvm_vcpu_init)

Could you please make sure that whoever reads the comment in a year =
still knows where to look? :)

>=20
>>=20
>>> +/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
>>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct =
kvm_create_spapr_tce_iommu)
>>=20
>> and why is this one 0xaf then?
>=20
> Sorry, mistype. My bad. Sorry again.

No worries - just repost this single patch with the fixed comment.


Alex
