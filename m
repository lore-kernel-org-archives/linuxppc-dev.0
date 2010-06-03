Return-Path: <paulus@ozlabs.org>
Date: Thu, 3 Jun 2010 10:47:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Emulate most Book I instructions in
	emulate_step()
Message-ID: <20100603004758.GA19618@brick.ozlabs.ibm.com>
References: <20100602112903.GB30149@brick.ozlabs.ibm.com>
	<09904F7B-6319-45FA-ADC4-757A2AD239AB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09904F7B-6319-45FA-ADC4-757A2AD239AB@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 02, 2010 at 07:45:27AM -0500, Kumar Gala wrote:

> Why do we need to have emu support for all of these instructions?

Fair question.  This arose in the context of the support for data
breakpoint events in perf_events.  Since the data breakpoint facility
on our processors (DABR on server, DAC/DVC on Book 3E) interrupts
before doing the access, we have to execute the instruction that
caused the breakpoint without the data breakpoint set, then put the
data breakpoint back and carry on.

The interesting case comes when the interrupt occurs on a
lwarx/ldarx.  If we just single-step it, we'll lose the reservation
and most likely get into an infinite loop, making no progress.   So we
have two alternatives: either try to arrange that we can single-step
the lwarx and get to the stwcx without losing the reservation, or
emulate the lwarx and all the instructions up to and including the
stwcx.

The first alternative seemed pretty fragile to me since it means that
we have to arrange that we can single-step and take data breakpoints
without using any spinlocks, mutexes or atomic ops (including
bitops).  Also, the architecture says that some embedded
implementations might clear the reservation on taking an interrupt
(which presumably could include debug interrupts).

The second alternative -- emulating the lwarx/stwcx and all the
instructions in between -- sounds complicated but turns out to be
pretty straightforward in fact, since the code for each instruction is
pretty small, easy to verify that it's correct, and has little
interaction with other code.

Note that we have to do this emulation both for the kernel and for
user code, since a data breakpoint event could occur in the kernel or
in usermode.  While we can constrain what occurs between lwarx/stwcx
in the kernel pretty tightly, userspace is not so well constrained, so
I though it best to do all the integer ops that can be done reasonably
easily and can occur in C code.

The other thing I want to do is use this to replace the alignment
fixup code, since they're doing very similar things now.  That will
need little-endian support plus implementing the rest of the Altivec
and VSX loads and stores, along with dcbz, l/stswi, l/stswx, etc.

Finally, emulating should be faster than single-stepping, and so
extending the set of emulated instructions should improve the
performance of kprobes and uprobes.

Paul.
