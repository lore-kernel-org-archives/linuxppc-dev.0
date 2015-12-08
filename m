Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DD271A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 20:05:55 +1100 (AEDT)
Date: Tue, 8 Dec 2015 16:18:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 5/9] KVM: PPC: Account TCE-containing pages in
 locked_vm
Message-ID: <20151208051838.GQ20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qnK4RqISe3HuYx1/"
In-Reply-To: <1442314179-9706-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qnK4RqISe3HuYx1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:35PM +1000, Alexey Kardashevskiy wrote:
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

Hmm.  Does it make sense to account for the descriptor struct itself?
I mean there are lots of little structures the kernel will allocate on
a process's behalf, and I don't think most of them get accounted
against locked vm.

> This does not change the amount of (de)allocated memory.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 51 ++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 9526c34..b70787d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -45,13 +45,56 @@ static long kvmppc_stt_npages(unsigned long window_si=
ze)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
> =20
> +static long kvmppc_account_memlimit(long npages, bool inc)
> +{
> +	long ret =3D 0;
> +	const long bytes =3D sizeof(struct kvmppc_spapr_tce_table) +
> +			(abs(npages) * sizeof(struct page *));
> +	const long stt_pages =3D ALIGN(bytes, PAGE_SIZE) / PAGE_SIZE;

Overflow checks might be useful here, I'm not sure.

> +
> +	if (!current || !current->mm)
> +		return ret; /* process exited */
> +
> +	npages +=3D stt_pages;
> +
> +	down_write(&current->mm->mmap_sem);
> +
> +	if (inc) {
> +		long locked, lock_limit;
> +
> +		locked =3D current->mm->locked_vm + npages;
> +		lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> +			ret =3D -ENOMEM;
> +		else
> +			current->mm->locked_vm +=3D npages;
> +	} else {
> +		if (npages > current->mm->locked_vm)

Should this be a WARN_ON?  It means something has gone wrong
previously in the accounting, doesn't it?

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
> +	long npages =3D kvmppc_stt_npages(stt->window_size);
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

--qnK4RqISe3HuYx1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZmguAAoJEGw4ysog2bOSbhQP/2ll/L7Y8B0jUkp5z+1IBuN5
wX/PIGBhCTZE/NUWd7/SeXnB3zgJbRVImXKb7UBwWiwBGms6Ee2YaSgmHzSWKBV7
sI3xYfR9bwJuuqMXlXzC/AYoCeUmUs7+iZORErlejmCUi3YCxJWI6QkDuMemHBE7
HKrwrA6GTPOihuOisoXR8jpVXP+XtvVhpA896DA8SarBGaa5qFeaRSP8YXfAy96m
+alasqhgOo1auB700deEncj2h4aHF6KbSKxV/laeLoQ8A893jEr6Jrqnl2vP2ACo
F29zNl1qa2YtTrkKhJT78qQIW7AYQmBPTmel32OEsAjlVsf7n09VJjToOKrrlePb
bBngwTy93+pqtl+dvLWO6YtnlHhfocO5sfT2Xz/sHfyE7qc9Y9gQdFaIXnlbLolw
vv5HQtS+0MqF+ZPJN38pWz96yucC0eJnIttp43/o4BqaygAB8usTrOuxF5m1KGFQ
ER8yxMAyJwIlJltclx3mmRGe83Yx1BuPJ9sTOMOhxDbhWgBkUhOrt5BpUiRR6lZZ
FFhc+lUub5E8waAutRkcCxpbtVLv7Vm3ZbJEitz/67jrqC2XVfeLtp3UE12iMXGq
LuGTFNdP2Da3rQqtEHPzByMjdFW6NT4S4SJphp46Tfij5anaxC6CSVgcQYTdpKVp
up964A3xbBvo/GL9y6L1
=mmnn
-----END PGP SIGNATURE-----

--qnK4RqISe3HuYx1/--
