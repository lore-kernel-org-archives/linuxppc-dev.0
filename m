Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 2CD84684C9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 05:46:50 +1000 (EST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id AC17142ABE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 21:46:35 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id D87E1353CD8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 21:46:29 +0200 (MEST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Mon, 10 Oct 2005 21:46:29 +0200
Sender: wd@denx.de
Message-Id: <20051010194629.D87E1353CD8@atlas.denx.de>
Subject: [PATCH] MPC5200 - Fix compile problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

the following patch  is  against  the  current  2.6  kernel.org  tree
(commit  f96c3bbe91117402f13119ce9e609db9087ed58f) **after** applying
following two patches:


http://patchwork.ozlabs.org/linuxppc/patch?id=2018
http://patchwork.ozlabs.org/linuxppc/patch?id=2017

Without the patch, I get this:

  CC      net/sysctl_net.o
In file included from drivers/net/fec_mpc52xx/fec.c:33:
arch/ppc/syslib/bestcomm/bestcomm.h: In function 'sdma_enable_task':
arch/ppc/syslib/bestcomm/bestcomm.h:130: warning: ISO C90 forbids mixed declarations and code
  LD      fs/built-in.o
drivers/net/fec_mpc52xx/fec.c: In function 'fec_reinit':
drivers/net/fec_mpc52xx/fec.c:525: error: invalid storage class for function 'fec_update_stat'
make[3]: *** [drivers/net/fec_mpc52xx/fec.o] Error 1
make[2]: *** [drivers/net/fec_mpc52xx] Error 2
make[1]: *** [drivers/net] Error 2
drivers/serial/mpc52xx_uart.c:703: error: static declaration of 'mpc52xx_uart_driver' follows non-static declaration
drivers/serial/mpc52xx_uart.c:671: error: previous declaration of 'mpc52xx_uart_driver' was here
make[2]: *** [drivers/serial/mpc52xx_uart.o] Error 1
make[1]: *** [drivers/serial] Error 2


!-------------------------------------------------------------flip-

MPC5200: Fix compiler warnings with GCC 4.x

Signed-off by Wolfgang Denk <wd@denx.de>

---
commit c55cdf8cbaf7b9f18f9357a9b9e2582ae3326541
tree e46f7ed10df8d84e3f85439cb3c81bc8a1630487
parent cdd7fdf10b3cbb7eb82cacc7ba5dba3553020f49
author Wolfgang Denk <wd@pollux.denx.de> Mon, 10 Oct 2005 21:16:49 +0200
committer Wolfgang Denk <wd@pollux.denx.de> Mon, 10 Oct 2005 21:16:49 +0200

 arch/ppc/syslib/bestcomm/bestcomm.h |    4 +++-
 drivers/net/fec_mpc52xx/fec.c       |    2 +-
 drivers/serial/mpc52xx_uart.c       |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/bestcomm/bestcomm.h b/arch/ppc/syslib/bestcomm/bestcomm.h
--- a/arch/ppc/syslib/bestcomm/bestcomm.h
+++ b/arch/ppc/syslib/bestcomm/bestcomm.h
@@ -116,6 +116,8 @@ struct sdma_tdt {
 
 static inline void sdma_enable_task(int task)
 {
+	u16 reg;
+
 	DPRINTK("***DMA enable task (%d): tdt = %08x\n",task, sdma.tdt);
 	DPRINTK("***tdt->start   = %08x\n",sdma.tdt[task].start);
 	DPRINTK("***tdt->stop    = %08x\n",sdma.tdt[task].stop);
@@ -127,7 +129,7 @@ static inline void sdma_enable_task(int 
 	DPRINTK("***tdt->litbase = %08x\n",sdma.tdt[task].litbase);
 	DPRINTK("***--------------\n");
 
-	u16 reg = in_be16(&sdma.io->tcr[task]);
+	reg = in_be16(&sdma.io->tcr[task]);
 	DPRINTK("***enable task: &sdma.io->tcr=%08x, reg = %04x\n", &sdma.io->tcr, reg);
 	out_be16(&sdma.io->tcr[task],  reg | TASK_ENABLE);
 }
diff --git a/drivers/net/fec_mpc52xx/fec.c b/drivers/net/fec_mpc52xx/fec.c
--- a/drivers/net/fec_mpc52xx/fec.c
+++ b/drivers/net/fec_mpc52xx/fec.c
@@ -522,7 +522,7 @@ static void fec_reinit(struct net_device
 {
 	struct fec_priv *priv = (struct fec_priv *)dev->priv;
 	struct mpc52xx_fec *fec = priv->fec;
-	static void fec_update_stat(struct net_device *);
+	void fec_update_stat(struct net_device *);
 
 	netif_stop_queue(dev);
 	out_be32(&fec->imask, 0x0);
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -668,7 +668,7 @@ mpc52xx_console_setup(struct console *co
 }
 
 
-extern struct uart_driver mpc52xx_uart_driver;
+static struct uart_driver mpc52xx_uart_driver;
 
 static struct console mpc52xx_console = {
 	.name	= "ttyS",



!-------------------------------------------------------------flip-



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.
