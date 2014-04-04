Return-Path: <monstr@monstr.eu>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C4A714009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 23:17:12 +1100 (EST)
Received: by mail-wi0-f170.google.com with SMTP id bs8so2528646wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 05:17:06 -0700 (PDT)
Message-ID: <533EA2B0.7080703@monstr.eu>
Date: Fri, 04 Apr 2014 14:16:48 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 09/20] of/fdt: create common debugfs
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-10-git-send-email-robherring2@gmail.com>
In-Reply-To: <1396563423-30893-10-git-send-email-robherring2@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SXcHr1kraRrGHX60PN7el4MlAHDxunCoJ"
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SXcHr1kraRrGHX60PN7el4MlAHDxunCoJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/04/2014 12:16 AM, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> Both powerpc and microblaze have the same FDT blob in debugfs feature.
> Move this to common location and remove the powerpc and microblaze
> implementations. This feature could become more useful when FDT
> overlay support is added.
>=20
> This changes the path of the blob from "$arch/flat-device-tree" to
> "device-tree/flat-device-tree".
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/microblaze/kernel/prom.c | 31 -------------------------------
>  arch/powerpc/kernel/prom.c    | 21 ---------------------
>  drivers/of/fdt.c              | 24 ++++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 52 deletions(-)
>=20
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/pro=
m.c
> index abdfb10..1312cd2 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -114,34 +114,3 @@ void __init early_init_devtree(void *params)
> =20
>  	pr_debug(" <- early_init_devtree()\n");
>  }
> -
> -/*******
> - *
> - * New implementation of the OF "find" APIs, return a refcounted
> - * object, call of_node_put() when done.  The device tree and list
> - * are protected by a rw_lock.
> - *
> - * Note that property management will need some locking as well,
> - * this isn't dealt with yet.
> - *
> - *******/
> -
> -#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
> -static struct debugfs_blob_wrapper flat_dt_blob;
> -
> -static int __init export_flat_device_tree(void)
> -{
> -	struct dentry *d;
> -
> -	flat_dt_blob.data =3D initial_boot_params;
> -	flat_dt_blob.size =3D initial_boot_params->totalsize;

As I see even microblaze version was buggy.

=2E..

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index fa16a91..2085d47 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -20,6 +20,7 @@
>  #include <linux/string.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> +#include <linux/debugfs.h>
> =20
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #ifdef CONFIG_PPC
> @@ -1084,4 +1085,27 @@ void __init unflatten_and_copy_device_tree(void)=

>  	unflatten_device_tree();
>  }
> =20
> +#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
> +static struct debugfs_blob_wrapper flat_dt_blob;
> +
> +static int __init of_flat_dt_debugfs_export_fdt(void)
> +{
> +	struct dentry *d =3D debugfs_create_dir("device-tree", NULL);
> +
> +	if (!d)
> +		return -ENOENT;
> +
> +	flat_dt_blob.data =3D initial_boot_params;
> +	flat_dt_blob.size =3D fdt_totalsize(initial_boot_params);

Have you tried to compile this?

=46rom my tests fdt_totalsize is not available for target just for host
from libfdt.h

drivers/of/fdt.c: In function 'of_flat_dt_debugfs_export_fdt':
drivers/of/fdt.c:957:2: error: implicit declaration of function 'fdt_tota=
lsize' [-Werror=3Dimplicit-function-declaration]

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--SXcHr1kraRrGHX60PN7el4MlAHDxunCoJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM+orEACgkQykllyylKDCEQ4gCeMtlQJbbpbN/o1SDKP6hiCr1v
GgYAn32EVfeuurvoNTUc6QQGkmvK5zsB
=6ZDn
-----END PGP SIGNATURE-----

--SXcHr1kraRrGHX60PN7el4MlAHDxunCoJ--
