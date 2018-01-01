Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9LR36W9nzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 02:17:34 +1100 (AEDT)
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
Date: Mon, 1 Jan 2018 16:17:20 +0100
MIME-Version: 1.0
In-Reply-To: <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.12.2017 18:00, Nicolin Chen wrote:
> AC97 configures some registers earlier to start a communication
> with CODECs, so this patch moves those register settings to the
> dai_probe() as well, along with other register configurations.
> 
> It also applies _fsl_ssi_set_dai_fmt() to AC97 only since other
> formats would be configured via fsl_ssi_set_dai_fmt() directly.
> 
> Meanwhile, this patch adds fsl_ssi_dai_ac97_remove() to cleanup
> some control bits for AC97.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

This patch breaks AC'97 CODEC probing.

Namely, the fsl_ssi DAI probe callback is only called after the AC'97
CODEC probe callback, so when you move SSI AC'97 startup to its DAI
probe callback it won't be done yet when the CODEC is probed (and this
requires a working AC'97 interface to successfully complete).

Maciej
