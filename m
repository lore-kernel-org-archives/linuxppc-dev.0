Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D7A82DDE4A
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 06:47:27 +1000 (EST)
Date: Fri, 25 May 2007 22:47:48 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 5/7] ps3: Disk Storage Driver
Message-ID: <20070525204748.GA4686@aepfle.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.575306000@sonycom.com>
	<20070525114550.GA32552@aepfle.de>
	<Pine.LNX.4.62.0705252143070.2657@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.62.0705252143070.2657@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, Geert Uytterhoeven wrote:

> On Fri, 25 May 2007, Olaf Hering wrote:
> > On Fri, May 25, Geert.Uytterhoeven@sonycom.com wrote:
> > > Add a Disk Storage Driver for the PS3:
> > 
> > There is no device symlink in /sys/block/ps3da/
> 
> Interesting... Do you know how to create it?

No, that was not obvious.
But for gelic it goes like this:

+++ b/drivers/net/gelic_net.c
@@ -1364,6 +1364,7 @@ static int gelic_net_setup_netdev(struct
        u64 v1, v2;
 
        SET_MODULE_OWNER(netdev);
+       SET_NETDEV_DEV(netdev, &card->dev->core);
        spin_lock_init(&card->tx_dma_lock);
 
        card->rx_csum = GELIC_NET_RX_CSUM_DEFAULT;
