Message-ID: <380DFDD4.EEDC570E@netx4.com>
Date: Wed, 20 Oct 1999 13:37:24 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA use
References: <380DCA0D.B272F889@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lewis wrote:
> 
> Hello,
> 
> Has anyone out there done anything with PCMCIA on the 8xx?

Yes.  I put some hacks in the kernel to support an ATA/IDE
flash card.  At one time this worked, and with the IDE and
interrupt stuff changing so much recently I am not sure if
it works any longer.  Look in the arch/ppc/kernel/m8xx_setup.c
file.  I have some more elaborate functions if you need
better examples.

In addition to what is there, you also need to sense and enable
the proper power supply, which is very implementation specific.
You will also have to initialize the PCMCIA control/address
registers and make sure it gets mapped in somplace (either a
driver or mm/init.c).

I continue to have nightmares about porting pcmcia-cs to the
8xx, and should probably do it some day with David's help.  Since
my experience with applications using PCMCIA on the 8xx has been
they are quite unique and static, I have always just initialized
the interface for the application.  Less code, less overhead.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
