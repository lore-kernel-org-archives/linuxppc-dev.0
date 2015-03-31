Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED0A91A0467
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 15:23:12 +1100 (AEDT)
Message-ID: <1427775792.1072.1.camel@ellerman.id.au>
Subject: Re: [PATCH 02/27] powerpc/powermac: move pmac_pci_probe_mode from
 setup.c to pci.c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 31 Mar 2015 15:23:12 +1100
In-Reply-To: <1427751988.20500.101.camel@kernel.crashing.org>
References: <20150330123214.9EE4014009B@ozlabs.org>
 <1427751988.20500.101.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 08:46 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-03-30 at 23:32 +1100, Michael Ellerman wrote:
> > On Wed, 2015-25-03 at 05:35:36 UTC, Daniel Axtens wrote:
> > 
> > Why did we move it? Just for cleanliness?
> > 
> > > diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
> > > index 8327cce..46d2193 100644
> > > --- a/arch/powerpc/platforms/powermac/pmac.h
> > > +++ b/arch/powerpc/platforms/powermac/pmac.h
> > > @@ -39,4 +39,8 @@ extern void low_cpu_die(void) __attribute__((noreturn));
> > >  extern int pmac_nvram_init(void);
> > >  extern void pmac_pic_init(void);
> > >  
> > > +#ifdef CONFIG_PPC64
> > > +extern int pmac_pci_probe_mode(struct pci_bus *bus);
> > > +#endif
> > 
> > You don't need to ifdef declarations, and you don't need extern.
> 
> I like extern :-) If the rest of the file use it, I prefer if he
> continues doing so.

I like Ponies.

It's fashionable to not use it, and I expect we'll start seeing treewide
extern-removal series soon enough, but whatever.

cheers
