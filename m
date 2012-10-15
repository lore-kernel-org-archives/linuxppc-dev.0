Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69CDB2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2012 18:52:21 +1100 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>
Subject: RE: [PATCH][v4] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Mon, 15 Oct 2012 07:52:11 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C90AFCFC0B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1347331734-6540-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1347331734-6540-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bhartiya Anju-B07263 <B07263@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Any comment for this patch? It's been over a month...

Best Regards,=20
Shaohui Xie
> -----Original Message-----
> From: Xie Shaohui-B21989
> Sent: Tuesday, September 11, 2012 10:49 AM
> To: jgarzik@pobox.com; linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xie
> Shaohui-B21989; Bhartiya Anju-B07263
> Subject: [PATCH][v4] sata_fsl: add workaround for data length mismatch on
> freescale V2 controller
>=20
> The freescale V2 SATA controller checks if the received data length
> matches the programmed length 'ttl', if not, it assumes that this is an
> error.
> In ATAPI, the 'ttl' is based on max allocation length and not the actual
> data transfer length, controller will raise 'DLM' (Data length Mismatch)
> error bit in Hstatus register. Along with 'DLM', DE (Device error) and FE
> (fatal Error) bits are also set in Hstatus register, 'E' (Internal Error)
> bit is set in Serror register and CE (Command Error) and DE (Device error=
)
> registers have the corresponding bit set. In this condition, we need to
> clear errors in following way: in the service routine, based on 'DLM'
> flag, HCONTROL[27] operation clears Hstatus, CE and DE registers, clear
> Serror register.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Anju Bhartiya <Anju.Bhartiya@freescale.com>
> ---
> changes for v4:
> 1. put HCONTROL_CLEAR_ERROR to enum and rename it as CLEAR_ERROR;
>=20
> changes for v3:
> 1. not using uppercase for variable names; 2. remove unnecessary parens;
>=20
> changes for v2:
> 1. remove the using of quirk;
> 2. wrap errata codes in condition;
>=20
>=20
>  drivers/ata/sata_fsl.c |   39 +++++++++++++++++++++++++++++++++++----
>  1 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> d6577b9..124b2c1 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -123,6 +123,7 @@ enum {
>  	ONLINE =3D (1 << 31),
>  	GOING_OFFLINE =3D (1 << 30),
>  	BIST_ERR =3D (1 << 29),
> +	CLEAR_ERROR =3D (1 << 27),
>=20
>  	FATAL_ERR_HC_MASTER_ERR =3D (1 << 18),
>  	FATAL_ERR_PARITY_ERR_TX =3D (1 << 17),
> @@ -143,6 +144,7 @@ enum {
>  	    FATAL_ERR_CRC_ERR_RX |
>  	    FATAL_ERR_FIFO_OVRFL_TX | FATAL_ERR_FIFO_OVRFL_RX,
>=20
> +	INT_ON_DATA_LENGTH_MISMATCH =3D (1 << 12),
>  	INT_ON_FATAL_ERR =3D (1 << 5),
>  	INT_ON_PHYRDY_CHG =3D (1 << 4),
>=20
> @@ -1181,25 +1183,54 @@ static void sata_fsl_host_intr(struct ata_port
> *ap)
>  	u32 hstatus, done_mask =3D 0;
>  	struct ata_queued_cmd *qc;
>  	u32 SError;
> +	u32 tag;
> +	u32 status_mask =3D INT_ON_ERROR;
>=20
>  	hstatus =3D ioread32(hcr_base + HSTATUS);
>=20
>  	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
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
> +				/* Set HControl[27] to clear error registers */
> +				hcontrol =3D ioread32(hcr_base + HCONTROL);
> +				iowrite32(hcontrol | CLEAR_ERROR,
> +						hcr_base + HCONTROL);
> +
> +				/* Clear HControl[27] */
> +				iowrite32(hcontrol & ~CLEAR_ERROR,
> +						hcr_base + HCONTROL);
> +
> +				/* Clear SError[E] bit */
> +				sata_fsl_scr_write(&ap->link, SCR_ERROR,
> +						SError);
> +
> +				/* Ignore fatal error and device error */
> +				status_mask &=3D ~(INT_ON_SINGL_DEVICE_ERR
> +						| INT_ON_FATAL_ERR);
> +				break;
> +			}
> +		}
> +	}
> +
>  	if (unlikely(SError & 0xFFFF0000)) {
>  		DPRINTK("serror @host_intr : 0x%x\n", SError);
>  		sata_fsl_error_intr(ap);
>  	}
>=20
> -	if (unlikely(hstatus & INT_ON_ERROR)) {
> +	if (unlikely(hstatus & status_mask)) {
>  		DPRINTK("error interrupt!!\n");
>  		sata_fsl_error_intr(ap);
>  		return;
>  	}
>=20
> -	/* Read command completed register */
> -	done_mask =3D ioread32(hcr_base + CC);
> -
>  	VPRINTK("Status of all queues :\n");
>  	VPRINTK("done_mask/CC =3D 0x%x, CA =3D 0x%x,
> CE=3D0x%x,CQ=3D0x%x,apqa=3D0x%x\n",
>  		done_mask,
> --
> 1.6.4
