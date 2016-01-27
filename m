Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73E0D1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 21:44:04 +1100 (AEDT)
Date: Wed, 27 Jan 2016 11:44:00 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 amodra@gmail.com, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160127104400.GA32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <1453889967.10839.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453889967.10839.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2016 at 09:19:27PM +1100, Michael Ellerman wrote:
> Hi Torsten,
> 
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -1206,7 +1206,12 @@ _GLOBAL(enter_prom)
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  _GLOBAL(mcount)
> >  _GLOBAL(_mcount)
> > -	blr
> > +	std	r0,LRSAVE(r1) /* gcc6 does this _after_ this call _only_ */
> > +	mflr	r0
> > +	mtctr	r0
> > +	ld	r0,LRSAVE(r1)
> > +	mtlr	r0
> > +	bctr
> 
> Can we use r11 instead? eg:
> 
> _GLOBAL(_mcount)
> 	mflr	r11
> 	mtctr	r11
> 	mtlr	r0
> 	bctr
> 
> Otherwise I worry the std/ld is going to cause a load-hit-store. And it's just
> plain more instructions too.
> 
> I don't quite grok the gcc code enough to tell if that's always safe, GCC does
> use r11 sometimes, but I don't think it ever expects it to survive across
> _mcount()?

I used r11 in that area once, and it crashed, but I don't recall the deatils.
We'll see. The performance shouldn't be critical, as the code is only used
during boot-up. With DYNAMIC_FTRACE, The calls will be replaced by
0x600000^W PPC_INST_NOP :)

> >  
> >  	bl	prepare_ftrace_return
> >  	nop
> 
> AFAICS these end up being the only instructions shared between the two
> versions. Which I don't think is worth the semantic burden of all the #ifdefs.
> So please just write it as two separate functions, one for
> CC_USING_MPROFILE_KERNEL and one for not.
> 
> > index 44d4d8e..080c525 100644
> > --- a/arch/powerpc/kernel/ftrace.c
> > +++ b/arch/powerpc/kernel/ftrace.c
> > @@ -306,11 +306,19 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >  	 * The load offset is different depending on the ABI. For simplicity
> >  	 * just mask it out when doing the compare.
> >  	 */
> > +#ifndef CC_USING_MPROFILE_KERNEL
> >  	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
> > -		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
> > +		pr_err("Unexpected call sequence at %p: %x %x\n",
> > +		ip, op[0], op[1]);
> >  		return -EINVAL;
> >  	}
> > -
> > +#else
> > +	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
> > +	if (op[0] != 0x60000000) {
> 
> That is "PPC_INST_NOP".
> 
> > +		pr_err("Unexpected call at %p: %x\n", ip, op[0]);
> > +		return -EINVAL;
> > +	}
> > +#endif
> 
> Can you please break that out into a static inline, with separate versions for
> the two cases.
> 
> We should aim for no #ifdefs inside functions.

Points taken.

Does this set _work_ for you now? That'd be great to hear.

Stay tuned for v7...

	Torsten
