From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14976.29084.376745.660244@tango.linuxcare.com.au>
Date: Wed, 7 Feb 2001 08:50:20 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A806897.9D2D480E@mvista.com>
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<3A6DCBBE.60AB54CE@mvista.com>
	<14975.55329.292764.981333@tango.linuxcare.com.au>
	<3A806897.9D2D480E@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> That's not what MMU context means, well at least the way I have
> learned to use it in the past.  An MMU context is supposed to represent
> the virtual mapping of memory objects.  Linux has memory objects

No, an MMU context represents an address space, or more precisely the
set of virtual to physical mappings in an address space, which will
typically include mappings of many objects.  That's the way the term
is used in the Linux kernel, that's why it's the mm_struct (which
represents an address space) which has the MMU context in it.

> and the ability to map these through VM areas, which is interesting
> considering (IMHO) the TLB management and the terms (like context)
> banted about are such a big hack.  Normally, it is the other way around.
> You have some legacy hunk of code designed around arcane two level
> page tables that tries to represent VM areas and memory objects
> with TLB management doing its best to implement real MMU context.

On machines like the x86 where the MMU doesn't know about MMU contexts
you have to basically context-switch the whole MMU including the TLB.
Fortunately we don't have to do that. :)

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting Open Source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
