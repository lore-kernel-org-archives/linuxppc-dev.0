Date: Mon, 29 Apr 2002 16:10:17 +0200
From: Marius Groeger <mag@sysgo.de>
Message-Id: <200204291410.g3TEAHD06070@dagobert.svc.sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: console on SCC1 on 8260
In-Reply-To: <3CC7F018.2040604@dgt-lab.com.pl>
References: <3CC7F018.2040604@dgt-lab.com.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In linux.ppc.embedded, you wrote:
>
> Huh, I've just discovered that arch/ppc/8260_io/uart.c does not support
>  console on SCC1!
> Anyone has such version of this driver?

Sure does work for us here. We had to apply the following patch though:

--- linux-2.4.16.org/arch/ppc/8260_io/uart.c    Fri Dec 21 15:57:14 2001
+++ linux-2.4.16-elinos/arch/ppc/8260_io/uart.c Fri Dec 21 15:57:17 2001
@@ -162,6 +162,7 @@
 #else /* SCC_CONSOLE */
 #define SCC_NUM_BASE   0       /* SCC base tty "number" */
 #define SCC_IDX_BASE   0       /* table index */
+#define PORT_NUM(P)    (((P) < (SCC_NUM_BASE)) ? (P) : (P)-(SCC_NUM_BASE))
 static struct serial_state rs_table[] = {
        /* UART CLK   PORT          IRQ      FLAGS  NUM   */

Regards,
Marius.

--
Marius Groeger        SYSGO Real-Time Solutions GmbH    www.sysgo.de
Software Engineering  Embedded and Real-Time Software   www.osek.de
mgroeger @ sysgo de   Germany                           www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
