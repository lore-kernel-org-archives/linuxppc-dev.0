Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id B887B1A0391
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 05:48:52 +1000 (AEST)
Date: Fri, 25 Sep 2015 12:48:48 -0700 (PDT)
Message-Id: <20150925.124848.1041664902815491015.davem@davemloft.net>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 igal.liberman@freescale.com, roy.pledge@freescale.com,
 ppc@mindchasers.com, joe@perches.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, f.fainelli@gmail.com, stsp@list.ru
Subject: Re: [v3 2/8] dpaa_eth: add support for DPAA Ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <1443106819-5549-3-git-send-email-madalin.bucur@freescale.com>
References: <1443106819-5549-1-git-send-email-madalin.bucur@freescale.com>
 <1443106819-5549-3-git-send-email-madalin.bucur@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@freescale.com>
Date: Thu, 24 Sep 2015 18:00:13 +0300

> +#define DPA_NAPI_WEIGHT		64

This is just the default, so simply use "NAPI_POLL_WEIGHT" rather
than defining your own macro unnecessarily for this.

> +static int dpa_eth_priv_stop(struct net_device *net_dev)
> +{
> +	int err;
> +	struct dpa_priv_s *priv;
> +
> +	err = dpa_stop(net_dev);
> +	/* Allow NAPI to consume any frame still in the Rx/TxConfirm
> +	 * ingress queues. This is to avoid a race between the current
> +	 * context and ksoftirqd which could leave NAPI disabled while
> +	 * in fact there's still Rx traffic to be processed.
> +	 */
> +	usleep_range(5000, 10000);

A wait never fixes a race.  Instead you must use appropriate mutual
exclusion mechanisms to ensure that NAPI is really completed it's
run, and we definitely have a means by which to do that properly.

> +	net_dev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> +		NETIF_F_LLTX);

This second line should start exactly at the first column after the
openning parenthesis of the first line.
