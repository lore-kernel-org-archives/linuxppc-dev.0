Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DD3F67A63
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 09:08:53 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148938117.5959.24.camel@localhost.localdomain>
References: <1148935262.25048.31.camel@brick>
	<1148938117.5959.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 29 May 2006 19:08:35 -0400
Message-Id: <1148944116.25048.78.camel@brick>
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

On Tue, 2006-05-30 at 07:28 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-05-29 at 16:41 -0400, Michal Ostrowski wrote:
> > The following set of patches is aimed at killing the
> > ppc64_interrupt_controller global variable, and similarly that various
> > global variables used to tweak the parameters of virtual IRQ re-mapping.
> > Instead each platform can use a single function to configure IRQ
> > re-mapping in "init_early()".
> 
>  .../...
> 
> Hi ! Interesting.. I've start looking at reworking that with a slightly
> different approach though...
> 

I'm in total agreement with your assessment of where things should go.

My main motivation here was to kill ppc64_interrupt_controller and to
consolidate our knowledge of the requirements of the different platforms
into a single interface (i.e. virt_irq_config). 

As such I see this patch as either a first step, or clean-up along-side,
the changes you're considering.

I did consider at first making more changes than published here; in
particular to address the offsetting issue you and Paul have commented
on.  

Current code such as:

        virq = virt_irq_create_mapping(irq[0]);

        ...

        np->intrs[intrcount].line = irq_offset_up(virq);


Should be more like:

        np->intrs[intrcount].line = virt_irq_create_mapping(irq[0]);


(Where the knowledge regarding all remapping/offsetting is embedded
behind the remapping interfaces.  We should kill irq_offset_{up,down}
and replace them with things such as real_irq_to_virt() and
virt_irq_to_real().)


The patches I've sent out were not intended to deal with this, as I
wanted to keep the change set focused and small. However, things similar
to what you've outlined I've been keeping in mind as potential follow-on
work; and I had intended these patches to facilitate that.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
