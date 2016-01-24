Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B4BF1A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:43:11 +1100 (AEDT)
Date: Mon, 25 Jan 2016 10:57:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 3/6] KVM: PPC: Account TCE-containing pages in
 locked_vm
Message-ID: <20160124235714.GC27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5wdX5gfZV4kojQYf"
In-Reply-To: <1453361977-19589-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5wdX5gfZV4kojQYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 06:39:34PM +1100, Alexey Kardashevskiy wrote:
> At the moment pages used for TCE tables (in addition to pages addressed
> by TCEs) are not counted in locked_vm counter so a malicious userspace
> tool can call ioctl(KVM_CREATE_SPAPR_TCE) as many times as RLIMIT_NOFILE =
and
> lock a lot of memory.
>=20
> This adds counting for pages used for TCE tables.
>=20
> This counts the number of pages required for a table plus pages for
> the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.
>=20
> This changes release_spapr_tce_table() to store @npages on stack to
> avoid calling kvmppc_stt_npages() in the loop (tiny optimization,
> probably).
>=20
> This does not change the amount of (de)allocated memory.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * switched from long to unsigned long types
> * added WARN_ON_ONCE() in locked_vm decrement case
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 55 ++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 9526c34..ea498b4 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -39,19 +39,62 @@
> =20
>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> =20
> -static long kvmppc_stt_npages(unsigned long window_size)
> +static unsigned long kvmppc_stt_npages(unsigned long window_size)
>  {
>  	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
> =20
> +static long kvmppc_account_memlimit(unsigned long npages, bool inc)
> +{
> +	long ret =3D 0;
> +	const unsigned long bytes =3D sizeof(struct kvmppc_spapr_tce_table) +
> +			(npages * sizeof(struct page *));
> +	const unsigned long stt_pages =3D ALIGN(bytes, PAGE_SIZE) / PAGE_SIZE;

Urgh, this is made pretty hard to follow by the fact that in some
places npages / stt_pages refers to the number of pages occupied by
the actual TCE tables, and in other places to the number of pages
occupied by the overhead data structures.  Please use different (and
consistent) variables for the two things to make this clearer.

It also seems odd the calculation of the overhead pages is done here,
but the base number of pages is calculated in the caller, even though
both quantities come from the stt structure itself.

> +	if (!current || !current->mm)
> +		return ret; /* process exited */
> +
> +	npages +=3D stt_pages;
> +
> +	down_write(&current->mm->mmap_sem);
> +
> +	if (inc) {
> +		unsigned long locked, lock_limit;
> +
> +		locked =3D current->mm->locked_vm + npages;
> +		lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> +			ret =3D -ENOMEM;
> +		else
> +			current->mm->locked_vm +=3D npages;
> +	} else {
> +		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
> +			npages =3D current->mm->locked_vm;
> +
> +		current->mm->locked_vm -=3D npages;
> +	}
> +
> +	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
> +			inc ? '+' : '-',
> +			npages << PAGE_SHIFT,
> +			current->mm->locked_vm << PAGE_SHIFT,
> +			rlimit(RLIMIT_MEMLOCK),
> +			ret ? " - exceeded" : "");
> +
> +	up_write(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
>  static void release_spapr_tce_table(struct rcu_head *head)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
>  			struct kvmppc_spapr_tce_table, rcu);
>  	int i;
> +	unsigned long npages =3D kvmppc_stt_npages(stt->window_size);
> =20
> -	for (i =3D 0; i < kvmppc_stt_npages(stt->window_size); i++)
> +	for (i =3D 0; i < npages; i++)
>  		__free_page(stt->pages[i]);
> =20
>  	kfree(stt);
> @@ -89,6 +132,7 @@ static int kvm_spapr_tce_release(struct inode *inode, =
struct file *filp)
> =20
>  	kvm_put_kvm(stt->kvm);
> =20
> +	kvmppc_account_memlimit(kvmppc_stt_npages(stt->window_size), false);
>  	call_rcu(&stt->rcu, release_spapr_tce_table);
> =20
>  	return 0;
> @@ -103,7 +147,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				   struct kvm_create_spapr_tce *args)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
> -	long npages;
> +	unsigned long npages;
>  	int ret =3D -ENOMEM;
>  	int i;
> =20
> @@ -114,6 +158,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	}
> =20
>  	npages =3D kvmppc_stt_npages(args->window_size);
> +	ret =3D kvmppc_account_memlimit(npages, true);
> +	if (ret) {
> +		stt =3D NULL;
> +		goto fail;
> +	}
> =20
>  	stt =3D kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
>  		      GFP_KERNEL);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5wdX5gfZV4kojQYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpWTaAAoJEGw4ysog2bOSoWUP/2wnZv4b921aek0I2z41kh2w
X9qTZ57zsMW8mK7PIylhJLhVdtqcwIs0e0V7/YsJscTKES3NZZXjwhKEGauqXU4D
87DxA9WEzB/eYdLlci61cvHt1PazSueeYogT1XsTQZhq3RLZt5Br/5NL/sqDuqe7
T5fvxG4Vh+J1FBE5pQAxd8ye5073f5Yzv/ADovLZzBL+dIFIkXALkWC5/hFGKI/R
SW2mKV7ERN3wVZYrmtY+kdzoADiWnbOSTQFNfiUQoHCXBjO2+K1v3bNPdTr+d0Vh
SaiJve07cO8mv21yM3VQ3JCb6XgNT67sVUglnIySNiX0vUrY6bsOs8TpriTcNbkD
KD8zLry0sIXGa42leU/CQzD5RqRewB1yv6j+zcnKtTgqRKai8PminObVWSnYLxtM
5QcrNWws0vSyhVOB83garkc/Du0XfS+k7CPsGc3M8em6k3O4ma4Ymrx4kEzJO5ws
755l3PTZ4aAZYBzBHlrc6Ulc7sF0j+UXjNbZ8au2bFQKDGWd33EoGeFnl60UfVU1
SfyIGszBC/Ji7BNAPr+zSHRmbI8XvbdDgW7Xh0M/jDL5LT3cVXFs0E0A1JhHDUbG
dBiqYK8PtxPq+wFcWG0lzz+mNJDgrWLZI9iHdczV2viTghr/0/qLnXDAPeDUg4oj
OITrBbqPturqumK5cFOl
=mbcp
-----END PGP SIGNATURE-----

--5wdX5gfZV4kojQYf--
