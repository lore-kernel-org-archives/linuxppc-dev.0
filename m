Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6B21DDF29
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 19:09:56 +1000 (EST)
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks (not word wrapped)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <200806031449.14385.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031449.14385.borntraeger@de.ibm.com>
Content-Type: text/plain
Date: Wed, 04 Jun 2008 19:06:42 +1000
Message-Id: <1212570402.9496.72.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-03 at 14:49 +0200, Christian Borntraeger wrote:
> This patch tries to change hvc_console to not use request_irq/free_irq if
> the backend does not use irqs. This allows virtio_console to use hvc_console
> without having a linker reference to request_irq/free_irq.
> 
> The irq specific code is moved to hvc_irq.c and selected by the drivers that
> use irqs (System p, System i, XEN).
> 
> I replaced "irq" with the opaque name "data". The request_irq and free_irq
> calls are replaced with notifier_add and notifier_del. I have also changed
> the code a bit to call the notifier_add and notifier_del inside the spinlock
> area as the callbacks are found via hp->ops.
> 
> Feedback is appreciated.

I haven't looked at the patch proper but I agree with the basic
premises. We routinely use hvc_console for things that don't have an
irq. In fact, David even did a backend hooking up to udbg which is
useful when bringing up weird stuffs :-)

Cheers,
Ben.
