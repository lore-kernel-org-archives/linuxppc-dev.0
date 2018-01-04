Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCKQg388nzDqZZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 07:39:06 +1100 (AEDT)
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
 <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
 <20180104190732.GA27975@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <61acf616-dd63-bccd-2c91-ce244b799f09@maciej.szmigiero.name>
Date: Thu, 4 Jan 2018 21:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180104190732.GA27975@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.01.2018 20:07, Nicolin Chen wrote:
> On Mon, Jan 01, 2018 at 04:17:20PM +0100, Maciej S. Szmigiero wrote:
>>> AC97 configures some registers earlier to start a communication
>>> with CODECs, so this patch moves those register settings to the
>>> dai_probe() as well, along with other register configurations.
>  
>> This patch breaks AC'97 CODEC probing.
>>
>> Namely, the fsl_ssi DAI probe callback is only called after the AC'97
>> CODEC probe callback, so when you move SSI AC'97 startup to its DAI
>> probe callback it won't be done yet when the CODEC is probed (and this
>> requires a working AC'97 interface to successfully complete).
> 
> Hmm...What's the dependency here? Why is it required like this?

This patch moves enabling AC'97 communication (done by
fsl_ssi_setup_ac97() ) from SSI _platform device_ probe path to
SSI _DAI_ probe path.

However, it turns out that a SSI _DAI_ probe happens after a AC'97
CODEC probe (that is, ac97_soc_probe() in sound/soc/codecs/ac97.c).
And a AC'97 CODEC probe needs AC'97 communication to be working,
since it has to detect the CODEC model, configure it, etc.

> I am okay to put everything to a separate fsl_ssi_hw_init() and
> move it back to the platform probe() though.
> 

This could be a solution - I assume that by "everything" in the above
sentence you mean (at least) enabling the AC'97 communication at the
SSI.

Maciej
