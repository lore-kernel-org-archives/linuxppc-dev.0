Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91A8C1A0109
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 06:59:32 +1100 (AEDT)
Message-ID: <547CC89F.1030205@tabi.org>
Date: Mon, 01 Dec 2014 13:59:27 -0600
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <547CC407.30308@metafoo.de> <20141201194147.GP7712@sirena.org.uk>
 <2547588.Qc4F2IfZke@wuerfel>
In-Reply-To: <2547588.Qc4F2IfZke@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jiada Wang <jiada_wang@mentor.com>, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 Markus Pargmann <mpa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 01:56 PM, Arnd Bergmann wrote:
> All other drivers that call irq_of_parse_and_map and pass that into
> devm_request_irq just never unmap, and their interrupts are already
> mapped by the platform code, so I think it's not even a leak.

Does this mean that fsl_ssi.c should not be calling 
irq_of_parse_and_map?  How else should it get the IRQ?
