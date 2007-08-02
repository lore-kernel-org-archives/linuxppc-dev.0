Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84903DDDD5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:10:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l72J2cUZ003934
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 15:02:38 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72K8rej268186
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:08:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72K8rtq007904
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:08:53 -0600
Date: Thu, 2 Aug 2007 15:08:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
Message-ID: <20070802150852.39701576@weaponx.rchland.ibm.com>
In-Reply-To: <20070802034848.GA837@localhost.localdomain>
References: <20070730163517.GA10087@ru.mvista.com>
	<20070802034848.GA837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2 Aug 2007 13:48:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 30, 2007 at 08:35:17PM +0400, Valentine Barshak wrote:
> > PPC44x cascade UIC irq handler fix.
> > 
> > According to PPC44x UM, if an interrupt is configured as
> > level-sensitive, and a clear is attempted on the UIC_SR, the UIC_SR
> > field is not cleared if the incoming interrupt signal is at the
> > asserted polarity. This causes us to enter a cascade handler twice,
> > since we first ack parent UIC interrupt and ack child UIC one after
> > that. The patch checks child UIC msr value and returns IRQ_HANDLED
> > if there're no pending interrupts. Otherwise we get a kernel panic
> > with a "Fatal exception in interrupt" (illegal vector).
> > The patch also fixes status flags.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Hrm... This doesn't seem like the right fix to me.  Instead, I think
> the cascaded IRQ handler should ack the interrupt on the child first.
> I'm a little surprised it doesn't at the moment.

Agreed.  Anyone going to hack up a patch for that?

josh
