Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B93A41A0377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 13:46:10 +1000 (AEST)
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141]) by ozlabs.org (Postfix) with ESMTP id 62A371401F0
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 13:46:10 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Bump opal_init initcall priority
Date: Mon, 15 Jun 2015 13:44:44 +1000
Message-ID: <6999655.JGazEvKYOi@mexican>
In-Reply-To: <20150612094735.C2DAB1402B4@ozlabs.org>
References: <20150612094735.C2DAB1402B4@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Jun 2015 19:47:35 Michael Ellerman wrote:
> On Thu, 2015-11-06 at 09:25:29 UTC, Alistair Popple wrote:
> > opal_init() is called via a machine_subsys_initcall(). Due to a hack
> > in the eeh code the eeh driver is initialised with at the same
> > initcall level. This means depending on link ordering the following
> > error can occur because the opal irchip has not been initialised:
> > 
> > irq: XICS didn't like hwirq-0x9 to VIRQ17 mapping (rc=-22)
> > pnv_eeh_post_init: Can't request OPAL event interrupt (0)
> > 
> > This patch solves the issue by making sure opal_init is called prior
> > to the subsystems that may need it.
> 
> What is the hack in the eeh code?
> 
> I'm seeing eeh_ops->post_init() called from eeh_init() which is
> core_initcall_sync(), is that what you're talking about?

Yes, but there is this at the start of eeh_init():

	/*
	 * We have to delay the initialization on PowerNV after
	 * the PCI hierarchy tree has been built because the PEs
	 * are figured out based on PCI devices instead of device
	 * tree nodes
	 */
	if (machine_is(powernv) && cnt++ <= 0)
		return ret;

Which basically stops eeh_init() running from the core initcall level on 
PowerNV. Instead on PowerNV eeh_init() gets called from pnv_pci_ioda_fixup() 
which itself is called via the PCI layer from a subsys_initcall (ie. the same 
level as opal_init() is called at without this patch). This is why I missed 
this during my testing - apparently I got lucky during my compilations and 
opal_init() must have been called prior to the pci subsystem initialisation.

Ideally I'd like to change the way eeh_init() is called and make it an 
explicit call for each machine type, however that is a more invasive change 
which will take some time as there seem to be a bunch of subtle dependencies 
between initcalls for different platforms that aren't well documented and I'm 
not convinced I understand them all yet. Hence this "quick" fix.

> Then pnv_eeh_post_init() is the powernv version of eeh_ops->post_init, and 
it
> calls opal_event_request().
> 
> So you'd need the irq_chip setup by then I think?

Yeah, it needs to be setup prior to eeh_post_init() being called. 

> So I guess I'm missing the hack you're talking about.
> 
> Regardless of which level it needs to be at, the only thing that needs to 
run
> early is opal_event_init() am I right? Not all of opal_init().

Yes, that is correct. But I was trying to avoid doing the thing which seemed 
to have got us in this mess in the first place (ie. just making everything 
that needs to run "early" run from a core_initcall). However I guess just 
running opal_event_init() earlier is less likely to have unintended side 
effects than running all of opal_init() earlier. Let me know what you'd 
prefer.

Thanks.

- Alistair

> cheers
