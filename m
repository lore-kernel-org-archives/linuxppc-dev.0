Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 6D5D1DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:13:32 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so105704wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:13:31 -0800 (PST)
Message-ID: <9e4733910712201513t329e2a49j420cb3b4ece5057@mail.gmail.com>
Date: Thu, 20 Dec 2007 18:13:31 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <476AF061.1030605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
	<476AED87.3090703@freescale.com>
	<9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
	<476AEF47.8040802@freescale.com> <476AF061.1030605@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/20/07, Scott Wood <scottwood@freescale.com> wrote:
> Timur Tabi wrote:
> > Jon Smirl wrote:
> >
> >> mpc5200 does it like this:
> >> of_platform_bus_probe(NULL, NULL, NULL);
> >
> > I think that tells the OF base code to probe everything in the device tree,
> > which is probably overkill.  I think fsl_soc.c covers most of the device tree,
> > but the SSI is not defined in fsl_soc.c.
>
> Not quite; it tells it to use a built-in list of bus matches.  Most of
> which are device_type-based, FWIW.

Here's the default. Using NULL would work.

static struct of_device_id of_default_bus_ids[] = {
        { .type = "soc", },
        { .compatible = "soc", },
        { .type = "spider", },
        { .type = "axon", },
        { .type = "plb5", },
        { .type = "plb4", },
        { .type = "opb", },
        { .type = "ebc", },
        {},
};


>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
