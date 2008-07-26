Return-Path: <hugh@veritas.com>
Date: Sat, 26 Jul 2008 12:02:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
In-Reply-To: <1217022373.11188.115.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0807261122430.20543@blonde.site>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
	<Pine.LNX.4.64.0807251839190.20617@blonde.site>
	<1217022373.11188.115.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 Jul 2008, Benjamin Herrenschmidt wrote:
> On Fri, 2008-07-25 at 19:45 +0100, Hugh Dickins wrote:
> > 
> > I've Cc'ed Ben and linuxppc-dev because I wonder if they're aware
> > that several options (I got it from LATENCYTOP, but I think LOCKDEP
> > and FTRACE and some others) are doing a "select FRAME_POINTER",
> > which forces CONFIG_FRAME_POINTER=y on PowerPC, even though
> > FRAME_POINTER is not an option offered on PowerPC.  The
> > resulting kernels appear to run okay, but I was surprised.
> 
> Because the option just does nothing for us ? :-) We always have frame
> pointers on powerpc except in some case for leaf functions. I don't know
> if the option has any actual effect on the later, but I don't think we
> have a case where doing either way would break things.

Thanks, that's reassuring.

I raised the question partly because I'd noticed CONFIG_FRAME_POINTER=y
does increase the size of powerpc kernels: part of that will have been
because of the -fno-optimize-sibling-calls bundled in, but when I edit
that out of the Makefile I'm left with

   text	   data	    bss	    dec	    hex	filename
4773061	 856632	 232052	5861745	 597171	FPN/vmlinux
4943653	 856632	 232052	6032337	 5c0bd1	FPY/vmlinux

Going to the first divergence between them,
the 2.6.26-git6 vmlinux built without CONFIG_FRAME_POINTER has

c000000000008024 <.run_init_process>:
c000000000008024:	7c 08 02 a6 	mflr    r0
c000000000008028:	fb c1 ff f0 	std     r30,-16(r1)
c00000000000802c:	eb c2 80 48 	ld      r30,-32696(r2)
c000000000008030:	f8 01 00 10 	std     r0,16(r1)
c000000000008034:	f8 21 ff 81 	stdu    r1,-128(r1)
c000000000008038:	e9 3e 80 10 	ld      r9,-32752(r30)
c00000000000803c:	f8 69 00 00 	std     r3,0(r9)
c000000000008040:	7d 24 4b 78 	mr      r4,r9
c000000000008044:	38 a9 01 10 	addi    r5,r9,272
c000000000008048:	48 01 70 4d 	bl      c00000000001f094
                                                <.kernel_execve>
c00000000000804c:	60 00 00 00 	nop
c000000000008050:	38 21 00 80 	addi    r1,r1,128
c000000000008054:	e8 01 00 10 	ld      r0,16(r1)
c000000000008058:	eb c1 ff f0 	ld      r30,-16(r1)
c00000000000805c:	7c 08 03 a6 	mtlr    r0
c000000000008060:	4e 80 00 20 	blr

Whereas the vmlinux built with -fno-omit-frame_pointer has

c000000000008024 <.run_init_process>:
c000000000008024:	7c 08 02 a6 	mflr    r0
c000000000008028:	fb c1 ff f0 	std     r30,-16(r1)
c00000000000802c:	eb c2 80 48 	ld      r30,-32696(r2)
c000000000008030:	fb e1 ff f8 	std     r31,-8(r1)
c000000000008034:	f8 01 00 10 	std     r0,16(r1)
c000000000008038:	f8 21 ff 81 	stdu    r1,-128(r1)
c00000000000803c:	e9 3e 80 10 	ld      r9,-32752(r30)
c000000000008040:	f8 69 00 00 	std     r3,0(r9)
c000000000008044:	7d 24 4b 78 	mr      r4,r9
c000000000008048:	38 a9 01 10 	addi    r5,r9,272
c00000000000804c:	7c 3f 0b 78 	mr      r31,r1
c000000000008050:	48 01 8c 91 	bl      c000000000020ce0
                                                <.kernel_execve>
c000000000008054:	60 00 00 00 	nop
c000000000008058:	e8 21 00 00 	ld      r1,0(r1)
c00000000000805c:	e8 01 00 10 	ld      r0,16(r1)
c000000000008060:	eb c1 ff f0 	ld      r30,-16(r1)
c000000000008064:	eb e1 ff f8 	ld      r31,-8(r1)
c000000000008068:	7c 08 03 a6 	mtlr    r0
c00000000000806c:	4e 80 00 20 	blr

That's for

static void run_init_process(char *init_filename)
{
	argv_init[0] = init_filename;
	kernel_execve(init_filename, argv_init, envp_init);
}

Hmm, perhaps it is doing sibling calls differently even without the
explicit -fno-optimize-sibling-calls (but when I add that option,
the vmlinux size does go up another 4400).

Sorry, I'm most probably fussing over nothing,
and wasting your time with my ignorance.

Hugh
