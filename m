Message-ID: <39C7E573.A630CBEC@mvista.com>
Date: Tue, 19 Sep 2000 18:15:15 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "G. Guével" <gguevel@interfaceconcept.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU problems on MPC860P
References: <000001c02262$42c4b160$2901a8c0@none>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


G. Guével wrote:

> I made a new kernel from cllf(rpxclassic) board with MPC860T.

Well, as I recall, you have a custom board.  The CLLF (or any other)
configuration isn't likely to work with your custom board.  What
changes did you make to the sources to support your board?

> It seems that Linux does not clear all mmu registers.

Yes, I believe it configures everything properly.

> Which registers must be cleared by the previous monitor ?

None, but there are several steps the monitor has to perform
to properly initialize the processor.  Most important is the
cache initialization steps.  Linux doesn't do this, and it
really can't because you need to know these steps are done
out of reset.

> I use my personal monitor which does not deal with mmu.

That's fine.  Just make sure if the caches are used that they
are consistent with memory, especially the I-cache if you copied
instructions around.  The Linux image must be called with the
MMU disabled.

> I don't know if EPPC-BUG makes some special actions before
> loading Linux loader.

EPPC-Bug???  Where does this fit into the picture?  It is used on
the MBX board.  On the MBX we expect register 3 to have a pointer
to the board info structure...I know the MMU is disabled, but I
don't remember the cache state, except that it is consistent.

You have to build some kind of board information structure in the
arch/ppc/mbxboot/embed_config.c.  If you are using CLLF, it is
expecting to read this from serial EEPROM.  If any of the information
in here is incorrect, you will have some trouble.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
