Return-Path: <philippe.retornaz@gmail.com>
Received: from mail-ea0-x22f.google.com (mail-ea0-x22f.google.com
 [IPv6:2a00:1450:4013:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 460402C0185
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 18:54:19 +1100 (EST)
Received: by mail-ea0-f175.google.com with SMTP id l15so974439eak.34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 00:54:14 -0700 (PDT)
Message-ID: <52720CA4.3090003@gmail.com>
Date: Thu, 31 Oct 2013 08:54:12 +0100
From: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@gmail.com>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
References: <cover.1383197521.git.b42378@freescale.com>
 <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
In-Reply-To: <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 galak@codeaurora.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

>
> +			/* When using dual fifo mode, we need to keep watermark
> +			 * as even numbers due to dma script limitation.
> +			 */
> +			ssi_private->dma_params_tx.maxburst /= 2;
> +			ssi_private->dma_params_tx.maxburst *= 2;
> +			ssi_private->dma_params_rx.maxburst /= 2;
> +			ssi_private->dma_params_rx.maxburst *= 2;
>

Why not using a mask here ?
ssi_private->dma_params_tx.maxburst &= ~0x1;
ssi_private->dma_params_rx.maxburst &= ~0x1;

Regards,

Philippe
