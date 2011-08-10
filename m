Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D47D8B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 01:39:23 +1000 (EST)
Received: by fxh10 with SMTP id 10so1082799fxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 08:39:18 -0700 (PDT)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <b965536bbd0457ab9614777dc00fc0dd22cf1d47.1312953203.git.baruch@tkos.co.il>
References: <20110810044307.GA2804@sapphire.tkos.co.il>
	<b965536bbd0457ab9614777dc00fc0dd22cf1d47.1312953203.git.baruch@tkos.co.il>
Date: Wed, 10 Aug 2011 11:39:18 -0400
Message-ID: <CAP=VYLoNSaVyfLyKDun-aBEQy+UzKJNwphs2U_74AhKAHgch_Q@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: 85xx: separate e500 from e500mc
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 1:21 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6,=
 thus
> breaking clear_pages(), probably others too.
>
> This patch adds a new "Processor Type" entry for e500mc, and makes e500 s=
ystems
> depend on PPC_E500_V1_V2.

Isn't the original invalid configuration still possible, i.e. I can
choose E500_V1_V2
and also E500MC at the same time, unless you add something like a
"depends !E500MC" to  your new V1_V2 option?

Alternatively, you could treat it like using i386 kernel on a modern
core by taking
the LCD for the L1_CACHE_SHIFT of the configured in platforms.  I have boot=
ed
a kernel built for an mpc8548 core on a P4080 CPU, so that does work (with =
only
minimal dts fiddling).  And it keeps the ability to boot one kernel on seve=
ral
platforms open (one of the reasons for the ppc --> powerpc shuffle a couple
of years ago...)

Paul.

>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>
> Changes from v2:
>
> =A0 =A0 =A0 =A0* s/CONFIG_PPC_E500/CONFIG_PPC_E500_V1_V2/ to avoid confus=
ion as
> =A0 =A0 =A0 =A0 =A0noted by Scott Wood
>
> Changes from v1:
>
> =A0 =A0 =A0 =A0* Rebase on 3.1-rc1
>
> =A0 =A0 =A0 =A0* Remove the list of processor families from the PPC_E500 =
and
> =A0 =A0 =A0 =A0 =A0PPC_E500MC options description. The P20xx can be eithe=
r e500v2 or
> =A0 =A0 =A0 =A0 =A0e500mc.
>
> =A0arch/powerpc/platforms/85xx/Kconfig =A0 =A0| =A0 13 +++++++++----
> =A0arch/powerpc/platforms/Kconfig.cputype | =A0 27 +++++++++++++++-------=
-----
> =A02 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms=
/85xx/Kconfig
> index 498534c..00d4720 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -13,6 +13,8 @@ if FSL_SOC_BOOKE
>
> =A0if PPC32
>
> +if PPC_E500_V1_V2
> +
> =A0config MPC8540_ADS
> =A0 =A0 =A0 =A0bool "Freescale MPC8540 ADS"
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> @@ -171,10 +173,13 @@ config SBC8560
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables support for the Wind River SBC8560=
 board
>
> +endif # PPC_E500_V1_V2
> +
> +if PPC_E500MC
> +
> =A0config P2040_RDB
> =A0 =A0 =A0 =A0bool "Freescale P2040 RDB"
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> - =A0 =A0 =A0 select PPC_E500MC
> =A0 =A0 =A0 =A0select PHYS_64BIT
> =A0 =A0 =A0 =A0select SWIOTLB
> =A0 =A0 =A0 =A0select MPC8xxx_GPIO
> @@ -186,7 +191,6 @@ config P2040_RDB
> =A0config P3041_DS
> =A0 =A0 =A0 =A0bool "Freescale P3041 DS"
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> - =A0 =A0 =A0 select PPC_E500MC
> =A0 =A0 =A0 =A0select PHYS_64BIT
> =A0 =A0 =A0 =A0select SWIOTLB
> =A0 =A0 =A0 =A0select MPC8xxx_GPIO
> @@ -198,7 +202,6 @@ config P3041_DS
> =A0config P4080_DS
> =A0 =A0 =A0 =A0bool "Freescale P4080 DS"
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> - =A0 =A0 =A0 select PPC_E500MC
> =A0 =A0 =A0 =A0select PHYS_64BIT
> =A0 =A0 =A0 =A0select SWIOTLB
> =A0 =A0 =A0 =A0select MPC8xxx_GPIO
> @@ -207,13 +210,15 @@ config P4080_DS
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables support for the P4080 DS board
>
> +endif # PPC_E500MC
> +
> =A0endif # PPC32
>
> =A0config P5020_DS
> =A0 =A0 =A0 =A0bool "Freescale P5020 DS"
> + =A0 =A0 =A0 depends on PPC_E500MC
> =A0 =A0 =A0 =A0select DEFAULT_UIMAGE
> =A0 =A0 =A0 =A0select E500
> - =A0 =A0 =A0 select PPC_E500MC
> =A0 =A0 =A0 =A0select PHYS_64BIT
> =A0 =A0 =A0 =A0select SWIOTLB
> =A0 =A0 =A0 =A0select MPC8xxx_GPIO
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
> index e06e395..e6cb00c 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -10,13 +10,13 @@ choice
> =A0 =A0 =A0 =A0prompt "Processor Type"
> =A0 =A0 =A0 =A0depends on PPC32
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 There are five families of 32 bit PowerPC chips support=
ed.
> + =A0 =A0 =A0 =A0 There are six families of 32 bit PowerPC chips supporte=
d.
> =A0 =A0 =A0 =A0 =A0The most common ones are the desktop and server CPUs (=
601, 603,
> =A0 =A0 =A0 =A0 =A0604, 740, 750, 74xx) CPUs from Freescale and IBM, with=
 their
> =A0 =A0 =A0 =A0 =A0embedded 512x/52xx/82xx/83xx/86xx counterparts.
> - =A0 =A0 =A0 =A0 The other embeeded parts, namely 4xx, 8xx, e200 (55xx) =
and e500
> - =A0 =A0 =A0 =A0 (85xx) each form a family of their own that is not comp=
atible
> - =A0 =A0 =A0 =A0 with the others.
> + =A0 =A0 =A0 =A0 The other embeeded parts, namely 4xx, 8xx, e200 (55xx),=
 e500
> + =A0 =A0 =A0 =A0 (85xx), and e500mc each form a family of their own that=
 is not
> + =A0 =A0 =A0 =A0 compatible with the others.
>
> =A0 =A0 =A0 =A0 =A0If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
>
> @@ -24,10 +24,15 @@ config PPC_BOOK3S_32
> =A0 =A0 =A0 =A0bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
> =A0 =A0 =A0 =A0select PPC_FPU
>
> -config PPC_85xx
> - =A0 =A0 =A0 bool "Freescale 85xx"
> +config PPC_E500_V1_V2
> + =A0 =A0 =A0 bool "Freescale e500v1/e500v2"
> + =A0 =A0 =A0 select PPC_85xx
> =A0 =A0 =A0 =A0select E500
>
> +config PPC_E500MC
> + =A0 =A0 =A0 bool "Freescale e500mc/e5500"
> + =A0 =A0 =A0 select PPC_85xx
> +
> =A0config PPC_8xx
> =A0 =A0 =A0 =A0bool "Freescale 8xx"
> =A0 =A0 =A0 =A0select FSL_SOC
> @@ -128,15 +133,13 @@ config TUNE_CELL
> =A0config 8xx
> =A0 =A0 =A0 =A0bool
>
> -config E500
> +config PPC_85xx
> + =A0 =A0 =A0 bool
> =A0 =A0 =A0 =A0select FSL_EMB_PERFMON
> =A0 =A0 =A0 =A0select PPC_FSL_BOOK3E
> - =A0 =A0 =A0 bool
>
> -config PPC_E500MC
> - =A0 =A0 =A0 bool "e500mc Support"
> - =A0 =A0 =A0 select PPC_FPU
> - =A0 =A0 =A0 depends on E500
> +config E500
> + =A0 =A0 =A0 bool
>
> =A0config PPC_FPU
> =A0 =A0 =A0 =A0bool
> --
> 1.7.5.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
