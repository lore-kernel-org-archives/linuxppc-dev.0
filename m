Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 578011A0337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 22:30:29 +1100 (AEDT)
Date: Wed, 17 Feb 2016 12:30:22 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v8 1/8] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160217113022.GA9578@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174435.06578692C8@newverein.lst.de>
 <1455706540.4450.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455706540.4450.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 09:55:40PM +1100, Michael Ellerman wrote:
> On Wed, 2016-02-10 at 17:21 +0100, Torsten Duwe wrote:
> 
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -476,17 +474,44 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
> >  	return (unsigned long)&stubs[i];
> >  }
> >  
> > +#ifdef CC_USING_MPROFILE_KERNEL
> > +static int is_early_mcount_callsite(u32 *instruction)
> > +{
> > +	/* -mprofile-kernel sequence starting with
> > +	 * mflr r0 and maybe std r0, LRSAVE(r1).
> > +	 */
> > +	if ((instruction[-3] == PPC_INST_MFLR &&
> > +	     instruction[-2] == PPC_INST_STD_LR) ||
> > +	    instruction[-2] == PPC_INST_MFLR) {
> > +		/* Nothing to be done here, it's an _mcount
> > +		 * call location and r2 will have to be
> > +		 * restored in the _mcount function.
> > +		 */
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> On a kernel built with the 2 instruction version this will fault when the
> function we're looking at is located at the beginning of a page. Because
> instruction[-3] goes off the front of the mapping.
> 
> We can probably fix that. But it's still a bit dicey.

Not necessarily. Now that it's a separate function, it can be nested a bit deeper,
so we don't take chances on compiler optimisation:

if (instruction[-2] == PPC_INST_STD_LR) /* where should R0 come from? there must be... */
  {
    if (instruction[-3] == PPC_INST_MFLR)
      return 1;
  }
else if (instruction[-2] == PPC_INST_MFLR)
    return 1;
return 0;

> I'm wondering if we want to just say we only support the 2 instruction version.
> Currently that means GCC 6 only, or a distro compiler with the backport of
> e95d0248dace. But we could also ask GCC to backport it to 4.9 and 5.
> 
> Thoughts?

IMHO that's a too weak reason for a too strong limitation. OTOH getting everyone
to use the 2 insn version sounds appealing...

Is e95d0248dace self-sufficient or does it depend on other improvements?

	Torsten
