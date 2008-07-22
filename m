Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EE7E8DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 10:25:29 +1000 (EST)
Date: Tue, 22 Jul 2008 10:25:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] serial: fix struct uart_info change fallout
Message-Id: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus, Alan,

Today's linux-next (actually just Linus' tree) build (powerpc
ppc64_defconfig) failed like this:

drivers/serial/serial_txx9.c: In function 'receive_chars':
drivers/serial/serial_txx9.c:275: error: 'struct uart_info' has no member named 'tty'
drivers/serial/icom.c: In function 'recv_interrupt':
drivers/serial/icom.c:733: error: 'struct uart_info' has no member named 'tty'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/serial/icom.c        |    2 +-
 drivers/serial/serial_txx9.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/icom.c b/drivers/serial/icom.c
index 9c2df5c..2b7531d 100644
--- a/drivers/serial/icom.c
+++ b/drivers/serial/icom.c
@@ -730,7 +730,7 @@ static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 {
 	short int count, rcv_buff;
-	struct tty_struct *tty = icom_port->uart_port.info->tty;
+	struct tty_struct *tty = icom_port->uart_port.info->port.tty;
 	unsigned short int status;
 	struct uart_icount *icount;
 	unsigned long offset;
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 7ad2192..8fcb4c5 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -272,7 +272,7 @@ static void serial_txx9_initialize(struct uart_port *port)
 static inline void
 receive_chars(struct uart_txx9_port *up, unsigned int *status)
 {
-	struct tty_struct *tty = up->port.info->tty;
+	struct tty_struct *tty = up->port.info->port.tty;
 	unsigned char ch;
 	unsigned int disr = *status;
 	int max_count = 256;
-- 
1.5.6.2

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
