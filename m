Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25F591A09EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 05:48:59 +1100 (AEDT)
Message-ID: <547CB817.10806@tabi.org>
Date: Mon, 01 Dec 2014 12:48:55 -0600
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
 Markus Pargmann <mpa@pengutronix.de>, Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de> <547C9C34.9080602@metafoo.de>
In-Reply-To: <547C9C34.9080602@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 10:49 AM, Lars-Peter Clausen wrote:
> The driver creates the mapping by calling irq_of_parse_and_map(), so it
> also has to dispose the mapping.

I agree with Markus, this does seem weird.  It sounds like you're saying 
that irq_of_parse_and_map() and devm_request_irq() are incompatible.  A 
quick grep shows the following drivers that call both functions:

ata/pata_mpc52xx.c
built-in.o
cpufreq/exynos5440-cpufreq.c
crypto/omap-sham.c
dma/moxart-dma.c
edac/mpc85xx_edac.c
hsi/clients/nokia-modem.c
i2c/busses/i2c-wmt.c
input/serio/apbps2.c
mmc/host/omap_hsmmc.c
mmc/host/moxart-mmc.c
mtd/nand/mpc5121_nfc.c
net/ethernet/arc/emac_main.c
net/ethernet/moxa/moxart_ether.c
pci/host/pcie-rcar.c
pinctrl/samsung/pinctrl-exynos5440.c
pinctrl/samsung/pinctrl-exynos.c
pinctrl/pinctrl-bcm2835.c
spi/spi-bcm2835.c
spi/spi-mpc512x-psc.c
staging/xillybus/xillybus_of.c
thermal/samsung/exynos_tmu.c
