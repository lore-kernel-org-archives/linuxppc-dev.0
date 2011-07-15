Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4AC21007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 20:23:56 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Shan Hai <haishan.bai@gmail.com>
In-Reply-To: <1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 12:23:38 +0200
Message-ID: <1310725418.2586.309.camel@twins>
Mime-Version: 1.0
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-15 at 16:07 +0800, Shan Hai wrote:
> The kernel has no write permission on COW pages by default on e500 core, =
this
> will cause endless loop in futex_lock_pi, because futex code assumes the =
kernel
> has write permission on COW pages. Grant write permission to the kernel o=
n COW
> pages when access violation page fault occurs.
>=20
> Signed-off-by: Shan Hai <haishan.bai@gmail.com>
> ---
>  arch/powerpc/include/asm/futex.h |   11 ++++++++++-
>  arch/powerpc/include/asm/tlb.h   |   25 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/=
futex.h
> index c94e4a3..54c3e74 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -8,6 +8,7 @@
>  #include <asm/errno.h>
>  #include <asm/synch.h>
>  #include <asm/asm-compat.h>
> +#include <asm/tlb.h>
> =20
>  #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
>    __asm__ __volatile ( \
> @@ -113,7 +114,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user =
*uaddr,
>          : "cc", "memory");
> =20
>  	*uval =3D prev;
> -        return ret;
> +
> +	/* Futex assumes the kernel has permission to write to
> +	 * COW pages, grant the kernel write permission on COW
> +	 * pages because it has none by default.
> +	 */
> +	if (ret =3D=3D -EFAULT)
> +		__tlb_fixup_write_permission(current->mm, (unsigned long)uaddr);
> +
> +	return ret;
>  }
> =20
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tl=
b.h
> index e2b428b..3863c6a 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -45,5 +45,30 @@ static inline void __tlb_remove_tlb_entry(struct mmu_g=
ather *tlb, pte_t *ptep,
>  #endif
>  }
> =20
> +/* Grant write permission to the kernel on a page. */
> +static inline void __tlb_fixup_write_permission(struct mm_struct *mm,
> +						unsigned long address)
> +{
> +#if defined(CONFIG_FSL_BOOKE)
> +	/* Grant write permission to the kernel on a page by setting TLB.SW
> +	 * bit, the bit setting operation is tricky here, calling
> +	 * handle_mm_fault with FAULT_FLAG_WRITE causes _PAGE_DIRTY bit of
> +	 * the pte to be set, the _PAGE_DIRTY of the pte is translated into
> +	 * TLB.SW on Powerpc e500 core.
> +	 */
> +
> +	struct vm_area_struct *vma;
> +
> +	vma =3D find_vma(mm, address);

Uhm, find_vma() needs mmap_sem, and futex_atomic_cmpxchg_inatomic() is
most certainly not called with that lock held.

> +	if (likely(vma)) {
> +		/* only fixup present page */
> +		if (follow_page(vma, address, FOLL_WRITE)) {
> +			handle_mm_fault(mm, vma, address, FAULT_FLAG_WRITE);

So how can this toggle your sw dirty/young tracking, that's pretty much
what gup(.write=3D1) does too!

> +			flush_tlb_page(vma, address);
> +		}
> +	}
> +#endif
> +}
> +
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_POWERPC_TLB_H */
