Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW52y42lGzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 16:16:10 +1000 (AEST)
Date: Mon, 14 Aug 2017 14:52:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 1/8] powerpc/xive: introduce a common routine
 xive_queue_page_alloc()
Message-ID: <20170814045215.GH3452@umbus.fritz.box>
References: <20170811142341.22715-1-clg@kaod.org>
 <20170811142341.22715-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
In-Reply-To: <20170811142341.22715-2-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 04:23:34PM +0200, C=E9dric Le Goater wrote:
> This routine will be used in the spapr backend. Also introduce a short
> xive_alloc_order() helper.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/sysdev/xive/common.c        | 16 ++++++++++++++++
>  arch/powerpc/sysdev/xive/native.c        | 16 +++++-----------
>  arch/powerpc/sysdev/xive/xive-internal.h |  6 ++++++
>  3 files changed, 27 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 6e0c9dee724f..26999ceae20e 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1424,6 +1424,22 @@ bool xive_core_init(const struct xive_ops *ops, vo=
id __iomem *area, u32 offset,
>  	return true;
>  }
> =20
> +__be32 *xive_queue_page_alloc(unsigned int cpu, u32 queue_shift)
> +{
> +	unsigned int alloc_order;
> +	struct page *pages;
> +	__be32 *qpage;
> +
> +	alloc_order =3D xive_alloc_order(queue_shift);
> +	pages =3D alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +	qpage =3D (__be32 *)page_address(pages);
> +	memset(qpage, 0, 1 << queue_shift);
> +
> +	return qpage;
> +}
> +
>  static int __init xive_off(char *arg)
>  {
>  	xive_cmdline_disabled =3D true;
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive=
/native.c
> index 0f95476b01f6..ef92a83090e1 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -202,17 +202,12 @@ EXPORT_SYMBOL_GPL(xive_native_disable_queue);
>  static int xive_native_setup_queue(unsigned int cpu, struct xive_cpu *xc=
, u8 prio)
>  {
>  	struct xive_q *q =3D &xc->queue[prio];
> -	unsigned int alloc_order;
> -	struct page *pages;
>  	__be32 *qpage;
> =20
> -	alloc_order =3D (xive_queue_shift > PAGE_SHIFT) ?
> -		(xive_queue_shift - PAGE_SHIFT) : 0;
> -	pages =3D alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
> -	if (!pages)
> -		return -ENOMEM;
> -	qpage =3D (__be32 *)page_address(pages);
> -	memset(qpage, 0, 1 << xive_queue_shift);
> +	qpage =3D xive_queue_page_alloc(cpu, xive_queue_shift);
> +	if (IS_ERR(qpage))
> +		return PTR_ERR(qpage);
> +
>  	return xive_native_configure_queue(get_hard_smp_processor_id(cpu),
>  					   q, prio, qpage, xive_queue_shift, false);
>  }
> @@ -227,8 +222,7 @@ static void xive_native_cleanup_queue(unsigned int cp=
u, struct xive_cpu *xc, u8
>  	 * from an IPI and iounmap isn't safe
>  	 */
>  	__xive_native_disable_queue(get_hard_smp_processor_id(cpu), q, prio);
> -	alloc_order =3D (xive_queue_shift > PAGE_SHIFT) ?
> -		(xive_queue_shift - PAGE_SHIFT) : 0;
> +	alloc_order =3D xive_alloc_order(xive_queue_shift);
>  	free_pages((unsigned long)q->qpage, alloc_order);
>  	q->qpage =3D NULL;
>  }
> diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysd=
ev/xive/xive-internal.h
> index d07ef2d29caf..dd1e2022cce4 100644
> --- a/arch/powerpc/sysdev/xive/xive-internal.h
> +++ b/arch/powerpc/sysdev/xive/xive-internal.h
> @@ -56,6 +56,12 @@ struct xive_ops {
> =20
>  bool xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 =
offset,
>  		    u8 max_prio);
> +__be32 *xive_queue_page_alloc(unsigned int cpu, u32 queue_shift);
> +
> +static inline u32 xive_alloc_order(u32 queue_shift)
> +{
> +	return (queue_shift > PAGE_SHIFT) ? (queue_shift - PAGE_SHIFT) : 0;
> +}
> =20
>  extern bool xive_cmdline_disabled;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRLH4ACgkQbDjKyiDZ
s5Ig0Q//YjIxBjHd1PiHW2gjeoUAcICGJ7hAx4KMWwnbSX2fGOsxD2Qt1cz8GVOD
ISjccBWffT4QlNIo+VIQ6o+qh2WQ+HFwl0VtZnTCAdXw1Epjxx0x0o4RqCoSARXc
w3DqMk0FUp67ZzWiPZrI+sYODYiPUNHZLfjtKzR/jvUu6wZbehXwD54S0KSr+uRI
++xp079nUEpV6x5TPyWikcmyAI3z62zGJErkwUo3va6HXi9TQLe/DArVD8eT7oXE
fmlVwvBViLegPeJzJ+eHg0SUtCzMxKz11aHBVLAb1tu4B9llHWzJpo1AaFqEwub0
n4NwLeDRbZJitxmT8te355BKMfFVRoNpc8e0yw0aFvgpNscK5NA8Rgvp1B4W260r
2xwQF/C+YPnNsC55btlAEkz+i8G92y+uXjECbDAukFsf4612XRYY8vUXdBHV5GOU
wY6difQyAnNZr5IO9tqrxwq9qOTAgyFPflzq/ugykhwiEmwySO6LDH0vWmwwxvtl
X4jdm0Ml8goG7koaYMgjiemwX8NscGa041Egyl426CNu9QKBix1Qq96aWy+bqxY4
7W6oI5QXmtX2WNd3IrEOYHunxMiJii6xafIiH39209UTf4foAghGdnv/GMv8rQy3
9G+r8d1ptiRxxrSHElCXAT2aWjQGshobK26lVG1OvjVakbZLptM=
=FSvO
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
