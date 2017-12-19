Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z12Nn1rtJzDsQk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 13:46:48 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id z5so6103831plo.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 18:46:48 -0800 (PST)
Date: Tue, 19 Dec 2017 12:46:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Torsten Duwe <duwe@lst.de>, linux-kernel@vger.kernel.org, Jiri Kosina
 <jkosina@suse.cz>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171219124631.6a193491@roar.ozlabs.ibm.com>
In-Reply-To: <20171218185622.rgoyy5doyh3gyqh5@treble>
References: <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
 <20171212140501.44vf4xcz6jhbqofd@treble>
 <20171215194009.349b04da@roar.ozlabs.ibm.com>
 <20171218025854.angid7h33gnmxsrg@treble>
 <20171218153334.618c0b66@roar.ozlabs.ibm.com>
 <20171218185622.rgoyy5doyh3gyqh5@treble>
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

On Mon, 18 Dec 2017 12:56:22 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Dec 18, 2017 at 03:33:34PM +1000, Nicholas Piggin wrote:
> > On Sun, 17 Dec 2017 20:58:54 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >   
> > > On Fri, Dec 15, 2017 at 07:40:09PM +1000, Nicholas Piggin wrote:  
> > > > On Tue, 12 Dec 2017 08:05:01 -0600
> > > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >     
> > > > > On Tue, Dec 12, 2017 at 12:39:12PM +0100, Torsten Duwe wrote:    
> > > > > > Hi all,
> > > > > > 
> > > > > > The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> > > > > > 
> > > > > > [...] There are several rules that must be adhered to in order to ensure
> > > > > > reliable and consistent call chain backtracing:
> > > > > > 
> > > > > > * Before a function calls any other function, it shall establish its
> > > > > >   own stack frame, whose size shall be a multiple of 16 bytes.      
> > > > > 
> > > > > What about leaf functions?  If a leaf function doesn't establish a stack
> > > > > frame, and it has inline asm which contains a blr to another function,
> > > > > this ABI is broken.    
> > > 
> > > Oops, I meant to say "bl" instead of "blr".
> > >   
> > > > > Also, even for non-leaf functions, is it possible for GCC to insert the
> > > > > inline asm before it sets up the stack frame?  (This is an occasional
> > > > > problem on x86.)    
> > > > 
> > > > Inline asm must not have control transfer out of the statement unless
> > > > it is asm goto.    
> > > 
> > > Can inline asm have calls to other functions?  
> > 
> > I don't believe so.  
> 
> It's allowed on x86, I don't see why it wouldn't be allowed on powerpc.

It's not allowed in general, but there's a lot of architecture specific
differences there, so maybe x86 has an exception. I don't think such an
exception exists for powerpc.... If you know exactly how the code
generation works then you could write inline asm works.

> As you mentioned, GCC doesn't pay attention to what's inside asm("").

And as you mentioned, it doesn't set up the stack frame properly for
leaf functions that call others in asm. There's other concerns too like
different ABI versions (v1/v2) have different stack and calling
conventions.

> > > > > Also, what about hand-coded asm?    
> > > > 
> > > > Should follow the same rules if it uses the stack.    
> > > 
> > > How is that enforced?  
> > 
> > It's not, AFAIK. Gcc doesn't understand what's inside asm("").  
> 
> Here I was talking about .S files.

Not enforced, but you can assume hand coded asm will not set up a
non-standard stack frame and calling convention, that would be a
bug.

> 
> > > > > > To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> > > > > > This patch may be unneccessarily limited to ppc64le, but OTOH the only
> > > > > > user of this flag so far is livepatching, which is only implemented on
> > > > > > PPCs with 64-LE, a.k.a. ELF ABI v2.      
> > > > > 
> > > > > In addition to fixing the above issues, the unwinder also needs to
> > > > > detect interrupts (i.e., preemption) and page faults on the stack of a
> > > > > blocked task.  If a function were preempted before it created a stack
> > > > > frame, or if a leaf function blocked on a page fault, the stack trace
> > > > > will skip the function's caller, so such a trace will need to be
> > > > > reported to livepatch as unreliable.    
> > > > 
> > > > I don't think there is much problem there for powerpc. Stack frame
> > > > creation and function call with return pointer are each atomic.    
> > > 
> > > What if the function is interrupted before it creates the stack frame?
> > >   
> > 
> > Then there will be no stack frame, but you still get the caller address
> > because it's saved in LR register as part of the function call. Then
> > you get the caller's caller in its stack frame.  
> 
> Ok.  So what about the interrupted function itself?  Looking at the
> powerpc version of save_context_stack(), it doesn't do anything special
> for exception frames like checking regs->nip.
> 
> Though it looks like that should be possible since show_stack() has a
> way to identify exception frames.
> 

Yes, the low level interrupt code stores a marker in the stack frame
which identifies where an exception occurs.

Thanks,
Nick
