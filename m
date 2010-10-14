Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AE64B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 17:14:57 +1100 (EST)
Subject: Re: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287021866-22095-1-git-send-email-b21989@freescale.com>
Date: Thu, 14 Oct 2010 01:14:44 -0500
Message-Id: <7F0756F8-8297-43A6-913A-6DA2634E18E5@kernel.crashing.org>
References: <1287021866-22095-1-git-send-email-b21989@freescale.com>
To: Shaohui Xie <b21989@freescale.com>
Cc: alexandre.bounine@idt.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 9:04 PM, Shaohui Xie wrote:

> From: Li Yang <leoli@freescale.com>
>=20
> The access to HID1 register is only legitimate for e500 v1/v2 cores.
> Also fixes magic number.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_rio.c |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c =
b/arch/powerpc/sysdev/fsl_rio.c
> index 4127636..dfff3b7 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -1537,9 +1537,12 @@ int fsl_rio_setup(struct platform_device *dev)
> #ifdef CONFIG_E500
> 	saved_mcheck_exception =3D ppc_md.machine_check_exception;
> 	ppc_md.machine_check_exception =3D fsl_rio_mcheck_exception;
> -#endif
> -	/* Ensure that RFXE is set */
> -	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
> +
> +#ifndef CONFIG_PPC_E500MC
> +	/* Ensure that RFXE is set on e500 v1/v2 */
> +	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | HID1_RFXE));
> +#endif /* !PPC_E500MC */
> +#endif /* E500 */

I've never really been happy with this code.  We really should set =
HID1_RFXE in cpu_setup_fsl_booke.S instead.

- k=
