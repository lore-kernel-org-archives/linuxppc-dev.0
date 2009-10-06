Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6752CB7C63
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 02:53:11 +1100 (EST)
Date: Tue, 6 Oct 2009 11:10:54 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] pasemi_mac: ethtool get settings fix
Message-ID: <20091006161054.GB29195@lixom.net>
References: <4AC9ED9B.5040400@ru.mvista.com>
	<20091005132756.GA11704@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091005132756.GA11704@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Weird, I see my address in the to: line but I never got a copy in my inbox.

On Mon, Oct 05, 2009 at 05:27:56PM +0400, Valentine Barshak wrote:
> Not all pasemi mac interfaces can have a phy attached.
> For example, XAUI has no phy and phydev is NULL for it.
> In this case ethtool get settings causes kernel crash.
> Fix it by returning -EOPNOTSUPP if there's no PHY attached.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Olof Johansson <olof@lixom.net>

> ---
>  drivers/net/pasemi_mac_ethtool.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -pruN linux-2.6.orig/drivers/net/pasemi_mac_ethtool.c linux-2.6/drivers/net/pasemi_mac_ethtool.c
> --- linux-2.6.orig/drivers/net/pasemi_mac_ethtool.c	2009-02-14 03:23:08.000000000 +0300
> +++ linux-2.6/drivers/net/pasemi_mac_ethtool.c	2009-10-05 16:21:52.000000000 +0400
> @@ -71,6 +71,9 @@ pasemi_mac_ethtool_get_settings(struct n
>  	struct pasemi_mac *mac = netdev_priv(netdev);
>  	struct phy_device *phydev = mac->phydev;
>  
> +	if (!phydev)
> +		return -EOPNOTSUPP;
> +
>  	return phy_ethtool_gset(phydev, cmd);
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
