Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFFA11A1799
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2015 12:30:02 +1000 (AEST)
Message-ID: <1439087389.3715.55.camel@kernel.crashing.org>
Subject: Re: powerpc: Add an inline function to update HID0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Date: Sun, 09 Aug 2015 12:29:49 +1000
In-Reply-To: <20150804100858.1F272140306@ozlabs.org>
References: <20150804100858.1F272140306@ozlabs.org>
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

On Tue, 2015-08-04 at 20:08 +1000, Michael Ellerman wrote:
> On Tue, 2015-04-08 at 08:30:58 UTC, "Gautham R. Shenoy" wrote:
> > Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> > prescribes that updates to HID0 be preceded by a SYNC instruction and
> > followed by an ISYNC instruction (Page 91).
> > 
> > Create a function name update_hid0() which follows this recipe and
> > invoke it from the static split core path.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++
> 
> Why is it in there? It's not KVM related per se.
> 
> Where should it go? I think reg.h would be best, ideally near the definition
> for HID0, though that's probably not possible because of ASSEMBLY requirements.
> So at the bottom of reg.h ?
> 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index c6ef05b..325f1d6 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -685,4 +685,15 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
> >  
> >  extern void xics_wake_cpu(int cpu);
> >  
> > +static inline void update_hid0(unsigned long hid0)
> > +{
> > +	/*
> > +	 *  The HID0 update should at the very least be preceded by a
> > +	 *  a SYNC instruction followed by an ISYNC instruction
> > +	 */
> > +	mb();
> > +	mtspr(SPRN_HID0, hid0);
> > +	isync();
> 
> That's going to turn into three separate inline asm blocks, which is maybe a
> bit unfortunate. Have you checked the generated code is what we want, ie. just
> sync, mtspr, isync ?

It depends on the processor, I'd rather we make this out of line in
misc.S or similar and use the appropriate CPU table bits and pieces.

Some older CPUs require whacking it N times for example.

Cheers,
Ben.

> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
