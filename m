Date: Fri, 16 Nov 2001 04:57:38 -0700
From: Matt Porter <mporter@mvista.com>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116045737.A24130@cx258813-a.chnd1.az.home.com>
References: <20011116164625.K673@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011116164625.K673@zax>; from david@gibson.dropbear.id.au on Fri, Nov 16, 2001 at 04:46:26PM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 04:46:26PM +1100, David Gibson wrote:
>
> At the moment the initialization for each of the 4xx boards goes
> through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> in turns calls a board_init() function for the specific board.
>
> It seems to me that it would make more sense to put platform_init() in
> the board specific files, and these functions could then call back,
> where appropriate, to generic 4xx setup functions.  This would mean:
> 	- It would be easier to support wierd and wacky boards which
> have non-standard address setups.
> 	- Some ugly #ifdefs in ppc4xx_setup.c could be done away with.
> 	- We should be able to remove some inconvenient header
> dependencies - at present lots of things are recompiled when board
> local defines are changed because walnut.h/ep405.h/etc are included
> indirectly in serial.h and some other unexpected places.
>
> Thoughts?

I've been wondering why it's architected that way as well.  It
seems you are looking for it to follow the model of the well
abstracted 7xx/74xx ports.  Examples are the ones that rely on
mpc10x_common and pplus_common as libraries of common initialization
code (MEN F1, PCore, MCPN765, MVME5100, etc.).

Seems like that would be an improvement for people doing custom
405 ports and ease maintenance of existing ports (especially
the #ifdef creep).

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
