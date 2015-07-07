Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51CC21A19AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 11:36:05 +1000 (AEST)
References: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
In-Reply-To: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Message-Id: <D774C024-C728-47EF-AAD3-9F17B99B61B0@tabi.org>
Cc: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel][PATCH 1/2] ASoC: fsl_ssi: Add driver suspend and
 resume to support MEGA Fast
Date: Mon, 6 Jul 2015 21:36:02 -0400
To: Zidan Wang <zidan.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 6, 2015, at 4:49 AM, Zidan Wang wrote:

> +static bool fsl_ssi_readable_reg(struct device *dev, unsigned int =
reg)
> +{
> +	switch (reg) {
> +	case CCSR_SSI_STX0:
> +	case CCSR_SSI_STX1:
> +	case CCSR_SSI_SRX0:
> +	case CCSR_SSI_SRX1:
> +	case CCSR_SSI_SCR:
> +	case CCSR_SSI_SISR:
> +	case CCSR_SSI_SIER:
> +	case CCSR_SSI_STCR:
> +	case CCSR_SSI_SRCR:
> +	case CCSR_SSI_STCCR:
> +	case CCSR_SSI_SRCCR:
> +	case CCSR_SSI_SFCSR:
> +	case CCSR_SSI_STR:
> +	case CCSR_SSI_SOR:
> +	case CCSR_SSI_SACNT:
> +	case CCSR_SSI_SACADD:
> +	case CCSR_SSI_SACDAT:
> +	case CCSR_SSI_SATAG:
> +	case CCSR_SSI_STMSK:
> +	case CCSR_SSI_SRMSK:
> +	case CCSR_SSI_SACCST:
> +	case CCSR_SSI_SACCEN:
> +	case CCSR_SSI_SACCDIS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

This should be the other way around: return true by default, and false =
it is one of the few registers that is not readable.=
