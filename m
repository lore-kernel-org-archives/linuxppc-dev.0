From: linas@austin.ibm.com
Date: Wed, 22 Oct 2003 10:41:46 -0500
To: Seb James <seb@peak.uklinux.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Using in_8 and out_8 without module optimization
Message-ID: <20031022104146.A23472@forte.austin.ibm.com>
References: <1066742722.18957.36.camel@circle.hypercube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066742722.18957.36.camel@circle.hypercube>; from seb@peak.uklinux.net on Tue, Oct 21, 2003 at 02:25:24PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 21, 2003 at 02:25:24PM +0100, Seb James wrote:
>
> I need to run the module without optimization as I really need a section
> of the code to run exactly as I've coded it, but when I compile without

re-write that section in assembly.

Note that even if the compiler doesn't reorder insn's or memory load/store's,
the CPU might still excecute out-of-order, and/or the memory controller
(if any) might store/load out of order.  If you need guarenteed order
of execution, you need to use memory/io barriers, e.g. eieio, sync;
if you are seeing cacheing of i/o loads/stores, you are probably not
using 'volatile' (or not using it correctly).

On Tue, Oct 21, 2003 at 04:03:33PM +0200, Holger Bettag wrote:
>
> On Tue, 21 Oct 2003, Wolfgang Grandegger wrote:
>
> > To ensure that the asm-code is executed in sequence with your
> > C-code use:
> >
> >   -fno-schedule-insns -fno-schedule-insns2
> >
> Some other optimizations might still rearrange code, so consider
> -fno-strength-reduce and -fno-move-all-moveables and possibly a few other
> switches. Just compile with -S and see if the assembly code looks right.

If a device driver breaks because of compiler optimizations, the answer
is to fix the device driver, not to disable optimization.  I'm guessing
that the driver isn't using eieio in all the right places. (and/or volatile).


--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
