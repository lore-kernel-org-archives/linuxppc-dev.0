Date: Thu, 3 Oct 2002 17:31:43 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: generic vector unit support?
Message-ID: <20021003213143.GA9675@nevyn.them.org>
References: <E81F90F8-D715-11D6-B5AB-003065BFB10E@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E81F90F8-D715-11D6-B5AB-003065BFB10E@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 04:20:14PM -0500, Kumar Gala wrote:
> I am not sure about what to do about ptrace.  We extended the interface
> to have two new request types (PTRACE_GETVRREGS, PTRACE_SETVRREGS)
> which return the full altivec state (all registers, vscr, vrsave).  We
> could overload these request types to return all the 'vector' state
> depending on which processor we are.  This would mean debuggers would
> have to know which processor we are to know how big of a buffer to have
> for ptrace calls, the memory layout, etc.

I'd rather see you do it the other way around:  Add PTRACE_GETSPEREGS
in the e500, so that the debugger can use ptrace to figure out which
registers are available.

> We also extend generic vector idea to allow dumping of altivec/SPE
> register state into core files (which we do not do currently).

That's a great idea.  Again, I think Altivec and SPE registers should
be tagged differently even though they can't coexist.

Otherwise, it sounds like a good idea to me.

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
