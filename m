Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6B721A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 16:39:21 +1000 (AEST)
Received: from navarro.puc.rediris.es (navarro.puc.rediris.es
 [IPv6:2001:720:418:ca01::131])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E92F514029D
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 16:39:20 +1000 (AEST)
Date: Wed, 22 Jul 2015 07:57:40 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [RFC 5/8] powerpc/slb: Add documentation to runtime patching of
 SLB encoding
Message-ID: <20150722055740.GA20532@visitor2.iram.es>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1437461926-8908-5-git-send-email-khandual@linux.vnet.ibm.com>
 <1437544263.16792.12.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437544263.16792.12.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 22, 2015 at 03:51:03PM +1000, Michael Ellerman wrote:
> On Tue, 2015-07-21 at 12:28 +0530, Anshuman Khandual wrote:
> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> > 
> > This patch adds some documentation to 'patch_slb_encoding' function
> > explaining about how it clears the existing immediate value in the
> > given instruction and inserts a new one there.
> > 
> > diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> > index dcba4c2..8083a9e 100644
> > --- a/arch/powerpc/mm/slb.c
> > +++ b/arch/powerpc/mm/slb.c
> > @@ -278,7 +278,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
> >  static inline void patch_slb_encoding(unsigned int *insn_addr,
> >  				      unsigned int immed)
> >  {
> > -	int insn = (*insn_addr & 0xffff0000) | immed;
> > +	/*
> > +	 * Currently this patches only "li" and "cmpldi"
> > +	 * instructions with an immediate value. Here it
> > +	 * just clears the existing immediate value from
> > +	 * the instruction and inserts a new one there.
> > +	 */
> > +	unsigned int insn = (*insn_addr & 0xffff0000) | immed;
> >  	patch_instruction(insn_addr, insn);
> >  }
> 
> 
> How about:
> 
> 	/*
> 	 * This function patches either an li or a cmpldi instruction with
> 	 * a new immediate value. This relies on the fact that both li
> 	 * (which is actually ori) and cmpldi both take a 16-bit immediate

Hmm, li is actually encoded as addi with r0 as source register...

> 	 * value, and it is situated in the same location in the instruction,
> 	 * ie. bits 0-15.

In PPC documentation, it's rather bits 16-31 (big endian bit order).
Or say lower half which is endian agnostic.

    Cheers,
    Gabriel
