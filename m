Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DED69B7BA3
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 15:24:20 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix compile errors found by new ppc64e_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1255910308.4192.8.camel@concordia>
References: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
	<1255712717-21221-2-git-send-email-galak@kernel.crashing.org>
	<1255910308.4192.8.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Oct 2009 13:24:07 +0900
Message-Id: <1255926247.2182.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-19 at 10:58 +1100, Michael Ellerman wrote:

> >  	if (bus->self) {
> > +#ifdef CONFIG_PPC_STD_MMU_64
> >  		struct resource *res = bus->resource[0];
> > +#endif
> >  
> >  		pr_debug("IO unmapping for PCI-PCI bridge %s\n",
> >  			 pci_name(bus->self));
> 104 
> 105 #ifdef CONFIG_PPC_STD_MMU_64                                                
> 106                 __flush_hash_table_range(&init_mm, res->start + _IO_BASE,
> 107                                          res->end + _IO_BASE + 1);
> 108 #endif
> 109		return 0;
> 110	 }
> 
> So just expand the ifdef around the pr_debug()?

I'd rather move the pr_debug to after the ifdef, it doesn't need to
absolutely be before the __flush_hash_* call, it's more to see in the
log whether the bus was properly unmapped when doing unplug.

Cheers,
Ben.
