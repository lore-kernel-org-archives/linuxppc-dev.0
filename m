Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id E21AADDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:13:09 +1100 (EST)
Received: by gxk9 with SMTP id 9so2722113gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 07:13:06 -0800 (PST)
Message-ID: <fa686aa40901070713kca10b27y6c6aac03e6224fac@mail.gmail.com>
Date: Wed, 7 Jan 2009 08:13:06 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
In-Reply-To: <20090107141254.140990@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107141254.140990@gmx.net>
Cc: linuxppc-dev@ozlabs.org, bzolnier@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 7:12 AM, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> The AmigaOne uses the onboard VIA IDE controller in legacy mode (like the
> Pegasos).
>
> Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
> ---
>  drivers/ide/via82cxxx.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

This patch needs to also be posted on the linux-ide mailing list.

> diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
> index 2a812d3..086f476 100644
> --- a/drivers/ide/via82cxxx.c
> +++ b/drivers/ide/via82cxxx.c
> @@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_i
>                d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
>  #endif
>
> +#ifdef CONFIG_AMIGAONE
> +       if (machine_is(amigaone))
> +               d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
> +#endif
> +

I know you're just following the example of the PEGASOS workaround
immediately above; but the #defines are really ugly.  I wonder if
there is there a cleaner way to manipulate the flags.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
