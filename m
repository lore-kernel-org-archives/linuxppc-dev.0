Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7FD12C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 10:51:14 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id q10so5562363pdj.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:51:11 -0700 (PDT)
Message-ID: <521D4977.7060803@ozlabs.ru>
Date: Wed, 28 Aug 2013 10:51:03 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
References: <1376552966-8529-1-git-send-email-aik@ozlabs.ru>
 <20130827075600.GE22899@redhat.com> <521C666A.3020508@ozlabs.ru>
 <20130827105832.GH22899@redhat.com>
In-Reply-To: <20130827105832.GH22899@redhat.com>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2013 08:58 PM, Gleb Natapov wrote:
> On Tue, Aug 27, 2013 at 06:42:18PM +1000, Alexey Kardashevskiy wrote:
>> On 08/27/2013 05:56 PM, Gleb Natapov wrote:
>>> On Thu, Aug 15, 2013 at 05:49:26PM +1000, Alexey Kardashevskiy wrote:
>>>> This is to reserve a capablity number for upcoming support
>>>> of VFIO-IOMMU DMA operations in real mode.
>>>>
>>>> The last ioctl in the group which KVM_CREATE_SPAPR_TCE_IOMMU is added to
>>>> is 0xac, the next two numbers are taken - 0xad for KVM_KVMCLOCK_CTRL and
>>> 0xac was also taken by KVM_SET_ONE_REG :(
>>>
>>>> 0xae for KVM_ARM_VCPU_INIT. So the KVM_CREATE_SPAPR_TCE_IOMMU ioclt gets
>>>> 0xaf.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>
>>>> ---
>>>> Changes:
>>>> 2013/08/15 v8:
>>>> * fixed comment again
>>>>
>>>> 2013/08/15:
>>>> * fixed mistype in comments
>>>> * fixed commit message which says what uses ioctls 0xad and 0xae
>>>>
>>>> 2013/07/16:
>>>> * changed the number
>>>>
>>>> 2013/07/11:
>>>> * changed order in a file, added comment about a gap in ioctl number
>>>> ---
>>>>  include/uapi/linux/kvm.h | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>> index 99c2533..bd94127 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
>>>>  #define KVM_CAP_IRQ_XICS 92
>>>>  #define KVM_CAP_ARM_EL1_32BIT 93
>>>>  #define KVM_CAP_SPAPR_MULTITCE 94
>>>> +#define KVM_CAP_SPAPR_TCE_IOMMU 95
>>>>  
>>>>  #ifdef KVM_CAP_IRQ_ROUTING
>>>>  
>>>> @@ -933,6 +934,11 @@ struct kvm_s390_ucas_mapping {
>>>>  #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
>>>>  /* Available with KVM_CAP_PPC_RTAS */
>>>>  #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
>>>> +/* 0xad is taken by KVM_KVMCLOCK_CTRL */
>>>> +/* 0xae is taken by KVM_ARM_VCPU_INIT */
>>>> +/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
>>>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, \
>>>> +					struct kvm_create_spapr_tce_iommu)
>>>>  
>>> Why not use KVM_CREATE_DEVICE API for that?
>>
>>
>> Because when I came up with my ioctl first time, it was not in upstream and
>> since then nobody pointed me to this new ioctl :)
> Sorry about that :(. The ioctl exists for a while now, but with v8 patch I
> imaging your patch series predates it.

The ioctl I made up is basically a copy of KVM_CREATE_SPAPR_TCE which does
the same thing for emulated devices and it is there for quite a while but
it is not really extensible. And these two ioctls share some bits of code.
Now we will have 2 pieces of code which do almost the same thing but in a
different way. Kinda sucks :(

>> So my stuff is not going to upstream again. Heh. Ok. I'll implement it.
>>
> Thanks! Should I keep KVM_CAP_SPAPR_MULTITCE capability patch or can I
> drop it for now?

Please keep it, it is unrelated to the IOMMU-VFIO thing.



-- 
Alexey
