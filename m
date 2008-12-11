Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FC21DE007
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:47:50 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBB0lNAl031128
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:47:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBB0lkWW178858
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:47:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBB1luHB021942
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 20:47:56 -0500
Date: Wed, 10 Dec 2008 19:47:38 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Introduce ppc_pci_flags accessors
Message-ID: <20081210194738.0c339a97@zod.rchland.ibm.com>
In-Reply-To: <1228953845.7999.5.camel@localhost>
References: <20081210191148.GA1769@yoda.jdub.homelinux.org>
	<1228952788.7999.0.camel@localhost>
	<20081210185446.13e33cb2@zod.rchland.ibm.com>
	<1228953845.7999.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 11:04:05 +1100
Michael Ellerman <michael@ellerman.id.au> wrote:

> On Wed, 2008-12-10 at 18:54 -0500, Josh Boyer wrote:
> > On Thu, 11 Dec 2008 10:46:28 +1100
> > Michael Ellerman <michael@ellerman.id.au> wrote:
> > 
> > > On Wed, 2008-12-10 at 14:11 -0500, Josh Boyer wrote:
> > > > Currently there are a number of platforms that open code access to
> > > > the ppc_pci_flags global variable.  However, that variable is not
> > > > present if CONFIG_PCI is not set, which can lead to a build break.
> > > > 
> > > > This introduces a number of accessor functions that are defined
> > > > to be empty in the case of CONFIG_PCI being disabled.  The
> > > > various platform files in the kernel are updated to use these.
> > > > 
> > > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > > 
> > > > ---
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> > > > index fa8b3b7..8f2c7ca 100644
> > > > --- a/arch/powerpc/include/asm/pci-bridge.h
> > > > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > > > @@ -13,7 +13,6 @@
> > > >  
> > > >  struct device_node;
> > > >  
> > > > -extern unsigned int ppc_pci_flags;
> > > >  enum {
> > > >  	/* Force re-assigning all resources (ignore firmware
> > > >  	 * setup completely)
> > > > @@ -36,6 +35,16 @@ enum {
> > > >  	/* ... except for domain 0 */
> > > >  	PPC_PCI_COMPAT_DOMAIN_0		= 0x00000020,
> > > >  };
> > > > +#ifdef CONFIG_PCI
> > > > +extern unsigned int ppc_pci_flags;
> > > > +#define ppc_pci_set_flags(flags) ppc_pci_flags = (flags)
> > > > +#define ppc_pci_add_flags(flags) ppc_pci_flags |= (flags)
> > > > +#define ppc_pci_flag_is_set(flag) (ppc_pci_flags & (flag))
> > > > +#else
> > > > +#define ppc_pci_set_flags(flags) do {} while (0)
> > > > +#define ppc_pci_add_flags(flags) do {} while (0)
> > > > +#define ppc_pci_flag_is_set(flag) (0)
> > > > +#endif
> > > 
> > > I hate to be picky, but I don't see any reason why these shouldn't be
> > > static inlines.
> > 
> > There's a perfectly good reason.  I AM LAZY.
> 
> Fair enough, I'll do the typing for you :)

Catering to my laziness... not sure if that is good or bad :).

> #ifdef CONFIG_PCI
> extern unsigned int ppc_pci_flags;
> 
> static inline void ppc_pci_set_flags(int flags)
> {
> 	ppc_pci_flags = flags;
> }
> 
> static inline void ppc_pci_add_flags(int flags)
> {
> 	ppc_pci_flags |= flags;
> }
> 
> static inline int ppc_pci_flag_is_set(int flag)
> {
> 	return (ppc_pci_flags & flag);
> }
> #else
> static inline void ppc_pci_set_flags(int flags) { }
> static inline void ppc_pci_add_flags(int flags) { }
> static inline int ppc_pci_flag_is_set(int flag)
> {
> 	return 0;
> }
> #endif
> 
> 
> One other thought, should the check routine be
> ppc_pci_flags_are_set(flags)? 

Likely, yes.  I can change that and I'll respin.

josh
