Date: Mon, 15 Oct 2001 13:44:50 -0400
From: Daniel Jacobowitz <drow@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: Ed.Swarthout@motorola.com, paulus@samba.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: interesting line in process.c
Message-ID: <20011015134450.A26404@nevyn.them.org>
References: <15304.11248.720092.645241@cargo.ozlabs.ibm.com> <3BCAF4D2.D41EE8C4@mvista.com> <200110151547.f9FFltD24916@pacific.somerset.sps.mot.com> <3BCB06A7.7A6C0D9F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BCB06A7.7A6C0D9F@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 15, 2001 at 11:54:15AM -0400, Dan Malek wrote:
>
> Edward Swarthout wrote:
>
> > I would suggest ppc do the same thing and define a single debug array
> > in thread_struct which contains the processor specific debug registers
> > needed to support gdb's use of hardware breakpoints.
>
> So, gdb has knowledge of hardware breakpoints and knows how to use
> them across the different processors?  I would ask we consider using
> a standard breakpoint interface to the kernel and allow the kernel
> to implement the breakpoints as it desires.  It seems having this
> knowledge and synchronizing the necessary information across the
> interface could be challenging.

Yes, I'd much prefer that the kernel handle it, from a purely GDB point
of view, but this does also introduce significant complexity; witness
Dave Miller's decision not to handle single-step in kernel on either
Sparc or MIPS.  The kernel would need to track the registers somewhere
process-specific, not allow them to be set via ptrace, etc.

As far as I know no platform currently has ptrace constants for setting
hardware breakpoints/watchpoints; instead, some export the registers
via ptrace.  It should be much cleaner to do it via an abstract
interface.

I'm willing to do the GDB support code for this if someone else
volunteers to do the kernel parts :)

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
