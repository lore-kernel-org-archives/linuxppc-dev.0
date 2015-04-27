Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 374091A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 01:25:18 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Mon, 27 Apr 2015 17:25:05 +0200
Message-ID: <5771531.b7UhrXUGmv@wuerfel>
In-Reply-To: <CAOHikRDkQwG+7EUddXmx427ZpEOjqTt22H_zzozABOE3a963tQ@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
 <8525627.D1S9aInyMV@wuerfel>
 <CAOHikRDkQwG+7EUddXmx427ZpEOjqTt22H_zzozABOE3a963tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > > index bef250e..9f6a4b9 100644
> > > --- a/drivers/mmc/host/sdhci-pltfm.c
> > > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
> > > *pdev)
> > >
> > >                 if (of_get_property(np, "broken-cd", NULL))
> > >                         host->quirks |=
> > >SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > >
> > > +
> > > +               if (of_get_property(np, "delay-after-power", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> > > +
> > > +               if (of_get_property(np, "no-hispd", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> > > +
> > > +               if (of_get_property(np, "broken-adma", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > > +
> > > +               if (of_get_property(np, "broken-dma", NULL))
> > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > +
> > > +               if (of_get_property(np, "no-cmd23", NULL))
> > > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > >
> > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> > 
> > Any property you add needs to be documented in the DT binding.
> > If possible, add generic properties for each bug you have mmc.txt
> > rather than the driver specific sdhci.txt, and implement the
> I will add the binding in mmc.txt. I thought this was present but not.
> 
> > parsing in a common function that is used for all mmc hosts.
> As per mine understanding the sdhci_get_of_porperty is a common
> parsing function  . Am I wrong ??

No, this is only used for sdhci, not for the other controllers.

> > An alternative would be to set all these bits based on the compatible
> > string of your host, if that is the only one that has all these bugs.
> 
> The host driver  (arasan) is reused but this quirks are needed due to
> board issues. so I have a control over dtb only to fix this.

What is the nature of the bug on that board? Is there a different
way to describe that without introducing six new properties?

	Arnd
