Return-Path: <benh@kernel.crashing.org>
Message-ID: <1333405938.30734.60.camel@pasglop>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 03 Apr 2012 08:32:18 +1000
In-Reply-To: <alpine.LFD.2.02.1204022324140.2542@ionos>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <alpine.LFD.2.02.1204022251420.2542@ionos>
 <1333401600.30734.56.camel@pasglop>
 <alpine.LFD.2.02.1204022324140.2542@ionos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2012-04-02 at 23:27 +0200, Thomas Gleixner wrote:
> So it's covered by this section:
> 
> mpic_set_irq_type()
> 
>         if (flow_type == IRQ_TYPE_NONE)
>                 if (mpic->senses && src < mpic->senses_count)
>                         flow_type = mpic->senses[src];
>         if (flow_type == IRQ_TYPE_NONE)
>                 flow_type = IRQ_TYPE_LEVEL_LOW;
> 
> And with IRQ_TYPE_NONE this is always going to end up with
> IRQ_TYPE_LEVEL_LOW simply because the only function which might set
> mpic->senses is mpic_set_default_senses(). And this function does not
> have a single caller .....
> 
> /me scratches head 

Something must have broken ... when converting from the device-tree we
should be calling xlate which should extract the polarity/sense from the
device-tree.

Now, afaik, IRQ_LEVEL_LOW is correct for PCI unless the interrupt is
inverted inside Apple ASIC which is possible... (it's not an external
PCI, it's a cell inside K2).

Cheers,
Ben.
