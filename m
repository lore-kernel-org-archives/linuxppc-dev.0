Return-Path: <blofeldus@yahoo.com>
Received: from web53505.mail.yahoo.com (web53505.mail.yahoo.com
	[206.190.37.66]) by ozlabs.org (Postfix) with SMTP id 116D567B31
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 05:38:51 +1000 (EST)
Message-ID: <20050620193210.42378.qmail@web53505.mail.yahoo.com>
Date: Mon, 20 Jun 2005 12:32:10 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
To: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] GCC4 compile fixes for mpc52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,
 A quick patch to fix your tree for gcc4
-rb

drivers/net/fec_mpc52xx/fec.c: In function 'fec_reinit':
drivers/net/fec_mpc52xx/fec.c:525: error: invalid storage class for
function 'fec_update_stat'

drivers/serial/mpc52xx_uart.c:707: error: static declaration of
'mpc52xx_uart_driver' follows non-static declaration
drivers/serial/mpc52xx_uart.c:675: error: previous declaration of
'mpc52xx_uart_driver' was here

Signed off by Roger Blofeld <blofeldus@yahoo.com>

diff --git a/drivers/net/fec_mpc52xx/fec.c
b/drivers/net/fec_mpc52xx/fec.c
--- a/drivers/net/fec_mpc52xx/fec.c
+++ b/drivers/net/fec_mpc52xx/fec.c
@@ -522,7 +522,7 @@ static void fec_reinit(struct net_device
 {
        struct fec_priv *priv = (struct fec_priv *)dev->priv;
        struct mpc52xx_fec *fec = priv->fec;
-       static void fec_update_stat(struct net_device *);
+       void fec_update_stat(struct net_device *);
 
        netif_stop_queue(dev);
        out_be32(&fec->imask, 0x0);
diff --git a/drivers/serial/mpc52xx_uart.c
b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -672,7 +672,7 @@ mpc52xx_console_setup(struct console *co
 }
 
 
-extern struct uart_driver mpc52xx_uart_driver;
+static struct uart_driver mpc52xx_uart_driver;
 
 static struct console mpc52xx_console = {
        .name   = "ttyPSC",



no microsoft products were used in the production of this email

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
