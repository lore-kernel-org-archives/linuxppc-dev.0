Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6277614008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 11:05:47 +1000 (EST)
Message-ID: <1397005523.32034.339.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/qe: Setup clock source for TDM
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Tue, 8 Apr 2014 20:05:23 -0500
In-Reply-To: <1395133745-5557-1-git-send-email-X.Xie@freescale.com>
References: <1395133745-5557-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-18 at 17:09 +0800, Xie Xiaobo wrote:
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
> index 238a07b..9a9f733 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -1,5 +1,6 @@
>  /*
> - * Copyright (C) 2006-2010 Freescale Semiconductor, Inc. All rights reserved.
> + * Copyright (C) 2006-2010, 2014 Freescale Semiconductor, Inc.
> + * All rights reserved.
>   *
>   * Authors: 	Shlomi Gridish <gridish@freescale.com>
>   * 		Li Yang <leoli@freescale.com>
> @@ -240,6 +241,12 @@ enum qe_clock qe_clock_source(const char *source)
>  	if (strcasecmp(source, "none") == 0)
>  		return QE_CLK_NONE;
>  
> +	if (strcasecmp(source, "tsync_pin") == 0)
> +		return QE_TSYNC_PIN;
> +
> +	if (strcasecmp(source, "rsync_pin") == 0)
> +		return QE_RSYNC_PIN;
> +

Binding update?

> @@ -210,3 +210,774 @@ int ucc_set_qe_mux_rxtx(unsigned int ucc_num, enum qe_clock clock,
>  
>  	return 0;
>  }
> +
> +/* tdm_num: TDM A-H port num is 0-7 */
> +int ucc_set_tdm_rxtx_clk(u32 tdm_num, enum qe_clock clock,
> +		enum comm_dir mode)
> +{
> +	u32 clock_bits, shift;
> +	struct qe_mux *qe_mux_reg;
> +	 __be32 __iomem *cmxs1cr;
> +
> +	clock_bits = 0;
> +	qe_mux_reg = &qe_immr->qmx;
> +
> +	if ((tdm_num > 7 || tdm_num < 0))
> +		return -EINVAL;
> +
> +	/* The communications direction must be RX or TX */
> +	if (!((mode == COMM_DIR_RX) || (mode == COMM_DIR_TX)))
> +		return -EINVAL;

Unnecessary parentheses.

tdm_num cannot be < 0 as it is unsigned.

Use a symbolic name rather than "7".

> +	switch (mode) {
> +	case COMM_DIR_RX:
> +		switch (tdm_num) {
> +		case 0:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK3:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK8:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 28;
> +			break;
> +		case 1:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK5:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK10:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 24;
> +			break;
> +		case 2:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK7:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK12:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 20;
> +			break;
> +		case 3:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK9:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK14:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 16;
> +			break;
> +		case 4:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK11:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK16:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 28;
> +			break;
> +		case 5:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK13:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK18:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 24;
> +			break;
> +		case 6:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK15:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK20:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 20;
> +			break;
> +		case 7:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK17:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK22:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 16;
> +			break;
> +		default:
> +				break;
> +		}
> +		break;
> +	case COMM_DIR_TX:
> +		switch (tdm_num) {
> +		case 0:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK4:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK9:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 12;
> +			break;
> +		case 1:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK6:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK11:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 8;
> +			break;
> +		case 2:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK8:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK13:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 4;
> +			break;
> +		case 3:
> +			switch (clock) {
> +			case QE_BRG3:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG4:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK1:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK2:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK10:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK15:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 0;
> +			break;
> +		case 4:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK12:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK17:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 12;
> +			break;
> +		case 5:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK14:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK19:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 8;
> +			break;
> +		case 6:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK16:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK21:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 4;
> +			break;
> +		case 7:
> +			switch (clock) {
> +			case QE_BRG12:
> +					clock_bits = 1;
> +					break;
> +			case QE_BRG13:
> +					clock_bits = 2;
> +					break;
> +			case QE_CLK23:
> +					clock_bits = 4;
> +					break;
> +			case QE_CLK24:
> +					clock_bits = 5;
> +					break;
> +			case QE_CLK18:
> +					clock_bits = 6;
> +					break;
> +			case QE_CLK3:
> +					clock_bits = 7;
> +					break;
> +			default:
> +					break;
> +			}
> +			shift = 0;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}

Unnecessary "default"s.

Please consider reformatting this data into an array.

> +	if (!clock_bits)
> +		return -ENOENT;
> +
> +	cmxs1cr = (tdm_num < 4) ? (&qe_mux_reg->cmxsi1cr_l) :
> +				  (&qe_mux_reg->cmxsi1cr_h);

Unnecessary parentheses.

> +int ucc_set_tdm_rxtx_sync(u32 tdm_num, enum qe_clock clock,
> +		enum comm_dir mode)

Similar comments as the clock function above.

> +	clock_bits = (u32) source;

Unnecessary cast.

> +#ifdef CONFIG_FSL_UCC_TDM
> +	} else {
> +		/* tdm Rx clock routing */
> +		if ((uf_info->rx_clock != QE_CLK_NONE) &&
> +			ucc_set_tdm_rxtx_clk(uf_info->tdm_num,
> +				uf_info->rx_clock, COMM_DIR_RX)) {
> +			pr_err("%s: illegal value for RX clock", __func__);
> +			ucc_fast_free(uccf);
> +			return -EINVAL;
> +		}
> +
> +		/* tdm Tx clock routing */
> +		if ((uf_info->tx_clock != QE_CLK_NONE) &&
> +			ucc_set_tdm_rxtx_clk(uf_info->tdm_num,
> +				uf_info->tx_clock, COMM_DIR_TX)) {
> +			pr_err("%s:illegal value for TX clock", __func__);
> +			ucc_fast_free(uccf);
> +			return -EINVAL;
> +		}
> +
> +		/* tdm Rx sync clock routing */
> +		if ((uf_info->rx_sync != QE_CLK_NONE) &&
> +			ucc_set_tdm_rxtx_sync(uf_info->tdm_num,
> +				uf_info->rx_sync, COMM_DIR_RX)) {
> +			pr_err("%s:illegal value for TX clock", __func__);
> +			ucc_fast_free(uccf);
> +			return -EINVAL;
> +		}
> +
> +		/* tdm Tx sync clock routing */
> +		if ((uf_info->tx_sync != QE_CLK_NONE) &&
> +			ucc_set_tdm_rxtx_sync(uf_info->tdm_num,
> +				uf_info->tx_sync, COMM_DIR_TX)) {
> +			pr_err("%s:illegal value for TX clock", __func__);
> +			ucc_fast_free(uccf);
> +			return -EINVAL;
> +		}

Please be consistent with error formatting (space after colon), and
either make the error messages distinctive, or if it isn't worthwhile,
factor out the error code to the end and use goto.  You should probably
do that anyway, even if you print a distinctive error message first.

Also you should probably provide more info in the print regarding the
particular values and subdevices involved.

-Scott
