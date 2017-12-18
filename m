Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0S5N3tPrzDrXy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 15:01:27 +1100 (AEDT)
Date: Sun, 17 Dec 2017 22:01:24 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Torsten Duwe <duwe@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171218040124.xmjeq6x3m2hpl6g4@treble>
References: <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
 <20171212140501.44vf4xcz6jhbqofd@treble>
 <20171215194009.349b04da@roar.ozlabs.ibm.com>
 <20171218025854.angid7h33gnmxsrg@treble>
 <CAKTCnz=jukr_dY5PNRQYcFT9NMu+tmViw1UUfzrPUvE7HsHurg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAKTCnz=jukr_dY5PNRQYcFT9NMu+tmViw1UUfzrPUvE7HsHurg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2017 at 02:39:06PM +1100, Balbir Singh wrote:
> On Mon, Dec 18, 2017 at 1:58 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Fri, Dec 15, 2017 at 07:40:09PM +1000, Nicholas Piggin wrote:
> >> On Tue, 12 Dec 2017 08:05:01 -0600
> >> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>
> >> > On Tue, Dec 12, 2017 at 12:39:12PM +0100, Torsten Duwe wrote:
> >> > > Hi all,
> >> > >
> >> > > The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> >> > >
> >> > > [...] There are several rules that must be adhered to in order to ensure
> >> > > reliable and consistent call chain backtracing:
> >> > >
> >> > > * Before a function calls any other function, it shall establish its
> >> > >   own stack frame, whose size shall be a multiple of 16 bytes.
> >> >
> >> > What about leaf functions?  If a leaf function doesn't establish a stack
> >> > frame, and it has inline asm which contains a blr to another function,
> >> > this ABI is broken.
> >
> > Oops, I meant to say "bl" instead of "blr".
> 
> I was wondering why "blr" mattered, but I guess we should speak of the
> consistency
> model. By walking a stack trace we expect to find whether a function is in use
> or not and can/cannot be live-patched at this point in time. Right?

Right.

> >> > Also, even for non-leaf functions, is it possible for GCC to insert the
> >> > inline asm before it sets up the stack frame?  (This is an occasional
> >> > problem on x86.)
> >>
> >> Inline asm must not have control transfer out of the statement unless
> >> it is asm goto.
> >
> > Can inline asm have calls to other functions?
> >
> >> > Also, what about hand-coded asm?
> >>
> >> Should follow the same rules if it uses the stack.
> >
> > How is that enforced?
> >
> >> > > To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> >> > > This patch may be unneccessarily limited to ppc64le, but OTOH the only
> >> > > user of this flag so far is livepatching, which is only implemented on
> >> > > PPCs with 64-LE, a.k.a. ELF ABI v2.
> >> >
> >> > In addition to fixing the above issues, the unwinder also needs to
> >> > detect interrupts (i.e., preemption) and page faults on the stack of a
> >> > blocked task.  If a function were preempted before it created a stack
> >> > frame, or if a leaf function blocked on a page fault, the stack trace
> >> > will skip the function's caller, so such a trace will need to be
> >> > reported to livepatch as unreliable.
> >>
> >> I don't think there is much problem there for powerpc. Stack frame
> >> creation and function call with return pointer are each atomic.
> >
> > What if the function is interrupted before it creates the stack frame?
> >
> 
> If it is interrupted, the exception handler will establish a new stack frame.
> From a consistency viewpoint, I guess the question is -- has the function
> been entered or considered to be entered when a stack frame has not
> yet been established

Actually I think it's the function's *caller* which gets skipped.  r1
(stack pointer) will point to the caller's stack frame, and presumably
the unwinder would read the caller's caller's stack frame to get the
next LR, skipping the caller's return address because it hasn't been
saved yet.

-- 
Josh
