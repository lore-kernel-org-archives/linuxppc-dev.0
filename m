From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14976.32421.281551.591586@tango.linuxcare.com.au>
Date: Wed, 7 Feb 2001 09:45:57 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A807ACA.E23A7B47@mvista.com>
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<3A6DCBBE.60AB54CE@mvista.com>
	<14975.55329.292764.981333@tango.linuxcare.com.au>
	<3A806897.9D2D480E@mvista.com>
	<14976.29084.376745.660244@tango.linuxcare.com.au>
	<3A807ACA.E23A7B47@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> > > That's not what MMU context means, well at least the way I have
> > > learned to use it in the past.  An MMU context is supposed to represent
> > > the virtual mapping of memory objects.  Linux has memory objects
> >
> > No, an MMU context represents an address space, or more precisely the
> > set of virtual to physical mappings in an address space,...
>
> Isn't that what I just said above :-)?  Your original message said

That is one possible interpretation of what you said above. :)  You
went on to talk about memory objects which is why I thought you were
saying that a context represented a mapping of a single object.  I
think we're actually in violent agreement.

> you want to map some context to just a few of the VSIDs, that is what
> I said isn't correct.

What does "correct" mean in this context (excuse the pun :) ?
We can set up the VSIDs however we darn well please.  We set up the
VSIDs so that the kernel portion of each context is the same.  Where's
the problem?

In saying "we can effectively choose a different context for each
256MB segment" I was trying to say "if you think about MMUs in terms
of MMU contexts, then you can think of the PPC MMU as being able to
select a different context, not just per task, but per 256MB segment
of the address space of that task as well".

> Well, an MMU doesn't have to know about contexts (or have something
> called a 'context register') for you to implement MMU context management.

Sure.  But it needs to know about more address bits (in some sense)
than the 32 bits of VA that the cpu core gives you.  The x86 MMU
doesn't.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting Open Source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
