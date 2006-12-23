Return-Path: <amodra@bigpond.net.au>
Received: from omta05ps.mx.bigpond.com (omta05ps.mx.bigpond.com
	[144.140.83.195]) by ozlabs.org (Postfix) with ESMTP id B0B28DDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Dec 2006 17:28:33 +1100 (EST)
Date: Sat, 23 Dec 2006 16:58:31 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061223062831.GA26406@bubble.grove.modra.org>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta>
	<20061220211931.GB16860@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061220211931.GB16860@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 20, 2006 at 03:19:31PM -0600, Linas Vepstas wrote:
> On Tue, Dec 19, 2006 at 07:46:50PM -0600, Peter Bergner wrote:
> > On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> > > Per xchat, here's the update. I'm guessing I'm using a broken
> > > compiler, as per chain of evidence below ...
> > [snip]
> > > However, I also note that the following scrolled by:
> > > init/main.c:81:2: warning: #warning gcc-4.1.0 is known to miscompile the
> > > kernel. A different compiler version is recommended.
> > 
> > It may be due to this GCC bug which Olaf ran into a while back:
> > 
> >   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=24644
> > 
> > You can verify whether you have a broken compiler by compiling
> > the minimal test case I posted in comment #15.  If you see r13
> > being copied into another register and then used, then you have
> > a broken compiler.
> 
> No, that's not it. I'd be surprised, as I was using the SuSE
> SLES10 gcc-4.1.0-28.4.ppc.rpm compiler, which would have that fix.

Hmm, this looks like at problem Paul forwarded on to me, originally
reported by Hugh Dickins <hugh@veritas.com>.  In his email, Hugh said:

> I spent too long looking in the wrong direction (head_64.S and entry_64.S),
> then noticed this in generic_file_aio_read from "objdump -rd mm/filemap.o":
>     3b54:	7d a5 6b 78 	mr      r5,r13
>     3b58:	38 c0 00 00 	li      r6,0
>     3b5c:	7c 09 03 a6 	mtctr   r0
>     3b60:	38 e0 00 00 	li      r7,0
>     3b64:	39 00 00 00 	li      r8,0
>     3b68:	eb a3 00 20 	ld      r29,32(r3)
>     3b6c:	48 00 00 48 	b       3bb4 <.generic_file_aio_read+0xa4>
>     3b70:	e9 49 00 08 	ld      r10,8(r9)
>     3b74:	7c e7 52 14 	add     r7,r7,r10
>     3b78:	7c e9 53 79 	or.     r9,r7,r10
>     3b7c:	41 c0 01 88 	blt-    3d04 <.generic_file_aio_read+0x1f4>
>     3b80:	e9 25 01 a0 	ld      r9,416(r5)
> 
> So, if the task is preempted and rescheduled on a different cpu in between
> the first and the last line, r5 will be looking at a different paca_struct
> from the one we're now on, and pick up the wrong __current.  (Well, there's
> a branch in the middle there, which then branches back: so the flow isn't
> quite as I've shown, but the effect is the same.)
> 
> That's compiled on SuSE 10.1, gcc 4.1.0-25 (with CONFIG_CC_OPTIMIZE_FOR_SIZE,
> but I've since checked that the same kind of thing happens without).  In most
> places it does use the expected 416(r13) for current, but occasionally via an
> intermediate register as here: why it should choose to do it that way I don't
> know, but assume it's some subtle and legitimate optimization.  It looks as
> if YDL 4.1's older gcc 3.4.4-2 does not do it that way.

I don't know if SuSE's 4.1.0-25 has the PR24644 fix, or whether that
fix cures the mm/filemap.c problem.  I do know that a 4.1.2 20061121
compiler I happened to have lying around made copies of r13 on 2.6.17
mm/filemap.c, even with local_paca made volatile.  The following
workaround allowed me to compile a kernel without any silly r13
copies.

#define get_paca()	({__asm__ __volatile__ ("#paca %0" : "=r" (local_paca)); local_paca;})

The asm tells gcc that local_paca is changed in some unspecified way
just before each access.  Explicitly making r13 volatile like this
should avoid the fuzzy gcc semantics of volatile global register
variables.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
