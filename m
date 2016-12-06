Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXvxP0pgSzDvhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 19:31:53 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so19192727pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 00:31:53 -0800 (PST)
Date: Tue, 6 Dec 2016 18:31:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] KVM: PPC: Book3S: Change interrupt call to reduce
 scratch space use on HV
Message-ID: <20161206183133.384feba6@roar.ozlabs.ibm.com>
In-Reply-To: <20161206060907.GA25458@fergus.ozlabs.ibm.com>
References: <20161201071812.23258-1-npiggin@gmail.com>
 <20161201071812.23258-2-npiggin@gmail.com>
 <20161206060907.GA25458@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Dec 2016 17:09:07 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Thu, Dec 01, 2016 at 06:18:10PM +1100, Nicholas Piggin wrote:
> > Change the calling convention to put the trap number together with
> > CR in two halves of r12, which frees up HSTATE_SCRATCH2 in the HV
> > handler, and r9 free.  
> 
> Cute idea!  Some comments below...
> 
> > The 64-bit PR handler entry translates the calling convention back
> > to match the previous call convention (i.e., shared with 32-bit), for
> > simplicity.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/exception-64s.h | 28 +++++++++++++++-------------
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 15 +++++++--------
> >  arch/powerpc/kvm/book3s_segment.S        | 27 ++++++++++++++++++++-------
> >  3 files changed, 42 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> > index 9a3eee6..bc8fc45 100644
> > --- a/arch/powerpc/include/asm/exception-64s.h
> > +++ b/arch/powerpc/include/asm/exception-64s.h
> > @@ -233,7 +233,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
> >  
> >  #endif
> >  
> > -#define __KVM_HANDLER_PROLOG(area, n)					\
> > +#define __KVM_HANDLER(area, h, n)					\
> >  	BEGIN_FTR_SECTION_NESTED(947)					\
> >  	ld	r10,area+EX_CFAR(r13);					\
> >  	std	r10,HSTATE_CFAR(r13);					\
> > @@ -243,30 +243,32 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
> >  	std	r10,HSTATE_PPR(r13);					\
> >  	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
> >  	ld	r10,area+EX_R10(r13);					\
> > -	stw	r9,HSTATE_SCRATCH1(r13);				\
> > -	ld	r9,area+EX_R9(r13);					\
> >  	std	r12,HSTATE_SCRATCH0(r13);				\
> > -
> > -#define __KVM_HANDLER(area, h, n)					\
> > -	__KVM_HANDLER_PROLOG(area, n)					\
> > -	li	r12,n;							\
> > +	li	r12,(n);						\
> > +	sldi	r12,r12,32;						\
> > +	or	r12,r12,r9;						\  
> 
> Did you consider doing it the other way around, i.e. with r12
> containing (cr << 32) | trap?  That would save 1 instruction in each
> handler:

When I tinkered with it I thought it came out slightly nicer this way, but
your suggested versions seem to prove me wrong. I can change it if you'd
like.

> 
> +	sldi	r12,r9,32;						\
> +	ori	r12,r12,(n);						\
> 
> > +	ld	r9,area+EX_R9(r13);					\
> > +	std	r9,HSTATE_SCRATCH1(r13);				\  
> 
> Why not put this std in kvmppc_interrupt[_hv] rather than in each
> handler?

Patch 3/3 uses r9 to load the ctr when CONFIG_RELOCATABLE is turned on, so
this resulted in the smaller difference between the two cases. I agree it's
not ideal when config relocatable is off.

[snip]

Thanks,
Nick
