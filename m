Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CBCFDDED9
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 10:49:13 +1000 (EST)
Subject: Re: [PATCH] ppc4xx_pci: necessary fixes for 4GB RAM size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080828092820.2cacaba7@zod.rchland.ibm.com>
References: <1219391015-6317-1-git-send-email-yanok@emcraft.com>
	<20080828092820.2cacaba7@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 10:19:00 +1000
Message-Id: <1220228340.13162.401.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 09:28 -0400, Josh Boyer wrote:
> On Fri, 22 Aug 2008 11:43:35 +0400
> Ilya Yanok <yanok@emcraft.com> wrote:
> 
> > 1. total_memory should be phys_addr_t not unsigned long
> > 2. is_power_of_2() works with u32 so I just inlined (size & (size-1)) != 0
> > instead.
> > Also this patch fixes default initialization: res->end should be 0x7fffffff
> > not 0x80000000.
> > 
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> 
> Ben, any comments here?  Looks right to me.

Just one minor comment... The patch should do what I failed to do
before, which is to move total_memory declaration to a header :-)

Cheers,
Ben.

> josh
> 
> > ---
> >  arch/powerpc/sysdev/ppc4xx_pci.c |   11 ++++++-----
> >  1 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> > index e1c7df9..645b2c9 100644
> > --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> > +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> > @@ -36,7 +36,7 @@
> >  static int dma_offset_set;
> > 
> >  /* Move that to a useable header */
> > -extern unsigned long total_memory;
> > +extern phys_addr_t total_memory;
> > 
> >  #define U64_TO_U32_LOW(val)	((u32)((val) & 0x00000000ffffffffULL))
> >  #define U64_TO_U32_HIGH(val)	((u32)((val) >> 32))
> > @@ -105,7 +105,8 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
> > 
> >  	/* Default */
> >  	res->start = 0;
> > -	res->end = size = 0x80000000;
> > +	size = 0x80000000;
> > +	res->end = size - 1;
> >  	res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
> > 
> >  	/* Get dma-ranges property */
> > @@ -167,13 +168,13 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
> >  	 */
> >  	if (size < total_memory) {
> >  		printk(KERN_ERR "%s: dma-ranges too small "
> > -		       "(size=%llx total_memory=%lx)\n",
> > -		       hose->dn->full_name, size, total_memory);
> > +		       "(size=%llx total_memory=%llx)\n",
> > +		       hose->dn->full_name, size, (u64)total_memory);
> >  		return -ENXIO;
> >  	}
> > 
> >  	/* Check we are a power of 2 size and that base is a multiple of size*/
> > -	if (!is_power_of_2(size) ||
> > +	if ((size & (size - 1)) != 0  ||
> >  	    (res->start & (size - 1)) != 0) {
> >  		printk(KERN_ERR "%s: dma-ranges unaligned\n",
> >  		       hose->dn->full_name);
