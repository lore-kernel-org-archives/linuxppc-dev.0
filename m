Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CE5D7140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 22:52:39 +1100 (EST)
Received: by mail-la0-f43.google.com with SMTP id e16so2557827lan.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 04:52:34 -0700 (PDT)
Message-ID: <53341101.9000404@cogentembedded.com>
Date: Thu, 27 Mar 2014 15:52:33 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, B07421@freescale.com
Subject: Re: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
References: <1395901116-16034-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1395901116-16034-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mugunthanvnm@ti.com, linux-kernel@vger.kernel.org,
 helmut.schaa@googlemail.com, zonque@gmail.com, R63061@freescale.com,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 27-03-2014 10:18, Zhao Qiang wrote:

> The at8031 can work on polling mode and interrupt mode.
> Add ack_interrupt and config intr funcs to enable
> interrupt mode for it.

> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>   drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index bc71947..d034ef5 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
[...]
> @@ -191,6 +194,31 @@ static int at803x_config_init(struct phy_device *phydev)
>   	return 0;
>   }
>
> +static int at803x_ack_interrupt(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	err = phy_read(phydev, AT803X_INSR);

    Could make this an initializer...

> +
> +	return (err < 0) ? err : 0;
> +}
> +
> +static int at803x_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;
> +
> +	value = phy_read(phydev, AT803X_INER);
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +		err = phy_write(phydev, AT803X_INER,
> +				(value | AT803X_INER_INIT));

    Inner parens not needed.

> +	else
> +		err = phy_write(phydev, AT803X_INER, value);

    Why are you not clearing the bits here? Why write back what has been read 
at all?

WBR, Sergei
