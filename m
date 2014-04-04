Return-Path: <monstr@monstr.eu>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 474EE1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 23:22:40 +1100 (EST)
Received: by mail-we0-f179.google.com with SMTP id x48so3258168wes.24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 05:22:35 -0700 (PDT)
Message-ID: <533EA408.6030807@monstr.eu>
Date: Fri, 04 Apr 2014 14:22:32 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: monstr@monstr.eu
Subject: Re: [PATCH 09/20] of/fdt: create common debugfs
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-10-git-send-email-robherring2@gmail.com>
 <533EA2B0.7080703@monstr.eu>
In-Reply-To: <533EA2B0.7080703@monstr.eu>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r10iaFHWe8I0MrFruuVTGa97lJwlHwBbP"
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
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
--r10iaFHWe8I0MrFruuVTGa97lJwlHwBbP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index fa16a91..2085d47 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/string.h>
>>  #include <linux/errno.h>
>>  #include <linux/slab.h>
>> +#include <linux/debugfs.h>
>> =20
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #ifdef CONFIG_PPC
>> @@ -1084,4 +1085,27 @@ void __init unflatten_and_copy_device_tree(void=
)
>>  	unflatten_device_tree();
>>  }
>> =20
>> +#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>> +static struct debugfs_blob_wrapper flat_dt_blob;
>> +
>> +static int __init of_flat_dt_debugfs_export_fdt(void)
>> +{
>> +	struct dentry *d =3D debugfs_create_dir("device-tree", NULL);
>> +
>> +	if (!d)
>> +		return -ENOENT;
>> +
>> +	flat_dt_blob.data =3D initial_boot_params;
>> +	flat_dt_blob.size =3D fdt_totalsize(initial_boot_params);
>=20
> Have you tried to compile this?
>=20
> From my tests fdt_totalsize is not available for target just for host
> from libfdt.h
>=20
> drivers/of/fdt.c: In function 'of_flat_dt_debugfs_export_fdt':
> drivers/of/fdt.c:957:2: error: implicit declaration of function 'fdt_to=
talsize' [-Werror=3Dimplicit-function-declaration]

Ignore this one - there is no compilation problem.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--r10iaFHWe8I0MrFruuVTGa97lJwlHwBbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM+pAgACgkQykllyylKDCEf6wCghsimYAczhHWXbZUjT49dX+uS
mPEAnjbZGwC+DMYWYEBlqILPbjiqfRvW
=pRcv
-----END PGP SIGNATURE-----

--r10iaFHWe8I0MrFruuVTGa97lJwlHwBbP--
