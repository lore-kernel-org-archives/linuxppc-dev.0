Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9FD38DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 13:37:46 +1100 (EST)
Date: Tue, 25 Mar 2008 13:37:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [RFC][POWERPC] refactor dcr code
Message-Id: <20080325133737.21b8724d.sfr@canb.auug.org.au>
In-Reply-To: <20080324232835.A0AFA1B58093@mail17-dub.bigfish.com>
References: <20080324232835.A0AFA1B58093@mail17-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__25_Mar_2008_13_37_37_+1100_MwQNhyGqCbj/rC5W"
Cc: linuxppc-dev@ozlabs.org, git-dev@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__25_Mar_2008_13_37_37_+1100_MwQNhyGqCbj/rC5W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Just some trivial issues ...

On Mon, 24 Mar 2008 16:28:33 -0700 Stephen Neuendorffer <stephen.neuendorff=
er@xilinx.com> wrote:
>
> +++ b/arch/powerpc/sysdev/dcr.c
> @@ -23,6 +23,67 @@
>  #include <asm/prom.h>
>  #include <asm/dcr.h>
> =20
> +#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
> +
> +bool dcr_map_ok_generic(dcr_host_t host) {
> +	if(host.type =3D=3D INVALID) {
          ^
Space, please.

> +		return 0;
> +	} else if(host.type =3D=3D NATIVE) {

And again.  And more below.

> +		return dcr_map_ok_native(host.host.native);
> +	} else {
> +		return dcr_map_ok_mmio(host.host.mmio);
> +	}

You don't need the braces around each if/else clause. Again, more below.

> +dcr_host_t dcr_map_generic(struct device_node *dev, unsigned int dcr_n,
> +				 unsigned int dcr_c) {
> +	dcr_host_t host;
> +	const char *prop =3D of_get_property(dev, "dcr-access-method", NULL);
> +       	if(!strcmp(prop, "native")) {

Indentation.  We also usually separate declarations from code with a a
blank line.

> -dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
> +dcr_host_mmio_t dcr_map_mmio(struct device_node *dev, unsigned int dcr_n,
>  		   unsigned int dcr_c)
>  {
> -	dcr_host_t ret =3D { .token =3D NULL, .stride =3D 0, .base =3D dcr_n };
> +	dcr_host_mmio_t ret =3D { .token =3D NULL, .stride =3D 0, .base =3D dcr=
_n };
>  	u64 addr;
> =20
>  	pr_debug("dcr_map(%s, 0x%x, 0x%x)\n",
>  		 dev->full_name, dcr_n, dcr_c);
> =20
>  	addr =3D of_translate_dcr_address(dev, dcr_n, &ret.stride);
> -	pr_debug("translates to addr: 0x%lx, stride: 0x%x\n",
> +	pr_debug("translates to addr: 0x%p, stride: 0x%x\n",
>  		 addr, ret.stride);

This change should cause a warning because you are passing a u64 where
printk is expecting a pointer.  We usually use %llx and cast the u64 to
unsigned long long.

> +++ b/include/asm-powerpc/dcr-mmio.h
> @@ -27,20 +27,20 @@ typedef struct {
>  	void __iomem *token;
>  	unsigned int stride;
>  	unsigned int base;
> -} dcr_host_t;
> +} dcr_host_mmio_t;
> =20
> -#define DCR_MAP_OK(host)	((host).token !=3D NULL)
> +#define dcr_map_ok_mmio(host)	((host).token !=3D NULL)

This could be a static inline function.

> +++ b/include/asm-powerpc/dcr-native.h
> @@ -24,14 +24,14 @@
> =20
>  typedef struct {
>  	unsigned int base;
> -} dcr_host_t;
> +} dcr_host_native_t;
> =20
> -#define DCR_MAP_OK(host)	(1)
> +#define dcr_map_ok_native(host)	(1)

As could this.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__25_Mar_2008_13_37_37_+1100_MwQNhyGqCbj/rC5W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6GV2TgG2atn1QN8RAiPBAJ91deoNs4lwGy8zLfaek4dTnhr5gQCdFxxv
k6aHcX13aKtikrZYCzWJ5pM=
=oZ0o
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Mar_2008_13_37_37_+1100_MwQNhyGqCbj/rC5W--
