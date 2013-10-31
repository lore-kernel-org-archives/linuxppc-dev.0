Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id EC6982C03D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 23:04:34 +1100 (EST)
Message-ID: <5272474D.5000207@tabi.org>
Date: Thu, 31 Oct 2013 07:04:29 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>, s.hauer@pengutronix.de,
 shawn.guo@linaro.org, broonie@kernel.org
Subject: Re: [PATCH v3 3/4] ASoC: fsl_ssi: Add dual fifo mode support
References: <cover.1383207153.git.b42378@freescale.com>
 <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
In-Reply-To: <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 philippe.retornaz@gmail.com, galak@codeaurora.org, dmaengine@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
> +	if (ssi_private->use_dual_fifo) {
> +		write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
> +		write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
> +		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
> +	} else {
> +		write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
> +		write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
> +		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
> +	}

Why do you need the "else" part?  Why can't you just do this:

if (ssi_private->use_dual_fifo) {
	write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
	write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
}
