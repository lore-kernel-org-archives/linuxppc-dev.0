Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0FF91A0C77
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 03:57:25 +1100 (AEDT)
Message-ID: <547C9CAD.1000008@tabi.org>
Date: Mon, 01 Dec 2014 10:51:57 -0600
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
> also has to dispose the mapping. But the easy way out is to simply use
> platform_get_irq() instead of irq_of_parse_map(). In this case the
> mapping is not managed by the device but by the of core, so the device
> has not to dispose the mapping.

Is this a problem unique to the SSI driver?  Maybe devm_free_irq() 
should also dispose of the mapping?
