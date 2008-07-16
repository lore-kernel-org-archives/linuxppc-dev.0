Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 16 Jul 2008 07:50:25 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: fkan@amcc.com
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Message-ID: <20080716075025.0bca152c@zod.rchland.ibm.com>
In-Reply-To: <1216186406-27993-1-git-send-email-fkan@amcc.com>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2008 22:33:26 -0700
fkan@amcc.com wrote:

> From: Victor Gallardo <vgallard@amcc.com>
>=20
> ppc4xx: Add AMCC Arches 460GT eval board support=20
>=20
> Signed-off-by: Victor Gallardo <vgallard@amcc.com>

=46rom what I can tell, you don't even need this patch or the defconfig.
Nothing differs at this point from Glacier other than the DTS.  Since
U-Boot is your loader, it should be able to pass the different DTS to a
kernel that supports Cayonlands and have no issues.

> ---
>  arch/powerpc/platforms/44x/Kconfig  |   18 ++++++++
>  arch/powerpc/platforms/44x/Makefile |    1 +
>  arch/powerpc/platforms/44x/arches.c |   76 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 95 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/44x/arches.c
>=20
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/=
44x/Kconfig
> index 6abe913..95d1217 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -77,6 +77,16 @@ config CANYONLANDS
>  	help
>  	  This option enables support for the AMCC PPC460EX evaluation board.
>=20
> +config ARCHES
> +	bool "Arches"
> +	depends on 44x
> +	default n
> +	select 460GT
> +	select PCI
> +	select PPC4xx_PCI_EXPRESS
> +	help
> +	  This option enables support for the AMCC PPC460GT Arches board.

If you do want to have explicit support for Arches, that's fine.  Look
at how Yosemite is supported.  It just reuses Bamboo.  You could do the
same.

>  config YOSEMITE
>  	bool "Yosemite"
>  	depends on 44x
> @@ -149,6 +159,14 @@ config 460EX
>  	select IBM_NEW_EMAC_ZMII
>  	select IBM_NEW_EMAC_TAH
>=20
> +config 460GT
> +	bool
> +	select PPC_FPU
> +	select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_RGMII
> +	select IBM_NEW_EMAC_ZMII
> +	select IBM_NEW_EMAC_TAH

I don't see a reason to add this at all.  460EX and 460GT select the
same set of options.

>  # 44x errata/workaround config symbols, selected by the CPU models above
>  config IBM440EP_ERR42
>  	bool
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms=
/44x/Makefile
> index 774165f..86a4823 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_RAINIER)	+=3D rainier.o
>  obj-$(CONFIG_WARP)	+=3D warp.o
>  obj-$(CONFIG_WARP)	+=3D warp-nand.o
>  obj-$(CONFIG_CANYONLANDS) +=3D canyonlands.o
> +obj-$(CONFIG_ARCHES)	+=3D arches.o

Here you would just have:

obj-$(CONFIG_ARCHES) +=3D cayonlands.o

> diff --git a/arch/powerpc/platforms/44x/arches.c b/arch/powerpc/platforms=
/44x/arches.c
> new file mode 100644
> index 0000000..6d6aa66
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/arches.c

And then you don't need this file at all.  Just add a
"amcc,canyonlands" string to your root node compatible property.

josh
