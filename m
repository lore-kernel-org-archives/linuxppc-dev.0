Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B452BB7030
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:16:57 +1100 (EST)
Subject: Re: [PATCH 6/9] powerpc/mpc8548cds: Add FPGA node to dts
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-5-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 6 Mar 2012 06:16:54 -0600
Message-Id: <3F722CAC-7771-4DBD-A694-BC211FB25DF4@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <1331024805-15926-5-git-send-email-chenhui.zhao@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> From: chenhui zhao <chenhui.zhao@freescale.com>
>=20
> Remove FPGA(CADMUS) macros in code. Move it to dts.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---

Timur,

Do you mind reviewing & ack'ing.

- k

> arch/powerpc/boot/dts/mpc8548cds.dts      |    8 ++++-
> arch/powerpc/platforms/85xx/mpc85xx_cds.c |   50 =
+++++++++++++++++++---------
> 2 files changed, 41 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts =
b/arch/powerpc/boot/dts/mpc8548cds.dts
> index 8d4df8e..0683983 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -35,7 +35,8 @@
> 	lbc: localbus@e0005000 {
> 		reg =3D <0 0xe0005000 0 0x1000>;
>=20
> -		ranges =3D <0x0 0x0 0x0 0xff000000 0x01000000>;
> +		ranges =3D <0x0 0x0 0x0 0xff000000 0x01000000
> +			  0x1 0x0 0x0 0xf8004000 0x00001000>;
>=20
> 		nor@0,0 {
> 			#address-cells =3D <1>;
> @@ -72,6 +73,11 @@
> 				read-only;
> 			};
> 		};
> +
> +		board-control@1,0 {
> +			compatible =3D "fsl,mpc8548cds-fpga";
> +			reg =3D <0x1 0x0 0x1000>;
> +		};
> 	};
>=20
> 	soc: soc8548@e0000000 {
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index c009c5b..a600dd0 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -48,17 +48,24 @@
>=20
> #include "mpc85xx.h"
>=20
> -/* CADMUS info */
> -/* xxx - galak, move into device tree */
> -#define CADMUS_BASE (0xf8004000)
> -#define CADMUS_SIZE (256)
> -#define CM_VER	(0)
> -#define CM_CSR	(1)
> -#define CM_RST	(2)
> -
> +/*
> + * The CDS board contains an FPGA/CPLD called "Cadmus", which =
collects
> + * various logic and performs system control functions.
> + * Here is the FPGA/CPLD register map.
> + */
> +struct cadmus_reg {
> +	u8 cm_ver;		/* Board version */
> +	u8 cm_csr;		/* General control/status */
> +	u8 cm_rst;		/* Reset control */
> +	u8 cm_hsclk;	/* High speed clock */
> +	u8 cm_hsxclk;	/* High speed clock extended */
> +	u8 cm_led;		/* LED data */
> +	u8 cm_pci;		/* PCI control/status */
> +	u8 cm_dma;		/* DMA control */
> +	u8 res[248];	/* Total 256 bytes */
> +};
>=20
> -static int cds_pci_slot =3D 2;
> -static volatile u8 *cadmus;
> +static struct cadmus_reg *cadmus;
>=20
> #ifdef CONFIG_PCI
>=20
> @@ -274,20 +281,30 @@ machine_device_initcall(mpc85xx_cds, =
mpc85xx_cds_8259_attach);
>  */
> static void __init mpc85xx_cds_setup_arch(void)
> {
> -#ifdef CONFIG_PCI
> 	struct device_node *np;
> -#endif
> +	int cds_pci_slot;
>=20
> 	if (ppc_md.progress)
> 		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
>=20
> -	cadmus =3D ioremap(CADMUS_BASE, CADMUS_SIZE);
> -	cds_pci_slot =3D ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
> +	np =3D of_find_compatible_node(NULL, NULL, =
"fsl,mpc8548cds-fpga");
> +	if (!np) {
> +		pr_err("Could not find FPGA node.\n");
> +		return;
> +	}
> +
> +	cadmus =3D of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!cadmus) {
> +		pr_err("Fail to map FPGA area.\n");
> +		return;
> +	}
>=20
> 	if (ppc_md.progress) {
> 		char buf[40];
> +		cds_pci_slot =3D ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + =
1;
> 		snprintf(buf, 40, "CDS Version =3D 0x%x in slot %d\n",
> -				cadmus[CM_VER], cds_pci_slot);
> +				in_8(&cadmus->cm_ver), cds_pci_slot);
> 		ppc_md.progress(buf, 0);
> 	}
>=20
> @@ -317,7 +334,8 @@ static void mpc85xx_cds_show_cpuinfo(struct =
seq_file *m)
> 	svid =3D mfspr(SPRN_SVR);
>=20
> 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> -	seq_printf(m, "Machine\t\t: MPC85xx CDS (0x%x)\n", =
cadmus[CM_VER]);
> +	seq_printf(m, "Machine\t\t: MPC85xx CDS (0x%x)\n",
> +			in_8(&cadmus->cm_ver));
> 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
>=20
> --=20
> 1.6.4.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
