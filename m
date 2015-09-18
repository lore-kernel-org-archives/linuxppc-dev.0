Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x22c.google.com (mail-oi0-x22c.google.com
 [IPv6:2607:f8b0:4003:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA5271A0372
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 10:22:32 +1000 (AEST)
Received: by oixx17 with SMTP id x17so18810767oix.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 17:22:30 -0700 (PDT)
Date: Fri, 18 Sep 2015 08:22:08 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>, Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
Message-ID: <20150918002208.GB1300@fixme-laptop.cn.ibm.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ping ;-)

Regards,
Boqun

On Mon, Sep 07, 2015 at 07:58:00AM +0800, Boqun Feng wrote:
> Currently, little endian is only supported on powernv and pseries,
> however, Kconfigs still allow us to include other platforms in a LE
> kernel, this may result in space wasting or even build error if some
> BE-only platforms always assume they are built for a BE kernel. So just
> modify the Kconfigs of BE-only platforms to remove them from being built
> for a LE kernel.
>=20
> For 32bit only platforms, nothing needs to be done, because
> CPU_LITTLE_ENDIAN depends on PPC64. For 64bit supported platforms, add
> CPU_BIG_ENDIAN to dependencies explicitly, so that these platforms will
> be disabled for LE [Suggested-by: C=E9dric Le Goater <clg@fr.ibm.com>].
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/powerpc/platforms/cell/Kconfig     | 4 ++--
>  arch/powerpc/platforms/maple/Kconfig    | 2 +-
>  arch/powerpc/platforms/pasemi/Kconfig   | 2 +-
>  arch/powerpc/platforms/powermac/Kconfig | 2 +-
>  arch/powerpc/platforms/ps3/Kconfig      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms=
/cell/Kconfig
> index 2f23133..808a904 100644
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
> =20
>  config PPC_IBM_CELL_BLADE
>  	bool "IBM Cell Blade"
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>  	select PPC_CELL_NATIVE
>  	select PPC_OF_PLATFORM_PCI
>  	select PCI
> @@ -35,7 +35,7 @@ config PPC_IBM_CELL_BLADE
> =20
>  config PPC_CELL_QPACE
>  	bool "IBM Cell - QPACE"
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>  	select PPC_CELL_COMMON
> =20
>  config AXON_MSI
> diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platform=
s/maple/Kconfig
> index 1ea621a..e359d0d 100644
> --- a/arch/powerpc/platforms/maple/Kconfig
> +++ b/arch/powerpc/platforms/maple/Kconfig
> @@ -1,5 +1,5 @@
>  config PPC_MAPLE
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>  	bool "Maple 970FX Evaluation Board"
>  	select PCI
>  	select MPIC
> diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platfor=
ms/pasemi/Kconfig
> index a2aeb32..00d4b28 100644
> --- a/arch/powerpc/platforms/pasemi/Kconfig
> +++ b/arch/powerpc/platforms/pasemi/Kconfig
> @@ -1,5 +1,5 @@
>  config PPC_PASEMI
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>  	bool "PA Semi SoC-based platforms"
>  	default n
>  	select MPIC
> diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platf=
orms/powermac/Kconfig
> index 607124b..43c6062 100644
> --- a/arch/powerpc/platforms/powermac/Kconfig
> +++ b/arch/powerpc/platforms/powermac/Kconfig
> @@ -1,6 +1,6 @@
>  config PPC_PMAC
>  	bool "Apple PowerMac based machines"
> -	depends on PPC_BOOK3S
> +	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
>  	select MPIC
>  	select PCI
>  	select PPC_INDIRECT_PCI if PPC32
> diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/=
ps3/Kconfig
> index 56f2740..b27f40f 100644
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -1,6 +1,6 @@
>  config PPC_PS3
>  	bool "Sony PS3"
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
>  	select PPC_CELL
>  	select USB_OHCI_LITTLE_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_MMIO
> --=20
> 2.5.1
>=20

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+1kmAAoJEEl56MO1B/q4zrMIAK1vRRCYXSUDS63rs/qO9FfD
BAzew3xmmxrG87d5eYnxG2KUA+se2N5NR25uDj+88zGUo34mEosUQDGtHVHPlpnJ
dusRDWnSY1ydFsUsLXgJ1+xYBk2q59cXE10/Dq/65atdQ6fG25hlS31NeIb04AFp
RAWRtTWuSr3XP5pd9QMVD5Pi7lg9FDy/dvwPgcAgeSoUakiMALtBxT94OlQrgky5
LzXFwxe8hw5u0ArEWLOgZHnyxbbQ/RN+k6FJS1pWBym1g1E02QPtDuGjdxGYBmgJ
F/O8jFK+vROpgDFX4FV/7KPkuK0lWB1PqTSTscyXsFvY32VcsGIXLnbrMaPEZxI=
=XUCo
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
