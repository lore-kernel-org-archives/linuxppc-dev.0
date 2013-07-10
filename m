Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4772C02BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 00:17:27 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id z10so6387113pdj.31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 07:17:24 -0700 (PDT)
Message-ID: <51DD6CED.6080001@ozlabs.ru>
Date: Thu, 11 Jul 2013 00:17:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/8] KVM: PPC: reserve a capability and ioctl numbers
 for realmode VFIO
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-3-git-send-email-aik@ozlabs.ru> <51DC2DDA.6040408@suse.de>
 <51DC9E32.8040109@ozlabs.ru> <E8E3A724-7045-4B8F-BE29-29BAB41D68C2@suse.de>
In-Reply-To: <E8E3A724-7045-4B8F-BE29-29BAB41D68C2@suse.de>
Content-Type: text/plain; charset=KOI8-R
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

On 07/10/2013 08:27 PM, Alexander Graf wrote:
> 
> On 10.07.2013, at 01:35, Alexey Kardashevskiy wrote:
> 
>> On 07/10/2013 01:35 AM, Alexander Graf wrote:
>>> On 06/27/2013 07:02 AM, Alexey Kardashevskiy wrote:
>>>> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
>>>> ---
>>>>  include/uapi/linux/kvm.h |    2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>> index 970b1f5..0865c01 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
>>>>  #define KVM_CAP_PPC_RTAS 91
>>>>  #define KVM_CAP_IRQ_XICS 92
>>>>  #define KVM_CAP_SPAPR_MULTITCE 93
>>>> +#define KVM_CAP_SPAPR_TCE_IOMMU 94
>>>>
>>>>  #ifdef KVM_CAP_IRQ_ROUTING
>>>>
>>>> @@ -923,6 +924,7 @@ struct kvm_s390_ucas_mapping {
>>>>  /* Available with KVM_CAP_PPC_ALLOC_HTAB */
>>>>  #define KVM_PPC_ALLOCATE_HTAB      _IOWR(KVMIO, 0xa7, __u32)
>>>>  #define KVM_CREATE_SPAPR_TCE      _IOW(KVMIO,  0xa8, struct
>>>> kvm_create_spapr_tce)
>>>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct
>>>> kvm_create_spapr_tce_iommu)
>>>
>>> Please order them by number.
>>
>> Oh. Again :( We have had this discussion with Scott Wood here already.
>> Where _exactly_ do you want me to put it?
> 
> 8 lines further down. With a comment saying when it's available. Also why is it af, not ad?


0xad and 0xae are taken.
Where should I have commented this? In the commit message? Or in the patch
itself?


>> Many sections, not really ordered. Thank you.
> 
> They should all be ordered inside of their own categories.


-- 
Alexey
