Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B32C1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 09:14:27 +1100 (AEDT)
Received: by mail-ig0-x235.google.com with SMTP id z14so64665963igp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 14:14:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <569D3800.2040801@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name>
Date: Mon, 18 Jan 2016 20:14:24 -0200
Message-ID: <CAOMZO5Dgcw-5hv4=H5LcJ2NVobz+4YW7Gu=Y8y88465CYLZ+=w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Mon, Jan 18, 2016 at 5:07 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> There is no guarantee that on fsl_ssi module load
> SSI registers will have their power-on-reset values.
>
> In fact, if the driver is reloaded the values in
> registers will be whatever they were set to previously.
>
> However, the cache needs to be fully populated at probe
> time to avoid non-atomic allocations during register
> access.
>
> Special case here is imx21-class SSI, since
> according to datasheet it don't have SACC{ST,EN,DIS}
> regs.
>
> This fixes hard lockup on fsl_ssi module reload,
> at least in AC'97 mode.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
