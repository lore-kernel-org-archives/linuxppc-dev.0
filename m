Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CF7E7DE039
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 03:49:51 +1100 (EST)
Date: Thu, 31 Jan 2008 10:18:05 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Set dma_data correctly for direct_ops on pasemi
Message-ID: <20080131161805.GA10340@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
	<20080131064130.GA32344@lixom.net>
	<1201783096.4147.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201783096.4147.3.camel@concordia>
Cc: torvalds@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 31, 2008 at 11:38:16PM +1100, Michael Ellerman wrote:
> On Thu, 2008-01-31 at 00:41 -0600, Olof Johansson wrote:
> > More late-caught fallout from the mainline merge. The patch:
> > 
> > [POWERPC] Use archdata.dma_data in dma_direct_ops and add the offset
> > 
> > "Now that all platforms using dma_direct_offset setup the
> > archdata.dma_data correctly, ..."
> > 
> > Nope -- the pasemi iommu setup code that disables translation on the
> > DMA pci device didn't set dma_data correctly.
> > 
> > The below patch is needed, please merge as soon as practical. Thanks!
> 
> Sorry about that.
> 
> I'm confused though, didn't your device come from alloc_pci_dev() which
> kzalloc()s the pci_dev which contains the archdata which contains the
> dma_data, ie. dma_data will already be 0?

Yeah, I don't see how my patch could work (but it did), since the code
falls through and overwrites dma_data with the pointer to the table,
just as before. Weird, I did test it last night. See new patch.


-Olof
