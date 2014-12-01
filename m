Return-Path: <lars@metafoo.de>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by lists.ozlabs.org (Postfix) with ESMTP id 5C3DE1A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 04:00:18 +1100 (AEDT)
Message-ID: <547C9C34.9080602@metafoo.de>
Date: Mon, 01 Dec 2014 17:49:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>, Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de>
In-Reply-To: <20141201065046.GB27289@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org,
 nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 07:50 AM, Markus Pargmann wrote:
[...]
>
> devm_request_irq() is used by other drivers too, this should not be a
> problem. Looking at the code it seems that irq_dispose_mapping may not
> be necessary with devm_request_irq(). So I think it would be better to
> remove irq_dispose_mapping() instead.

The driver creates the mapping by calling irq_of_parse_and_map(), so it also 
has to dispose the mapping. But the easy way out is to simply use 
platform_get_irq() instead of irq_of_parse_map(). In this case the mapping 
is not managed by the device but by the of core, so the device has not to 
dispose the mapping.

- Lars
