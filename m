Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA506C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498E2208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmdEQBVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498E2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wq2T1L4jzDqkJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:02:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmdEQBVj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmdEQBVj"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wpzn6dwszDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 05:00:05 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id v68-v6so10067603pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=53ULN/eUPXJWILCpXkBWhrT7ZwImYSEtLPNzjJN0TII=;
 b=AmdEQBVjNuJFw+0ioZ3L9QRNJ2+RS0FiClJTht0FofgD5UK5Q5SIrK4kjWvUscbD+g
 sSClySqVNbX4A3jIF4d2A6qo0BjLS5oQccO+sZ/ZHzLVvxX4THBcSD/dZKECUWSKgdJg
 JxpCZimjupLMLl2X6ghjl7Pd6BKVYi4fjiyJsNo6BxYQ3nBHWCAyeHcBfTYOfxbdKAgX
 Dn/vjmQzRtqnFASg/1HPDtrxU/6C0FNzQdLhlC5yc814U49ylyiqAsUs5efbj7SwU6Tu
 dgcbmWh4J5/1djkP0VFpiXloqVTTBrAyn2Puic5KoNma9uiXDcohALgrPRVfeJ6FUpyn
 t6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53ULN/eUPXJWILCpXkBWhrT7ZwImYSEtLPNzjJN0TII=;
 b=jyV3mze41Boos5aDMF4PPCTevMwbTUm+GCQk3b0tTLiL0jhrjBZpyeToT5MkbmzdMP
 9oI73GCKjkfrOq+rs8UWIsM0uD0eQnnmMYjhA4U+MIe5GmcIGAWQLSoEfFoIkY4LhFyR
 1+udG2aqO8zh1zB09zfIF79y8njADUH3SZs1HZ9f5JHOSDhjAi5pUKAIYbwwGRYYyyyY
 Bw0obVETFcXgydjMiwmLpnrjFOv/rcWtoK46zfDF1031OruDfW8YAHsOXzLYXUDLb93b
 YXY3jjvUsIy5KmAM8XhzfAiFsu4l7gydQJVB+ggJ6micshLNN+IevEOHmZNR3edwQ7JY
 UCJA==
X-Gm-Message-State: AGRZ1gJzcFdkM6ju5EzUc5ypZ/QESR3/YaifOmDZvjuQImIpn7YwyPKH
 ziBKnPmeq0sVXdCCN5S1BF++O3pXXHkFRGB6XIQ=
X-Google-Smtp-Source: AJdET5dIE5Q756/4N7rZNkhbsYEd+dz02gGnwlFO7tpoACMwa1eDOxKK3/Kfr8tyEhwSSzBdrpU1uB9G62Co8K2V7Wg=
X-Received: by 2002:a63:7154:: with SMTP id b20mr6685371pgn.342.1542304804137; 
 Thu, 15 Nov 2018 10:00:04 -0800 (PST)
MIME-Version: 1.0
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
In-Reply-To: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 15 Nov 2018 23:29:52 +0530
Message-ID: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, 
 joe@perches.com, darren@stevens-zone.net, christophe.leroy@c-s.fr, 
 geoff@infradead.org
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
Cc: linuxppc-dev@lists.ozlabs.org, Souptick Joarder <jrdr.linux@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/powerpc/platforms/pasemi/dma_lib.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
> index 53384eb..d18d164 100644
> --- a/arch/powerpc/platforms/pasemi/dma_lib.c
> +++ b/arch/powerpc/platforms/pasemi/dma_lib.c
> @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
>
>         chan->ring_size = ring_size;
>
> -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
>                                              ring_size * sizeof(u64),
>                                              &chan->ring_dma, GFP_KERNEL);
>
>         if (!chan->ring_virt)
>                 return -ENOMEM;
>
> -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> -
>         return 0;
>  }
>  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
> --
> 2.7.4
>
