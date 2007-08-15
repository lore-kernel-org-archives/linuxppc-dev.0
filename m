Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80060DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 05:14:47 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7FJG3Ih014118
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:16:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7FJEifp410500
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:14:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7FJEh5V021283
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:14:43 -0400
Date: Wed, 15 Aug 2007 14:13:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] Fix irq flow handler for 4xx UIC
Message-ID: <20070815141326.77278a10@zod.rchland.ibm.com>
In-Reply-To: <20070814035242.9674EDDEF0@ozlabs.org>
References: <20070814034811.GA8791@localhost.localdomain>
	<20070814035242.9674EDDEF0@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Aug 2007 13:52:42 +1000 (EST)
David Gibson <david@gibson.dropbear.id.au> wrote:

> At present the driver for the UIC (the embedded interrupt controller
> in 4xx chips) uses the handle_level_irq() flow handler.  It turns out
> this does not correctly handle level triggered interrupts on the UIC.
> 
> Specifically, acknowledging an irq on the UIC (i.e. clearing the
> relevant bit in UIC_SR) will have no effect for a level interrupt
> which is still asserted by the external device, even if the irq is
> already masked.  Therefore, unlike handle_level_irq() we must ack the
> interrupt after invoking the ISR (which should cause the device to
> stop asserting the irq) instead of acking it when we mask it, before
> the ISR.
> 
> This patch implements this change, in a new handle_uic_irq(), a
> customised irq flow handler for the UIC.  For edge triggered
> interrupts, handle_uic_irq() still uses the old flow - we must ack
> edge triggered interrupt before the ISR not after, or we could miss a
> second event which occurred between invoking the ISR and acking the
> irq.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
