Date: Fri, 4 Oct 2002 12:49:30 -0500
Subject: Re: RFC: generic vector unit support?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: Daniel Jacobowitz <drow@false.org>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <20021003213143.GA9675@nevyn.them.org>
Message-Id: <A1FE3890-D7C1-11D6-9BAC-003065BFB10E@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday, October 3, 2002, at 04:31  PM, Daniel Jacobowitz wrote:

> On Thu, Oct 03, 2002 at 04:20:14PM -0500, Kumar Gala wrote:
>> I am not sure about what to do about ptrace.  We extended the
>> interface
>> to have two new request types (PTRACE_GETVRREGS, PTRACE_SETVRREGS)
>> which return the full altivec state (all registers, vscr, vrsave).  We
>> could overload these request types to return all the 'vector' state
>> depending on which processor we are.  This would mean debuggers would
>> have to know which processor we are to know how big of a buffer to
>> have
>> for ptrace calls, the memory layout, etc.
>
> I'd rather see you do it the other way around:  Add PTRACE_GETSPEREGS
> in the e500, so that the debugger can use ptrace to figure out which
> registers are available.

This seems reasonable, make life easier on the debugger.

>
>> We also extend generic vector idea to allow dumping of altivec/SPE
>> register state into core files (which we do not do currently).
>
> That's a great idea.  Again, I think Altivec and SPE registers should
> be tagged differently even though they can't coexist.

I was thinking, by doing this we can add a dump_vector into the generic
code that handles the creation of core files.

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
