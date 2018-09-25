Return-Path: <olof@lixom.net>
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KWlv6QvQzDr4m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 05:46:18 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id y71-v6so6479737lje.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 12:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
From: Olof Johansson <olof@lixom.net>
Date: Tue, 25 Sep 2018 21:45:56 +0200
Message-ID: <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> unmapped page.
>
> This leads to a crash when probing  qman_portal as the init_pcfg function
> calls qman_liodn_fixup that tries to read qman registers.
>
> Assume that qman didn't probe when the pool mask is 0.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index a120002b630e..4fc80d2c8feb 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>         }
>
>         pcfg->pools = qm_get_pools_sdqcr();
> +       if (pcfg->pools == 0)
> +               return -EPROBE_DEFER;

This is quite late in the probe, after a bunch of resources have been claimed.

Note that the ioremaps above this are doing unwinds, and you'll end up
doing duplicate ioremaps if you come in and probe again.

You should probably unwind those allocations, or move them to devm_*
or do this check earlier in the function.


-Olof
