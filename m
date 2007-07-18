Return-Path: <pradeep.rautela@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id E28EBDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 17:00:38 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so231457pyi
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:00:37 -0700 (PDT)
Message-ID: <a901b49a0707180000g1c107323ub6c95a6ef3b5b2fe@mail.gmail.com>
Date: Wed, 18 Jul 2007 12:30:37 +0530
From: "pradeep singh" <pradeep.rautela@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: [PATCH 1/2] Fix error checking in Vitesse IRQ config
In-Reply-To: <11847405503115-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11847405503115-git-send-email-afleming@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/18/07, Andy Fleming <afleming@freescale.com> wrote:
> phy_read() returns a negative number if there's an error, but the
> error-checking code in the Vitesse driver's config_intr function
> triggers if phy_read() returns non-zero.  Correct that.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> I made a really stupid mistake in the 4 patches I sent out, earlier.  I
> thought those patches had been tested, but they hadn't been.  This one
> corrects a tiny error in the patch, and they have now been tested.  As before
> this change can be pulled from:
>
> http://opensource.freescale.com/pub/scm/linux-2.6-85xx.git netdev
>
> Really, REALLY sorry about that.  I have been given a paper bag of appropriate
> size and shape to fit over my head.
>
>  drivers/net/phy/vitesse.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
> index 6a53856..8874497 100644
> --- a/drivers/net/phy/vitesse.c
> +++ b/drivers/net/phy/vitesse.c
> @@ -109,7 +109,7 @@ static int vsc824x_config_intr(struct phy_device *phydev)
>                  */
>                 err = phy_read(phydev, MII_VSC8244_ISTAT);
>
> -               if (err)
> +               if (err < 0)
>                         return err;

but would that mean, if phy_read returns > 0 it is a success?

thanks
>
>                 err = phy_write(phydev, MII_VSC8244_IMASK, 0);
> --
> 1.5.0.2.230.gfbe3d-dirty
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Pradeep
