Date: Fri, 16 Nov 2001 07:59:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116075917.A5410@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011116164625.K673@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 04:46:26PM +1100, David Gibson wrote:

> At the moment the initialization for each of the 4xx boards goes
> through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> in turns calls a board_init() function for the specific board.
>
> It seems to me that it would make more sense to put platform_init() in
> the board specific files, and these functions could then call back,
> where appropriate, to generic 4xx setup functions.  This would mean:

But 95% of the current 4xx platform_init is generic.  With the exception
of the redwood kbd init stuff, which right now we could probably move
into the redwood board_init (providing redwood_irkb_init sets things to
NULL which the previous bits set).

> 	- It would be easier to support wierd and wacky boards which
> have non-standard address setups.

Can you be more specific?

> 	- Some ugly #ifdefs in ppc4xx_setup.c could be done away with.

All of the ones around externs can go regardless.

> 	- We should be able to remove some inconvenient header
> dependencies - at present lots of things are recompiled when board
> local defines are changed because walnut.h/ep405.h/etc are included
> indirectly in serial.h and some other unexpected places.

Keep in mind <asm/ibm4xx.h> has the same exact thing.  As does
<asm/mpc8xx.h>.  There's lots of wierd header dependancies, and it's not
fixable in 2.4 anyhow.  kbuild-2.5 doesn't have this issue, and this
isn't even much of a problem anyhow.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
