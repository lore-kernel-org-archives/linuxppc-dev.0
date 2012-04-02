Return-Path: <tglx@linutronix.de>
Date: Mon, 2 Apr 2012 23:27:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <1333401600.30734.56.camel@pasglop>
Message-ID: <alpine.LFD.2.02.1204022324140.2542@ionos>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <alpine.LFD.2.02.1204022251420.2542@ionos>
 <1333401600.30734.56.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Milton Miller <miltonm@bga.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 LAK <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Apr 2012, Benjamin Herrenschmidt wrote:

> On Mon, 2012-04-02 at 22:52 +0200, Thomas Gleixner wrote:
> > > When I revert a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5 ("genirq: Fix
> > > long-term regression in genirq irq_set_irq_type() handling") on top
> > of
> > > 3.4-rc1 the sata irq errors disappear, but I see a lot of spurious
> > 
> > Hmm. Which irq chip is handling the interrupt for that sata irq ?
> 
> MPIC. The irq is a PCI IRQ, and so should be level-low, it should have
> been mapped by the PCI code using the of_* calls.

So it's covered by this section:

mpic_set_irq_type()

        if (flow_type == IRQ_TYPE_NONE)
                if (mpic->senses && src < mpic->senses_count)
                        flow_type = mpic->senses[src];
        if (flow_type == IRQ_TYPE_NONE)
                flow_type = IRQ_TYPE_LEVEL_LOW;

And with IRQ_TYPE_NONE this is always going to end up with
IRQ_TYPE_LEVEL_LOW simply because the only function which might set
mpic->senses is mpic_set_default_senses(). And this function does not
have a single caller .....

/me scratches head
