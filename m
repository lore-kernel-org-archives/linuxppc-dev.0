Date: Mon, 16 Aug 1999 09:12:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Eric Dorland <dorland@lords.com>
cc: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with the atyfb driver on Power Mac G3
In-Reply-To: <l03130300b3dd08561f04@[209.226.106.245]>
Message-ID: <Pine.LNX.4.10.9908160910040.19649-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 15 Aug 1999, Eric Dorland wrote:
> >At 4:28 PM -0400 8/15/99, Eric Dorland wrote:
> >>So now atyclk works, and through some experimenting, I've found that
> >>changing the dsp_on value from 24 to 29 removes all the snow I have been
> >>experiencing, without any noticeable slow down. Hooray! Now, the problem is
> >>that this value does not get retained when switching virtual consoles, ie
> >>whenever I switch virtual consoles or start X the dsp_on value gets reset
> >>back to 24. How can I get this value to stay fixed? Should I just hardcode
> >>it into my own kernel compile?
> >
> >Probably not.  Whenever you change video modes, dsp_on and dsp_off are
> >recalculated from the new parameters; a fixed value will not be right for
> >all situations.
> 
> You're right of course. I would have to modify the calculation in some way.
> Any ideas how?

The first thing is to repeat the experiment with a few samples of the set of
zillions of video modes. Then you have to try to find a relation between all
parameters. aty_dsp_gt() in drivers/video/atyfb.c may be good start, just
assume some of the hardcoded values there are wrong.

If you find the Magic Formula, just let us know :-)

> >If you use the exact same mode (and I mean exact) on all VCs (including the
> >one X is running on), no mode switch will be performed when you change VCs,
> >which should preserve your custom dsp_on setting.
> 
> This, unfortunately, does not seem to be the case. I am using the smae mode
> in all my VCs and X and the dsp_on setting is not preserved. I think that
> the atyfb driver gets re-intialized each time I change VCs.

Atyfb always reprograms the video mode. The optimization of not doing that
wasn't implemented yet.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
