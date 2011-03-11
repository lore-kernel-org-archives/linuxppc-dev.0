Return-Path: <B32579@freescale.com>
Received: from CH1EHSOBE001.bigfish.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09FB6B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 14:13:04 +1100 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: "jgarzik@pobox.com" <jgarzik@pobox.com>
Subject: RE: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Fri, 11 Mar 2011 03:12:55 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87412FC9C@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1299472170-3580-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1299472170-3580-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeff,

I am not finding any comments on this.

Could you please ACK this patch so that it can be applied in external list.=
=20

--Prabhakar

> -----Original Message-----
> From: Kushwaha Prabhakar-B32579
> Sent: Monday, March 07, 2011 10:00 AM
> To: linux-ide@vger.kernel.org
> Cc: jgarzik@pobox.com; meet2prabhu@gmail.com; linuxppc-
> dev@lists.ozlabs.org; Kushwaha Prabhakar-B32579
> Subject: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
>=20
> RX_WATER_MARK sets the number of locations in Rx FIFO that can be used
> before the transport layer instructs the link layer to transmit HOLDS.
> Note that it can take some time for the HOLDs to get to the other end,
> and that in the interim there must be enough room in the FIFO to absorb
> all data that could arrive.
>=20
> Update the new recommended value to 16.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> (branch master)
>=20
>  This patch is already gone through review of linuxppc-dev mail list.
>  Making CC linuxppc-dev@lists.ozlabs.org
>=20
>  drivers/ata/sata_fsl.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> 895771c..29d2f29 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -186,6 +186,11 @@ enum {
>  	COMMANDSTAT =3D 0x20,
>  };
>=20
> +/* TRANSCFG (transport-layer) configuration control */ enum {
> +	TRANSCFG_RX_WATER_MARK =3D (1 << 4),
> +};
> +
>  /* PHY (link-layer) configuration control */  enum {
>  	PHY_BIST_ENABLE =3D 0x01,
> @@ -1305,6 +1310,7 @@ static int sata_fsl_probe(struct platform_device
> *ofdev,
>  	struct sata_fsl_host_priv *host_priv =3D NULL;
>  	int irq;
>  	struct ata_host *host;
> +	u32 temp;
>=20
>  	struct ata_port_info pi =3D sata_fsl_port_info[0];
>  	const struct ata_port_info *ppi[] =3D { &pi, NULL }; @@ -1319,6
> +1325,12 @@ static int sata_fsl_probe(struct platform_device *ofdev,
>  	ssr_base =3D hcr_base + 0x100;
>  	csr_base =3D hcr_base + 0x140;
>=20
> +	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-
> sata")) {
> +		temp =3D ioread32(csr_base + TRANSCFG);
> +		temp =3D temp & 0xffffffe0;
> +		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base +
> TRANSCFG);
> +	}
> +
>  	DPRINTK("@reset i/o =3D 0x%x\n", ioread32(csr_base + TRANSCFG));
>  	DPRINTK("sizeof(cmd_desc) =3D %d\n", sizeof(struct command_desc));
>  	DPRINTK("sizeof(#define cmd_desc) =3D %d\n", SATA_FSL_CMD_DESC_SIZE);
> --
> 1.7.3
