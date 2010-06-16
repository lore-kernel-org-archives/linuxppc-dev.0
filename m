Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60F21B7D85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 01:01:22 +1000 (EST)
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4C187616.4000303@neli.hopto.org>
Date: Wed, 16 Jun 2010 10:01:16 -0500
Message-Id: <A79B65D2-CDAF-4B16-8E97-E3522F154056@kernel.crashing.org>
References: <4C187616.4000303@neli.hopto.org>
To: Micha Nelissen <micha@neli.hopto.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 16, 2010, at 1:58 AM, Micha Nelissen wrote:

> Hi,
>=20
> Attached is a patch to fix large physical address support for the =
e500v2 core. When >4GB addresses are used, the MAS7 register needs to be =
valid for tlbsx instruction usage.
>=20
> Please review and apply.
>=20
> Micha
> diff -u -ru linux-2.6.34/arch/powerpc/include/asm/reg.h =
linux-2.6.34-fix/arch/powerpc/include/asm/reg.h
> --- linux-2.6.34/arch/powerpc/include/asm/reg.h	2010-05-16 =
23:17:36.000000000 +0200
> +++ linux-2.6.34-fix/arch/powerpc/include/asm/reg.h	2010-06-16 =
08:43:28.000000000 +0200
> @@ -272,6 +272,7 @@
> #define HID0_DAPUEN	(1<<8)		/* Debug APU enable */
> #define HID0_SGE	(1<<7)		/* Store Gathering Enable */
> #define HID0_SIED	(1<<7)		/* Serial Instr. Execution =
[Disable] */
> +#define HID0_EN_MAS7_UPDATE (1<<7)      /* tlbre/tlbsx update MAS7 - =
e500v2 */
> #define HID0_DCFA	(1<<6)		/* Data Cache Flush Assist */
> #define HID0_LRSTK	(1<<4)		/* Link register stack - 745x */
> #define HID0_BTIC	(1<<5)		/* Branch Target Instr Cache =
Enable */
> diff -u -ru linux-2.6.34/arch/powerpc/kernel/head_fsl_booke.S =
linux-2.6.34-fix/arch/powerpc/kernel/head_fsl_booke.S
> --- linux-2.6.34/arch/powerpc/kernel/head_fsl_booke.S	2010-05-16 =
23:17:36.000000000 +0200
> +++ linux-2.6.34-fix/arch/powerpc/kernel/head_fsl_booke.S	=
2010-06-16 08:45:10.000000000 +0200
> @@ -328,6 +328,13 @@
> 	oris	r2,r2,HID0_DOZE@h
> 	mtspr	SPRN_HID0, r2
> #endif
> +#ifdef CONFIG_PTE_64BIT
> +BEGIN_MMU_FTR_SECTION
> +	mfspr	r2,SPRN_HID0
> +	ori	r2,r2,HID0_EN_MAS7_UPDATE@l
> +	mtspr	SPRN_HID0, r2
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
> +#endif

If you want to do this, do it in:

arch/powerpc/kernel/cpu_setup_fsl_booke.S

- k=
