Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx1Qf1CQ0zDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 17:48:57 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id x12so11861870itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 00:48:57 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1497884657-3744-2-git-send-email-madalin.bucur@nxp.com>
References: <1497884657-3744-1-git-send-email-madalin.bucur@nxp.com>
 <1497884657-3744-2-git-send-email-madalin.bucur@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jun 2017 09:48:54 +0200
Message-ID: <CAMuHMdU6hkU03s2ZBYEYdOqO3M1djbjZ0YKw8VbHYEvsNxLZxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsl/fman: propagate dma_ops
To: madalin.bucur@nxp.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Madalin,

On Mon, Jun 19, 2017 at 5:04 PM, Madalin Bucur <madalin.bucur@nxp.com> wrot=
e:
> Make sure dma_ops are set, to be later used by the Ethernet driver.
>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fman/mac.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethe=
rnet/freescale/fman/mac.c
> index 0b31f85..6e67d22f 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -623,6 +623,8 @@ static struct platform_device *dpaa_eth_add_device(in=
t fman_id,
>                 goto no_mem;
>         }
>
> +       set_dma_ops(&pdev->dev, get_dma_ops(priv->dev));
> +

When compile-testing with f NO_DMA=3Dy:

    drivers/net/ethernet/freescale/fman/mac.c: In function
=E2=80=98dpaa_eth_add_device=E2=80=99:
    drivers/net/ethernet/freescale/fman/mac.c:626: error: implicit
declaration of function =E2=80=98set_dma_ops=E2=80=99

Reverting commit 5567e989198b5a8d fixes this regression in v4.12-rc7.

Why is this change needed?
There's no single other call to the DMA API in this file?

If it's really needed, can't set_dma_ops() be called from the driver that
needs it, cfr. your other patch "[PATCH 2/2] dpaa_eth: reuse the dma_ops
provided by the FMan MAC device"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
