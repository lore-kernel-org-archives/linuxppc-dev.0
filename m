Return-Path: <aik@ozlabs.ru>
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com
 [IPv6:2607:f8b0:400d:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 189592C011A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 10:49:57 +1000 (EST)
Received: by mail-qc0-f178.google.com with SMTP id l11so6882qcy.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 17:49:53 -0700 (PDT)
Message-ID: <51884FA8.6010400@ozlabs.ru>
Date: Tue, 07 May 2013 10:49:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/5] KVM: PPC: iommu: Add missing
 kvm_iommu_map_pages/kvm_iommu_unmap_pages
References: <1367824921-27151-1-git-send-email-y>
 <51875a36.25ac440a.50d9.ffffe90d@mx.google.com>
 <1367874436.2868.90.camel@ul30vt.home>
In-Reply-To: <1367874436.2868.90.camel@ul30vt.home>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2013 07:07 AM, Alex Williamson wrote:
> On Mon, 2013-05-06 at 17:21 +1000, aik@ozlabs.ru wrote:
>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> The IOMMU API implements groups creating/deletion, device binding
>> and IOMMU map/unmap operations.
>>
>> The PowerPC implementation uses most of the API except map/unmap
>> operations, which are implemented on POWER using hypercalls.
>>
>> However, in order to link a kernel with the CONFIG_IOMMU_API enabled,
>> the empty kvm_iommu_map_pages/kvm_iommu_unmap_pages have to be
>> defined, so this defines them.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Paul Mackerras <paulus@samba.org>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index b6a047e..c025d91 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -603,4 +603,18 @@ struct kvm_vcpu_arch {
>>  
>>  #define __KVM_HAVE_ARCH_WQP
>>  
>> +#ifdef CONFIG_IOMMU_API
>> +/* POWERPC does not use IOMMU API for mapping/unmapping */
>> +static inline int kvm_iommu_map_pages(struct kvm *kvm,
>> +		struct kvm_memory_slot *slot)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
>> +		struct kvm_memory_slot *slot)
>> +{
>> +}
>> +#endif /* CONFIG_IOMMU_API */
>> +
>>  #endif /* __POWERPC_KVM_HOST_H__ */
> 
> This is no longer needed, Gleb applied my patch for 3.10 that make all
> of KVM device assignment dependent on a build config option and the top
> level kvm_host.h now includes this when that is not set.  Thanks,

Cannot find it, could you point me please where it is on github or
git.kernel.org? Thanks.


-- 
Alexey
