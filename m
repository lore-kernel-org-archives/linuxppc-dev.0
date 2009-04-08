Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4ED4FDE0AE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 15:08:56 +1000 (EST)
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-jsi739cd3KfALQ1u5Y39"
Date: Wed, 08 Apr 2009 15:08:55 +1000
Message-Id: <1239167335.10104.26.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jsi739cd3KfALQ1u5Y39
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 14:36 +1000, Tony Breeds wrote:
> This patch silences all the warnings generated in arch/powerpc for
> allmodconfig build.
>=20
> It does:
>  * Where appropriate use the uninitialized_var() macro to help GCC
>    understand we know what's going on.
>  * Explicitly casts PHYSICAL_START in one printk()
>  * Initialise a few variables, as it's "neater" than using uninitialized_=
var()
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> Only compile tested.
>=20
>  arch/powerpc/kernel/cacheinfo.c           |    4 ++--
>  arch/powerpc/kernel/pci_dn.c              |    2 +-
>  arch/powerpc/kernel/setup_64.c            |    4 ++--
>  arch/powerpc/platforms/cell/axon_msi.c    |    2 +-
>  arch/powerpc/platforms/cell/beat_iommu.c  |    2 +-
>  arch/powerpc/platforms/iseries/pci.c      |   24 ++++++++++++-----------=
-
>  arch/powerpc/platforms/powermac/low_i2c.c |    5 ++---
>  arch/powerpc/platforms/pseries/msi.c      |    2 +-
>  8 files changed, 22 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cachei=
nfo.c
> index bb37b1d..fd6aef9 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -510,7 +510,7 @@ static struct cache *index_kobj_to_cache(struct kobje=
ct *k)
> =20
>  static ssize_t size_show(struct kobject *k, struct kobj_attribute *attr,=
 char *buf)
>  {
> -	unsigned int size_kb;
> +	unsigned int uninitialized_var(size_kb);
>  	struct cache *cache;
> =20
>  	cache =3D index_kobj_to_cache(k);
> @@ -559,7 +559,7 @@ static struct kobj_attribute cache_nr_sets_attr =3D
> =20
>  static ssize_t associativity_show(struct kobject *k, struct kobj_attribu=
te *attr, char *buf)
>  {
> -	unsigned int associativity;
> +	unsigned int uninitialized_var(associativity);
>  	struct cache *cache;

The getter routines in here could really multiplex their return values
with a negative error code, which I generally prefer, but this works I
guess.


> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 1c67de5..b9d66ed 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -83,7 +83,7 @@ void *traverse_pci_devices(struct device_node *start, t=
raverse_func pre,
>  		void *data)
>  {
>  	struct device_node *dn, *nextdn;
> -	void *ret;
> +	void *uninitialized_var(ret);

The code causing this one is a little ugly anyway, I think we should
change it to be:

-               if (pre && ((ret =3D pre(dn, data)) !=3D NULL))
-                       return ret;
+               if (pre) {
+                       ret =3D pre(dn, data);
+                       if (ret !=3D NULL)
+                               return ret;
+               }


> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platfo=
rms/cell/axon_msi.c
> index 0ce45c2..dae4c7c 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -151,7 +151,7 @@ static struct axon_msic *find_msi_translator(struct p=
ci_dev *dev)
>  {
>  	struct irq_host *irq_host;
>  	struct device_node *dn, *tmp;
> -	const phandle *ph;
> +	const phandle *uninitialized_var(ph);
>  	struct axon_msic *msic =3D NULL;

Freakin gcc. This is just:

if (!dn)
	return;

for (; dn; ..)
	ph =3D ..

if (!ph)

And it can't work out that it's never used uninitialised?

> diff --git a/arch/powerpc/platforms/cell/beat_iommu.c b/arch/powerpc/plat=
forms/cell/beat_iommu.c
> index 93b0efd..8230cd8 100644
> --- a/arch/powerpc/platforms/cell/beat_iommu.c
> +++ b/arch/powerpc/platforms/cell/beat_iommu.c
> @@ -57,7 +57,7 @@ static unsigned long celleb_dma_direct_offset;
>  static void __init celleb_init_direct_mapping(void)
>  {
>  	u64 lpar_addr, io_addr;
> -	u64 io_space_id, ioid, dma_base, dma_size, io_page_size;
> +	u64 io_space_id=3D0, ioid=3D0, dma_base=3D0, dma_size=3D0, io_page_size=
=3D0;

Do you need a new spacebar? :D

> diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platform=
s/iseries/pci.c
> index 02a634f..05f047d 100644
> --- a/arch/powerpc/platforms/iseries/pci.c
> +++ b/arch/powerpc/platforms/iseries/pci.c
> @@ -616,8 +616,8 @@ static inline struct device_node *xlate_iomm_address(
>   */
>  static u8 iseries_readb(const volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	struct HvCallPci_LoadReturn ret;
>  	struct device_node *dn =3D
> @@ -634,8 +634,8 @@ static u8 iseries_readb(const volatile void __iomem *=
addr)
> =20
>  static u16 iseries_readw_be(const volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	struct HvCallPci_LoadReturn ret;
>  	struct device_node *dn =3D
> @@ -653,8 +653,8 @@ static u16 iseries_readw_be(const volatile void __iom=
em *addr)
> =20
>  static u32 iseries_readl_be(const volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	struct HvCallPci_LoadReturn ret;
>  	struct device_node *dn =3D
> @@ -676,8 +676,8 @@ static u32 iseries_readl_be(const volatile void __iom=
em *addr)
>   */
>  static void iseries_writeb(u8 data, volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	u64 rc;
>  	struct device_node *dn =3D
> @@ -692,8 +692,8 @@ static void iseries_writeb(u8 data, volatile void __i=
omem *addr)
> =20
>  static void iseries_writew_be(u16 data, volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	u64 rc;
>  	struct device_node *dn =3D
> @@ -708,8 +708,8 @@ static void iseries_writew_be(u16 data, volatile void=
 __iomem *addr)
> =20
>  static void iseries_writel_be(u32 data, volatile void __iomem *addr)
>  {
> -	u64 bar_offset;
> -	u64 dsa;
> +	u64 uninitialized_var(bar_offset);
> +	u64 uninitialized_var(dsa);
>  	int retry =3D 0;
>  	u64 rc;
>  	struct device_node *dn =3D
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/pla=
tforms/powermac/low_i2c.c
> index 21226b7..5989427 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1090,7 +1090,7 @@ EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
> =20
>  int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
>  {
> -	int rc;
> +	int rc =3D 0;
> =20
>  	mutex_lock(&bus->mutex);
>  	bus->polled =3D polled || pmac_i2c_force_poll;
> @@ -1099,9 +1099,8 @@ int pmac_i2c_open(struct pmac_i2c_bus *bus, int pol=
led)
>  	if (bus->open && (rc =3D bus->open(bus)) !=3D 0) {
>  		bus->opened =3D 0;
>  		mutex_unlock(&bus->mutex);
> -		return rc;
>  	}
> -	return 0;
> +	return rc;

This one is a bug surely?

1092 {
1093         int rc;
1094       =20
1095         mutex_lock(&bus->mutex);
1096         bus->polled =3D polled || pmac_i2c_force_poll;
1097         bus->opened =3D 1;
1098         bus->mode =3D pmac_i2c_mode_std;
1099         if (bus->open && (rc =3D bus->open(bus)) !=3D 0) {
1100                 bus->opened =3D 0;
1101                 mutex_unlock(&bus->mutex);
1102                 return rc;
1103         }
1104         return 0;
1105 }


I can't reproduce it though with a simple test case :?

> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platform=
s/pseries/msi.c
> index bf2e1ac..d92f593 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -282,7 +282,7 @@ static int msi_quota_for_device(struct pci_dev *dev, =
int request)
>  {
>  	struct device_node *pe_dn;
>  	struct msi_counts counts;
> -	int total;
> +	int uninitialized_var(total);
> =20
>  	pr_debug("rtas_msi: calc quota for %s, request %d\n", pci_name(dev),
>  		  request);

Gah, gcc sucks. It should just not warn in these cases where it doesn't
know wth is going on.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jsi739cd3KfALQ1u5Y39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkncMWcACgkQdSjSd0sB4dL6XQCfaDxvlTacKFkMUugD3O95OcAU
yIgAoJPzwQO22BXNFGIDgDvSev154u2W
=KZEh
-----END PGP SIGNATURE-----

--=-jsi739cd3KfALQ1u5Y39--
