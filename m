Return-Path: <tglx@linutronix.de>
Date: Fri, 6 Apr 2012 13:17:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <m2r4w1akz4.fsf@igel.home>
Message-ID: <alpine.LFD.2.02.1204061315040.2542@ionos>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost> <m2y5qdow0v.fsf@igel.home>
 <20120404154020.40C513E09D5@localhost> <m2r4w1akz4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 6 Apr 2012, Andreas Schwab wrote:

> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > Can you attach console output logs for each of configs above and also
> > with NR_IRQS=128?  That might give me some clues as to which specific
> > code is causing the issues.
> 
> It really looks like the issue starts when irq_expand_nr_irqs is called
> the first time to make nr_irqs bigger than NR_IRQS.

And it looks like the irqdomain code is the real culprit.

void irq_set_virq_count(unsigned int count)
{
        pr_debug("irq: Trying to set virq count to %d\n", count);

        BUG_ON(count < NUM_ISA_INTERRUPTS);
        if (count < NR_IRQS)
                irq_virq_count = count;
}

That looks simply wrong.....

s/NR_IRQS/nr_irqs/ should do the trick.

Thanks,

	tglx
