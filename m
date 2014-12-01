Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A25C1A017B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 07:02:10 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
Date: Mon, 01 Dec 2014 21:01:43 +0100
Message-ID: <3401240.VsRpsiV8WN@wuerfel>
In-Reply-To: <547CC89F.1030205@tabi.org>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <2547588.Qc4F2IfZke@wuerfel> <547CC89F.1030205@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jiada Wang <jiada_wang@mentor.com>, Li.Xiubo@freescale.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
 tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 01 December 2014 13:59:27 Timur Tabi wrote:
> On 12/01/2014 01:56 PM, Arnd Bergmann wrote:
> > All other drivers that call irq_of_parse_and_map and pass that into
> > devm_request_irq just never unmap, and their interrupts are already
> > mapped by the platform code, so I think it's not even a leak.
> 
> Does this mean that fsl_ssi.c should not be calling 
> irq_of_parse_and_map?  How else should it get the IRQ?

platform_get_irq()

	Arnd
