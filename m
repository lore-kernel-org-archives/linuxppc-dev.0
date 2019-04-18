Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A58C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:03:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E64206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxjmOoYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E64206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lCng2WX5zDqRB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxjmOoYA"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lCk25TBfzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:00:26 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id v14so1943909wmf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pw1FAqykH+UF3fjtfJ6Mf6wdF0exFztFvJZAXvxyVKg=;
 b=DxjmOoYA5FR/fxL2GlrgwGjwPyKtTP/YcrqtSZmwfzz7IFCtkHI1TUoNZGLvt6Jrrx
 OJ+Uz5tuK+DVJIzMU7nK8P6pEfLwwNdnQ7yCLAeMVtAz6fV1pUhHfDCFlPLTF+pAL6uh
 XEKAyV40QSXBLcOc1+5/T+TaGhfwEBdQUL7b+koJNCSMXaEFd10SukQbyuqLIVh/oy58
 3H+CUy9HFk/xPZr43wgjUVGqaaVxxYz6sXGXq4fRQakoqi6qUgdVstNtxuYIHVQ3FkQP
 FDpKmA8yEMmLCl2IuQSQDlsXul1lmGohaQpYQjq1SXmCZbV7K0tjx8hFTMXQ2UB+ziG3
 EYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pw1FAqykH+UF3fjtfJ6Mf6wdF0exFztFvJZAXvxyVKg=;
 b=YPKqb0e2ZMq2kA/UYZAmRrHtlWatNiDWS7eZ5fGM3qTyZU+/3ArDKNd6vs8lj/EY0c
 GNOqnCjoGwmR6R9m2SWdi+dytZ0zXSIqupCccTx757ESdSfUxir22H9FOEk+gaIClG/p
 hvdu4Vm6YN6Lmcj6gvVIxvPO46uN433nkSjemHbTBxPKKU9qeRknZFaAW6p37TytLjAa
 1MZzjg0tMXi7mu9KWwG9DxxBa3pJnzrPb4gx4TBuqB6RhAxiXUq9cAGaP5s39u1pSoKW
 Puu0/aXAILSNi8PtleeKp8B7pQuN+WtKiR6cy/UAslCWckbdJQmgDxOTH0C9T7r60EeY
 Gdjg==
X-Gm-Message-State: APjAAAXYBP7VzIi/iQQ3fYaBOhR1jWKNUF/iKAWwePYByUcvNOpknA5J
 z6yMcj6QX4BCT8dB80kbjx3yAXRt5rt/FfIfY90=
X-Google-Smtp-Source: APXvYqxUMeQRyOVazc5Uz46XVpBJSOKQ6ZFOR6P6n+hVm64dZztoOKs+Xqs13J0NQk+GKCgnYKiHlkrwZga7h8tXC/E=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr2149650wmd.124.1555578022703; 
 Thu, 18 Apr 2019 02:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190415101046.5872-1-jonas.gorski@gmail.com>
 <20190415101046.5872-2-jonas.gorski@gmail.com>
 <155554397723.15276.10863024281240089015@swboyd.mtv.corp.google.com>
In-Reply-To: <155554397723.15276.10863024281240089015@swboyd.mtv.corp.google.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 18 Apr 2019 11:00:21 +0200
Message-ID: <CAOiHx==vJ7ss3G8poddKpdDA_3U9bh9LtBaaFZ2EcxxGF4nNGA@mail.gmail.com>
Subject: Re: [PATCH RFT V2 1/8] clk: divider: add explicit big endian support
To: Stephen Boyd <sboyd@kernel.org>
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
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Prashant Gaikwad <pgaikwad@nvidia.com>,
 Paul Mackerras <paulus@samba.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-tegra@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 18 Apr 2019 at 01:32, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Jonas Gorski (2019-04-15 03:10:39)
> > @@ -370,7 +388,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> >         if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> >                 u32 val;
> >
> > -               val = clk_readl(divider->reg) >> divider->shift;
> > +               val = clk_div_readl(divider->reg) >> divider->shift;
>
> Good deal that kbuild running sparse found that this was supposed to be
> divider and not divider->reg. If you can fix that and remove the else in
> all the basic type readl wrappers then this series looks good to merge
> for me.

Yeah, I'm quite glad about that. I was first confused why I didn't
catch it in my test build, but then remembered only C++ complains
about implicit void* casts (IIRC). I have it already fixed locally and
did a sparse build myself, was just waiting for at least one non-bot
comment before resending the series.


Regards
Jonas
