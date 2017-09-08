Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpR6r0DwzzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 15:42:43 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g13so955855pfm.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 22:42:43 -0700 (PDT)
Date: Thu, 7 Sep 2017 22:42:36 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 lukma@denx.de, caleb@crome.org, max.krummenacher@toradex.com,
 arnaud.mouiche@invoxia.com, mpa@pengutronix.de, mail@maciej.szmigiero.name
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Message-ID: <20170908054235.GA9603@Asurada-CZ80>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2017 at 10:23:43PM -0700, Nicolin Chen wrote:
> The set_sysclk() now is used to override the output bit clock rate.
> But this is not a common way to implement a set_dai_sysclk(). And
> this creates a problem when a general machine driver (simple-card
> for example) tries to do set_dai_sysclk() by passing an input clock
> rate for the baud clock instead of setting the bit clock rate as
> fsl_ssi driver expected.
> 
> So this patch solves this problem by firstly removing set_sysclk()
> since the hw_params() can calculate the bit clock rate. Secondly,
> in order not to break those TDM use cases which previously might
> have been using set_sysclk() to override the bit clock rate, this
> patch changes the driver to override it based on the slot number.
> 
> The patch also removes an obsolete comment of the dir parameter.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Forgot to mention, I think that it's better to wait for a couple of
Tested-by from those who use the TDM mode of SSI before applying it.

Thanks
Nicolin
