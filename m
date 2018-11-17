Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED362C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 07:09:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6405C2084A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 07:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1vIDkbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6405C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xmRk3JwVzF3mq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 18:09:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1vIDkbe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1vIDkbe"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xmPB1t5lzF3n9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 18:06:51 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so14015659lja.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 23:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fIKcjyDRicTrvbuurk8pmEnO8fySvmZKHCB2aFwXKyo=;
 b=d1vIDkbeZUZUCYskR8G7+3qH2MMSz6P51FBjnG/CkqJ7iWaUY9dyicU2YmH6olA42D
 Sp5JkcRb397m5fl5zZFVJY+eNi77Lps6tbR4yk7IXiUOT+CvsbSmn0C1eNXACcYw4zR1
 fMC3t03xr4Cnqf0749ChMGV88OFtE8sqiFGN5VedJl4L5e0SEscrTTPRjJpXVABBM/Nc
 DykZpAZ/xLephvYBoA7UGbBJMX7baxyhg7y6GPb1JyIxSKN+uRsH6271lLw/3TrF/k5d
 IiSXtuQY6TZAMsMAqvGrLMiaXdTywSthefBge9GBj5WY5CGxqscf/FcMcih0KPMYwf/O
 xdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fIKcjyDRicTrvbuurk8pmEnO8fySvmZKHCB2aFwXKyo=;
 b=hDFC7xQ+3munIqQrOimgoLqhCcvevCwTVSFwKuEJseq0zwdia7DHxb6EzsrhnGpDVk
 2npHC65EuYKvh7tA/MqBTRR899GGuHTshflkRewfndERdIMLpi+KcP4+vF7LTEScbwNX
 QXQ4DjM4eCMVo5AYyIhtLkJeNNpJRfiBmBNKli2vH1/hv1C+e+LJTuNNXTeF5ibImoHq
 oPHLBda2KMAlN8f1u0C5TlWa7AIRwLwvaInCqO5LssWF5v3jtpz+9cBGaxn/yV9j1Cxl
 ZwtJfVsriavs0mGC60dly8Q8L+ZvLd1mUwAp7JlejGPSHydM9Cxl7nOTF2u8GAJ1dKte
 y3Ug==
X-Gm-Message-State: AGRZ1gK69Oq0rn+Nr3tksJtoJZpFNtV/XJfJQY0AYERppL7ALrtpHXia
 NvtCKA54E7OPYwTzqH5crAevgK5whkKyEcDtEJY=
X-Google-Smtp-Source: AJdET5czjaiMsHoTtcU3ldJi6TO+PftdpUiKXZ88r8b39gmA5paMZgOKfehDa96kXsV8gIx4bI6GqpsYsVHngdTtUTo=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr7425061lji.93.1542438407249; 
 Fri, 16 Nov 2018 23:06:47 -0800 (PST)
MIME-Version: 1.0
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
 <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
 <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
In-Reply-To: <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 17 Nov 2018 12:40:14 +0530
Message-ID: <CAFqt6zY2bv=G1N13E4-SA2DE6ey3kw378fFzgEHV7wdpJ5hp5g@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: darren@stevens-zone.net, Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 geoff@infradead.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Joe,

On Fri, Nov 16, 2018 at 12:55 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-11-15 at 23:29 +0530, Sabyasachi Gupta wrote:
> > On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Any comment on this patch?
>
> It's obviously correct.
>
> You might realign the arguments on the next lines
> to the open parenthesis.
>
> Perhaps there should be new function calls
> added for symmetry to the other alloc functions
> for multiplication overflow protection.
>
> Perhaps:
>
> void *dma_alloc_array_coherent()
> void *dma_calloc_coherent()
>
> Something like
> ---
>  include/linux/dma-mapping.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 15bd41447025..95bebf8883b1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -565,6 +565,25 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>                         (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
>  }
>
> +static inline void *dma_alloc_array_coherent(struct device *dev,
> +                                            size_t n, size_t size,
> +                                            dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +       size_t bytes;
> +
> +       if (unlikely(check_mul_overflow(n, size, &bytes)))
> +               return NULL;
> +       return dma_alloc_coherent(dev, bytes, dma_handle, gfp);
> +}
> +
> +static inline void *dma_calloc_coherent(struct device *dev,
> +                                       size_t n, size_t size,
> +                                       dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +       return dma_alloc_array_coherent(dev, n, size, dma_handle,
> +                                       gfp | __GFP_ZERO);
> +}
> +

If I understood correctly, you are talking about adding these 2 new inline
functions. We can do that.

Can you please help to understand the consumers of these 2 new inline ?

>  static inline void dma_free_coherent(struct device *dev, size_t size,
>                 void *cpu_addr, dma_addr_t dma_handle)
>  {
>
> ---
> > > diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
> []
> > > @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
> > >
> > >         chan->ring_size = ring_size;
> > >
> > > -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> > > +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
> > >                                              ring_size * sizeof(u64),
> > >                                              &chan->ring_dma, GFP_KERNEL);
> > >  en
> > >         if (!chan->ring_virt)
> > >                 return -ENOMEM;
> > >
> > > -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> > > -
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
>
>
