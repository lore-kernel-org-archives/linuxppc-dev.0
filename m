Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 42B082C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 03:06:08 +1000 (EST)
Message-ID: <51DC42FC.8050206@suse.de>
Date: Tue, 09 Jul 2013 19:06:04 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 7/8] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373123227-22969-8-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 07/06/2013 05:07 PM, Alexey Kardashevskiy wrote:
> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> and H_STUFF_TCE requests without passing them to QEMU, which saves time
> on switching to QEMU and back.
>
> Both real and virtual modes are supported. First the kernel tries to
> handle a TCE request in the real mode, if failed it passes it to
> the virtual mode to complete the operation. If it a virtual mode
> handler fails, a request is passed to the user mode.
>
> This adds a new KVM_CAP_SPAPR_TCE_IOMMU ioctl to associate
> a virtual PCI bus ID (LIOBN) with an IOMMU group which enables
> in-kernel handling of IOMMU map/unmap. The external user API support
> in VFIO is required.
>
> Tests show that this patch increases transmission speed from 220MB/s
> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>
> Signed-off-by: Paul Mackerras<paulus@samba.org>
> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
>
> ---
>
> Changes:
> 2013/07/06:
> * added realmode arch_spin_lock to protect TCE table from races
> in real and virtual modes
> * POWERPC IOMMU API is changed to support real mode
> * iommu_take_ownership and iommu_release_ownership are protected by
> iommu_table's locks
> * VFIO external user API use rewritten
> * multiple small fixes
>
> 2013/06/27:
> * tce_list page is referenced now in order to protect it from accident
> invalidation during H_PUT_TCE_INDIRECT execution
> * added use of the external user VFIO API
>
> 2013/06/05:
> * changed capability number
> * changed ioctl number
> * update the doc article number
>
> 2013/05/20:
> * removed get_user() from real mode handlers
> * kvm_vcpu_arch::tce_tmp usage extended. Now real mode handler puts there
> translated TCEs, tries realmode_get_page() on those and if it fails, it
> passes control over the virtual mode handler which tries to finish
> the request handling
> * kvmppc_lookup_pte() now does realmode_get_page() protected by BUSY bit
> on a page
> * The only reason to pass the request to user mode now is when the user mode
> did not register TCE table in the kernel, in all other cases the virtual mode
> handler is expected to do the job
>
> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
> ---
>   Documentation/virtual/kvm/api.txt   |  26 ++++
>   arch/powerpc/include/asm/iommu.h    |   9 +-
>   arch/powerpc/include/asm/kvm_host.h |   3 +
>   arch/powerpc/include/asm/kvm_ppc.h  |   2 +
>   arch/powerpc/include/uapi/asm/kvm.h |   7 +
>   arch/powerpc/kernel/iommu.c         | 196 +++++++++++++++--------
>   arch/powerpc/kvm/book3s_64_vio.c    | 299 +++++++++++++++++++++++++++++++++++-
>   arch/powerpc/kvm/book3s_64_vio_hv.c | 129 ++++++++++++++++
>   arch/powerpc/kvm/powerpc.c          |  12 ++
>   9 files changed, 609 insertions(+), 74 deletions(-)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 762c703..01b0dc2 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2387,6 +2387,32 @@ slows operations a lot.
>   Unlike other capabilities of this section, this one is always enabled.
>
>
> +4.87 KVM_CREATE_SPAPR_TCE_IOMMU
> +
> +Capability: KVM_CAP_SPAPR_TCE_IOMMU
> +Architectures: powerpc
> +Type: vm ioctl
> +Parameters: struct kvm_create_spapr_tce_iommu (in)
> +Returns: 0 on success, -1 on error
> +
> +struct kvm_create_spapr_tce_iommu {
> +	__u64 liobn;
> +	__u32 iommu_id;
> +	__u32 flags;

Your documentation is out of sync.

Please also split this patch up. It's too long for review.


Alex
