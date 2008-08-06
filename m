Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18586.13766.755344.181525@cargo.ozlabs.ibm.com>
Date: Thu, 7 Aug 2008 09:37:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH] Link the bootwrapper as a position-independent
	executable
In-Reply-To: <A1BAD7C8-8459-4D6E-80BA-639D305611DD@kernel.crashing.org>
References: <18585.14669.954874.540716@drongo.ozlabs.ibm.com>
	<A1BAD7C8-8459-4D6E-80BA-639D305611DD@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Hurray!  Looks good, just a few nits...

Thanks for reviewing.

> > +	bl	.+4
> > +p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
> 
> bl p_base  instead?

I went back and forth on that.  I ended up with it that way to
emphasize that the bl does need to branch to the *next* instruction
for the idiom to work.

> > +10:	or.	r8,r0,r9	/* skip relocation if we don't have both */
> >  	beq	3f
> 
> Either the code or the comment is wrong -- the code says "skip  
> relocation
> if we don't have either".

Ah, operator precedence rules in English. :)  I (and I think most
native English speakers) would parse my comment as "don't (have both)"
whereas I think you parsed it as "(don't have) both".  Similarly what
you say the code says parses as "don't (have either)" for me rather
than "(don't have) either".   IOW, "don't have either" means "both are
missing".

Anyway I can change the comment to say "we need both to do
relocation".  OK?

> > +	cmpwi	r0,22		/* R_PPC_RELATIVE */
> > +	bne	3f
> 
> It would be nice if there was some way to complain (at build time?)
> if there are unhandled relocations present.  Prevents a lot of headaches
> when things go wrong (and they will ;-) )

Yes, that would be a good idea.  There is one extra relocation when I
build for pSeries, which was for _platform_stack_top (which is
undefined), which we're OK ignoring.

> >  4:	dcbf	r0,r9
> >  	icbi	r0,r9
> 
> Fix these while you're at it?  It's not r0, it's 0.

Yeah.

> > +  .dynsym : { *(.dynsym) }
> > +  .dynstr : { *(.dynstr) }
> > +  .dynamic :
> > +  {
> > +    __dynamic_start = .;
> > +    *(.dynamic)
> > +  }
> > +  .hash : { *(.hash) }
> > +  .interp : { *(.interp) }
> > +  .rela.dyn : { *(.rela*) }
> 
> Do some of these sections need alignment?

I suppose they should ideally be 4-byte aligned.  We don't actually
use .dynsym, .dynstr, .hash or .interp, but I couldn't find any way to
make the linker omit them.

Paul.
