Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F5EE1A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 08:33:58 +1100 (AEDT)
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
References: <56770FE1.4060202@maciej.szmigiero.name>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5692CE43.20708@tabi.org>
Date: Sun, 10 Jan 2016 15:33:55 -0600
MIME-Version: 1.0
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
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
> +	regmap_write(regs, CCSR_SSI_SACNT,
> +			ssi_private->regcache_sacnt);

So I'm not familiar with all of the regcache features, but I understand 
this patch.  I was wondering if it makes sense to write the same exact 
value that was read previously.  Isn't it possible for the WR or RD bits 
to change between fsl_ssi_suspend() and fsl_ssi_resume()?  That is, 
should we be doing this instead?

u32 temp;
regmap_read(regs, CCSR_SSI_SACNT, &temp);
temp &= 0x18; // preserve WR and RD
regmap_write(regs, CCSR_SSI_SACNT, (ssi_private->regcache_sacnt & ~0x18) 
| temp);
