Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 33D541007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 04:17:26 +1100 (EST)
Message-ID: <4EDE4E1D.4030408@freescale.com>
Date: Tue, 6 Dec 2011 11:17:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH 2/2 v2] mtd/nand: Add ONFI support for FSL NAND controller
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1323161655-19050-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1323161655-19050-2-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mtd@lists.infradead.org, kumar.gala@freescale.com,
 linuxppc-dev@lists.ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2011 02:54 AM, Shengzhou Liu wrote:
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> index 4f405a0..b4db407 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -349,19 +349,24 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  		fsl_elbc_run_command(mtd);
>  		return;
>  
> -	/* READID must read all 5 possible bytes while CEB is active */
>  	case NAND_CMD_READID:
> -		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD_READID.\n");
> +	case NAND_CMD_PARAM:
> +		dev_vdbg(priv->dev, "fsl_elbc_cmdfunc: NAND_CMD %x\n", command);
>  
>  		out_be32(&lbc->fir, (FIR_OP_CM0 << FIR_OP0_SHIFT) |
>  		                    (FIR_OP_UA  << FIR_OP1_SHIFT) |
>  		                    (FIR_OP_RBW << FIR_OP2_SHIFT));
> -		out_be32(&lbc->fcr, NAND_CMD_READID << FCR_CMD0_SHIFT);
> -		/* nand_get_flash_type() reads 8 bytes of entire ID string */
> -		out_be32(&lbc->fbcr, 8);
> -		elbc_fcm_ctrl->read_bytes = 8;
> +		out_be32(&lbc->fcr, command << FCR_CMD0_SHIFT);
> +		/* reads 8 bytes of entire ID string */
> +		if (NAND_CMD_READID == command) {

if (command == NAND_CMD_READID) {

> +			out_be32(&lbc->fbcr, 8);
> +			elbc_fcm_ctrl->read_bytes = 8;
> +		} else {
> +			out_be32(&lbc->fbcr, 256);
> +			elbc_fcm_ctrl->read_bytes = 256;
> +		}

Any harm in always using 256?

-Scott
