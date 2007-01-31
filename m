Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2CDBDDEF8
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 17:52:34 +1100 (EST)
Date: Tue, 30 Jan 2007 22:52:32 -0800 (PST)
Message-Id: <20070130.225232.112422538.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1170032301.26655.140.camel@localhost.localdomain>
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 29 Jan 2007 11:58:21 +1100

> Do you have some pointers to documentation on those sparc64
> interfaces ?

So I got things working on sparc64 with a one-liner to the current
upstream vanilla 2.6.20-rc7 :-)  It's not the best, but it works.

You can see it all at:

	kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git

Basically, I changed arch_teardown_msi_irq() to pass in the
PCI device pointer, that's it.

The rest is sparc64 specific stuff.

One thing that's disappointing is that this "MSI Queue" framework
sparc64 has really suggests a two-tiered interrupt handling scheme.
As I previously explained, on sparc64 you assosciated each MSI with a
queue, and you can attach multiple MSIs to a single queue.

The queue is what generates the interrupt, and in response to that
interrupt you process a ring of MSI descriptors in the queue.  The
descriptors have a bunch of very useful information which we have no
way to make use of currently, and in particular it has the MSI number
in each entry.

So what would be cool would be to be able to attach the IRQ
action entries to a list inside of the MSI queue.

Instead, what happens right now is that each queue has a single
MSI assosciated with it, and that's the interrupt.

The MSI descriptors have all sorts of useful information, such as a
system TICK timestamp (for profiling), the exact bus/dev/fn that
generated the MSI (for debugging), as well as the full MSI address,
data, and code values (for IRQ dispatch and PCI-E error message
processing).

I've tested tg3 with MSI on my Niagara, it seems to work well.
Unfortunately I don't have any MSI-X capable devices here, but
eventually I am sure I will.  I glanced over the MSI-X code and I see
no reason why it wouldn't work.
