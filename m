Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2A752C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 07:58:13 +1000 (EST)
Received: by mail-pd0-f173.google.com with SMTP id bv13so2176641pdb.32
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 14:58:10 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1326313337-24603-12-git-send-email-grant.likely@secretlab.ca>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-12-git-send-email-grant.likely@secretlab.ca>
Date: Thu, 25 Jul 2013 23:58:10 +0200
Message-ID: <CAMuHMdV=pSG+CtvGqr1c9nDKeHCU0cVQcFkfAo5iMMna2HOvZg@mail.gmail.com>
Subject: Re: [RFC 11/14] powerpc: Eliminate NO_IRQ usage
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@arm.linux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, Linux-Next <linux-next@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2012 at 9:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> NO_IRQ is evil.  Stop using it in arch/powerpc and powerpc device drivers

> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 3e06696..55c6ff9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -666,7 +666,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>         ssi_private->ssi_phys = res.start;
>
>         ssi_private->irq = irq_of_parse_and_map(np, 0);
> -       if (ssi_private->irq == NO_IRQ) {
> +       if (!ssi_private->irq) {
>                 dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
>                 ret = -ENXIO;
>                 goto error_iomap;

What's the plan with this patch?

This is now failing on xtensa, as it's one of the architectures that doesn't
define NO_IRQ. Only arm, c6x, mn10300, openrisc, parisc, powerpc, and sparc
define it.

sound/soc/fsl/fsl_ssi.c:705:26: error: 'NO_IRQ' undeclared (first use
in this function)
make[4]: *** [sound/soc/fsl/fsl_ssi.o] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/9187959/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
