Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6451DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Oct 2007 19:01:40 +1000 (EST)
Date: Mon, 8 Oct 2007 11:01:35 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20071008090135.GB11231@pengutronix.de>
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
	<46FBF9B7.9010007@freescale.com>
	<200709281112.18480.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

On Fri, Sep 28, 2007 at 11:12:17AM +0200, Juergen Beisert wrote:
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

While the previous patch I sent fixed the reset path for the fec
controller this patch makes sure the chip does not have to be resetted.
Problem was that we ran out of receive buffers when we nmapped our
board (nmap sends lots of small packages in a short period of time).
By increasing the number of rx buffers this problem does not appear
anymore.
This patch produces a significant memory overhead to the driver of about
340k, so we might want to have this configurable as a module parameter.
Let me know what the preferred way is, I can update the patch
accordingly.

Sascha


Increase the number of RX packets in the fec_mpc52xx driver. This is
necessary to no run out of rx packets when lots of small packets arrive
in short time (for example when nmapping the board)

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 drivers/net/fec_mpc52xx/fec.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/net/fec_mpc52xx/fec.h
===================================================================
--- linux-2.6.orig/drivers/net/fec_mpc52xx/fec.h
+++ linux-2.6/drivers/net/fec_mpc52xx/fec.h
@@ -19,7 +19,7 @@
 /* Tunable constant */
 /* FEC_RX_BUFFER_SIZE includes 4 bytes for CRC32 */
 #define FEC_RX_BUFFER_SIZE	1522	/* max receive packet size */
-#define FEC_RX_NUM_BD		64
+#define FEC_RX_NUM_BD		256
 #define FEC_TX_NUM_BD		64
 
 #define FEC_RESET_DELAY		50 	/* uS */

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
