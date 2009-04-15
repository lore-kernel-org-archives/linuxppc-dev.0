Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11BE8DE15A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 09:02:24 +1000 (EST)
Message-Id: <E3135C12-C512-43CF-B30D-B3AF7D7DE181@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090331082730.1427.96418.stgit@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 09/14] net: Rework gianfar driver to use of_mdio
	infrastructure.
Date: Wed, 15 Apr 2009 18:01:17 -0500
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
	<20090331082730.1427.96418.stgit@localhost.localdomain>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 31, 2009, at 3:27 AM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch simplifies the driver by making use of more common code.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> drivers/net/gianfar.c |  103 +++++++++++++++++ 
> +-------------------------------
> drivers/net/gianfar.h |    3 +
> 2 files changed, 40 insertions(+), 66 deletions(-)
>
>
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 65f5587..c22eba9 100644
> @@ -699,23 +657,38 @@ static int init_phy(struct net_device *dev)
>
>
> +	if (priv->tbi_node) {
> +		priv->tbiphy = of_phy_connect(dev, priv->tbi_node, &adjust_link,
> +					      0, interface);
> +		if (!priv->tbiphy) {
> +			dev_err(&dev->dev, "error: Could not attach to TBI\n");
> +			goto err_tbiphy;
> +		}
> +	}

I don't believe we need this.  Certainly, the current code doesn't do  
anything like this.  The TBI node is a special internal PHY used to  
manage SGMII/TBI links.


Andy
