Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 2D282B7225
 for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2011 23:23:56 +1100 (EST)
Message-ID: <4EC8F158.8010706@redhat.com>
Date: Sun, 20 Nov 2011 14:23:52 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 01/11] KVM: PPC: Add memory-mapping support for PCI
 passthrough and emulation
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116225209.GB26985@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111116225209.GB26985@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2011 12:52 AM, Paul Mackerras wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> This adds support for adding PCI device I/O regions to the guest memory
> map, and for trapping guest accesses to emulated MMIO regions and
> delivering them to qemu for MMIO emulation.  To trap guest accesses to
> emulated MMIO regions, we reserve key 31 for the hypervisor's use and
> set the VPM1 bit in LPCR, which sends all page faults to the host.
> Any page fault that is not a key fault gets reflected immediately to the
> guest.  We set HPTEs for emulated MMIO regions to have key = 31, and
> don't allow the guest to create HPTEs with key = 31.  Any page fault
> that is a key fault with key = 31 is then a candidate for MMIO
> emulation and thus gets sent up to qemu.  We also load the instruction
> that caused the fault for use later when qemu has done the emulation.
>
> [paulus@samba.org: Cleaned up, moved kvmppc_book3s_hv_emulate_mmio()
>  to book3s_64_mmu_hv.c]
>
>
> +	/*
> +	 * XXX WARNING: We do not know for sure whether the instruction we just
> +	 * read from memory is the same that caused the fault in the first
> +	 * place. We don't have a problem with the guest shooting itself in
> +	 * the foot that way, however we must be careful that we enforce
> +	 * the write permission based on the instruction we are actually
> +	 * emulating, not based on dsisr. Unfortunately, the KVM code for
> +	 * instruction emulation isn't smart enough for that to work
> +	 * so right now we just do it badly and racily, but that will need
> +	 * fixing
> +	 */
> +

Ouch, I assume this will be fixed before merging?

>  }
>  
>  int kvmppc_core_prepare_memory_region(struct kvm *kvm,
> -				struct kvm_userspace_memory_region *mem)
> +				      struct kvm_memory_slot *memslot,
> +				      struct kvm_userspace_memory_region *mem)
>  {
>  	unsigned long psize, porder;
>  	unsigned long i, npages, totalpages;
>  	unsigned long pg_ix;
>  	struct kvmppc_pginfo *pginfo;
> -	unsigned long hva;
>  	struct kvmppc_rma_info *ri = NULL;
> +	struct vm_area_struct *vma;
>  	struct page *page;
> +	unsigned long hva;
> +
> +	/*
> +	 * This could be an attempt at adding memory or it could be MMIO
> +	 * pass-through. We need to treat them differently but the only
> +	 * way for us to know what it is is to look at the VMA and play
> +	 * guess work so let's just do that
> +	 */

There is no "the VMA".  There could be multiple VMAs, or none (with the
mmap() coming afterwards).  You could do all the checks you want here,
only to have host userspace remap it under your feet.  This needs to be
done on a per-page basis at fault time.

Please see the corresponding x86 code (warning: convoluted), which has a
similar problem (though I have no idea if you can use a similar solution).

> +
> +		/*
> +		 * We require read & write permission as we cannot yet
> +		 * enforce guest read-only protection or no access.
> +		 */
> +		if ((vma->vm_flags & (VM_READ | VM_WRITE)) !=
> +		    (VM_READ | VM_WRITE))
> +			goto err_unlock;

This, too, must be done at get_user_pages() time.

What happens if mmu notifiers tell you to write protect a page?

>  void kvm_arch_commit_memory_region(struct kvm *kvm,
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index c107fae..774b04d 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -105,6 +105,9 @@ struct kvm_userspace_memory_region {
>  #define KVM_MEM_LOG_DIRTY_PAGES  1UL
>  #define KVM_MEMSLOT_INVALID      (1UL << 1)
>  
> +/* Kernel internal use */
> +#define KVM_MEMSLOT_IO		 (1UL << 31)
> +

Please define it internally then (and leave a comment so we don't
overlap it).

-- 
error compiling committee.c: too many arguments to function
