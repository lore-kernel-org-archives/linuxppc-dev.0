Return-Path: <festevam@gmail.com>
Received: from mail-ot0-x230.google.com (mail-ot0-x230.google.com
 [IPv6:2607:f8b0:4003:c0f::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L9lf1YpyzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 01:17:49 +1000 (AEST)
Received: by mail-ot0-x230.google.com with SMTP id v6-v6so4561067otj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 08:17:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
References: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Apr 2018 12:17:47 -0300
Message-ID: <CAOMZO5AHDmpwZcgjrhQv_po9kcjJf0vXArrCEVqnOPcS7ci36Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Fix divisor calculation
 failure at lower ratio
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
 alsa-devel@alsa-project.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolin,

On Sun, Apr 8, 2018 at 8:57 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> When the desired ratio is less than 256, the savesub (tolerance)
> in the calculation would become 0. This will then fail the loop-
> search immediately without reporting any errors.
>
> But if the ratio is smaller enough, there is no need to calculate
> the tolerance because PM divisor alone is enough to get the ratio.
>
> So a simple fix could be just to set PM directly instead of going
> into the loop-search.
>
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Marek Vasut <marex@denx.de>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
