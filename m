Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68DBE1A0EE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 13:45:05 +1100 (AEDT)
Date: Tue, 8 Dec 2015 13:05:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 1/9] rcu: Define notrace version of
 list_for_each_entry_rcu
Message-ID: <20151208020532.GG20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
In-Reply-To: <1442314179-9706-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:31PM +1000, Alexey Kardashevskiy wrote:
> This defines list_for_each_entry_rcu_notrace and list_entry_rcu_notrace
> which use rcu_dereference_raw_notrace instead of rcu_dereference_raw.
> This allows using list_for_each_entry_rcu_notrace in real mode (MMU is of=
f).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/linux/rculist.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 17c6b1f..439c4d7 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -253,6 +253,25 @@ static inline void list_splice_init_rcu(struct list_=
head *list,
>  })
> =20
>  /**
> + * list_entry_rcu_notrace - get the struct for this entry
> + * @ptr:        the &struct list_head pointer.
> + * @type:       the type of the struct this is embedded in.
> + * @member:     the name of the list_struct within the struct.
> + *
> + * This primitive may safely run concurrently with the _rcu list-mutation
> + * primitives such as list_add_rcu() as long as it's guarded by rcu_read=
_lock().
> + *
> + * This is the same as list_entry_rcu() except that it does
> + * not do any RCU debugging or tracing.
> + */
> +#define list_entry_rcu_notrace(ptr, type, member) \
> +({ \
> +	typeof(*ptr) __rcu *__ptr =3D (typeof(*ptr) __rcu __force *)ptr; \
> +	container_of((typeof(ptr))rcu_dereference_raw_notrace(__ptr), \
> +			type, member); \
> +})
> +
> +/**
>   * Where are list_empty_rcu() and list_first_entry_rcu()?
>   *
>   * Implementing those functions following their counterparts list_empty(=
) and
> @@ -308,6 +327,25 @@ static inline void list_splice_init_rcu(struct list_=
head *list,
>  		pos =3D list_entry_rcu(pos->member.next, typeof(*pos), member))
> =20
>  /**
> + * list_for_each_entry_rcu_notrace - iterate over rcu list of given type
> + * @pos:	the type * to use as a loop cursor.
> + * @head:	the head for your list.
> + * @member:	the name of the list_struct within the struct.
> + *
> + * This list-traversal primitive may safely run concurrently with
> + * the _rcu list-mutation primitives such as list_add_rcu()
> + * as long as the traversal is guarded by rcu_read_lock().
> + *
> + * This is the same as list_for_each_entry_rcu() except that it does
> + * not do any RCU debugging or tracing.
> + */
> +#define list_for_each_entry_rcu_notrace(pos, head, member) \
> +	for (pos =3D list_entry_rcu_notrace((head)->next, typeof(*pos), member)=
; \
> +		&pos->member !=3D (head); \
> +		pos =3D list_entry_rcu_notrace(pos->member.next, typeof(*pos), \
> +				member))
> +
> +/**
>   * list_for_each_entry_continue_rcu - continue iteration over list of gi=
ven type
>   * @pos:	the type * to use as a loop cursor.
>   * @head:	the head for your list.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZjrsAAoJEGw4ysog2bOS47gQALfdRu0GbLSdf5hONFMEjILp
KMwpXp/b+iBmBLQUIyBtRBZcx0C+HQmqQKrhnjQOdJkCIjo8nHHtdkgAjEcIGz3J
kBhMj/l6pLYvmBFZZkqUxQYAcML5WxrCWJ2DPQv1B/5zyz7j4r4NxiDnkjQmY3AB
bYfwiPir4oE03EnlQjQFUH6gTrvirdidrxR1REdZvD3j9oUJoKd6DqhtcSR/WofQ
ma75s7WNGjP0mC4az4F11NZkPXjEQo+PbiX3+Zcxt5tgc4T8xNGy6cLcrF0owjBW
BAqyIJCtfC7XxbUnEuW09xLGjdYoNT7fdafWrkLSBHcGhhpbJh0mjnUmQSzXSuWP
85BEQQtXHLm3jFr3hbxB38z12hm83FKGQclvQrMykpyrk2yR55UNztrHcHGVrIBQ
WpDfi2KbcyMY9GUO2QdqlbHt1KyO3nlJd6IIYgBupz6+Ah5MoskSaA7BSRXQiAhL
Ik187q8IBG29uJzO5IQ9f+PjbnXoX2Vui+KuLNVUeP3pX7e/594aYnJbJGvICFwl
AqPee5IjDUYt5kdQKv1f7gNmvVmds7TNrAoRu1p8+DqUSiuQlUAjmsXuejxACoIY
M2KYdb1LP+8qEz2D+T43ftDyu5TcLBeY+tdoA/euGjggwzvgCdtC5De9H6hHb21u
ugC8+GTFXmEegJ3AOmXH
=oeJ3
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
