Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC567DE0CD
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 11:36:32 +1100 (EST)
Subject: Re: Oops with 2.6.29-rc7 on POWER5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20090310000559.GD2256@yoda.jdub.homelinux.org>
References: <20090310000559.GD2256@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 10 Mar 2009 11:36:15 +1100
Message-Id: <1236645375.7260.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 20:05 -0400, Josh Boyer wrote:
> [c00000000fffb830] [c0000000005fe504] .mutex_lock_nested+0x78/0x4b0
> (unreliable)
> [c00000000fffb950] [c00000000039d520] .echo_char_raw+0x40/0x98
> [c00000000fffb9f0] [c00000000039fd68] .n_tty_receive_buf+0xb48/0x1104
> [c00000000fffbbb0] [c0000000003a3a08] .flush_to_ldisc+0x160/0x244
> [c00000000fffbc80] [c0000000003a3b5c] .tty_flip_buffer_push+0x70/0x9c
> [c00000000fffbd10] [c0000000003b9e94] .hvsi_interrupt+0x464/0x590
> [c00000000fffbe50] [c000000000119168] .handle_IRQ_event+0x60/0xdc
> [c00000000fffbef0] [c00000000011baf0] .handle_fasteoi_irq+0x108/0x1a8
> 
Do that patch help ?

Alan, any comment about the races talked about in those comments ? Are
they still something I should worry about ?

hvc: Remove tty->low_latency on pseries backends

The hvcs and hvsi backends both set tty->low_latency to one, along
with more or less scary comments regarding bugs or races that would
happen if not doing so.

However, they also both call tty_flip_buffer_push() in conexts where
it's illegal to do so since some recent tty changes (or at least it
may have been illegal always but it nows blows) when low_latency is
set (ie, hard interrupt or with spinlock held and irqs disabled).

This removes the setting for now to get them back to working condition,
we'll have to address the races described in the comments separately
if they are still an issue (some of this might have been fixed already).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/drivers/char/hvcs.c
===================================================================
--- linux-work.orig/drivers/char/hvcs.c	2009-03-10 11:28:03.000000000 +1100
+++ linux-work/drivers/char/hvcs.c	2009-03-10 11:28:08.000000000 +1100
@@ -1139,15 +1139,6 @@ static int hvcs_open(struct tty_struct *
 	hvcsd->tty = tty;
 	tty->driver_data = hvcsd;
 
-	/*
-	 * Set this driver to low latency so that we actually have a chance at
-	 * catching a throttled TTY after we flip_buffer_push.  Otherwise the
-	 * flush_to_async may not execute until after the kernel_thread has
-	 * yielded and resumed the next flip_buffer_push resulting in data
-	 * loss.
-	 */
-	tty->low_latency = 1;
-
 	memset(&hvcsd->buffer[0], 0x00, HVCS_BUFF_LEN);
 
 	/*
Index: linux-work/drivers/char/hvsi.c
===================================================================
--- linux-work.orig/drivers/char/hvsi.c	2009-03-10 11:27:19.000000000 +1100
+++ linux-work/drivers/char/hvsi.c	2009-03-10 11:27:22.000000000 +1100
@@ -810,7 +810,6 @@ static int hvsi_open(struct tty_struct *
 	hp = &hvsi_ports[line];
 
 	tty->driver_data = hp;
-	tty->low_latency = 1; /* avoid throttle/tty_flip_buffer_push race */
 
 	mb();
 	if (hp->state == HVSI_FSP_DIED)
