Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6YFB5986zDqRP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 01:13:18 +1100 (AEDT)
Subject: Re: [PATCH 03/11] KVM: PPC: Book3S HV: Move error code assignments in
 two functions
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
 <eb77a721-b771-65c0-83e6-a3e7120fa4ce@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04f75012-7453-e1b2-b004-857fde1b253e@redhat.com>
Date: Mon, 23 Jan 2017 15:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <eb77a721-b771-65c0-83e6-a3e7120fa4ce@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/01/2017 19:21, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Jan 2017 10:30:26 +0100
> 
> A local variable was set to an error code in a few cases before a concrete
> error situation was detected. Thus move the corresponding assignments into
> if branches to indicate a software failure there.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

NACK, current code uses consistent style.

Paolo

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8dcbe37a4dac..a93e1c4445da 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2967,15 +2967,17 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
>  
>  	mutex_lock(&kvm->slots_lock);
>  
> -	r = -EINVAL;
> -	if (log->slot >= KVM_USER_MEM_SLOTS)
> +	if (log->slot >= KVM_USER_MEM_SLOTS) {
> +		r = -EINVAL;
>  		goto out;
> +	}
>  
>  	slots = kvm_memslots(kvm);
>  	memslot = id_to_memslot(slots, log->slot);
> -	r = -ENOENT;
> -	if (!memslot->dirty_bitmap)
> +	if (!memslot->dirty_bitmap) {
> +		r = -ENOENT;
>  		goto out;
> +	}
>  
>  	n = kvm_dirty_bitmap_bytes(memslot);
>  	memset(memslot->dirty_bitmap, 0, n);
> @@ -2984,9 +2986,10 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
>  	if (r)
>  		goto out;
>  
> -	r = -EFAULT;
> -	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n))
> +	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n)) {
> +		r = -EFAULT;
>  		goto out;
> +	}
>  
>  	r = 0;
>  out:
> @@ -3127,9 +3130,10 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
>  	memslot = gfn_to_memslot(kvm, 0);
>  
>  	/* We must have some memory at 0 by now */
> -	err = -EINVAL;
> -	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
> +	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
> +		err = -EINVAL;
>  		goto out_srcu;
> +	}
>  
>  	/* Look up the VMA for the start of this memory slot */
>  	hva = memslot->userspace_addr;
> @@ -3144,10 +3148,11 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
>  	up_read(&current->mm->mmap_sem);
>  
>  	/* We can handle 4k, 64k or 16M pages in the VRMA */
> -	err = -EINVAL;
>  	if (!(psize == 0x1000 || psize == 0x10000 ||
> -	      psize == 0x1000000))
> +	      psize == 0x1000000)) {
> +		err = -EINVAL;
>  		goto out_srcu;
> +	}
>  
>  	senc = slb_pgsize_encoding(psize);
>  	kvm->arch.vrma_slb_v = senc | SLB_VSID_B_1T |
> 
