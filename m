Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFB401A011D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:31:00 +1100 (AEDT)
Date: Mon, 7 Mar 2016 16:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 2/9] powerpc/mmu: Add real mode support for IOMMU
 preregistered memory
Message-ID: <20160307053055.GK22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
In-Reply-To: <1457322077-26640-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 02:41:10PM +1100, Alexey Kardashevskiy wrote:
> This makes mm_iommu_lookup() able to work in realmode by replacing
> list_for_each_entry_rcu() (which can do debug stuff which can fail in
> real mode) with list_for_each_entry_lockless().
>=20
> This adds realmode version of mm_iommu_ua_to_hpa() which adds
> explicit vmalloc'd-to-linear address conversion.
> Unlike mm_iommu_ua_to_hpa(), mm_iommu_rm_ua_to_hpa() can fail.
>=20
> This changes mm_iommu_preregistered() to receive @mm as in real mode
> @current does not always have a correct pointer.

So, I'd generally expect a parameter called @mm to be an mm_struct *,
not a mm_context_t.

>=20
> This adds realmode version of mm_iommu_lookup() which receives @mm
> (for the same reason as for mm_iommu_preregistered()) and uses
> lockless version of list_for_each_entry_rcu().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  arch/powerpc/include/asm/mmu_context.h |  6 ++++-
>  arch/powerpc/mm/mmu_context_iommu.c    | 45 ++++++++++++++++++++++++++++=
++----
>  2 files changed, 45 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 878c277..3ba652a 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -18,7 +18,7 @@ extern void destroy_context(struct mm_struct *mm);
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  struct mm_iommu_table_group_mem_t;
> =20
> -extern bool mm_iommu_preregistered(void);
> +extern bool mm_iommu_preregistered(mm_context_t *mm);
>  extern long mm_iommu_get(unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
>  extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> @@ -26,10 +26,14 @@ extern void mm_iommu_init(mm_context_t *ctx);
>  extern void mm_iommu_cleanup(mm_context_t *ctx);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long =
ua,
>  		unsigned long size);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(mm_context_=
t *mm,
> +		unsigned long ua, unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
>  		unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned long *hpa);
> +extern long mm_iommu_rm_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index da6a216..aa1565d 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -63,12 +63,9 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct=
 *mm,
>  	return ret;
>  }
> =20
> -bool mm_iommu_preregistered(void)
> +bool mm_iommu_preregistered(mm_context_t *mm)
>  {
> -	if (!current || !current->mm)
> -		return false;
> -
> -	return !list_empty(&current->mm->context.iommu_group_mem_list);
> +	return !list_empty(&mm->iommu_group_mem_list);
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> =20
> @@ -231,6 +228,24 @@ unlock_exit:
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_put);
> =20
> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(mm_context_t *mm,
> +		unsigned long ua, unsigned long size)
> +{
> +	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;

I think you could do with a comment here explaining why the lockless
traversal is safe.

> +	list_for_each_entry_lockless(mem, &mm->iommu_group_mem_list, next) {
> +		if ((mem->ua <=3D ua) &&
> +				(ua + size <=3D mem->ua +
> +				 (mem->entries << PAGE_SHIFT))) {
> +			ret =3D mem;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_lookup_rm);
> +
>  struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
>  		unsigned long size)
>  {
> @@ -284,6 +299,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_=
mem_t *mem,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
> +long mm_iommu_rm_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa)
> +{
> +	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> +	void *va =3D &mem->hpas[entry];
> +	unsigned long *ra;
> +
> +	if (entry >=3D mem->entries)
> +		return -EFAULT;
> +
> +	ra =3D (void *) vmalloc_to_phys(va);
> +	if (!ra)
> +		return -EFAULT;
> +
> +	*hpa =3D *ra | (ua & ~PAGE_MASK);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_rm_ua_to_hpa);
> +
>  long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	if (atomic64_inc_not_zero(&mem->mapped))

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3RIPAAoJEGw4ysog2bOStSsQAI+rrWq0m1b3h+LUedfjM7Gb
plIuTYTBsMNp3fQf54ArNdiqnWs0A1zdO+eQMPp9NG8HmEKOLTsiPXKsWH76nToL
zyt7+LNHWNVDAoih1HzHCFfxj/5LJuRbJ84h8mIZTdz+edg4GiilGDTKCviZkh5E
RbUfGBiwOZdregxEJRvaVweDIUxbyZwCWSHCRudisVuGvmeHdEiLL6rBc3UWMh3f
nAcbEORomj9JuUDeeBeQDcWJHSWe89YGiD4FGoMjYIl4M4sWm0P26U86DsjDCYxv
tVCH9zPo/Lrdg0ht1YNCaFf8F/gVogTSOwdhBoEbF7tPMtX8iBaHKp6fP5cP27+n
aCX0cQ9UVLxak9W1k1c6CHHDp7DSZo7s0o0zVvdI9knzPJJO2J6dOzweAE7jQ66R
N9fsFg0kF4gJOKXGkXpmroKQSYXC6N7cgv9QuzM3xNztqKM6E2/KLbx/WktCKpqw
R6zkSaX8zmy8icNDSxlh0W4hOlM0ciP2jkH8Qw+/1ClxTLjlQCTxVjoDUV4Wla8o
ELmmdaDj0/PQvOguSInm1ItjXESljHrN9hFWBgmN4NEvCghYfBGVlIvzjIvZaBVD
VmW/CGKqCsPwdgomU5rCw7xW5LSenkuiYntK64CzXru4/3cfnuvg2OL3/CHQ0OAj
dS51CCjm43Ivp9EXnebV
=TWB1
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
