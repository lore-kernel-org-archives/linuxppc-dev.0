Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 7D7C8B70A6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 03:43:40 +1000 (EST)
Received: by bwz17 with SMTP id 17so2421842bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 10:43:38 -0700 (PDT)
Date: Mon, 9 Aug 2010 21:43:33 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Message-ID: <20100809174333.GC7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 04, 2010 at 07:02:56PM -0600, Grant Likely wrote:
> On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add auto CMD12 command support for eSDHC driver.
> > This is needed by P4080 and P1022 for block read/write.
> > Manual asynchronous CMD12 abort operation causes protocol violations on
> > these silicons.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-of-core.c |    4 ++++
> >  drivers/mmc/host/sdhci.c         |   14 ++++++++++++--
> >  drivers/mmc/host/sdhci.h         |    2 ++
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c6d1bd8..a92566e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -817,8 +817,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >        WARN_ON(!host->data);
> >
> >        mode = SDHCI_TRNS_BLK_CNT_EN;
> > -       if (data->blocks > 1)
> > -               mode |= SDHCI_TRNS_MULTI;
> > +       if (data->blocks > 1) {
> > +               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > +                       mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
> > +               else
> > +                       mode |= SDHCI_TRNS_MULTI;
> 
> nit:
> +               mode |= SDHCI_TRNS_MULTI;
> +               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> +                       mode |= SDHCI_TRNS_ACMD12;
> 
> Clearer, no?

Much clearer. I would prefer the nit incorporated.

Another nit:

> @@ -154,6 +154,10 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
>                 host->ops = &sdhci_of_data->ops;
>         }
> 
> +       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +               host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
> +      

^^ No need for the two empty lines.

>        if (of_get_property(np, "sdhci,1-bit-only", NULL))

Though, technically the patch looks OK, feel free to add my

  Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

on the next resend (if any).

Thanks Roy!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
