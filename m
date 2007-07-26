Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 8490EDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 19:41:38 +1000 (EST)
Subject: RE: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel Schnell <daniel.schnell@marel.com>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB02178125@is-hdq-exchange.marel.net>
References: <1185390656.3227.12.camel@chaos>
	<fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
	<1185392838.3227.13.camel@chaos>
	<DD39B5C3F4963040ADC9768BE7E430CB02178125@is-hdq-exchange.marel.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 26 Jul 2007 11:41:18 +0200
Message-Id: <1185442878.3227.23.camel@chaos>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-26 at 09:25 +0000, Daniel Schnell wrote:
> Thomas Gleixner wrote:
> 
> > On Wed, 2007-07-25 at 13:42 -0600, Grant Likely wrote:
> >> On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> The port lock needs to be dropped across the tty_flip_buffer call,
> >>> as it would lead to a deadlock with the spin_lock(&port->lock) in
> >>> uart_start() 
> >>> 
> >>> Uncovered by lockdep / preempt-rt
> >>> 
> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> While you are at it 8°> ... the mpc5200-fec driver has serious
> problems with preempt-rt, similar to what the IBM emac had ....

Care to whip up a patch ?

	tglx
