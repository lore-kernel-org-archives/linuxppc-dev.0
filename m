Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id 66E152C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 17:22:04 +1000 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] serial/mpc52xx_uart: fix kernel panic when system reboot
Date: Wed, 12 Jun 2013 09:21:42 +0200
Message-Id: <1371021702-3030-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: agust@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This bug appear when a second PSC based driver appends an interrupt
routine to the FIFO controller shared interrupt (like spi-mpc512x-psc).
When reboot, uart_shutdown() remove the serial console interrupt handler
while spi-mpc512x-psc isr is still activate and cause the following kernel
panic:

The system is going down for reboot NOW!rpc (ttyPSC0) (Mon Jun 10 12:26:07 20
INIT: Sending processirq 40: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.0-rc4-next-20130607-00001-ga0bceb3-dirty #5
Call Trace:
[cfff9f00] [c0007910] show_stack+0x48/0x150 (unreliable)
[cfff9f40] [c005ae60] __report_bad_irq.isra.6+0x34/0xe0
[cfff9f60] [c005b194] note_interrupt+0x214/0x26c
[cfff9f90] [c00590fc] handle_irq_event_percpu+0xd0/0x1bc
[cfff9fd0] [c005921c] handle_irq_event+0x34/0x54
[cfff9fe0] [c005b8f4] handle_level_irq+0x90/0xf4
[cfff9ff0] [c000cb98] call_handle_irq+0x18/0x28
[c050dd60] [c000575c] do_IRQ+0xcc/0x124
[c050dd90] [c000eb04] ret_from_except+0x0/0x14
--- Exception: 501 at __do_softirq+0x84/0x17c
    LR = __do_softirq+0x20/0x17c
[c050de50] [c0045e7c] ktime_get+0x148/0x160 (unreliable)
[c050dea0] [c001eccc] irq_exit+0x94/0xb8
[c050deb0] [c00056e0] do_IRQ+0x50/0x124
[c050dee0] [c000eb04] ret_from_except+0x0/0x14
--- Exception: 501 at cpu_startup_entry+0x5c/0x134
    LR = cpu_startup_entry+0xc0/0x134
[c050dfa0] [c0045170] cpu_startup_entry+0xac/0x134 (unreliable)
[c050dfc0] [c04b9d70] start_kernel+0x2d4/0x2e8
[c050dff0] [00003438] 0x3438
handlers:
[<c02ae388>] mpc512x_psc_spi_isr
Disabling IRQ #40


Disabling serial console interrupt before free_irq()
prevents this error.



Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
 drivers/tty/serial/mpc52xx_uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 9ba1945..e1280a2 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1058,6 +1058,9 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	if (psc_ops->clock)
 		psc_ops->clock(port, 0);
 
+	/* Disable interrupt */
+	psc_ops->cw_disable_ints(port);
+
 	/* Release interrupt */
 	free_irq(port->irq, port);
 }
-- 
1.8.1.2
