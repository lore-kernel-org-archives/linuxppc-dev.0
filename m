Return-Path: <sshtylyov@mvista.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE5842C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 21:30:09 +1000 (EST)
Received: by lags15 with SMTP id s15so900427lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 04:30:05 -0700 (PDT)
Message-ID: <504888F8.5060907@mvista.com>
Date: Thu, 06 Sep 2012 15:28:56 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] [v2] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
References: <1346905686-27912-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1346905686-27912-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, David.Laight@ACULAB.COM,
 Anju Bhartiya <Anju.Bhartiya@freescale.com>, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 06-09-2012 8:28, Shaohui Xie wrote:

> The freescale V2 SATA controller checks if the received data length matches
> the programmed length 'ttl', if not, it assumes that this is an error.
> In ATAPI, the 'ttl' is based on max allocation length and not the actual
> data transfer length, controller will raise 'DLM' (Data length Mismatch)
> error bit in Hstatus register. Along with 'DLM', DE (Device error) and
> FE (fatal Error) bits are also set in Hstatus register, 'E' (Internal Error)
> bit is set in Serror register and CE (Command Error) and DE (Device error)
> registers have the corresponding bit set. In this condition, we need to
> clear errors in following way: in the service routine, based on 'DLM' flag,
> HCONTROL[27] operation clears Hstatus, CE and DE registers, clear Serror
> register.

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Anju Bhartiya <Anju.Bhartiya@freescale.com>
> ---
> changes for V2:
> 1. remove the using of quirk;
> 2. wrap errata codes in condition;

>   drivers/ata/sata_fsl.c |   40 +++++++++++++++++++++++++++++++++++-----
>   1 files changed, 35 insertions(+), 5 deletions(-)

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d6577b9..6b7b73e 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
[...]
> @@ -1180,26 +1181,55 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>   	void __iomem *hcr_base = host_priv->hcr_base;
>   	u32 hstatus, done_mask = 0;
>   	struct ata_queued_cmd *qc;
> -	u32 SError;
> +	u32 SError, tag;
> +	u32 status_mask = INT_ON_ERROR;
>
>   	hstatus = ioread32(hcr_base + HSTATUS);
>
>   	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
>
> +	/* Read command completed register */
> +	done_mask = ioread32(hcr_base + CC);
> +
> +	/* Workaround for data length mismatch errata */
> +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> +		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> +			qc = ata_qc_from_tag(ap, tag);
> +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> +				u32 Hcontrol;

    No uppercase in variable names please. Besides, you have 'hstatus' 
variable already and that would be inconsistent.

> +#define HCONTROL_CLEAR_ERROR	(1 << 27)
> +				/* Set HControl[27] to clear error registers */
> +				Hcontrol = ioread32(hcr_base + HCONTROL);
> +				iowrite32(Hcontrol | HCONTROL_CLEAR_ERROR,
> +						hcr_base + HCONTROL);
> +
> +				/* Clear HControl[27] */
> +				iowrite32(Hcontrol & (~HCONTROL_CLEAR_ERROR),

    Parens not needed around ~HCONTROL_CLEAR_ERROR.

> +						hcr_base + HCONTROL);

MBR, Sergei
