Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:51:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD6D20645
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD6D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pFxz1rpFzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:51:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.65; helo=mail-vs1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pFw96WqGzDqLn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 17:49:43 +1000 (AEST)
Received: by mail-vs1-f65.google.com with SMTP id w13so7716537vsc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 00:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iaE8IUlf60hL4IwALqewtJ+kk5muvzJCn/QJKmcD5nw=;
 b=HxZmNx3pIauUL1EOGJUDgY3rEjRcR1crgTFrooaCGQ8Kjmabx0TklsoUHuX5crtXXs
 pWRGoMqXs1qHEp6YXzO3IwDuAKp2ryv7D2VR/lkdnOEHe6nYrmeKGYQGYk6ivLRITO+A
 tuQz4ZDlzT+yZHKoUKV0cZOmcQHdAjnmb6lgYoEHv+6rKST/VbiSItKbKuzZud/2eMVm
 WKNLSt+RnFiA8MY3jyidmJlSQPrUBuOrZUrwvwfwjtF66pXQwmVc5U5rXka+pCUU3tri
 0PR+Nu+h2Nm7d7WgyzkgUDl6/fC/OWgwv/UxLu2yiTJAa2FpYae9zLiYwvHaeFaDZ/z7
 clsw==
X-Gm-Message-State: APjAAAXzW7gGXjSg1xpVKVfR3MUGFQLdHhGCuGGMqk8e1EB+Q7mvXeCJ
 CVXLfAcneFXIwGEvFctDlYzLwDlry5KLgB8czbM=
X-Google-Smtp-Source: APXvYqwePCTMrrLrJ90Oq7fNmWzT8iMPfnUzQtV6TZGLzWU6MT52/ml65Nt8iafXxqW5uSlSP2EdgZ1PeA4LJ3ksQeE=
X-Received: by 2002:a67:f34f:: with SMTP id p15mr11955838vsm.11.1556005780530; 
 Tue, 23 Apr 2019 00:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190418111211.10474-1-jonas.gorski@gmail.com>
 <20190418111211.10474-2-jonas.gorski@gmail.com>
In-Reply-To: <20190418111211.10474-2-jonas.gorski@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2019 09:49:28 +0200
Message-ID: <CAMuHMdX7E8fR+2s-gPgGLKUCdW_--YUDW7w+op3BDurgACFEmA@mail.gmail.com>
Subject: Re: [PATCH RFT V3 1/8] clk: divider: add explicit big endian support
To: Jonas Gorski <jonas.gorski@gmail.com>
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
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Fabio Estevam <festevam@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 NXP Linux Team <linux-imx@nxp.com>, Anatolij Gustschin <agust@denx.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <sboyd@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jonas,

On Thu, Apr 18, 2019 at 1:12 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> Add a clock specific flag to switch register accesses to big endian, to
> allow runtime configuration of big endian divider clocks.
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> V2 -> V3:
>  * fix passed arguments to clk_div_readl found by kbuild
>  * drop unneeded else in clk_div_readl
> V1 -> V2:
>  * switch from global to local flag
>
>  drivers/clk/clk-divider.c    | 26 ++++++++++++++++++++++----
>  include/linux/clk-provider.h |  4 ++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e5a17265cfaf..25c7404e376c 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -25,6 +25,24 @@
>   * parent - fixed parent.  No clk_set_parent support
>   */
>
> +static inline u32 clk_div_readl(struct clk_divider *divider)
> +{
> +       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> +               return ioread32be(divider->reg);
> +
> +       return clk_readl(divider->reg);
> +}
> +
> +static inline void clk_div_writel(struct clk_divider *divider, u32 val)
> +{
> +       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> +               iowrite32be(val, divider->reg);
> +       else
> +               clk_writel(val, divider->reg);
> +}
> +
> +#define div_mask(width)        ((1 << (width)) - 1)

What's the purpose of adding this definition?
It does not seem to be used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
