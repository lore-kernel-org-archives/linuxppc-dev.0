Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0QQZ3GxLzDvY9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 10:44:54 +1100 (AEDT)
Date: Fri, 21 Oct 2016 10:14:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 1/4] powerpc/iommu: Pass mm_struct to
 init/cleanup helpers
Message-ID: <20161020231402.GP11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpcCHpaCAbC4X43d"
In-Reply-To: <1476932630-45323-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LpcCHpaCAbC4X43d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 02:03:47PM +1100, Alexey Kardashevskiy wrote:
> We are going to get rid of @current references in mmu_context_boos3s64.c
> and cache mm_struct in the VFIO container. Since mm_context_t does not
> have reference counting, we will be using mm_struct which does have
> the reference counter.
>=20
> This changes mm_iommu_init/mm_iommu_cleanup to receive mm_struct rather
> than mm_context_t (which is embedded into mm).
>=20
> This should not cause any behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/mmu_context.h | 4 ++--
>  arch/powerpc/kernel/setup-common.c     | 2 +-
>  arch/powerpc/mm/mmu_context_book3s64.c | 4 ++--
>  arch/powerpc/mm/mmu_context_iommu.c    | 9 +++++----
>  4 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 5c45114..424844b 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -23,8 +23,8 @@ extern bool mm_iommu_preregistered(void);
>  extern long mm_iommu_get(unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
>  extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> -extern void mm_iommu_init(mm_context_t *ctx);
> -extern void mm_iommu_cleanup(mm_context_t *ctx);
> +extern void mm_iommu_init(struct mm_struct *mm);
> +extern void mm_iommu_cleanup(struct mm_struct *mm);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long =
ua,
>  		unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 270ee30..f516ac5 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -915,7 +915,7 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.context.pte_frag =3D NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&init_mm.context);
> +	mm_iommu_init(&init_mm);
>  #endif
>  	irqstack_early_init();
>  	exc_lvl_early_init();
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu=
_context_book3s64.c
> index b114f8b..ad82735 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, struct =
mm_struct *mm)
>  	mm->context.pte_frag =3D NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&mm->context);
> +	mm_iommu_init(mm);
>  #endif
>  	return 0;
>  }
> @@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct mm_s=
truct *mm)
>  void destroy_context(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_cleanup(&mm->context);
> +	mm_iommu_cleanup(mm);
>  #endif
> =20
>  #ifdef CONFIG_PPC_ICSWX
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index e0f1c33..ad2e575 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -373,16 +373,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_grou=
p_mem_t *mem)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
> =20
> -void mm_iommu_init(mm_context_t *ctx)
> +void mm_iommu_init(struct mm_struct *mm)
>  {
> -	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>  }
> =20
> -void mm_iommu_cleanup(mm_context_t *ctx)
> +void mm_iommu_cleanup(struct mm_struct *mm)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *tmp;
> =20
> -	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next) {
> +	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
> +			next) {
>  		list_del_rcu(&mem->next);
>  		mm_iommu_do_free(mem);
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpcCHpaCAbC4X43d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCU+4AAoJEGw4ysog2bOSnowQAJdU61aWwjv//cUYfGT15zDp
PiHAQy3Qulaib8KWZ7Mx924YUAwgUZeM59voExUjU9+TpWx0Tu8aPD10G+2XtYm/
w0W3KgyE1SKAqfssRPDw2+/xr8/QmW9k6dDUXmWOlmYMscatNCY7F/wh+Q3s2LxS
UgI6jWmvEkDamNFaSQVkmzSVoYW2V5H/DQnPhBFGjdKvTNvojy9zxgZIjLhNNyKO
2+i6sIWF9B45A+VPxbgd+u9zy5l4u5BG1/fsjVyjeuC6YRrQGni4GrMqZa0FEJvV
8X6ZMs/vNuIX+eThM3tCcSTOXRQLy/d760w17ahuaOt2NMGHwurGqVWb5a6ONXAl
eDzc3q3iGPl+0o4UuiW0e8ADDFVz7j6bgethNWYvPb9AB9TQKX6Q3xu5BDwZaMLi
ITsmHcpJhCUj0rZ9c8x7BU18zl51+MWhqZt5nqB4h/Coeu3oRZKHiII+PLGG3fPt
rV8cFLRtnMSSWXRQRf0WwbuWcYpgDGjDOVo/IXRiMiI9daO9fgHHFX3ERKx0F2Od
6lbuXzsPcLbI7wS2lX0lQsduOta2F4fujTL8XuxYm06AEaWUePQ9z/KgJg6QYSv1
6PrK48RRvo0/RiV97pWDcFhiq4AB02FsnrZ2tnDI0RnfFUq9iSa7MmAr0i3SJo3R
B+4B8/WVmPg10JmHIFjJ
=jLjA
-----END PGP SIGNATURE-----

--LpcCHpaCAbC4X43d--
