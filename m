Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AD79DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Oct 2007 18:48:27 +1000 (EST)
Date: Mon, 8 Oct 2007 10:48:20 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20071008084820.GA11231@pengutronix.de>
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
	<46FBF9B7.9010007@freescale.com>
	<200709281112.18480.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200709281112.18480.jbe@pengutronix.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Sep 28, 2007 at 11:12:17AM +0200, Juergen Beisert wrote:
> I tried with in_atomic(). The BUG report is gone, but the problem still 
> exists. 
> 
> While network stress testing: 
> 
> [...]
> NETDEV WATCHDOG: eth0: transmit timed out
> net eth0: transmit timed out
> net eth0: queues didn't drain
> net eth0:   tx: index: 35, outdex: 36
> net eth0:   rx: index: 24, outdex: 25
> PHY: f0003000:00 - Link is Down
> PHY: f0003000:00 - Link is Up - 100/Full
> 
> The link is up again, but any connection is dead (no answers to ping etc.). 
> But the serial console is still working. I'm not sure if the RT-Preempt patch 
> *causes* this behavior or only *discover* it. Any idea?

We finally solved this problem. It has nothing to do with locking
though. The problem is that the bcom engine was not reenabled after
resetting the fec. The following patch solves this.


Reenable the bestcom engine after resetting the mpc52xx fec
controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 drivers/net/fec_mpc52xx/fec.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/net/fec_mpc52xx/fec.c
===================================================================
--- linux-2.6.orig/drivers/net/fec_mpc52xx/fec.c
+++ linux-2.6/drivers/net/fec_mpc52xx/fec.c
@@ -788,6 +788,9 @@ static void fec_reset(struct net_device 
 
 	fec_alloc_rx_buffers(priv->rx_dmatsk);
 
+	bcom_enable(priv->rx_dmatsk);
+	bcom_enable(priv->tx_dmatsk);
+
 	fec_start(dev);
 }
 


> 
> Juergen
> -- 
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>    Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
