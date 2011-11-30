Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 63BB9B6F76
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 00:23:52 +1100 (EST)
Subject: Re: [PATCH 6/6] 44x/currituck: Add support for the new IBM currituck
 platform
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
Date: Wed, 30 Nov 2011 07:23:40 -0600
Message-Id: <6E90E509-7B5B-4475-A2B1-9F10FD943F4E@kernel.crashing.org>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 29, 2011, at 11:24 PM, Tony Breeds wrote:

> Based on original work by David 'Shaggy' Kliekamp.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> arch/powerpc/boot/Makefile                   |    5 +-
> arch/powerpc/boot/dts/currituck.dts          |  240 =
++++++++++++++++++++++++++
> arch/powerpc/boot/treeboot-currituck.c       |  129 ++++++++++++++
> arch/powerpc/boot/wrapper                    |    3 +
> arch/powerpc/configs/44x/currituck_defconfig |  110 ++++++++++++
> arch/powerpc/include/asm/reg.h               |    1 +
> arch/powerpc/kernel/cputable.c               |   14 ++
> arch/powerpc/kernel/head_44x.S               |    2 +
> arch/powerpc/platforms/44x/Kconfig           |   10 +
> arch/powerpc/platforms/44x/Makefile          |    1 +
> arch/powerpc/platforms/44x/ppc47x.c          |  198 =
+++++++++++++++++++++
> arch/powerpc/sysdev/ppc4xx_pci.c             |   57 ++++++-
> arch/powerpc/sysdev/ppc4xx_pci.h             |    7 +
> 13 files changed, 775 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/currituck.dts
> create mode 100644 arch/powerpc/boot/treeboot-currituck.c
> create mode 100644 arch/powerpc/configs/44x/currituck_defconfig
> create mode 100644 arch/powerpc/platforms/44x/ppc47x.c

Split the board support patches from the SoC support.



> diff --git a/arch/powerpc/include/asm/reg.h =
b/arch/powerpc/include/asm/reg.h
> index 559da19..aa38de6 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -951,6 +951,7 @@
> #define PVR_403GCX	0x00201400
> #define PVR_405GP	0x40110000
> #define PVR_476		0x11a52000
> +#define PVR_476CURRITUCK	0x7ff50000

This seems like it should be PVR_476FPE

> #define PVR_STB03XXX	0x40310000
> #define PVR_NP405H	0x41410000
> #define PVR_NP405L	0x41610000
> diff --git a/arch/powerpc/kernel/cputable.c =
b/arch/powerpc/kernel/cputable.c
> index edae5bb..02e0749 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1830,6 +1830,20 @@ static struct cpu_spec __initdata cpu_specs[] =3D=
 {
> 		.machine_check		=3D machine_check_47x,
> 		.platform		=3D "ppc470",
> 	},
> +	{ /* 476 core Currituck */

comment should probably be:
	 /* 476FPE */

> +		.pvr_mask		=3D 0xffff0000,
> +		.pvr_value		=3D 0x7ff50000,
> +		.cpu_name		=3D "476",

should probably be "476FPE"

> +		.cpu_features		=3D CPU_FTRS_47X | =
CPU_FTR_476_DD2,
> +		.cpu_user_features	=3D COMMON_USER_BOOKE |
> +			PPC_FEATURE_HAS_FPU,
> +		.mmu_features		=3D MMU_FTR_TYPE_47x |
> +			MMU_FTR_USE_TLBIVAX_BCAST | =
MMU_FTR_LOCK_BCAST_INVAL,
> +		.icache_bsize		=3D 32,
> +		.dcache_bsize		=3D 128,
> +		.machine_check		=3D machine_check_47x,
> +		.platform		=3D "ppc470",
> +	},
> 	{ /* 476 iss */
> 		.pvr_mask		=3D 0xffff0000,
> 		.pvr_value		=3D 0x00050000,
> diff --git a/arch/powerpc/kernel/head_44x.S =
b/arch/powerpc/kernel/head_44x.S
> index b725dab..3aca1e2 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -732,6 +732,8 @@ _GLOBAL(init_cpu_state)
> 	/* We use the PVR to differenciate 44x cores from 476 */
> 	mfspr	r3,SPRN_PVR
> 	srwi	r3,r3,16
> +	cmplwi	cr0,r3,PVR_476CURRITUCK@h
> +	beq	head_start_47x
> 	cmplwi	cr0,r3,PVR_476@h
> 	beq	head_start_47x
> 	cmplwi	cr0,r3,PVR_476_ISS@h

- k=
