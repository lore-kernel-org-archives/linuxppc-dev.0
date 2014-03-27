Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE735140079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 13:29:45 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 02:13:48 +0000
Message-ID: <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
In-Reply-To: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> +
> +	if (xcsr & FSL_SAI_CSR_WSF)
> +		dev_dbg(dev, "isr: Start of Tx word detected\n");
> +
> +	if (xcsr & FSL_SAI_CSR_SEF)
> +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
> +
> +	if (xcsr & FSL_SAI_CSR_FEF)
> +		dev_dbg(dev, "isr: Transmit underrun detected\n");
> +

Actually, the above three isrs should to write a logic 1 to this field
to clear this flag.


> +	if (xcsr & FSL_SAI_CSR_FWF)
> +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> +
> +	if (xcsr & FSL_SAI_CSR_FRF)
> +		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
> +

While are these ones really needed to clear manually ?


Thanks,
--

Best Regards,
Xiubo
