Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 207911A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 16:32:48 +1100 (AEDT)
Message-ID: <1455600767.14533.5.camel@ellerman.id.au>
Subject: Re: [PATCH v4 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Date: Tue, 16 Feb 2016 16:32:47 +1100
In-Reply-To: <20160216110625.7b2e8134@camb691>
References: <1455512850-2543-1-git-send-email-cyrilbur@gmail.com>
 <1455512850-2543-2-git-send-email-cyrilbur@gmail.com>
 <20160215165916.GH2599@naverao1-tp.ibm.com>
 <20160216110625.7b2e8134@camb691>
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

On Tue, 2016-02-16 at 11:06 +1100, Cyril Bur wrote:
> On Mon, 15 Feb 2016 22:29:17 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2016/02/15 04:07PM, Cyril Bur wrote:
> > > Test that the non volatile floating point and Altivec registers get
> > > correctly preserved across the fork() syscall.
> > > 
> > > fork() works nicely for this purpose, the registers should be the same for
> > > both parent and child
> > > 
> > > diff --git a/tools/testing/selftests/powerpc/basic_asm.h b/tools/testing/selftests/powerpc/basic_asm.h
> > > new file mode 100644
> > > index 0000000..f243da0
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/powerpc/basic_asm.h
> > > @@ -0,0 +1,30 @@
> > > +#include <ppc-asm.h>
> > > +#include <asm/unistd.h>
> > > +
> > > +#define LOAD_REG_IMMEDIATE(reg,expr) \
> > > +	lis	reg,(expr)@highest;	\
> > > +	ori	reg,reg,(expr)@higher;	\
> > > +	rldicr	reg,reg,32,31;	\
> > > +	oris	reg,reg,(expr)@high;	\
> > > +	ori	reg,reg,(expr)@l;
> > > +
> > > +/* It is very important to note here that _extra is the extra amount of
> > > + * stack space needed.
> > > + * This space must be accessed at sp + 32!  
> > 
> 
> Hi Naveen,
> 
> Thanks for the review.

> > This looks to be specific to ABIv2. Is this series limited to ppc64le?  
> > If so, you might want to ensure this only builds there.
> > 
> 
> Is ABIv1 still in use? Can we still compile for v1? 

YES! >:E

> This is for series 64bit only, I've not really got any reason to believe this
> is LE only, shouldn't this work BE? The makefile enforces 64bit, I believe it is
> ok for kernel selftests to fail to compile if they aren't going to be able to
> run.

> > Also:
> > #define PPC_ABIV2_MIN_STACK_SIZE 32
> > 
> > or just:
> > #define PPC_MIN_STACK	32
> > 
> > ... is helpful. And, you might want to base the rest of your code that 
> > use PUSH_BASIC_STACK() on that. If we ever want to have these tests run 
> > anywhere else, that'll help a lot. (See further below)
> > 
> 
> So I thought about it. I agree that it would be nice, I just worry that I might
> get rabbitholed, I can see it going further and then providing stack accessors
> to abstract out even PPC_MIN_STACK except in a bunch of macros, and that's when
> I know I've gone too far.
> 
> Perhaps I could look at adding this when I write more tests, I have grand plans
> to push way more tests.

You definitely need a #define for the minimum stack frame size, based on the
ABI version. You can basically do what the kernel does for STACK_FRAME_MIN_SIZE.

You also need to cope with the TOC save slot moving between ABIv1 & 2, which
shouldn't be hard with a macro for it.

> > > + */
> > > +#define PUSH_BASIC_STACK(_extra) \
> > > +	mflr	r0; \
> > > +	std	r0,16(sp); \
> > > +	stdu	sp,-(_extra + 32)(sp); \
> > > +	mfcr	r0; \
> > > +	stw	r0,8(sp); \
> > > +	std	2,24(sp);  
> > 		^^
> > Better to use r2 here and below.
> > 
> 
> I think the reason I used '2' is that 'r2' isn't actually defined in ppc-asm.h
> for userspace, due to conventions, like 'sp', 'toc' has been used. So I could
> have used 'toc' but then there was an issue with toc NOT being defined, or
> getting undefined in some situations.

That's true, ppc-asm.h doesn't define r2, instead it defines toc.

But you can always use %r2, which is preferable to 2 IMHO.

Personally I'd rather you use %r1 than sp, but I won't make you. As someone who
has read lots of powerpc assembler %r1 translates as "stack pointer" where as
"sp" translates as "huh?".

> > > +FUNC_START(test_fpu)
> > > +	#r3 holds pointer to where to put the result of fork
> > > +	#r4 holds pointer to the pid
> > > +	#f14-f31 are non volatiles
> > > +	PUSH_BASIC_STACK(256)
> > > +	std	r3,40(sp) #Address of darray  
> > 
> > So, this could be:
> > 	PUSH_BASIC_STACK(256)
> > 	std	r3,PPC_MIN_STACK+8(sp)
> > 
> > ... though I wonder why there is +8 here?
> 
> I think the +8 is left over from my using +0 for something else and then not
> and not going back and being all neat about stack usage. Admittedly I didn't
> look over that too hard it being a selftest and all, I'm not sure optimal
> stack usage is super important here.

The first free slot is at PPC_MIN_STACK(%r1), so that's what you should use.

cheers
