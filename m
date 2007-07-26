Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 34E33DDF40
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:47:22 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1IDz0A-0008IE-00
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 10:47:18 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Fwd: Re: Kernel Bug when entering something after login
Date: Thu, 26 Jul 2007 10:47:16 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200707261047.17297.jbe@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46YI. Valid for current 2.6.22.1 kernel.

=2D---------  Forwarded Message  ----------

Subject: Re: Kernel Bug when entering something after login
Date: Wednesday 25 July 2007 21:06
=46rom: Thomas Gleixner <tglx@linutronix.de>
To: Juergen Beisert <juergen127@kreuzholzen.de>
Cc: linux-rt-users@vger.kernel.org

On Wed, 2007-07-25 at 19:00 +0200, Juergen Beisert wrote:
> [c0245db0] [c01bdb98] rt_spin_lock_slowlock+0x4c/0x224 (unreliable)
> [c0245e10] [c011823c] uart_start+0x24/0x48
> [c0245e30] [c0113ff4] n_tty_receive_buf+0x170/0xfd4
> [c0245ef0] [c010f0dc] flush_to_ldisc+0xe0/0x130
> [c0245f20] [c011b51c] mpc52xx_uart_int+0x194/0x350
> [c0245f50] [c0046dfc] handle_IRQ_event+0x6c/0x110
> [c0245f80] [c00475ec] thread_simple_irq+0x90/0xf8
> [c0245fa0] [c00479a0] do_irqd+0x34c/0x3cc
> [c0245fd0] [c0033380] kthread+0x48/0x84
> [c0245ff0] [c00104ac] kernel_thread+0x44/0x60
> Instruction dump:
> 70090008 40820144 80010064 bb410048 38210060 7c0803a6 4e800020 801c0010
> 5400003a 7c001278 7c000034 5400d97e <0f000000> 39600004 91610008 80010008
> note: IRQ-131[93] exited with preempt_count 1

Yup. That's a deadlock. In mainline this does not happen, as the
spinlock is a NOP. Turn on CONFIG_PROVE_LOCKING in mainline and you see
the problem as well.

Solution below

	tglx

Index: linux-2.6.22/drivers/serial/mpc52xx_uart.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.22.orig/drivers/serial/mpc52xx_uart.c	2007-07-09
 01:32:17.000000000 +0200 +++
 linux-2.6.22/drivers/serial/mpc52xx_uart.c	2007-07-25 21:06:11.000000000
 +0200 @@ -501,7 +501,9 @@ mpc52xx_uart_int_rx_chars(struct uart_po
 		}
 	}

+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&port->lock);

 	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
 }


=2D
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D------------------------------------------------------

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
