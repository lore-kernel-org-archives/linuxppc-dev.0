Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id B93BE67A79
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 09:23:20 +1100 (EST)
To: paulus@samba.org
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:23:02 +0100
Message-Id: <20050306222302.021351ED3D@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 3/4] delete unused file arch_ppc_syslib_ppc4xx_serial.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/ppc/syslib/ppc4xx_serial.c |  171 -------------------------------------
 1 files changed, 171 deletions(-)

diff -L arch/ppc/syslib/ppc4xx_serial.c -puN arch/ppc/syslib/ppc4xx_serial.c~remove_file-arch_ppc_syslib_ppc4xx_serial.c /dev/null
--- kj/arch/ppc/syslib/ppc4xx_serial.c
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,171 +0,0 @@
-/*
- * arch/ppc/syslib/ppc405_serial.c
- *
- * Author: MontaVista Software, Inc.
- *         	frank_rowand@mvista.com or source@mvista.com
- * 	   	debbie_chu@mvista.com
- *
- * This is a fairly standard 165xx type device that will eventually
- * be merged with other similar processor/boards.	-- Dan
- *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Console I/O support for Early kernel bringup.
- */
-
-#include <linux/config.h>
-
-#if defined(CONFIG_IBM405GP) || defined(CONFIG_IBM405CR)
-
-#ifdef CONFIG_KGDB
-#include <asm/kgdb.h>
-#include <linux/init.h>
-#endif
-
-#ifdef CONFIG_DEBUG_BRINGUP
-
-#include <linux/console.h>
-
-extern void ftr_reset_preferred_console(void);
-
-
-static int ppc405_sercons_setup(struct console *co, char *options)
-{
-#ifdef CONFIG_UART0_DEBUG_CONSOLE
-    volatile unsigned char *uart_dll  = (char *)0xef600300;
-    volatile unsigned char *uart_fcr  = (char *)0xef600302;
-    volatile unsigned char *uart_lcr  = (char *)0xef600303;
-#endif
-
-#ifdef CONFIG_UART1_DEBUG_CONSOLE
-    volatile unsigned char *uart_dll  = (char *)0xef600400;
-    volatile unsigned char *uart_fcr  = (char *)0xef600402;
-    volatile unsigned char *uart_lcr  = (char *)0xef600403;
-#endif
-
-    *uart_lcr = *uart_lcr | 0x80;   /* DLAB on  */
-
-/* ftr revisit - there is no config option for this
-**  also see include/asm-ppc/ppc405_serial.h
-**
-** #define CONFIG_IBM405GP_INTERNAL_CLOCK
-*/
-
-
-#ifdef  CONFIG_IBM405GP_INTERNAL_CLOCK
-    /* ftr revisit
-    ** why is bit 19 of chcr0 (0x1000) being set?
-    */
-    /* 0x2a results in data corruption, kgdb works with 0x28 */
-    *uart_dll = 0x28;		    /* 9600 baud */
-    _put_CHCR0((_get_CHCR0() & 0xffffe000) | 0x103e);
-#else
-    *uart_dll = 0x48;		    /* 9600 baud */
-#endif
-    *uart_lcr = *uart_lcr & 0x7f;   /* DLAB off */
-
-    return 0;
-}
-
-
-/*
- * This is a bringup hack, writing directly to uart0 or uart1
- */
-
-static void
-ppc405_sercons_write(struct console *co, const char *ptr,
-            unsigned nb)
-{
-    int i;
-
-#ifdef CONFIG_UART0_DEBUG_CONSOLE
-    volatile unsigned char *uart_xmit = (char *)0xef600300;
-    volatile unsigned char *uart_lsr  = (char *)0xef600305;
-#endif
-
-#ifdef CONFIG_UART1_DEBUG_CONSOLE
-    volatile unsigned char *uart_xmit = (char *)0xef600400;
-    volatile unsigned char *uart_lsr  = (char *)0xef600405;
-#endif
-
-    for (i = 0; i < nb; ++i) {
-
-	/* wait for transmit reg (possibly fifo) to empty */
-	while ((*uart_lsr & 0x40) == 0)
-	    ;
-
-	*uart_xmit = (ptr[i] & 0xff);
-
-	if (ptr[i] == '\n') {
-
-	    /* add a carriage return */
-
-	    /* wait for transmit reg (possibly fifo) to empty */
-	    while ((*uart_lsr & 0x40) == 0)
-		;
-
-	    *uart_xmit = '\r';
-	}
-    }
-
-    return;
-}
-
-
-static int
-ppc405_sercons_read(struct console *co, char *ptr, unsigned nb)
-{
-#ifdef CONFIG_UART0_DEBUG_CONSOLE
-    volatile unsigned char *uart_rcv  = (char *)0xef600300;
-    volatile unsigned char *uart_lsr  = (char *)0xef600305;
-#endif
-
-#ifdef CONFIG_UART1_DEBUG_CONSOLE
-    volatile unsigned char *uart_rcv  = (char *)0xef600400;
-    volatile unsigned char *uart_lsr  = (char *)0xef600405;
-#endif
-
-
-    /* ftr revisit: not tested */
-
-    if (nb == 0)
-	return(0);
-
-    if (!ptr)
-	return(-1);
-
-    /* wait for receive reg (possibly fifo) to contain data */
-    while ((*uart_lsr & 0x01) == 0)
-	;
-
-    *ptr = *uart_rcv;
-
-    return(1);
-}
-
-static struct console ppc405_sercons = {
-	.name =		"dbg_cons",
-	.write =	ppc405_console_write,
-	.setup =	ppc405_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
-
-void
-register_debug_console(void)
-{
-	register_console(&ppc405_sercons);
-}
-
-void
-unregister_debug_console(void)
-{
-	unregister_console(&ppc405_sercons);
-}
-
-#endif	/* CONFIG_DEBUG_BRINGUP */
-
-#endif	/* #if defined(CONFIG_IBM405GP) || defined(CONFIG_IBM405CR) */
_
