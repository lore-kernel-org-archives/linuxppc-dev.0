Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 546472C010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 07:07:25 +1000 (EST)
Message-ID: <1367874436.2868.90.camel@ul30vt.home>
Subject: Re: [PATCH 2/5] KVM: PPC: iommu: Add missing
 kvm_iommu_map_pages/kvm_iommu_unmap_pages
From: Alex Williamson <alex.williamson@redhat.com>
To: aik@ozlabs.ru
Date: Mon, 06 May 2013 15:07:16 -0600
In-Reply-To: <51875a36.25ac440a.50d9.ffffe90d@mx.google.com>
References: <1367824921-27151-1-git-send-email-y>
 <51875a36.25ac440a.50d9.ffffe90d@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2013-05-06 at 17:21 +1000, aik@ozlabs.ru wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> The IOMMU API implements groups creating/deletion, device binding
> and IOMMU map/unmap operations.
> 
> The PowerPC implementation uses most of the API except map/unmap
> operations, which are implemented on POWER using hypercalls.
> 
> However, in order to link a kernel with the CONFIG_IOMMU_API enabled,
> the empty kvm_iommu_map_pages/kvm_iommu_unmap_pages have to be
> defined, so this defines them.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/include/asm/kvm_host.h |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index b6a047e..c025d91 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -603,4 +603,18 @@ struct kvm_vcpu_arch {
>  
>  #define __KVM_HAVE_ARCH_WQP
>  
> +#ifdef CONFIG_IOMMU_API
> +/* POWERPC does not use IOMMU API for mapping/unmapping */
> +static inline int kvm_iommu_map_pages(struct kvm *kvm,
> +		struct kvm_memory_slot *slot)
> +{
> +	return 0;
> +}
> +
> +static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
> +		struct kvm_memory_slot *slot)
> +{
> +}
> +#endif /* CONFIG_IOMMU_API */
> +
>  #endif /* __POWERPC_KVM_HOST_H__ */

This is no longer needed, Gleb applied my patch for 3.10 that make all
of KVM device assignment dependent on a build config option and the top
level kvm_host.h now includes this when that is not set.  Thanks,

Alex
