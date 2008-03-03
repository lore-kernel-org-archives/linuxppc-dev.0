Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id AAF37DDF25
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:05:34 +1100 (EST)
Date: Mon, 3 Mar 2008 22:05:32 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080303210532.GA20382@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080303170719.GC28951@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Mon, Mar 03, 2008 at 11:07:20AM -0600, Scott Wood wrote:
> On Mon, Mar 03, 2008 at 03:47:27PM +0100, Philippe De Muyter wrote:
> > My root device is on a compact-flash connected to a PCI yenta chip from TI,
> > and this one is not working, altough it seems to be discovered :
> > 
> > 	Yenta: CardBus bridge found at 0000:00:12.0 [0000:0000]
> > 	Yenta: Using CSCINT to route CSC interrupts to PCI
> > 	Yenta: Routing CardBus interrupts to PCI
> > 	Yenta TI: socket 0000:00:12.0, mfunc 0x00001b22, devctl 0x64
> > 	irq 18: nobody cared (try booting with the "irqpoll" option)
> > 	Call Trace:
> > 	[cf813af0] [c00066c8] show_stack+0x3c/0x1bc (unreliable)
> > 	[cf813b30] [c003c1ac] __report_bad_irq+0x38/0xcc
> > 	[cf813b50] [c003c4c8] note_interrupt+0x288/0x2cc
> > 	[cf813b80] [c003cc34] handle_fasteoi_irq+0x94/0xf8
> 
> Maybe your PCI interrupt-map is wrong...

Is the PCI-interrupt map that part of the dts file :

                interrupt-map = <

                        /* IDSEL 0x02 */
                        1000 0 0 1 &mpic 1 1
                        1000 0 0 2 &mpic 2 1
                        1000 0 0 3 &mpic 3 1
                        1000 0 0 4 &mpic 4 1

                        /* IDSEL 0x03 */
                        1800 0 0 1 &mpic 4 1
                        1800 0 0 2 &mpic 1 1
                        1800 0 0 3 &mpic 2 1
                        1800 0 0 4 &mpic 3 1

			...

I do not understand anything there :(

Philippe
