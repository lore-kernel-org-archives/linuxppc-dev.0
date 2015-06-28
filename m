Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C10C01A0BC4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 05:12:37 +1000 (AEST)
Message-ID: <55904713.4020101@maciej.szmigiero.name>
Date: Sun, 28 Jun 2015 21:12:19 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
References: <558FFAC4.2060608@maciej.szmigiero.name> <558FFE4E.703@tabi.org>
In-Reply-To: <558FFE4E.703@tabi.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

W dniu 28.06.2015 16:01, Timur Tabi pisze:
> Maciej S. Szmigiero wrote:
>>       /* Are the RX and the TX clocks locked? */
>>       if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
>> -        ssi_private->cpu_dai_drv.symmetric_rates = 1;
>> +        if (!fsl_ssi_is_ac97(ssi_private))
>> +            ssi_private->cpu_dai_drv.symmetric_rates = 1;
>> +
> 
> Is this necessary?  Why not just add fsl,ssi-asynchronous to the AC97 device tree node?

Because in the AC'97 mode the driver supports only one channel config and one sample format
anyway the remaining settings controlled by this property don't do anything.

Since it should be safe to enable asymmetric rates with any AC'97 CODEC I think it is good
to do it in driver than to add "fsl,ssi-asynchronous" to every AC'97 DT node.

Also the description of this property in fsl,ssi.txt looks like that it only makes sense in
non-AC'97 mode.

Best regards,
Maciej Szmigiero
