Message-ID: <3CFD3747.B88C1BA5@mvista.com>
Date: Tue, 04 Jun 2002 14:55:19 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org, dan@embeddededge.com,
	frowand@mvista.com
Subject: Re: pt_regs.dbcr0/1
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Replying to a string of several messages:


Paul Mackerras wrote:
>
> Is anyone prepared to speak up for the dbcr0 and dbcr1 fields that
> someone added to struct pt_regs for 4xx in the 2_4_devel tree?
>
> If not, they are going.  If so, we can discuss it.
>
> Better still, does anyone have a clearly thought-out vision of how the
> debug facilities on 4xx should be managed?

That's a very important sentence...  If you are going to modify any of
the 4xx debug infrastructure, please be sure that you understand how
gdb (via ptrace.c), kgdb (via ppc_stub.c), and jtag debuggers use the
infrastructure and how they can interact.  Other interesting files
that get involved are head_4xx.S (saving state, handling the debug
exception), entry.S (restoring state), traps.c (single step handling),
ppc4xx_setup.c (debug register initialization), and I'm probably forgetting
some other file.  (Of course you also have to add in the 440 specific
files, which I'm not familiar with.)


> I would much prefer to see these fields put in the thread_struct
> rather than pt_regs.  I am reluctant to change pt_regs without a good
> reason since it is visible to userspace and is therefore part of the
> kernel API.  If the intention is to make the debug facilities
> available to userspace then the thread_struct is a good place to put
> fields relating to the debug facilities.

I had an early version of the kernel that used the thread_struct instead
of the pt_regs, but it was more complex than the current code, and gdb
and kgdb did not play well together.

Using pt_regs made it relatively easy for gdb and kgdb to coexist.


Dan Malek wrote:
>
> Paul Mackerras wrote:
>
> > Is anyone prepared to speak up for the dbcr0 and dbcr1 fields that
> > someone added to struct pt_regs for 4xx in the 2_4_devel tree?
>
> I believe they were moved because those registers are copied between
> the application context and the debugger.  I was part of making this
> work, but not for moving the registers :-)  IIRC, the reason was we
> wanted gdb to be '4xx-aware' so it could use more of the debug capabilities.
> There is also a problem of context switching these registers when you
> are trying to debug the kernel or applications.
>
> > If not, they are going.  If so, we can discuss it.
>
> You just can't toss them, they have to be context switched, but I think
> the thread struct is the proper place.  There are always problems with
> trying to run any combination of background debuggers, kgdb, or application
> gdb at the same time, which raises the discussion as to where these
> registers should be context switched.  I think we just resign ourselves
> to only one debug interface active at a time and simplify the kernel.

The last time that I fixed the 4xx debug infrastructure, I had gdb and kgdb
coexisting.  Adding RISCWatch (jtag based) to the mix made things a little
bit more fragile.  But for someone who was intimitely familiar with the
debug infrastructure (me), RISCWatch was somewhat useful in a tightly
constrained usage model coexistant with gdb/kgdb (I was debugging the
debugging infrastructure) before occassionally blowing everything up.
Using a jtag debugger simultaneously with gdb/kgdb is not an exercise
for the meek.

By gdb and kgdb coexisting, I mean having both debuggers actively
debugging a problem at the same time, without interfering with
each other.


>
> > Better still, does anyone have a clearly thought-out vision of how the
> > debug facilities on 4xx should be managed?
>
> With better hardware support? :-)  The debug registers just have to be
> context switched between the different threads (and the kernel if you
> want to debug that as well).  A separate discussion is how much we want
> gdb to be specifically aware of the 4xx, which will change the kernel
> ptrace() interface and functions.

I don't think you would have to change the ptrace() interface.  The major
features that the 4xx debug architecture provides that aren't currently
being used are hardware breakpoints, and hardware watchpoints (detecting
access of an address range).  I think that this can be handled with the
current API (but I defer to any gdb expert who wants to jump in...).



Paul Mackerras wrote:
>
> Dan Malek writes:

< stuff deleted >

> I think so too.  I think it will be basically impossible to do gdb +
> external debugging or xmon/kgdb + external debugging.

Note for the curious - the key problem areas are restoring process state (see
CONFIG_BDI_SWITCH in entry.S) and entering the kernel via exceptions
(head_4xx.S).



Dan Malek wrote:
>

< stuff deleted >

> I believe we have tied the BDI context switch configuration option to
> allowing external debugging by ensuring the kernel doesn't mess around
> with the debug registers.  We have at least discussed doing it.  As

Yes, someone did it.  See CONFIG_BDI_SWITCH in entry.S.



One final note:  I did not implement xmon support when I did the 405gp (walnut)
bringup.  I got kgdb working fairly quickly and didn't need a second debugger
at the time.  I don't know if anyone has since added 4xx xmon support.  If not,
that might be a good project for someone.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
