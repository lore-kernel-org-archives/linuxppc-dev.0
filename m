Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpFMQ4tWjzDrWt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 08:22:58 +1000 (AEST)
Message-ID: <1504822968.12628.38.camel@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 08 Sep 2017 08:22:48 +1000
In-Reply-To: <1504774792.31322.13.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
 <1504768943.27247.149.camel@infinera.com>
 <1504773212.12628.26.camel@kernel.crashing.org>
 <1504774792.31322.13.camel@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 08:59 +0000, Joakim Tjernlund wrote:
> 
> > Hrm it's tricky, you shouldn't just turn that ifdef back on without
> > also changing pci_resource_to_user().
> 
> There are two ifdef to change:
> __pci_mmap_make_offset():
> #if 0 /* See comment in pci_resource_to_user() for why this is disabled */
> 		*offset += hose->pci_mem_offset;
> #endif
> 
> and
> 
> pci_resource_to_user()
> 	/* We pass a fully fixed up address to userland for MMIO instead of
> 	 * a BAR value because X is lame and expects to be able to use that
> 	 * to pass to /dev/mem !
> 	 *
> 	 * That means that we'll have potentially 64 bits values where some
> 	 * userland apps only expect 32 (like X itself since it thinks only
> 	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
> 	 * 32 bits CHRPs :-(
> 	 *
> 	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
> 	 * has been fixed (and the fix spread enough), we can re-enable the
> 	 * 2 lines below and pass down a BAR value to userland. In that case
> 	 * we'll also have to re-enable the matching code in
> 	 * __pci_mmap_make_offset().
> 	 *
> 	 * BenH.
> 	 */
> #if 0
> 	else if (rsrc->flags & IORESOURCE_MEM)
> 		offset = hose->pci_mem_offset;
> #endif
> 
> Problem is that pci_mem_offset is gone, the closed I can find is mem_offset
> but that is an array,maybe just mem_offset[0] ?

No, you'd have to scan the array of resources to find which offset
applies.

> > I'm not sure exactly what's going
> > on in your case, if you have a problem can you add printk to instrument
> > ?
> 
> Seems to be something else going on in out board. Anyhow, the mem_offset should
> be fixed to compile, nice to have it behind a CONFIG option. Then
> one can start the process to remove the special casing easier.

Again, why do you need to remove it ? Can you find anything with the
existing code (with its #if'0) that is broken ?

Cheers,
Ben.
