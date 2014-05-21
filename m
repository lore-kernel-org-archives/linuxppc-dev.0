Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEF391A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:55:55 +1000 (EST)
Received: by mail-la0-f49.google.com with SMTP id pv20so2046135lab.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:55:50 -0700 (PDT)
Message-ID: <537D20EA.1000305@cogentembedded.com>
Date: Thu, 22 May 2014 01:55:54 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 4/9] net: systemport: use the new fixed
 PHY helpers
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
 <1400708331-18088-5-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-5-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2014 01:38 AM, Florian Fainelli wrote:

> of_phy_connect_fixed_link() is becoming obsolete, and also required
> platform code to register the fixed PHYs at the specified addresses for
> those to be usable. Get rid of it and use the new of_phy_is_fixed_link()
> plus of_phy_register_fixed_link() helpers to transition over the new
> scheme.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/bcmsysport.c | 17 +++++++++++++++--
>   drivers/net/ethernet/broadcom/bcmsysport.h |  1 +
>   2 files changed, 16 insertions(+), 2 deletions(-)

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index d40c5b969e9e..dc708a888f80 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -1327,8 +1327,8 @@ static int bcm_sysport_open(struct net_device *dev)
>   	/* Read CRC forward */
>   	priv->crc_fwd = !!(umac_readl(priv, UMAC_CMD) & CMD_CRC_FWD);
>
> -	priv->phydev = of_phy_connect_fixed_link(dev, bcm_sysport_adj_link,
> -							priv->phy_interface);
> +	priv->phydev = of_phy_connect(dev, priv->phy_dn, bcm_sysport_adj_link,
> +					0, priv->phy_interface);

    The continuation line should start on the next character after ( on the 
above line, according to the networking coding style.

[...]

WBR, Sergei
