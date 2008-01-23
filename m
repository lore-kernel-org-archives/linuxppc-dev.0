Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17544DDE36
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:41:19 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0NCfF9B014631
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:41:15 -0600
Date: Wed, 23 Jan 2008 06:38:53 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix compile error if CONFIG_STX_GP3 is defined
Message-ID: <Pine.LNX.4.64.0801230638340.4478@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cpmux is need in all cases, having wrapped by the ifndef CONFIG_STX_GP3
was causing a compile error.

---
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index def0158..d9af06a 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -165,9 +165,9 @@ void scc2_lineif(struct uart_cpm_port *pinfo)
 	 * really has to get out of the driver so boards can
 	 * be supported in a sane fashion.
 	 */
+	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
 #ifndef CONFIG_STX_GP3
 	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);

 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
-- 
1.5.3.7
