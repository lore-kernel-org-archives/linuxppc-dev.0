Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygmzb0hjMzDr5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 11:43:38 +1100 (AEDT)
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl_ssi: AC'97 ops need regmap,
 clock and cleaning up on failure
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
 <20171121003239.GC14136@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <52c327d2-9be2-dd7a-68d4-41d304077309@maciej.szmigiero.name>
Date: Tue, 21 Nov 2017 01:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171121003239.GC14136@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.11.2017 01:32, Nicolin Chen wrote:
> On Mon, Nov 20, 2017 at 11:14:55PM +0100, Maciej S. Szmigiero wrote:
(..)
>> @@ -1460,12 +1460,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>>  				sizeof(fsl_ssi_ac97_dai));
>>  
>>  		fsl_ac97_data = ssi_private;
> 
> By the way, is there any better way to register the ops for AC97
> while we could pass the ssi_private so as to remove the global
> fsl_ac97_data?

This might be possible (if SSI private data is provided to AC'97 codec in
codecs/ac97.c in platform device data which then is modified to make use
of it), but currently ASoC AC'97 only supports one controller per system
so for a real gain this limitation would have to be addressed first.

Maciej
