Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpDbF4zz2zDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 16:47:53 +1000 (AEST)
Date: Thu, 15 Jun 2017 16:47:29 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Fix emulation of mcrf in emulate_step()
Message-ID: <20170615164729.09f0f83a@kryten>
In-Reply-To: <20170615041805.GB16550@gate.crashing.org>
References: <20170614234639.11997-1-anton@ozlabs.org>
 <20170615041805.GB16550@gate.crashing.org>
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

Hi Segher,

> On Thu, Jun 15, 2017 at 09:46:38AM +1000, Anton Blanchard wrote:
> > The mcrf emulation code was looking at the CR fields in the reverse
> > order. It also relied on reserved fields being zero which is
> > somewhat fragile, so fix that too.  
> 
> It masked out the reserved bits.  I find the new code to be less
> readable (but also more correct ;-) ). 

Thanks for that, not sure how I missed it :) I'll respin a simpler
patch.

> Maybe there should be (inline)
> helper function to insert/extract CR fields?

That would be nice, there are quite a few places that could use it.

Anton

> Segher
> 
> 
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -683,8 +683,10 @@ int analyse_instr(struct instruction_op *op,
> > struct pt_regs *regs, case 19:
> >  		switch ((instr >> 1) & 0x3ff) {
> >  		case 0:		/* mcrf */
> > -			rd = (instr >> 21) & 0x1c;
> > -			ra = (instr >> 16) & 0x1c;
> > +			rd = 7 - ((instr >> 23) & 0x7);
> > +			ra = 7 - ((instr >> 18) & 0x7);
> > +			rd *= 4;
> > +			ra *= 4;
> >  			val = (regs->ccr >> ra) & 0xf;
> >  			regs->ccr = (regs->ccr & ~(0xfUL << rd)) |
> > (val << rd); goto instr_done;  
> 
