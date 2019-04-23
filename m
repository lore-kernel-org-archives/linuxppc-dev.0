Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99840C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 10:42:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE20F214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPpI+Wyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE20F214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pKkx71HgzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:42:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GPpI+Wyu"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pKhp1y5zzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 20:40:09 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id j13so2435644wmh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l1jRs+VjgKr89zOhBdbqqRIIlbputC+F8Zk2yYKbNgU=;
 b=GPpI+WyuDh9UF5YRcVMFIyZObqeJT7d8pRfSxWxEbzxyzzD9g/f+mpHEGsKZFjyHzW
 SJQPFd2bbh0inepg0kGnTIe/uhPn3qKZ/asAgPNLZ+VYjQ/oS9Oc3FeWV639bNQKN1ck
 4JcDhIaLrfyL2h9DDF/J76du516p8NyeGLpwMpGi4L58lEv/h2Xq5TFwhl/5PbkCskzN
 P4xac557sOvWB0r4P3AuMnhwUktvbEFAkdUBM1c7jk2xyUKHcXeWkCpd66OcSAs3+CFc
 LFxlycJm8IJushgZTkJaxWI1RX86iDBfEt9g/ydIMmosfulsQFvXS4M5VuF4oLeSXMgx
 8MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l1jRs+VjgKr89zOhBdbqqRIIlbputC+F8Zk2yYKbNgU=;
 b=K+s/MGzBHH84uP8kAj6xTUTRuaDvPluhlfKJuGIIfj5z/TpFkOt+OSKNeRscvTtK9n
 uQudJWmSUTCTRXFb454iQTJDF6R+khCHYasoC3ml4I2Cr5eoBvL3C794KNpH1eNLCucc
 rzhHM3Iw/w/6QEPk2Fam6DrgX3vxfDT3upVWDTf9e1Reypi2040ns28K1ZfEfuHrrn9X
 vDHtgQmAxlbmYOa/PYV4Y5DlD1xfXx3bCqB7C2O3/fcPjtF7tm1fDp4SachO9rjiePTx
 5uhShtOaG/rRzz7yTWnr11k/xKSWDOSXsJpHPgi9a5UpYfoAjLg9QD2+dUCNyNhPOHT3
 tZXg==
X-Gm-Message-State: APjAAAWxcbq2EDBVX2z7CiecPh+UWXNxVmNY9ZHBy0Til6YNvNUyngSi
 C20NO/R31a6tAKvuXrHm5PtxwTprSR+ECmaKcHo=
X-Google-Smtp-Source: APXvYqxX3ua8Qip8sefdRbffrTTXZjOWBfJVKhjRipliVEu+qqlgPQ7lY15svXgVJ4//LFGPkaoS3e4lRfjlEplbk9A=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr1754113wmd.124.1556016006820; 
 Tue, 23 Apr 2019 03:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190418111211.10474-1-jonas.gorski@gmail.com>
 <20190418111211.10474-2-jonas.gorski@gmail.com>
 <CAMuHMdX7E8fR+2s-gPgGLKUCdW_--YUDW7w+op3BDurgACFEmA@mail.gmail.com>
In-Reply-To: <CAMuHMdX7E8fR+2s-gPgGLKUCdW_--YUDW7w+op3BDurgACFEmA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 23 Apr 2019 12:39:59 +0200
Message-ID: <CAOiHx=mjhzG-i8H5R0A+Mu3mcBXTNEaaBhC8rwCQPMWArDA+1A@mail.gmail.com>
Subject: Re: [PATCH RFT V3 1/8] clk: divider: add explicit big endian support
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Tue, 23 Apr 2019 at 09:49, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Jonas,
>
> On Thu, Apr 18, 2019 at 1:12 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> > Add a clock specific flag to switch register accesses to big endian, to
> > allow runtime configuration of big endian divider clocks.
> >
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> > V2 -> V3:
> >  * fix passed arguments to clk_div_readl found by kbuild
> >  * drop unneeded else in clk_div_readl
> > V1 -> V2:
> >  * switch from global to local flag
> >
> >  drivers/clk/clk-divider.c    | 26 ++++++++++++++++++++++----
> >  include/linux/clk-provider.h |  4 ++++
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index e5a17265cfaf..25c7404e376c 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -25,6 +25,24 @@
> >   * parent - fixed parent.  No clk_set_parent support
> >   */
> >
> > +static inline u32 clk_div_readl(struct clk_divider *divider)
> > +{
> > +       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> > +               return ioread32be(divider->reg);
> > +
> > +       return clk_readl(divider->reg);
> > +}
> > +
> > +static inline void clk_div_writel(struct clk_divider *divider, u32 val)
> > +{
> > +       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
> > +               iowrite32be(val, divider->reg);
> > +       else
> > +               clk_writel(val, divider->reg);
> > +}
> > +
> > +#define div_mask(width)        ((1 << (width)) - 1)
>
> What's the purpose of adding this definition?
> It does not seem to be used.

No purpose at all, it's an uncaught artifact from rebasing ._.

Stephen, which one is your preferred way of fixing that?

a) a new V4 patchset without this line
b) a follow up patch that removes it
c) just removing the line yourself


Regards
Jonas
