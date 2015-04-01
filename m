Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0042.hostedemail.com
 [216.40.44.42])
 by lists.ozlabs.org (Postfix) with ESMTP id 148511A1914
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 04:11:44 +1100 (AEDT)
Message-ID: <1427908299.31790.51.camel@perches.com>
Subject: Re: [PATCH RFC 06/10] dpaa_eth: add ethtool functionality
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Date: Wed, 01 Apr 2015 10:11:39 -0700
In-Reply-To: <1427905196-27778-5-git-send-email-madalin.bucur@freescale.com>
References: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-2-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-3-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-4-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-5-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> Add support for basic ethtool operations.

> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
[]
> +static int __cold dpa_get_settings(struct net_device *net_dev,
> +				   struct ethtool_cmd *et_cmd)
> +{
> +	int			 _errno;

Using a variable name of _errno is misleading at best,
(btw: the only return value for phy_ethtool_gset is 0)

> +static void __cold dpa_get_drvinfo(struct net_device *net_dev,
> +				   struct ethtool_drvinfo *drvinfo)
> +{
> +	int		 _errno;
> +
> +	strncpy(drvinfo->driver, KBUILD_MODNAME,
> +		sizeof(drvinfo->driver) - 1)[sizeof(drvinfo->driver) - 1] = 0;

That's a really odd and unusual construct
more commonly written as strlcpy

> +	_errno = snprintf(drvinfo->version, sizeof(drvinfo->version),

Using errno here is especially misleading as that's
not the return value of an snprintf
