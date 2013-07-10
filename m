Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E840B2C02BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 01:01:02 +1000 (EST)
Subject: Re: [PATCH 2/8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=koi8-r
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <51DD6CED.6080001@ozlabs.ru>
Date: Wed, 10 Jul 2013 17:00:55 +0200
Message-Id: <8E7675CE-6931-43B5-AD4F-B52EBE5D21B5@suse.de>
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-3-git-send-email-aik@ozlabs.ru> <51DC2DDA.6040408@suse.de>
 <51DC9E32.8040109@ozlabs.ru> <E8E3A724-7045-4B8F-BE29-29BAB41D68C2@suse.de>
 <51DD6CED.6080001@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.07.2013, at 16:17, Alexey Kardashevskiy wrote:

> On 07/10/2013 08:27 PM, Alexander Graf wrote:
>>=20
>> On 10.07.2013, at 01:35, Alexey Kardashevskiy wrote:
>>=20
>>> On 07/10/2013 01:35 AM, Alexander Graf wrote:
>>>> On 06/27/2013 07:02 AM, Alexey Kardashevskiy wrote:
>>>>> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
>>>>> ---
>>>>> include/uapi/linux/kvm.h |    2 ++
>>>>> 1 file changed, 2 insertions(+)
>>>>>=20
>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>> index 970b1f5..0865c01 100644
>>>>> --- a/include/uapi/linux/kvm.h
>>>>> +++ b/include/uapi/linux/kvm.h
>>>>> @@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
>>>>> #define KVM_CAP_PPC_RTAS 91
>>>>> #define KVM_CAP_IRQ_XICS 92
>>>>> #define KVM_CAP_SPAPR_MULTITCE 93
>>>>> +#define KVM_CAP_SPAPR_TCE_IOMMU 94
>>>>>=20
>>>>> #ifdef KVM_CAP_IRQ_ROUTING
>>>>>=20
>>>>> @@ -923,6 +924,7 @@ struct kvm_s390_ucas_mapping {
>>>>> /* Available with KVM_CAP_PPC_ALLOC_HTAB */
>>>>> #define KVM_PPC_ALLOCATE_HTAB      _IOWR(KVMIO, 0xa7, __u32)
>>>>> #define KVM_CREATE_SPAPR_TCE      _IOW(KVMIO,  0xa8, struct
>>>>> kvm_create_spapr_tce)
>>>>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct
>>>>> kvm_create_spapr_tce_iommu)
>>>>=20
>>>> Please order them by number.
>>>=20
>>> Oh. Again :( We have had this discussion with Scott Wood here =
already.
>>> Where _exactly_ do you want me to put it?
>>=20
>> 8 lines further down. With a comment saying when it's available. Also =
why is it af, not ad?
>=20
>=20
> 0xad and 0xae are taken.
> Where should I have commented this? In the commit message? Or in the =
patch
> itself?

Yeah, with a comment right in between 0xad and your 0xaf entry =
explaining the gap.


Alex

>=20
>=20
>>> Many sections, not really ordered. Thank you.
>>=20
>> They should all be ordered inside of their own categories.
>=20
>=20
> --=20
> Alexey
