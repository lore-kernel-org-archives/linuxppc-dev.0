Message-ID: <3B9D57E0.4881358E@mvista.com>
Date: Mon, 10 Sep 2001 20:16:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another fix for xmon on non-standard MMU machines
References: <20010910194730.J4823@zax> <20010910160600.21153@smtp.adsl.oleane.com> <20010911091748.M4823@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> ..... Turns out the TLB miss handler
> was broken in that:
>     a) it set the TLB writable bit based only the _PAGE_DIRTY bit, but
> a page can be dirty but still write-protected - in particular this
> happens during the COW of the stack, so the two processes were sharing
> their stack.

What the heck are you looking at????

It sets _PAGE_DIRTY | _PAGE_ACCESSED based upon the setting of
the _PAGE_RW.

If you get a Data Store exception (which would be the case trying
to access a page that is write protected), and the page is not
marked _PAGE_RW, it will call the heavyweight fault handler to
fix this.....which is exactly what happens for copy-on-write.
The _PAGE_DIRTY is an alias to the hardware write protect.  Setting
this bit will allow a write operation.

The purpose of the TLB miss handlers are to simply store the Linux
PTE (or close approximation) into the hardware TLB.  It is up to
the Linux MM to construct this properly, which it appears isn't happening.

These exception handlers worked perfectly in the 2.4.2 timeframe.
Modifications to other areas of the kernel have caused problems, and
we need to find them there, not hack around down at this level where
we want minimal code.

The 603 cores and the 8xx are having similar problems to the 4xx.
There is something more generic that is wrong.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
