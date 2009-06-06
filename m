Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 000A0B70A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 14:17:16 +1000 (EST)
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090605.175656.95336229.davem@davemloft.net>
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<1244244749.31984.16.camel@pasglop>
	<20090605.175656.95336229.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 06 Jun 2009 14:16:46 +1000
Message-Id: <1244261806.31984.36.camel@pasglop>
Mime-Version: 1.0
Cc: sachinp@linux.vnet.ibm.com, sfr@canb.auug.org.au, greg@kroah.com,
	linux-kernel@vger.kernel.org, Linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, paulus@samba.org,
	Geert.Uytterhoeven@sonycom.com, geert@linux-m68k.org,
	subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-05 at 17:56 -0700, David Miller wrote:
> > 
> > Read my reply to Greg. Why the heck are you trying to map memory
> > non-cacheable in the first place ?
> 
> I agree, this is extremely fishy.
> 
> I guess the issue is that the driver wants consistent DMA memory
> but wants to allocate a huge area vmap() style.

That's my guess too, and I suppose we should be able to provide an
appropriate interface for that... There are two aspects that
are completely separate here:

 - One is the allocation of the pages themselves which much match
the various criteria for DMA'bility to the target device (fit the
DMA mask, etc...)

 - One is the creation of the virtual mapping in kernel space for which
appropriate pgprot for DMA must be provided.

For the first one, I don't know how legit it would be to allocate the
pages using dma_alloc_coherent one page at a time and try to figure out
the struct page * out of it. Sounds fishy and possibly non-portable. So
appart from using normal GFP and crossing fingers I'm not sure what
would be the right way to obtain the pages in the first place. Maybe we
should provide something.

The second could be as simple as having a pgprot_dma_coherent() like we
have a pgprot_uncached() for example, which would be either uncached or
cached depending on the consistency of DMA on the platform. But we need
to run that through things like MIPS which may have additional virtual
address space requirements.

Cheers,
Ben.
