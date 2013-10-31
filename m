Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C1902C03BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 12:37:25 +1100 (EST)
Message-ID: <1383183427.5117.73.camel@pasglop>
Subject: Re: [PATCH] ADB_PMU_LED_IDE selects LEDS_TRIGGER_IDE_DISK which has
 unmet direct dependencies
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Thu, 31 Oct 2013 12:37:07 +1100
In-Reply-To: <alpine.DEB.2.11.1310292123190.31521@trent.utfs.org>
References: <alpine.DEB.2.11.1310280031020.31521@trent.utfs.org>
 <1383088392.5117.38.camel@pasglop>
 <alpine.DEB.2.11.1310292123190.31521@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-29 at 21:25 -0700, Christian Kujau wrote:
> On Wed, 30 Oct 2013 at 10:13, Benjamin Herrenschmidt wrote:
> > You probably want to do that to the ADB_PMU_LED_IDE entry not the
> > ADB_PMU_LED one which doesn't have a dependency and isn't the one
> > selecting LEDS_TRIGGER_IDE_DISK :-)
> 
> Right you are, sorry for the mixup. Let me try again:

And this time without a changeset comment ? :-)

I've copied it from the previous version but next time, re-send the
complete commit.

Cheers,
Ben.

> 
>   Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 696238b..d26a312 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -103,6 +103,7 @@ config ADB_PMU_LED_IDE
>         bool "Use front LED as IDE LED by default"
>         depends on ADB_PMU_LED
>         depends on LEDS_CLASS
> +       depends on IDE_GD_ATA
>         select LEDS_TRIGGERS
>         select LEDS_TRIGGER_IDE_DISK
>         help
> 
> C.
> -- 
> BOFH excuse #378:
> 
> Operators killed by year 2000 bug bite.
