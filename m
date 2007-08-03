Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EEF6DDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 21:10:28 +1000 (EST)
Message-ID: <46B30CE9.5080905@ru.mvista.com>
Date: Fri, 03 Aug 2007 15:09:29 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
References: <20070730163517.GA10087@ru.mvista.com>	<20070802034848.GA837@localhost.localdomain>
	<20070802150852.39701576@weaponx.rchland.ibm.com>
In-Reply-To: <20070802150852.39701576@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 2 Aug 2007 13:48:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Mon, Jul 30, 2007 at 08:35:17PM +0400, Valentine Barshak wrote:
>>> PPC44x cascade UIC irq handler fix.
>>>
>>> According to PPC44x UM, if an interrupt is configured as
>>> level-sensitive, and a clear is attempted on the UIC_SR, the UIC_SR
>>> field is not cleared if the incoming interrupt signal is at the
>>> asserted polarity. This causes us to enter a cascade handler twice,
>>> since we first ack parent UIC interrupt and ack child UIC one after
>>> that. The patch checks child UIC msr value and returns IRQ_HANDLED
>>> if there're no pending interrupts. Otherwise we get a kernel panic
>>> with a "Fatal exception in interrupt" (illegal vector).
>>> The patch also fixes status flags.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> Hrm... This doesn't seem like the right fix to me.  Instead, I think
>> the cascaded IRQ handler should ack the interrupt on the child first.
>> I'm a little surprised it doesn't at the moment.
> 
> Agreed.  Anyone going to hack up a patch for that?
> 
> josh

Anyways, I don't see why kernel should panic if we get a spurious interrupt.
