Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id EB78CB7BB9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 00:17:10 +1100 (EST)
Message-ID: <4AC9ED9B.5040400@ru.mvista.com>
Date: Mon, 05 Oct 2009 16:59:07 +0400
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pasemi_mac: ethtool get settings fix
References: <20091001222748.GA21276@ru.mvista.com>
In-Reply-To: <20091001222748.GA21276@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resending pasemi_mac ethtool patches...

Valentine Barshak wrote:
> Not all pasemi mac interfaces can have a phy attached.
> For example, XAUI has no phy and phydev is NULL for it.
> In this case ethtool get settings causes kernel crash.
> Fix it by returning -EOPNOTSUPP if there's no PHY attached.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/net/pasemi_mac_ethtool.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-2.6.21.orig/drivers/net/pasemi_mac_ethtool.c	2008-11-06 18:10:38.000000000 +0300
> +++ linux-2.6.21/drivers/net/pasemi_mac_ethtool.c	2008-11-19 19:24:28.000000000 +0300
> @@ -71,6 +71,8 @@ pasemi_mac_ethtool_get_settings(struct n
>  	struct pasemi_mac *mac = netdev_priv(netdev);
>  	struct phy_device *phydev = mac->phydev;
>  
> +	if (!phydev)
> +		return -EOPNOTSUPP;
>  	return phy_ethtool_gset(phydev, cmd);
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
