Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AED242C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 18:42:28 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id lb1so4514163pab.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 01:42:26 -0700 (PDT)
Message-ID: <521C666A.3020508@ozlabs.ru>
Date: Tue, 27 Aug 2013 18:42:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
References: <1376552966-8529-1-git-send-email-aik@ozlabs.ru>
 <20130827075600.GE22899@redhat.com>
In-Reply-To: <20130827075600.GE22899@redhat.com>
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

On 08/27/2013 05:56 PM, Gleb Natapov wrote:
> On Thu, Aug 15, 2013 at 05:49:26PM +1000, Alexey Kardashevskiy wrote:
>> This is to reserve a capablity number for upcoming support
>> of VFIO-IOMMU DMA operations in real mode.
>>
>> The last ioctl in the group which KVM_CREATE_SPAPR_TCE_IOMMU is added to
>> is 0xac, the next two numbers are taken - 0xad for KVM_KVMCLOCK_CTRL and
> 0xac was also taken by KVM_SET_ONE_REG :(
> 
>> 0xae for KVM_ARM_VCPU_INIT. So the KVM_CREATE_SPAPR_TCE_IOMMU ioclt gets
>> 0xaf.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> ---
>> Changes:
>> 2013/08/15 v8:
>> * fixed comment again
>>
>> 2013/08/15:
>> * fixed mistype in comments
>> * fixed commit message which says what uses ioctls 0xad and 0xae
>>
>> 2013/07/16:
>> * changed the number
>>
>> 2013/07/11:
>> * changed order in a file, added comment about a gap in ioctl number
>> ---
>>  include/uapi/linux/kvm.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 99c2533..bd94127 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
>>  #define KVM_CAP_IRQ_XICS 92
>>  #define KVM_CAP_ARM_EL1_32BIT 93
>>  #define KVM_CAP_SPAPR_MULTITCE 94
>> +#define KVM_CAP_SPAPR_TCE_IOMMU 95
>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
>> @@ -933,6 +934,11 @@ struct kvm_s390_ucas_mapping {
>>  #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
>>  /* Available with KVM_CAP_PPC_RTAS */
>>  #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
>> +/* 0xad is taken by KVM_KVMCLOCK_CTRL */
>> +/* 0xae is taken by KVM_ARM_VCPU_INIT */
>> +/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, \
>> +					struct kvm_create_spapr_tce_iommu)
>>  
> Why not use KVM_CREATE_DEVICE API for that?


Because when I came up with my ioctl first time, it was not in upstream and
since then nobody pointed me to this new ioctl :)
So my stuff is not going to upstream again. Heh. Ok. I'll implement it.


> 
>>  /* ioctl for vm fd */
>>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)


-- 
Alexey
