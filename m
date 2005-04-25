Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1BEA67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 05:49:24 +1000 (EST)
Date: Mon, 25 Apr 2005 11:36:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050425143619.GF25420@logos.cnet>
References: <20050413195713.GF11131@logos.cnet>
	<20050425145029.GD3112@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050425145029.GD3112@smtp.west.cox.net>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] attempt to remove misc-embedded.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2005 at 07:50:29AM -0700, Tom Rini wrote:
> On Wed, Apr 13, 2005 at 04:57:13PM -0300, Marcelo Tosatti wrote:
> 
> > 
> > Hi Tom,
> > 
> > This is an attempt to move remove misc-embedded.c by moving its quirks to
> > misc.c. 
> > 
> > It needs further fixing and cleaning, for sure. 
> 
> I like the idea of deleting misc-embedded.c, but I don't think we should
> haven't make many changes to misc.c (except perhaps abstracting away a
> few more hunks of it) as I _think_ most of the cpu-specific stuff can be
> moved around now to the misc-board.c files.

So the plan is to move all cpu specific code in decompress_kernel() to cpu specific code :)

Including

#ifdef CONFIG_44x
        /* Reset MAL */
        mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
        /* Wait for reset */
        while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {};
        /* Reset EMAC */
        *(volatile unsigned long *)PPC44x_EMAC0_MR0 = 0x20000000;
        __asm__ __volatile__("eieio");
#endif


There are a few changes which are required for embedded targets, for example, passing "bd" 
to serial_init as its 2nd argument. 

Some misc-embedded.c requirements also need to be there, in decompress_kernel().

For example

+#ifdef CONFIG_EMBEDDEDBOOT
+        /* Set end of memory available to us.  It is always the highest
+         * memory address provided by the board information.
+         */
+       end_avail = (char *)(bp->bi_memsize);
+#else
        /* assume the chunk below 8M is free */
        end_avail = (char *)0x00800000;
+#endif

And later "end_avail" setting need to be abstracted away. 

Is that what you mean? 

> > Are there any major disagreements about the change? 
> > Might need to define a bd_t structure for all ppc's? 
> 
> That's something to be left for the flat OF tree thread. :)
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
