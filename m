Message-ID: <3A806897.9D2D480E@mvista.com>
Date: Tue, 06 Feb 2001 16:11:51 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
		<3A6DCBBE.60AB54CE@mvista.com> <14975.55329.292764.981333@tango.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> The way we do things on 6xx/7xx, .....

That's the way all PowerPCs currently do it.

> ....  We can effectively choose a different context for
> each 256MB segment of the address space, and we always choose context
> 0 for segments 0xc to 0xf.

That's not what MMU context means, well at least the way I have
learned to use it in the past.  An MMU context is supposed to represent
the virtual mapping of memory objects.  Linux has memory objects
and the ability to map these through VM areas, which is interesting
considering (IMHO) the TLB management and the terms (like context)
banted about are such a big hack.  Normally, it is the other way around.
You have some legacy hunk of code designed around arcane two level
page tables that tries to represent VM areas and memory objects
with TLB management doing its best to implement real MMU context.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
