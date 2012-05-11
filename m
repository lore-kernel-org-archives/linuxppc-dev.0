Return-Path: <ddaney.cavm@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72FB7B700B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 03:58:10 +1000 (EST)
Received: by dajt11 with SMTP id t11so4517202daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 10:58:08 -0700 (PDT)
Message-ID: <4FAD532E.401@gmail.com>
Date: Fri, 11 May 2012 10:58:06 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: of/phy: fix build error when phylib is built as
 a module
References: <20120510.224352.2149006669429730060.davem@davemloft.net>
 <1336751221-19127-1-git-send-email-bjorn@mork.no>
In-Reply-To: <1336751221-19127-1-git-send-email-bjorn@mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "rdunlap@xenotime.net" <rdunlap@xenotime.net>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2012 08:47 AM, Bjørn Mork wrote:
> CONFIG_OF_MDIO is tristate and will be m if PHYLIB is m.  Use
> IS_ENABLED macro to prevent build error:
>
>   ERROR: "of_mdio_find_bus" [drivers/net/phy/mdio-mux.ko] undefined!
>
> Reported-by: Randy Dunlap<rdunlap@xenotime.net>
> Cc: David Daney<david.daney@cavium.com>
> Signed-off-by: Bjørn Mork<bjorn@mork.no>

I was able to reproduce the failure, and this patch both fixes it and 
seems correct, so...

Acked-by: David Daney<david.daney@cavium.com>

Sorry about this failure.


> ---
> I wonder if this could be as banal as this?  Not even build tested...
>
> Should be wrapped into commit 25106022 if it works, to ensure
> bisectability.
>
>
>
> Bjørn
>
>   drivers/net/phy/mdio_bus.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 83d5c9f..683ef1c 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -88,7 +88,7 @@ static struct class mdio_bus_class = {
>   	.dev_release	= mdiobus_release,
>   };
>
> -#ifdef CONFIG_OF_MDIO
> +#if IS_ENABLED(CONFIG_OF_MDIO)
>   /* Helper function for of_mdio_find_bus */
>   static int of_mdio_bus_match(struct device *dev, void *mdio_bus_np)
>   {
