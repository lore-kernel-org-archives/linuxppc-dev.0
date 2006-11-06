Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94B8367C13
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 07:14:56 +1100 (EST)
Subject: Re: APUS and IOs question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <454F5259.3020107@hogyros.de>
References: <1162767333.28571.254.camel@localhost.localdomain>
	<454F5259.3020107@hogyros.de>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 07:14:48 +1100
Message-Id: <1162844088.28571.319.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 16:18 +0100, Simon Richter wrote:
> Hi,
> 
> Benjamin Herrenschmidt wrote:
> 
> > Somebody who understands APUS around ?
> 
> I have one, but I don't understand all of it. :-)
> 
> > In include/asm-ppc/io.h, we have a special definition of the PCI IO
> > accessors readw,writew,readl and writel for APUS that don't do byteswap
> > and also don't do barriers.
> 
> APUS PCI is weird, to say the least. The PCI extension is basically
> built to accomodate a single PCI device, which happens to be a Permedia2
> graphics chip that allows byte-swapped mappings of both register and
> framebuffer space and is never told to do DMA because nobody knows what
> kind of interesting effects that would have, so the only synchronisation
> that is needed is between accesses to the framebuffer and the GPU.
> 
> That, and that the 604e+ probably doesn't reorder accesses that much
> anyway that the barriers would do any good here. :-)

Still, it annoys me to have an  APUS-specific definition of accessors
that would otherwise be common to everybody...

Anyway, I decided not to change asm-ppc/io.h, so this will only become
an issue if we ever move APUS over to arch/powerpc

Ben.
