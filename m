Message-ID: <39906957.804A06FD@embeddededge.com>
Date: Tue, 08 Aug 2000 16:11:03 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FEC question about setting SIEL register
References: <20000808055121.7716D220@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> ....  The culprit was that I hadn't
> configured the PHY MII link interrupt (which is on external IRQ5 on our board)
> as edge triggerred in the SIU Interrupt Edge/Level (SIEL) register.

Yeah....There are about a bazillion different pin multiplexing
combinations on these parts.  You really should have a very methodical
procedure to verify all of them, usually as part of the design process
before hardware CAD.


> Setting the SIEL is trivial enough, but where abouts is the right place to
> do it: in the fec.c driver, or in the 8xxrom/boot loader?

Normally I do all of this in a boot rom.  The I/O pin configuration
necessary to make even minimal forward progress must be done very early,
so I just do all of it there in one place.

> ......  The FADS code in
> fec.c doesn't set the SIEL,

Nope.  It never did.

> .... and it doesn't seem to be set in the FADS code in
> 8xxrom/fadsrom either, so I would conclude that it probably suffers the same
> problem.

It should be, but I screwed that up the first time.  The next logical
place (and where it used to exist), was in m8xx_setup.c in the
function m8xx_init_IRQ().  Since I don't have a FADS board any longer
for testing, and everyone else was connecting this interrupt to a
port C pin, the code just disappeared as part of the new interrupt
management.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
