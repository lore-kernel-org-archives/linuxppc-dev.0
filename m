Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CA8C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:17:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2002084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIzBGpzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2002084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fz55211XzDqRJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:17:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIzBGpzE"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fz3N4xsqzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:15:43 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id s39so4868301edb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMzOF4uSDEO2czI0u54xXAsMS0XJszj2itVS4kGxliE=;
 b=aIzBGpzEc+WkohNa9Z2aqEpD+O1b6cnlEt1JZ42UBLnEPAK5ueo66UUwQ/3uDaeSxt
 CAv2HaWP/4BrjgujYwvqBHpvBGVdlhfbPFql+Z+kidt4EmeC9c3R5JWjhJwCZq6vvVsV
 NMGmkGZGS/pJIs9cLnp70uyDsdBbaUJ6FO99Z9J6H0rHhGTVTQm1WauPAj3TkDZzt+1P
 +sZNna9PN0nRvNcrayjq8YJqAp48Y8GJatpCKBuqbyzvKiDiPq+zhDnrqkVUe8smF7jN
 +iRWRhJJ+ypexp5qB6xmmLttXirrM1lU/AuZY3UD+lL0P9Ptzvk7BX7pF3A5h1IY3K8z
 Jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMzOF4uSDEO2czI0u54xXAsMS0XJszj2itVS4kGxliE=;
 b=oin5YR9+uKPY88UpdAalh1lurioBE6cLWPfF3+k9QpA64Q6EMDIqw5WHhtA+HRyy8e
 xrVXLWZBJAzW5IELV07dZs28YJuhxX6Jma5oLvoKldmIs75gAFqmVMjrylUeOFZXrjF7
 LGtgTzsZAWzB4SBm8iO1nL1aSCVZcmgWbhXp/tb28Wcaw0/g0Qg3jsnvfWnZuGuRkRId
 SqrWinFaIZCP+zw1QeTpgRIIYtkYYKLO+988Doqr307rw2jCPX9EJPIvmZM0+WoZpf5D
 mb4VOS1GCTuTGey4nva+5tlFAvdwkxpq9Z0JGEYn4rCaW/lCzJWBxQZwGLcvoq496JM+
 KrnA==
X-Gm-Message-State: APjAAAUfrmiEu5+ee2fk6hu2tinF3MZD1WSfvtpEoUfqLU8SHY8p4OLr
 rswCpsg3tLIE9UPuw2aEmedZzdt8ozDCf+e8JJg=
X-Google-Smtp-Source: APXvYqwtFkdXzzznOt+LGqMT+WWQHuvaK5bL+8ulM1daZktTxcAkO+p9DA5+QKyNnw1BtNmN9qlbJ53aybHPgPqK3GI=
X-Received: by 2002:a05:6402:12d5:: with SMTP id
 k21mr16320470edx.75.1554981339790; 
 Thu, 11 Apr 2019 04:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
In-Reply-To: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 11 Apr 2019 14:15:28 +0300
Message-ID: <CAEnQRZAQk1w79uqFCBCkFy=4_FQvxetfPsS10c+AMddJpc1VNg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
To: "S.j. Wang" <shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

Mostly looking good. See few comments inline:

<snip>

> +/*
> + * Select the pre-processing and post-processing options
> + *
> + * Fsin: input sample rate
> + * Fsout: output sample rate
> + * pre_proc: return value for pre-processing option
> + * post_proc: return value for post-processing option
> + */
> +static int fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)

Lets be naming consistent here: Fsin -> fs_in, Fsout -> fs_out.

> +{
> +       bool det_out_op2_cond;
> +       bool det_out_op0_cond;
> +
> +       /* Codition for selection of post-processing */
> +       det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +                                       ((Fsin > 56000) & (Fsout < 56000)));
Remove outer parenthesis. Also should here be a logical or (||)
instead of bitwise or (|)?
Same for && vs &.

> +       det_out_op0_cond = (Fsin * 23 < Fsout * 8);

Remove outer parenthesis.
> +
> +       /*
> +        * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
> +        * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> +        * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> +        * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> +        * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout
> +        */
> +       if (Fsin * 8 > 129 * Fsout)
> +               *pre_proc = 5;
> +       else if (Fsin * 8 > 65 * Fsout)
> +               *pre_proc = 4;
> +       else if (Fsin * 8 > 33 * Fsout)
> +               *pre_proc = 2;
> +       else if (Fsin * 8 > 15 * Fsout) {
> +               if (Fsin > 152000)
> +                       *pre_proc = 2;
> +               else
> +                       *pre_proc = 1;
> +       } else if (Fsin < 76000)
> +               *pre_proc = 0;
> +       else if (Fsin > 152000)
> +               *pre_proc = 2;
> +       else
> +               *pre_proc = 1;
> +
> +       if (det_out_op2_cond)
> +               *post_proc = 2;
> +       else if (det_out_op0_cond)
> +               *post_proc = 0;
> +       else
> +               *post_proc = 1;
> +
> +       /* unsupported options */
> +       if (*pre_proc == 4 || *pre_proc == 5)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /**
>   * Request ASRC pair
>   *
> @@ -239,8 +278,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         u32 inrate, outrate, indiv, outdiv;
>         u32 clk_index[2], div[2];
>         int in, out, channels;
> +       int pre_proc, post_proc;
>         struct clk *clk;
>         bool ideal;
> +       int ret;
>
>         if (!config) {
>                 pair_err("invalid pair config\n");
> @@ -289,6 +330,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>                 return -EINVAL;
>         }
>
> +       ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +       if (ret) {
> +               pair_err("No supported pre-processing options\n");
> +               return ret;
> +       }
> +
>         /* Validate input and output clock sources */
>         clk_index[IN] = clk_map[IN][config->inclk];
>         clk_index[OUT] = clk_map[OUT][config->outclk];
> @@ -380,8 +427,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         /* Apply configurations for pre- and post-processing */
>         regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>                            ASRCFG_PREMODi_MASK(index) | ASRCFG_POSTMODi_MASK(index),
> -                          ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -                          ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +                          ASRCFG_PREMOD(index, pre_proc) |
> +                          ASRCFG_POSTMOD(index, post_proc));
>
>         return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
>  }
> --
> 1.9.1
>
