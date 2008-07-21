Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DEF5BDE128
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:31:12 +1000 (EST)
Date: Mon, 21 Jul 2008 09:31:10 -0700 (PDT)
Message-Id: <20080721.093110.141511905.davem@davemloft.net>
To: smaclennan@pikatech.com
Subject: Re: Networkl problems with lastest kernel....
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080721121829.28faffab@lappy.seanm.ca>
References: <20080721121829.28faffab@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sean MacLennan <smaclennan@pikatech.com>
Date: Mon, 21 Jul 2008 12:18:29 -0400

> I just did a git pull of Linus' kernel. It seems to be mainly network
> changes... and I get the following oops. Anybody else seeing this?
> 
> I really don't have time to look at the problem right now, maybe
> tonight.

If I had a penny for every driver with broken TX queue handling...

Please try this patch, thanks:

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 2e720f2..4e01d29 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -1157,6 +1157,7 @@ static int emac_open(struct net_device *ndev)
 	mal_enable_rx_channel(dev->mal, dev->mal_rx_chan);
 	emac_tx_enable(dev);
 	emac_rx_enable(dev);
+	netif_start_queue(dev);
 	emac_netif_start(dev);
 
 	mutex_unlock(&dev->link_lock);
