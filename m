Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D79D81007D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 11:09:39 +1100 (EST)
Message-ID: <4EDEAEB9.6020703@freescale.com>
Date: Tue, 6 Dec 2011 18:09:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <shuo.liu@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
In-Reply-To: <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
> From: Liu Shuo <shuo.liu@freescale.com>
> 
> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
> to support the Nand flash chip whose page size is larger than 2K bytes,
> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and save
> them to a large buffer.
> 
> Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
> ---
> v3:
>     -remove page_size of struct fsl_elbc_mtd.
>     -do a oob write by NAND_CMD_RNDIN. 
> 
>  drivers/mtd/nand/fsl_elbc_nand.c |  243 ++++++++++++++++++++++++++++++++++----
>  1 files changed, 218 insertions(+), 25 deletions(-)

What is the plan for bad block marker migration?

> @@ -473,13 +568,72 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  		 * write so the HW generates the ECC.
>  		 */
>  		if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column != 0 ||
> -		    elbc_fcm_ctrl->index != mtd->writesize + mtd->oobsize)
> -			out_be32(&lbc->fbcr,
> -				elbc_fcm_ctrl->index - elbc_fcm_ctrl->column);
> -		else
> +		    elbc_fcm_ctrl->index != mtd->writesize + mtd->oobsize) {
> +			if (elbc_fcm_ctrl->oob && mtd->writesize > 2048) {
> +				out_be32(&lbc->fbcr, 64);
> +			} else {
> +				out_be32(&lbc->fbcr, elbc_fcm_ctrl->index
> +						- elbc_fcm_ctrl->column);
> +			}

We need to limit ourselves to the regions that have actually been
written to in the buffer.  fbcr needs to be set separately for first and
last subpages, with intermediate subpages having 0, 64, or 2112 as
appropriate.  Subpages that are entirely before column or entirely after
column + index should be skipped.

> +		} else {
> +			out_be32(&lbc->fir, FIR_OP_WB << FIR_OP1_SHIFT);
> +			for (i = 1; i < n; i++) {
> +				if (i == n - 1) {
> +					elbc_fcm_ctrl->use_mdr = 1;
> +					out_be32(&lbc->fir,
> +						(FIR_OP_WB  << FIR_OP1_SHIFT) |
> +						(FIR_OP_CM3 << FIR_OP2_SHIFT) |
> +						(FIR_OP_CW1 << FIR_OP3_SHIFT) |
> +						(FIR_OP_RS  << FIR_OP4_SHIFT));

Please explicitly show the (FIR_OP_NOP << FIR_OP0_SHIFT) compenent.

> +	} else if (mtd->writesize >= 2048 && mtd->writesize <= 16 * 1024) {
> +
>  		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);

Don't insert a blank line here.

-Scott
