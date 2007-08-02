Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B47ADDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 10:05:53 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1491.1186011132@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186007636.5495.536.camel@localhost.localdomain>
	<1491.1186011132@neuling.org>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 10:05:35 +1000
Message-Id: <1186013135.5495.540.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 09:32 +1000, Michael Neuling wrote:
> > On Wed, 2007-08-01 at 16:02 +1000, Michael Neuling wrote:
> > > We sometimes change the vmalloc segment in slb_flush_and_rebolt but we
> > > never updated with slb shadow buffer.  This fixes it.  Thanks to paulus
> > > for finding this.
> > > 
> > > Also added some write barriers to ensure the shadow buffer is always
> > > valid.
> > 
> > The shadow is global or per-cpu ?
> > 
> > Because in the later case, I think you need more than that.
> 
> It's per CPU.
> 
> > > @@ -759,6 +762,9 @@ int hash_page(unsigned long ea, unsigned
> > >  		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
> > >  		get_paca()->vmalloc_sllp =
> > >  			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> > > +		vflags = SLB_VSID_KERNEL |
> > > +			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> > > +		slb_shadow_update(VMALLOC_START, vflags, 1);
> > >  		slb_flush_and_rebolt();
> > >  	}
> > 
> > Later on:
> > 
> >         } else if (get_paca()->vmalloc_sllp !=
> >                    mmu_psize_defs[mmu_vmalloc_psize].sllp) {
> >                 get_paca()->vmalloc_sllp =
> >                         mmu_psize_defs[mmu_vmalloc_psize].sllp;
> >                 slb_flush_and_rebolt();
> >         }
> > 
> > If your shadow is per-cpu, you need to fix that up too.
> 
> I'm confused... isn't that the same section of code?

The first block of code detects the need for a demotion and changes the
global mmu_vmalloc_psize, along with changing the value on the local CPU
(and flushing it's SLB). But other CPUs still have the old values.

The second block of code checks if the global value matches the per-CPU
value and if not, proceeds to a local SLB flush. That's how the "other"
CPUs get the new value.

If your shadow is per-CPU, it thus needs to be updated in both cases.

Ben.


Ben.
