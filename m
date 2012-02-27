Return-Path: <robherring2@gmail.com>
Message-ID: <4F4BA86A.1040309@gmail.com>
Date: Mon, 27 Feb 2012 09:59:38 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] of/mdio: fix fixed link bus name
References: <8ebe6a3f11343c392a7353581d5f648980206e8e.1330346765.git.baruch@tkos.co.il>
In-Reply-To: <8ebe6a3f11343c392a7353581d5f648980206e8e.1330346765.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2012 06:48 AM, Baruch Siach wrote:
> Since 9e6c643b (phy/fixed: use an unique MDIO bus name) the name of the fixed
> PHY bus is "fixed-0". Teach of_phy_connect_fixed_link() the new name.
> 

Applied for 3.3.

Rob

> Tested on a P1020RDB PowerPC system.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/of/of_mdio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index 980c079..483c0ad 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -182,7 +182,7 @@ struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
>  	if (!phy_id || sz < sizeof(*phy_id))
>  		return NULL;
>  
> -	sprintf(bus_id, PHY_ID_FMT, "0", be32_to_cpu(phy_id[0]));
> +	sprintf(bus_id, PHY_ID_FMT, "fixed-0", be32_to_cpu(phy_id[0]));
>  
>  	phy = phy_connect(dev, bus_id, hndlr, 0, iface);
>  	return IS_ERR(phy) ? NULL : phy;
