Message-ID: <3BF549AA.80E0FCF4@mvista.com>
Date: Fri, 16 Nov 2001 09:15:22 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
>
> At the moment the initialization for each of the 4xx boards goes
> through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> in turns calls a board_init() function for the specific board.
>
> It seems to me that it would make more sense to put platform_init() in
> the board specific files, and these functions could then call back,
> where appropriate, to generic 4xx setup functions.  This would mean:
>         - It would be easier to support wierd and wacky boards which
> have non-standard address setups.
>         - Some ugly #ifdefs in ppc4xx_setup.c could be done away with.
>         - We should be able to remove some inconvenient header
> dependencies - at present lots of things are recompiled when board
> local defines are changed because walnut.h/ep405.h/etc are included
> indirectly in serial.h and some other unexpected places.
>
> Thoughts?
>
> --
> David Gibson                    | For every complex problem there is a
> david@gibson.dropbear.id.au     | solution which is simple, neat and
>                                 | wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>

David,

I actual did the work a week ago and it became quite evident it was
pointless to restructure to that extent at this time (Dan & Tom both
laughed at me as well).  We should address this when those weird & wacky
boards come along IMHO.

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
