Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADAEFDDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 09:56:25 +1000 (EST)
Date: Wed, 12 Sep 2007 03:56:02 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070912035602.0be0d47e@localhost.localdomain>
In-Reply-To: <200709120057.18873.arnd@arndb.de>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<200709120057.18873.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Sep 2007 00:57:17 +0200
Arnd Bergmann wrote:

> On Wednesday 12 September 2007, Vitaly Bordug wrote:
> > 
> > We are having 2 different instances of
> > pci_process_bridge_OF_ranges(), which makes describing 64-bit
> > physical addresses in non PPC64 case impossible.
> > 
> > This approach inherits pci space parsing, but has a new way to
> > behave equally good in both 32bit and 64bit environments. This
> > approach uses of_translate_address(), so implies proper ranges <>
> > definition in devicetree, where PCI node has its reg on soc bus,
> > and its ranges effectively belong to LAW addresses.
> > 
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> The patch looks really good, but it's hard to review when you move the
> code around at the same as you change it.
> 

Well, it's more a rewrite than a move, based on 64-bit implementation.

> Could you perhaps split the patch into two separate changesets, one
> that makes both functions identical in place, and one that merges
> them to live in a common location?
> 
I'm not sure I'm following what you are requesting. What is a benefit of code duplication? I was thinking about,
if it will look good enough, to provide this function at generic level but changing its name a little, while leaving old stuff in place, and encouraging people to use it in favour of 32 or 64-bit-specific approaches. That way we won't kill many boards at once(in case, for example,odd dts with missed ranges for pci subnode).
> > diff --git a/include/asm-powerpc/ppc-pci.h
> > b/include/asm-powerpc/ppc-pci.h index b847aa1..882b8bc 100644
> > --- a/include/asm-powerpc/ppc-pci.h
> > +++ b/include/asm-powerpc/ppc-pci.h
> > @@ -15,6 +15,13 @@
> >  #include <linux/pci.h>
> >  #include <asm/pci-bridge.h>
> >  
> > +struct ranges_pci {
> > +	unsigned int pci_space;
> > +	u64 pci_addr;
> > +	phys_addr_t phys_addr;
> > +	u64 size;
> > +} __attribute__((packed));
> > +
> 
> This structure definition uses unaligned members because of the
> 'packed' attribute. Is that really what you intended?
> 
yes, exactly, because I'm mapping this struct on ranges extracted from the dts instead of juggling with ranges[foo]
offsets.
> 	Arnd <><
Thanks for looking at it!

-- 
Sincerely, Vitaly
