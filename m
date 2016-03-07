Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 087391A0B73
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:49:23 +1100 (AEDT)
Received: by mail-wm0-x229.google.com with SMTP id p65so6355585wmp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Mar 2016 15:49:22 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1450941981-11900-1-git-send-email-xuelin.shi@nxp.com>
References: <1450941981-11900-1-git-send-email-xuelin.shi@nxp.com>
Date: Mon, 7 Mar 2016 17:49:19 -0600
Message-ID: <CADRPPNTH2+aH52rTpvDGT5k+KFFovb9spaDNR7SgR_j2KeQW1A@mail.gmail.com>
Subject: Re: [PATCH] dma driver: fix potential oom issue of fsldma
From: Li Yang <leoli@freescale.com>
To: Xuelin Shi <xuelin.shi@nxp.com>
Cc: Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 24, 2015 at 1:26 AM, Xuelin Shi <xuelin.shi@nxp.com> wrote:
> From: Xuelin Shi <xuelin.shi@freescale.com>

And please cc dmaengine maintainers and its mailing list when you send
next version.

>
> missing unmap sources and destinations while doing dequeue.
>
> Signed-off-by: Xuelin Shi <xuelin.shi@nxp.com>
> ---
>  drivers/dma/fsldma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 2209f75..aac85c3 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -522,6 +522,8 @@ static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
>                         chan_dbg(chan, "LD %p callback\n", desc);
>                         txd->callback(txd->callback_param);
>                 }
> +
> +               dma_descriptor_unmap(txd);
>         }
>
>         /* Run any dependencies */
> --
> 1.8.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
