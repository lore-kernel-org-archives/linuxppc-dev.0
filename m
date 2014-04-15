Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 94A7E140089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 18:30:27 +1000 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] fsl/pci: fix EP device sometimes hangup when system
 resume from sleep
Date: Tue, 15 Apr 2014 08:30:21 +0000
Message-ID: <b5549cd4baaf411eaa37f01a36a1cfac@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397547799-29464-1-git-send-email-dongsheng.wang@freescale.com>
 <1397547799-29464-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1397547799-29464-2-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Please ignore this patch. :(
I will resend it. Because I found when e1000 card plug in P1020 PCIe slot 2=
, we need more delay time
to let EP device return back.

Regards,
-Dongsheng

> -----Original Message-----
> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
> Sent: Tuesday, April 15, 2014 3:43 PM
> To: Wood Scott-B07421
> Cc: Zang Roy-R61911; Jin Zhengxiong-R64188; linuxppc-dev@lists.ozlabs.org=
; Wang
> Dongsheng-B40534
> Subject: [PATCH 2/2] fsl/pci: fix EP device sometimes hangup when system =
resume
> from sleep
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Root cause is pcie power management state transition need a delay.
> The delay time define in "PCI Bus Power Management Interface Specificatio=
n".
>=20
> D0, D1 or D2 --> D3 need to delay 10ms.
> D3 --> D0 need to delay 10ms.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.=
c
> index 4bd091a..33950ad 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1175,15 +1175,24 @@ static void send_pme_turnoff_message(struct
> pci_controller *hose)
>  	setbits32(&pci->pex_pmcr, PEX_PMCR_PTOMR);
>=20
>  	/* Wait trun off done */
> -	for (i =3D 0; i < 150; i++) {
> +	/* RC will get this detect quickly */
> +	for (i =3D 0; i < 50; i++) {
>  		dr =3D in_be32(&pci->pex_pme_mes_dr);
> -		if (dr) {
> +		if (dr & ENL23_DETECT_BIT) {
>  			out_be32(&pci->pex_pme_mes_dr, dr);
>  			break;
>  		}
>=20
>  		udelay(1000);
>  	}
> +
> +	/*
> +	 * "PCI Bus Power Management Interface Specification" define
> +	 * Minimum System Software Guaranteed Delays
> +	 *
> +	 * D0, D1 or D2 --> D3, need delay 10ms.
> +	 */
> +	mdelay(10);
>  }
>=20
>  static void fsl_pci_syscore_do_suspend(struct pci_controller *hose)
> @@ -1211,9 +1220,10 @@ static void fsl_pci_syscore_do_resume(struct
> pci_controller *hose)
>  	setbits32(&pci->pex_pmcr, PEX_PMCR_EXL2S);
>=20
>  	/* Wait exit done */
> -	for (i =3D 0; i < 150; i++) {
> +	/* RC will get this detect quickly */
> +	for (i =3D 0; i < 50; i++) {
>  		dr =3D in_be32(&pci->pex_pme_mes_dr);
> -		if (dr) {
> +		if (dr & EXL23_DETECT_BIT) {
>  			out_be32(&pci->pex_pme_mes_dr, dr);
>  			break;
>  		}
> @@ -1221,6 +1231,14 @@ static void fsl_pci_syscore_do_resume(struct
> pci_controller *hose)
>  		udelay(1000);
>  	}
>=20
> +	/*
> +	 * "PCI Bus Power Management Interface Specification" define
> +	 * Minimum System Software Guaranteed Delays
> +	 *
> +	 * D3 hot --> D0, need delay 10ms.
> +	 */
> +	mdelay(10);
> +
>  	setup_pci_atmu(hose);
>  }
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.=
h
> index c1cec77..37fc644 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -39,6 +39,9 @@ struct platform_device;
>  #define PME_DISR_EN_ENL23D	0x00002000
>  #define PME_DISR_EN_EXL23D	0x00001000
>=20
> +#define ENL23_DETECT_BIT        0x00002000
> +#define EXL23_DETECT_BIT        0x00001000
> +
>  /* PCI/PCI Express outbound window reg */
>  struct pci_outbound_window_regs {
>  	__be32	potar;	/* 0x.0 - Outbound translation address register */
> --
> 1.8.5
>=20
