Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 537FD1A09FF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 00:01:54 +1000 (AEST)
Message-ID: <558FFE4E.703@tabi.org>
Date: Sun, 28 Jun 2015 09:01:50 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
References: <558FFAC4.2060608@maciej.szmigiero.name>
In-Reply-To: <558FFAC4.2060608@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maciej S. Szmigiero wrote:
>   	/* Are the RX and the TX clocks locked? */
>   	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +		if (!fsl_ssi_is_ac97(ssi_private))
> +			ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +

Is this necessary?  Why not just add fsl,ssi-asynchronous to the AC97 
device tree node?
