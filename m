Date: Mon, 15 Oct 2001 10:47:55 -0500 (CDT)
Message-Id: <200110151547.f9FFltD24916@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: dan@mvista.com, paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Reply-To: Ed.Swarthout@motorola.com
In-reply-to: <3BCAF4D2.D41EE8C4@mvista.com> (message from Dan Malek on Mon, 15
	Oct 2001 10:38:10 -0400)
Subject: Re: interesting line in process.c
References: <15304.11248.720092.645241@cargo.ozlabs.ibm.com> <3BCAF4D2.D41EE8C4@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From Dan Malek:
>
> Paul Mackerras wrote:
> >
> > Which brings up another question that I have been meaning to ask: what
> > is the rationale for adding the dbcr0/1 fields to the ptrace struct
> > for 4xx?
>
> I dunno.  They have also been moving around during the 4xx port.
> I just put them where the folks that send the patches have them.
> I'll take a look at this since gdb is currently broken on 4xx.
> They have to be context switched, and maybe someone though gdb should
> have access to them.....

I bumped into this when I was looking at adding 74xx IABR/DABR support
for hardware breakpoints under gdb.
(see http://lists.linuxppc.org/linuxppc-dev/200108/msg00249.html)

But to really support the 405 (or booke) all 11 (or 12 for booke)
debug breakpoint registers should to be accessible to gdb.

i386 defines debugreg[8] in the thread_struct and gives ptrace access
to it with special restrictions.

I would suggest ppc do the same thing and define a single debug array
in thread_struct which contains the processor specific debug registers
needed to support gdb's use of hardware breakpoints.  New ptrace
numbers (offsets) will need to be defined to access this array.

Ed.Swarthout@motorola.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
