Date: Tue, 27 Nov 01 12:40:45 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111272040.AA24978@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Yes, but where is what I'm asking.

I don't understand this question.

> Right.  And what's a good place to put them?

I don't think there is one answer that will satisfy everyone. Each booter
should be able to put them where it wants and tell the kernel where that is.

Right now I put them in the memory belonging to my booter.

> Okay.  If I'm reading all of this your bi_recs end up in the middle of
> where you're run from, yes?

Yes, and that's the way I want it.

> This has the same problem that the wrapper
> does in that it's possible to overwrite these, if you're run in a bad
> spot.

What do you mean by "if you're run in a bad spot"? My code is statically linked
at 0x800000 and always runs there (this is all with translation disabled). I
assume 8 MB is more than enough for the kernel.

> No, I want to have the wrapper put the bi_recs there and suggest that
> other people who're doing bootloaders do likewise in 2.5, IF this makes
> sense as a good place to put them and they can't be overwriten by the
> kernel bss.

And why not instead give bootloader developers the freedom to put them
elsewhere if they want to?

> I've been thinking, and one of two things could happen, at least in the
> wrapper, we know mem size (Firmware, res data, magic).  Or assume
> there's at least XX megs of ram on the system (I _think_ 16mb is the
> 'normal' min, but of course we have lots of systems breaking that rule).
>
> What I'd like to see, and at least I think would be a good thing to
> figure out is a general 'safe' location to store these in.

Again, all this strikes me as unnecessary trouble. Just have the bootloader
tell the kernel where the bi_recs are! If you are concerned that your current
location for them could get overwritten by the kernel, just make your wrapper
do the same thing my booter does: store them at the wrapper's end symbol, not
the kernel's. Your wrapper runs at 0x800000 just like my booter, so I guess you
are not expecting the kernel image to exceed 8 MB, so I don't see the problem.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
