Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40C42337.20209@intracom.gr>
References: <40BF3206.8030705@intracom.gr>
	 <1086426744.4588.121.camel@imladris.demon.co.uk>
	 <20040605192221.GT15195@smtp.west.cox.net>
	 <1086472929.4862.12.camel@localhost.localdomain>
	 <40C42337.20209@intracom.gr>
Content-Type: text/plain
Date: Mon, 07 Jun 2004 10:12:41 +0100
Message-Id: <1086599561.29255.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-07 at 11:11 +0300, Pantelis Antoniou wrote:
> The following patch fixes the problem by properly waiting
> two character times on mode change.

Thanks. Cleaned up and working version looks like this:

--- drivers/serial/cpm_uart/cpm_uart.h.orig	2004-06-06 16:37:05.000000000 +0100
+++ drivers/serial/cpm_uart/cpm_uart.h	2004-06-07 10:06:58.380032904 +0100
@@ -65,6 +65,8 @@
 	uint dp_addr;
 	void *mem_addr;
 	dma_addr_t dma_addr;
+	int baud;
+	int bits;
 };

 extern int cpm_uart_port_map[UART_NR];
--- drivers/serial/cpm_uart/cpm_uart_core.c.orig	2004-06-07 09:27:48.020341888 +0100
+++ drivers/serial/cpm_uart/cpm_uart_core.c	2004-06-07 10:08:41.849303184 +0100
@@ -44,6 +44,7 @@

 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/delay.h>

 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -483,6 +484,10 @@
 	if ((termios->c_cflag & CREAD) == 0)
 		port->read_status_mask &= ~BD_SC_EMPTY;

+	/* if previous configuration exists wait 2 character times for tx to finish */
+	if (pinfo->baud != 0 || pinfo->bits != 0)
+		udelay((3 * 1000000 * pinfo->bits) / pinfo->baud);
+
 	spin_lock_irqsave(&port->lock, flags);

 	/* Start bit has not been added (so don't, because we would just
@@ -503,6 +508,10 @@
 	}

 	cpm_set_brg(pinfo->brg - 1, baud);
+
+	pinfo->baud = baud;
+	pinfo->bits = bits;
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
