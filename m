Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 4 May 2011 09:59:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc: make irq_{alloc, free}_virt private and
	remove count argument
Message-ID: <20110504155905.GB3317@ponder.secretlab.ca>
References: <20110428192227.8979.49181.stgit@ponder>
	<20110428200153.8979.23873.stgit@ponder>
	<1304387267.2513.298.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304387267.2513.298.camel@pasglop>
Cc: Michal Simek <monstr@monstr.eu>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, hpa@zytor.com,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2011 at 11:47:47AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-04-28 at 14:01 -0600, Grant Likely wrote:
> > irq_alloc_virt() and irq_free_virt() aren't called anywhere but from
> > arch/powerpc/kernel/irq.c, and they are only ever called with count=1.
> > This patch removes the prototypes from the header file, removes the
> > count arguments, and cuts out the dead code.
> > 
> > Also removes obsolete references to irq_early_init()
> 
> Nack.
> 
> The count was intended to be able to allocate blocks of interrupts. This
> was not used so far because we didn't support MSI blocks (for non-X
> MSIs) but that is coming, and unfortunately, the API that was designed
> for that is crap and requires contiguous IRQ numbers on the linux side
> as well as on the device side (well device side is a HW requirement but
> we could have been smarter on the Linux side).
> 
> So the ability to allocate blocks will be needed. In fact it's not clear
> yet whether we'll also need them to be naturally aligned powers of two
> or not at this stage. It depends how the bloody API is going to be used
> by drivers.

Heh, I wondered about that, but there hasn't been any users for at
least 5 years (as evidenced by commit e12514650b, "Fix loop logic in
irq_alloc_virt()") so it was looking pretty dead, and it made the
patch to switch to using irq_alloc_desc*() quite a bit simpler if it
was removed.  :-)

I'm not particularly attached to this patch, so I can drop it from the
series.

g.
