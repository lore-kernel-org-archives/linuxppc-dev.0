Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4FA3B2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 22:37:59 +1000 (EST)
Subject: Re: [PATCH][v3] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 7 Sep 2012 07:37:53 -0500
Message-Id: <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
References: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@lists.ozlabs.org,
 Anju Bhartiya <Anju.Bhartiya@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 7, 2012, at 5:01 AM, Shaohui Xie wrote:

> The freescale V2 SATA controller checks if the received data length =
matches
> the programmed length 'ttl', if not, it assumes that this is an error.
> In ATAPI, the 'ttl' is based on max allocation length and not the =
actual
> data transfer length, controller will raise 'DLM' (Data length =
Mismatch)
> error bit in Hstatus register. Along with 'DLM', DE (Device error) and
> FE (fatal Error) bits are also set in Hstatus register, 'E' (Internal =
Error)
> bit is set in Serror register and CE (Command Error) and DE (Device =
error)
> registers have the corresponding bit set. In this condition, we need =
to
> clear errors in following way: in the service routine, based on 'DLM' =
flag,
> HCONTROL[27] operation clears Hstatus, CE and DE registers, clear =
Serror
> register.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Anju Bhartiya <Anju.Bhartiya@freescale.com>
> ---
> changes for v3:
> 1. not using uppercase for variable names;
> 2. remove unnecessary parens;
>=20
> changes for v2:
> 1. remove the using of quirk;
> 2. wrap errata codes in condition;
>=20
> drivers/ata/sata_fsl.c |   39 +++++++++++++++++++++++++++++++++++----
> 1 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d6577b9..9fbab68 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -143,6 +143,7 @@ enum {
> 	    FATAL_ERR_CRC_ERR_RX |
> 	    FATAL_ERR_FIFO_OVRFL_TX | FATAL_ERR_FIFO_OVRFL_RX,
>=20
> +	INT_ON_DATA_LENGTH_MISMATCH =3D (1 << 12),
> 	INT_ON_FATAL_ERR =3D (1 << 5),
> 	INT_ON_PHYRDY_CHG =3D (1 << 4),
>=20
> @@ -1181,25 +1182,55 @@ static void sata_fsl_host_intr(struct ata_port =
*ap)
> 	u32 hstatus, done_mask =3D 0;
> 	struct ata_queued_cmd *qc;
> 	u32 SError;
> +	u32 tag;
> +	u32 status_mask =3D INT_ON_ERROR;
>=20
> 	hstatus =3D ioread32(hcr_base + HSTATUS);
>=20
> 	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
>=20
> +	/* Read command completed register */
> +	done_mask =3D ioread32(hcr_base + CC);
> +
> +	/* Workaround for data length mismatch errata */
> +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> +		for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
> +			qc =3D ata_qc_from_tag(ap, tag);
> +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> +				u32 hcontrol;
> +#define HCONTROL_CLEAR_ERROR	(1 << 27)

shouldn't we have this #define be part of the enum that the other =
HCONTROL_ bits/flags are part of?

> +				/* Set HControl[27] to clear error =
registers */
> +				hcontrol =3D ioread32(hcr_base + =
HCONTROL);
> +				iowrite32(hcontrol | =
HCONTROL_CLEAR_ERROR,
> +						hcr_base + HCONTROL);
> +
> +				/* Clear HControl[27] */
> +				iowrite32(hcontrol & =
~HCONTROL_CLEAR_ERROR,
> +						hcr_base + HCONTROL);
> +
> +				/* Clear SError[E] bit */
> +				sata_fsl_scr_write(&ap->link, SCR_ERROR,
> +						SError);
> +
> +				/* Ignore fatal error and device error =
*/
> +				status_mask &=3D =
~(INT_ON_SINGL_DEVICE_ERR
> +						| INT_ON_FATAL_ERR);
> +				break;
> +			}
> +		}
> +	}
> +
> 	if (unlikely(SError & 0xFFFF0000)) {
> 		DPRINTK("serror @host_intr : 0x%x\n", SError);
> 		sata_fsl_error_intr(ap);
> 	}
>=20
> -	if (unlikely(hstatus & INT_ON_ERROR)) {
> +	if (unlikely(hstatus & status_mask)) {
> 		DPRINTK("error interrupt!!\n");
> 		sata_fsl_error_intr(ap);
> 		return;
> 	}
>=20
> -	/* Read command completed register */
> -	done_mask =3D ioread32(hcr_base + CC);
> -
> 	VPRINTK("Status of all queues :\n");
> 	VPRINTK("done_mask/CC =3D 0x%x, CA =3D 0x%x, =
CE=3D0x%x,CQ=3D0x%x,apqa=3D0x%x\n",
> 		done_mask,
> --=20
> 1.6.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
