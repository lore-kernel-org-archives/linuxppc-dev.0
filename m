Return-Path: <benh@kernel.crashing.org>
Message-ID: <1333413457.30734.69.camel@pasglop>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 03 Apr 2012 10:37:37 +1000
In-Reply-To: <m2hax2qeqs.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-02 at 18:29 +0200, Andreas Schwab wrote:
> > This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
> > driver.
> 
> When I revert a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5 ("genirq: Fix
> long-term regression in genirq irq_set_irq_type() handling") on top of
> 3.4-rc1 the sata irq errors disappear, but I see a lot of spurious
> interrupts.  Also the X server is broken somehow, though I don't know
> whether that is related or a different bug.

I can't explain why but it works for me with your config on a similar
dual G5.

It would be interesting to figure out what causes the call to
set_irq_type(NONE)...

The SATA driver isn't doing anything. What should be happening
is that:

 - pci_read_irq_line() in arch/powerpc/kernel/pci-common.c

This will call of_irq_map_pci() and then call irq_of_create_mapping()
with the result if it's successful (it should be).

 - irq_of_create_mapping in kernel/irq/irqdomain.c

That should then call domain->ops->xlate() where domain is the domain
of the first MPIC (the one in K2), which should return your IRQ number
for the SATA controller (btw, it's 0, in case that matters, ie, HW irq 0
on MPIC 1 iirc) and the interrupt type. This is where you should
get IRQ_TYPE_LEVEL_LOW (i verified and that's what my device-tree
contains).

You can add printk's in there to see what's happening in your case ?

Cheers,
Ben.
