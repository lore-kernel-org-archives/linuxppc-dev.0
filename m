Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD60F1A0C62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 10:45:52 +1100 (AEDT)
Date: Mon, 25 Jan 2016 10:46:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 2/6] KVM: PPC: Use RCU for arch.spapr_tce_tables
Message-ID: <20160124234644.GB27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q/d9vTEvvdeKbPNw"
In-Reply-To: <1453361977-19589-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--q/d9vTEvvdeKbPNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 06:39:33PM +1100, Alexey Kardashevskiy wrote:
> At the moment spapr_tce_tables is not protected against races.

That's not really true - it's protected by the kvm->lock mutex.

> This makes
> use of RCU-variants of list helpers. As some bits are executed in real
> mode, this makes use of just introduced list_for_each_entry_rcu_notrace().
>=20
> This converts release_spapr_tce_table() to a RCU scheduled handler.

The change itself is fine, though.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_host.h |  1 +
>  arch/powerpc/kvm/book3s.c           |  2 +-
>  arch/powerpc/kvm/book3s_64_vio.c    | 20 +++++++++++---------
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 271fefb..c7ee696 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -184,6 +184,7 @@ struct kvmppc_spapr_tce_table {
>  	struct kvm *kvm;
>  	u64 liobn;
>  	u32 window_size;
> +	struct rcu_head rcu;
>  	struct page *pages[0];
>  };
> =20
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 638c6d9..b34220d 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -807,7 +807,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
>  {
> =20
>  #ifdef CONFIG_PPC64
> -	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
> +	INIT_LIST_HEAD_RCU(&kvm->arch.spapr_tce_tables);
>  	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
>  #endif
> =20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 54cf9bc..9526c34 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -45,19 +45,16 @@ static long kvmppc_stt_npages(unsigned long window_si=
ze)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
> =20
> -static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
> +static void release_spapr_tce_table(struct rcu_head *head)
>  {
> -	struct kvm *kvm =3D stt->kvm;
> +	struct kvmppc_spapr_tce_table *stt =3D container_of(head,
> +			struct kvmppc_spapr_tce_table, rcu);
>  	int i;
> =20
> -	mutex_lock(&kvm->lock);
> -	list_del(&stt->list);
>  	for (i =3D 0; i < kvmppc_stt_npages(stt->window_size); i++)
>  		__free_page(stt->pages[i]);
> +
>  	kfree(stt);
> -	mutex_unlock(&kvm->lock);
> -
> -	kvm_put_kvm(kvm);
>  }
> =20
>  static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fau=
lt *vmf)
> @@ -88,7 +85,12 @@ static int kvm_spapr_tce_release(struct inode *inode, =
struct file *filp)
>  {
>  	struct kvmppc_spapr_tce_table *stt =3D filp->private_data;
> =20
> -	release_spapr_tce_table(stt);
> +	list_del_rcu(&stt->list);
> +
> +	kvm_put_kvm(stt->kvm);
> +
> +	call_rcu(&stt->rcu, release_spapr_tce_table);
> +
>  	return 0;
>  }
> =20
> @@ -131,7 +133,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	kvm_get_kvm(kvm);
> =20
>  	mutex_lock(&kvm->lock);
> -	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> =20
>  	mutex_unlock(&kvm->lock);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q/d9vTEvvdeKbPNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpWJkAAoJEGw4ysog2bOSzA0P/Aj2A249rQ+E1Lh/kkYA//MD
VGSOTlL4OfQTN5AuJnh0nRlVcOsxSD11kTvYPDHy+pUo/kIAdcu4a+drGgOxvv0P
gzWGylRobufANC0Sk+4GsU6vq9JlYJfzOY9rNwniMIvWmynvlgS29ECMpJurp9Wu
5Zeei+NXApQpQwJb7WjYaG9WVyS1nV2TEkJ+Tn9H8mh7cp5gBvHJ5Kcchtkvb2xf
U7YMN5crjP52ODx5J+Xr1aC/VGIvx+CBkvf0zAtHfZ+Ng/mvHzOSOI8bCEzHdAMM
jKZgKKwRZ7gwt7s3/ygiucPuZ7YLtNZI7MkhuiGvaIZyyMTs2IaktnsPG9BsWwv7
CdTYh2FRP51XCxNXHqOivbyNOf/KdhdOpWYeJvOHUpklSi1hlEwpGVpifcx3r1k4
E2vou4foKwaIWgYJV22vMLwz6GrrabwkJbwyXaikvo+P5fVewaff9feiPiFlNp+/
YdD549fJH4Fe2gugxujvN8KgNcoy/6CWqjtYKofwQ6cxK0G2hDKiQWq5D29+qxS3
ygoCojQ8qiHdSaubnwSS7UeuEi0S/t3QRv0Pu6eWgIOpIBqiGhB1+7X1i/NNhLO/
7mqxgAjaEH/Rlh3cj6d38CJoT4m7b74HTCsuBV3uIj0b/44eJbcMpNZQhqlRCbzK
k5PLCyvOQD+PezeF5NcM
=lxmv
-----END PGP SIGNATURE-----

--q/d9vTEvvdeKbPNw--
