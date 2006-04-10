Return-Path: <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH]ppc64 kexec tools rm platform fix
From: Michael Ellerman <michael@ellerman.id.au>
To: David Wilder <dwilder@us.ibm.com>
In-Reply-To: <443700CB.3090909@us.ibm.com>
References: <443700CB.3090909@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EK01hU1zgSURodOpL6NZ"
Date: Mon, 10 Apr 2006 10:53:55 +0200
Message-Id: <1144659236.26317.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Mohan Kumar <mohankumar@in.ibm.com>, fastboot@lists.osdl.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EK01hU1zgSURodOpL6NZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for working on this one. Few comments below ...

On Fri, 2006-04-07 at 17:16 -0700, David Wilder wrote:
> This patch was discussed earlier on this list.  (see posting by Haren=20
> Myneni <hbabu@us.ibm.com>).=20
>=20
> In recent kernels, the platform property is removed from the=20
> /proc/device-tree.This property is used to determine whether the=20
> platform is LPAR or non-lpar, and reads htab-* and tce-* properties=20
> based on the platform. Fixed this issue such that read these properties=20
> if exists, otherwise continue instead of exiting with an error message.

(Copied from attachment, won't apply, original here
http://lists.osdl.org/pipermail/fastboot/2006-April/002765.html)

> ---
> kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c.orig       2006-04-08
> 16:09:20.000000000 -0700
> +++ kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c    2006-04-08
> 16:23:26.000000000 -0700
> @@ -34,13 +34,8 @@
>  #include "crashdump-ppc64.h"
>  #include <arch/options.h>
> =20
> -/* Platforms supported by kexec on PPC64 */
> -#define PLATFORM_PSERIES       0x0100
> -#define PLATFORM_PSERIES_LPAR  0x0101
> -
>  static struct exclude_range exclude_range[MAX_MEMORY_RANGES];
>  static unsigned long long rmo_top;
> -static unsigned int platform;
>  static struct memory_range memory_range[MAX_MEMORY_RANGES];
>  static struct memory_range base_memory_range[MAX_MEMORY_RANGES];
>  unsigned long long memory_max =3D 0;
> @@ -201,26 +196,6 @@ static int get_devtree_details(unsigned=20
>                 }
> =20
>                 if (strncmp(dentry->d_name, "chosen", 6) =3D=3D 0) {
> -                       /* get platform details from /chosen node */
> -                       strcat(fname, "/linux,platform");
> -                       if ((file =3D fopen(fname, "r")) =3D=3D NULL) {
> -                               perror(fname);
> -                               closedir(cdir);
> -                               closedir(dir);
> -                               return -1;
> -                       }
> -                       if (fread(&platform, sizeof(int), 1, file) !=3D
> 1) {
> -                               perror(fname);
> -                               fclose(file);
> -                               closedir(cdir);
> -                               closedir(dir);
> -                               return -1;
> -                       }
> -                       fclose(file);
> -
> -                       memset(fname, 0, sizeof(fname));
> -                       strcpy(fname, device_tree);
> -                       strcat(fname, dentry->d_name);
>                         strcat(fname, "/linux,kernel-end");
>                         if ((file =3D fopen(fname, "r")) =3D=3D NULL) {
>                                 perror(fname);
> @@ -291,18 +266,18 @@ static int get_devtree_details(unsigned=20
>                                 reserve(KDUMP_BACKUP_LIMIT,
> crash_base-KDUMP_BACKUP_LIMIT);
>                         }
> =20
> -                       /* if LPAR, no need to read any more
> from /chosen */
> -                       if (platform !=3D PLATFORM_PSERIES) {
> -                               closedir(cdir);
> -                               continue;
> -                       }
>                         memset(fname, 0, sizeof(fname));
>                         strcpy(fname, device_tree);
>                         strcat(fname, dentry->d_name);
>                         strcat(fname, "/linux,htab-base");
>                         if ((file =3D fopen(fname, "r")) =3D=3D NULL) {
> -                               perror(fname);
>                                 closedir(cdir);
> +                               if (errno =3D=3D ENOENT) {
> +                                       /* Non LPAR */
> +                                       errno =3D 0;
> +                                       continue;
> +                                }
> +                               perror(fname);
>                                 closedir(dir);
>                                 return -1;

I don't think you want to do the closedir() before the if. You certainly
don't need to do it twice?

>                         }
> @@ -394,23 +369,23 @@ static int get_devtree_details(unsigned=20
>                         }
>                         rmo_base =3D ((unsigned long long *)buf)[0];
>                         rmo_top =3D rmo_base + ((unsigned long long
> *)buf)[1];
> -                       if (platform =3D=3D PLATFORM_PSERIES) {
> -                               if (rmo_top > 0x30000000UL)
> -                                       rmo_top =3D 0x30000000UL;
> -                       }
> +                       if (rmo_top > 0x30000000UL)
> +                               rmo_top =3D 0x30000000UL;
> +
>                         fclose(file);
>                         closedir(cdir);
>                 } /* memory */
> =20
>                 if (strncmp(dentry->d_name, "pci@", 4) =3D=3D 0) {
> -                       if (platform !=3D PLATFORM_PSERIES) {
> -                               closedir(cdir);
> -                               continue;
> -                       }
>                         strcat(fname, "/linux,tce-base");
>                         if ((file =3D fopen(fname, "r")) =3D=3D NULL) {
> -                               perror(fname);
>                                 closedir(cdir);
> +                               if (errno =3D=3D ENOENT) {
> +                                       /* Non LPAR */
> +                                       errno =3D 0;
> +                                       continue;
> +                               }
> +                               perror(fname);
>                                 closedir(dir);

Same comment here.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EK01hU1zgSURodOpL6NZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEOh0jdSjSd0sB4dIRAjvZAJ4z+PVReONKCLLyiFzpwJTup5R6gQCfa+/M
rn9QR3TSZqbnuGyJ2aW4i2o=
=KYjV
-----END PGP SIGNATURE-----

--=-EK01hU1zgSURodOpL6NZ--
