Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (unknown [194.100.36.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B313167DF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 23:39:24 +1100 (EST)
Date: Fri, 10 Nov 2006 14:02:30 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611101359200.25024@host32.eke.fi>
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
	<a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 10 Nov 2006, Kalle Pokki wrote:

> OK, better drop all the hunks except the one that concerns
> drivers/serial/cpm_uart/cpm_uart_core.c then, since I added the same
> '__init' lines in cpm_uart.h, cpm_uart_cpm1.c, and cpm_uart_cpm2.c.

Hmm, it seems you already pushed the changes. This should apply to the 
current 'merge' branch.

 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index b691d3e..787a8f1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -282,7 +282,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
 }
 
 /* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
+int __init cpm_uart_init_portdesc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
 	u32 addr;
-- 
1.4.1.1
