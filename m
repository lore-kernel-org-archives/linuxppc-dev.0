Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD1491A0359
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 09:24:41 +1000 (AEST)
Message-ID: <558F30AB.4050902@maciej.szmigiero.name>
Date: Sun, 28 Jun 2015 01:24:27 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
References: <558F28E1.7040204@maciej.szmigiero.name>
 <CAOMZO5Cpgwg=7xvRm8cz8Dm6bbrLxo5Apm7y+3=Y+5Aga4e2fQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Cpgwg=7xvRm8cz8Dm6bbrLxo5Apm7y+3=Y+5Aga4e2fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Fabio,

W dniu 28.06.2015 01:06, Fabio Estevam pisze:
> Hi Maciej,
> 
> On Sat, Jun 27, 2015 at 7:51 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> Currently the AC'97 mode in fsl_ssi driver isn't functional.
> 
> Thanks for the fix. I look forward to test it on my udoo board.

Thanks.

>> This patch implements the following changes to make it work
>> properly:
>> * IPG clock have to be enabled during AC'97 CODEC
>> register access,
>> * AC'97 DAI driver struct need the same probe method as
>> I2S one to setup DMA params,
>> * AC'97 bus can support asymmetric playback/capture rates,
>> * Check whether setting AC'97 ops succeeded and
>> clean them on removal so the driver can be reloaded,
>> * AC'97 CODEC will be instantiated in AC'97 mode,
>> * Set DAI format function small fixes in AC'97 mode.
> 
> It seems like a lot of changes in a single patch.
> 
> Care to split it into smaller pieces?

OK, I will resend this split into individual patches.

>> +
>> +       ret = clk_prepare_enable(fsl_ac97_data->clk);
>> +       if (ret) {
>> +               pr_err("ac97 read clk_prepare_enable failed: %d\n",
>> +                       ret);
>> +               return -1;

> 'return ret' would be better here.

This function normal return value is an AC'97 register value,
so isn't more appropriate to return 0xffff in case of error
than linux error code?

> Thanks

Best regards,
Maciej Szmigiero
