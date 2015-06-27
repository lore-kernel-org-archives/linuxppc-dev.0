Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A43841A0359
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 09:06:52 +1000 (AEST)
Received: by lagh6 with SMTP id h6so18258530lag.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 16:06:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <558F28E1.7040204@maciej.szmigiero.name>
References: <558F28E1.7040204@maciej.szmigiero.name>
Date: Sat, 27 Jun 2015 20:06:47 -0300
Message-ID: <CAOMZO5Cpgwg=7xvRm8cz8Dm6bbrLxo5Apm7y+3=Y+5Aga4e2fQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maciej,

On Sat, Jun 27, 2015 at 7:51 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Currently the AC'97 mode in fsl_ssi driver isn't functional.

Thanks for the fix. I look forward to test it on my udoo board.

> This patch implements the following changes to make it work
> properly:
> * IPG clock have to be enabled during AC'97 CODEC
> register access,
> * AC'97 DAI driver struct need the same probe method as
> I2S one to setup DMA params,
> * AC'97 bus can support asymmetric playback/capture rates,
> * Check whether setting AC'97 ops succeeded and
> clean them on removal so the driver can be reloaded,
> * AC'97 CODEC will be instantiated in AC'97 mode,
> * Set DAI format function small fixes in AC'97 mode.

It seems like a lot of changes in a single patch.

Care to split it into smaller pieces?

Thanks
