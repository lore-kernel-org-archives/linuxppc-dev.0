Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 188B61A0519
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 13:24:59 +1000 (EST)
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by muin.pair.com (Postfix) with ESMTPSA id C74608FC19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 23:24:55 -0400 (EDT)
Received: by mail-vc0-f171.google.com with SMTP id id10so1715782vcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 20:24:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
Date: Thu, 12 Jun 2014 22:24:55 -0500
Message-ID: <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
From: Timur Tabi <timur@tabi.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Takashi Iwai <tiwai@suse.de>,
 alsa-devel mailing list <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lgirdwood@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 12, 2013 at 4:44 AM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:
>
> +static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> +                                 int clk_id, unsigned int freq, int dir)
> +{
> +       struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> +       struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> +       int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
> +       u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
> +       unsigned long flags, clkrate, baudrate, tmprate;
> +       u64 sub, savesub = 100000;
> +
> +       /* Don't apply it to any non-baudclk circumstance */
> +       if (IS_ERR(ssi_private->baudclk))
> +               return -EINVAL;
> +
> +       /* It should be already enough to divide clock by setting pm alone */
> +       psr = 0;
> +       div2 = 0;
> +
> +       factor = (div2 + 1) * (7 * psr + 1) * 2;
> +
> +       for (i = 0; i < 255; i++) {
> +               /* The bclk rate must be smaller than 1/5 sysclk rate */
> +               if (factor * (i + 1) < 5)
> +                       continue;
> +
> +               tmprate = freq * factor * (i + 2);
> +               clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
> +
> +               do_div(clkrate, factor);

This do_div() call causes this warning on PowerPC:

  CC      sound/soc/fsl/fsl_ssi.o
sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_set_bclk':
sound/soc/fsl/fsl_ssi.c:593:3: warning: comparison of distinct pointer
types lacks a cast
sound/soc/fsl/fsl_ssi.c:593:3: warning: right shift count >= width of type
sound/soc/fsl/fsl_ssi.c:593:3: warning: passing argument 1 of
'__div64_32' from incompatible pointer type
include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but
argument is of type 'long unsigned int *'

The comments in do_div() say that clkrate should be 64-bits.  Changing
clkrate to a u64 does fix this problem, but I'm wondering if anyone
else has seen this.  This code has been around for months.
