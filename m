Message-ID: <40166512.8050901@embeddededge.com>
Date: Tue, 27 Jan 2004 08:18:10 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8540ADS setup
References: <1075196173.13554.42.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nickl wrote:

> 1st, whats the correlation between PVR and "Revision"?

A portion of the PVR can indicate the chip revision,
but there are also other indicators.  The manual and datasheet
specific to the processor will define this.

> while u-boot/doc/README.mpc85xxads reads:
>
> "MPC85xx Rev 1 Chip, in general you will use a Rev2
> chip from Nov.2003. If you still see this definition
> while you have a Rev2(and newer) chip,undef this."

That was an optimistic statement by the person from Motorola
that originally wrote most of the u-boot update for the 85xx :-)

> So what Rev do I have? Booby traps on the way?

You definitely have a Rev. 1 part in your ADS board.  There
are no "booby traps", the Rev. 2 part cleans up some errata
among other things.  Your Motorola representative can
give you the details.

> 2nd, how to correctly setup the BDI flash access?
>
> bdi-8540>unlock 0xFF000000
> # Writing to workspace failed

The initialization of the 85xx parts is quite challenging,
especially for the debugger.

> I've taken the sections from ads8560.cfg that
> seem to map L2SRAM for that purpose and
> use WORKSPACE   0xf0000000.

Make sure you understand the reset/initialization process
of the 8540, that the sections you have taken from the
8560 file are sufficient for your board configuration.
The INIT section of the BDI2000 configuration file is
quite generic, and I suspect it should work fine for
the 8540 as well (I've never used the 8540, only the 8560).

I've found initializing the sdram and using something
within that space works the best.

> every time to reset the board, otherwise it stays dead :(
> Not necessary on manual reset and powerup.

Extend the power up delay, make sure you wait for the
reset to happen.  Issuing a 'go' command with nothing to
run (i.e. a bogus flash rom) could lead to some interesting
processor states as well :-)  Also, make sure you look at
the stop8560.cfg when you do have code running from flash.
You can't use the same configuration file like you can with
other processors once the boot rom is running.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
