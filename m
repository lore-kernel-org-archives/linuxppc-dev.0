Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svF5K67P9zDsrf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:27:01 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3svF5K0tNwz9s3T
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 00:27:00 +1100 (AEDT)
Date: Wed, 12 Oct 2016 08:26:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, markus@trippelsdorf.de, amodra@gmail.com
Subject: Re: [PATCH] powerpc: cmp -> cmpd for 64-bit
Message-ID: <20161012132647.GA4446@gate.crashing.org>
References: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
 <877f9e5ksw.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877f9e5ksw.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2016 at 02:05:19PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> 
> > PowerPC's "cmp" instruction has four operands.  Normally people write
> > "cmpw" or "cmpd" for the second cmp operand 0 or 1.  But, frequently
> > people forget, and write "cmp" with just three operands.
> >
> > With older binutils this is silently accepted as if this was "cmpw",
> > while often "cmpd" is wanted.  With newer binutils GAS will complain
> > about this for 64-bit code.  For 32-bit code it still silently assumes
> > "cmpw" is what is meant.
> 
> Thanks.
> 
> Anton already sent a fix for the two vdso ones, which were real bugs,
> and that's now in Linus' tree.

Ah cool.  You'll just need the one then (and many more for book4e, but
I cannot really handle that, other people can do that a lot better).


> > --- a/arch/powerpc/include/asm/cpuidle.h
> > +++ b/arch/powerpc/include/asm/cpuidle.h
> > @@ -26,7 +26,7 @@ extern u64 pnv_first_deep_stop_state;
> 
> #define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
> 	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
> >  	std	r0,0(r1);					\
> >  	ptesync;						\
> >  	ld	r0,0(r1);					\
> > -1:	cmp	cr0,r0,r0;					\
> > +1:	cmpd	cr0,r0,r0;					\
> >  	bne	1b;						\
> >  	IDLE_INST;						\
> >  	b	.
> 
> What's this one doing, is it a bug? I can't really tell without knowing
> what the magic sequence is meant to do.

It looks like it is making sure the ptesync is done.  The ld/cmp/bne
is the usual to make sure the ld is done, and in std/ptesync/ld the ld
won't be done before the ptesync is done.

The cmp always compares equal, of course, so both cmpw and cmpd would
work fine here.  cmpd looks better after ld ;-)


Segher
