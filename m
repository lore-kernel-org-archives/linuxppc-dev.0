Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 3B05167A04
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 14:09:46 +1000 (EST)
Date: Wed, 8 Jun 2005 21:09:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050608210943.A4183@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: remove orphaned ppc4xx_kgdb.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Removes ppc4xx_kgdb.c which is no longer being used. Pointed
out by Andrei Konovalov.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/syslib/ppc4xx_kgdb.c b/arch/ppc/syslib/ppc4xx_kgdb.c
deleted file mode 100644
--- a/arch/ppc/syslib/ppc4xx_kgdb.c
+++ /dev/null
@@ -1,124 +0,0 @@
-#include <linux/config.h>
-#include <linux/types.h>
-#include <asm/ibm4xx.h>
-#include <linux/kernel.h>
-
-
-
-#define LSR_DR		0x01 /* Data ready */
-#define LSR_OE		0x02 /* Overrun */
-#define LSR_PE		0x04 /* Parity error */
-#define LSR_FE		0x08 /* Framing error */
-#define LSR_BI		0x10 /* Break */
-#define LSR_THRE	0x20 /* Xmit holding register empty */
-#define LSR_TEMT	0x40 /* Xmitter empty */
-#define LSR_ERR		0x80 /* Error */
-
-#include <platforms/4xx/ibm_ocp.h>
-
-extern struct NS16550* COM_PORTS[];
-#ifndef NULL
-#define NULL 0x00
-#endif
-
-static volatile struct NS16550 *kgdb_debugport = NULL;
-
-volatile struct NS16550 *
-NS16550_init(int chan)
-{
-	volatile struct NS16550 *com_port;
-	int quot;
-#ifdef BASE_BAUD
-	quot = BASE_BAUD / 9600;
-#else
-	quot = 0x000c; /* 0xc = 9600 baud (on a pc) */
-#endif
-
-	com_port = (struct NS16550 *) COM_PORTS[chan];
-
-	com_port->lcr = 0x00;
-	com_port->ier = 0xFF;
-	com_port->ier = 0x00;
-	com_port->lcr = com_port->lcr | 0x80; /* Access baud rate */
-	com_port->dll = ( quot & 0x00ff ); /* 0xc = 9600 baud */
-	com_port->dlm = ( quot & 0xff00 ) >> 8;
-	com_port->lcr = 0x03; /* 8 data, 1 stop, no parity */
-	com_port->mcr = 0x00; /* RTS/DTR */
-	com_port->fcr = 0x07; /* Clear & enable FIFOs */
-
-	return( com_port );
-}
-
-
-void
-NS16550_putc(volatile struct NS16550 *com_port, unsigned char c)
-{
-	while ((com_port->lsr & LSR_THRE) == 0)
-		;
-	com_port->thr = c;
-	return;
-}
-
-unsigned char
-NS16550_getc(volatile struct NS16550 *com_port)
-{
-	while ((com_port->lsr & LSR_DR) == 0)
-		;
-	return (com_port->rbr);
-}
-
-unsigned char
-NS16550_tstc(volatile struct NS16550 *com_port)
-{
-	return ((com_port->lsr & LSR_DR) != 0);
-}
-
-
-#if defined(CONFIG_KGDB_TTYS0)
-#define KGDB_PORT 0
-#elif defined(CONFIG_KGDB_TTYS1)
-#define KGDB_PORT 1
-#elif defined(CONFIG_KGDB_TTYS2)
-#define KGDB_PORT 2
-#elif defined(CONFIG_KGDB_TTYS3)
-#define KGDB_PORT 3
-#else
-#error "invalid kgdb_tty port"
-#endif
-
-void putDebugChar( unsigned char c )
-{
-	if ( kgdb_debugport == NULL )
-		kgdb_debugport = NS16550_init(KGDB_PORT);
-	NS16550_putc( kgdb_debugport, c );
-}
-
-int getDebugChar( void )
-{
-	if (kgdb_debugport == NULL)
-		kgdb_debugport = NS16550_init(KGDB_PORT);
-
-	return(NS16550_getc(kgdb_debugport));
-}
-
-void kgdb_interruptible(int enable)
-{
-	return;
-}
-
-void putDebugString(char* str)
-{
-	while (*str != '\0') {
-		putDebugChar(*str);
-		str++;
-	}
-	putDebugChar('\r');
-	return;
-}
-
-void
-kgdb_map_scc(void)
-{
-	printk("kgdb init \n");
-	kgdb_debugport = NS16550_init(KGDB_PORT);
-}
