Message-ID: <3A9A8976.884C49C2@mvista.com>
Date: Mon, 26 Feb 2001 11:51:02 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steve Ferri <sferri@ss7-link.com>
CC: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cache Inhibit on 860?
References: <F1BD619B2A58D41197990050DA2C08E41A5E2C@SLINK12>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Ferri wrote:

> Is there a way to alloc memory and mark it as cache inhibited ?

In a few minutes :-).  I finally created a common set of 'dma_consistent'
functions for 8xx and 4xx (and anything else that may need them)
based upon implementations from other architectures.  I am now checking
this into the linuxppc_2_5 BitKeeper tree.

> This would eliminating the need for the invalidate and flush calls.

But, if you already have this working, it is probably better performance
unless these are tiny, frequently used buffers.

> .....  I am
> currently
> running a 2.2.14 version of the kernel on an 860 processor.

For 2.2.14, look at the arch/ppc/8xx_io/enet.c Ethernet driver as
an example.  It calls __get_free_page(), then tracks down the
page table entry and sets the cache inhibit flag.  Do the same thing
in your driver.  The stuff done in 'commproc.c' is different because
it is called earlier in the kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
