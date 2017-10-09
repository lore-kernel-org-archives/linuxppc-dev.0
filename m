Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9jlz2z2fzDr59
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:48:15 +1100 (AEDT)
Date: Mon, 9 Oct 2017 09:47:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Sandipan Das'" <sandipan@linux.vnet.ibm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "paulus@samba.org" <paulus@samba.org>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
Subject: Re: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
Message-ID: <20171009144756.GB4406@gate.crashing.org>
References: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008D92D@AcuExch.aculab.com>
 <20171009142053.GA4406@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD008D9DE@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD008D9DE@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 09, 2017 at 02:43:45PM +0000, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 09 October 2017 15:21
> > On Mon, Oct 09, 2017 at 01:49:26PM +0000, David Laight wrote:
> > > From: Sandipan Das
> > > > Sent: 09 October 2017 12:07
> > > > According to the GCC documentation, the behaviour of __builtin_clz()
> > > > and __builtin_clzl() is undefined if the value of the input argument
> > > > is zero. Without handling this special case, these builtins have been
> > > > used for emulating the following instructions:
> > > >   * Count Leading Zeros Word (cntlzw[.])
> > > >   * Count Leading Zeros Doubleword (cntlzd[.])
> > > >
> > > > This fixes the emulated behaviour of these instructions by adding an
> > > > additional check for this special case.
> > >
> > > Presumably the result is undefined because the underlying cpu
> > > instruction is used - and it's return value is implementation defined.
> > 
> > It is undefined because the result is undefined, and the compiler
> > optimises based on that.  The return value of the builtin is undefined,
> > not implementation defined.
> > 
> > The patch is correct.
> 
> But the code you are emulating might be relying on the (un)defined value
> the cpu instruction gives for zero input rather than the input width.
> 
> Or, put another way, if the return value for a clz instruction with zero
> argument is undefined (as it is on x86 - intel and amd may differ) then the
> emulation can return any value since the code can't care.
> So the conditional is not needed.

The cntlz[wd][.] insn has defined behaviour for 0 input.  It's just the
builtin that does not.  So we shouldn't call the builtin with an input
of 0 -- exactly what this patch does -- and that is all that was wrong.


Segher
