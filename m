Date: Thu, 11 Apr 2002 08:24:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020411152458.GB15663@opus.bloom.county>
References: <20020410151654.GC26754@opus.bloom.county> <0204110346.AA27237@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204110346.AA27237@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 10, 2002 at 08:46:33PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Not quite.  DINK32/PPCBug/PMON/Force firmware (pcore?)/other commerical
> > firmwares which know 0 about Linux and won't ever quite probably is the
> > 'fly in the ointment'.
>
> I disagree. StarMON also knows 0 about Linux, which is how it should be as

Fine, StarMON + ppc-boot-linux.  But this really is splitting hairs.
The problem is firmware (or firmware writers) who know about Linux and
want to boot linux from their firmware (in your case, you wrote another
program, ppc-boot-linux, to know about the linux bits) and those who
don't.

> If I've been able to make Linux/PPC boot so nicely and have one generic
> configuration with my very very no-frills firmware, I claim you've gotta be
> able to do that with other people's modern full-of-frills firmware.

What's the incentive to do something like that when it all just works
tho?

> Or you could make the zImage wrapper grep the ROM region for various strings to
> identify what board/firmware it's running on. Right now you could take your
> "simple" wrappers for different boards and merge them into one that will first
> select the board and then proceed as it does now. The only problem would be
> with board identification. Now my idea of having a board ID somewhere in the
> ROM is nothing earth-shattering, DEC has done 16 years before me, and I think
> just about company does that.

One of the real beautiful parts of the 'simple' wrapper (I wish someone
else would have came up w/ another name for it when I asked, anyhow...)
is that it doesn't care about firmware what so ever.

Hell, it could probably run on StarMON (I suspect it'd just need to have
the ELF header stripped off and loaded into a 'good' location). :)

> some convention across its boards, there nothing across *all* boards. That's
> where the grep idea comes in. I can bet that a board made by Mumbletech model
> ABC will have strings "Mumbletech" and "ABC" somewhere in the ROM. Just look
> for those magic strings and you'll know what you are running on. Past this step
> for everything else there already is a solution.

Which means for N boards (or N board mfrs) you have to add in another
bit to a file, or come up w/ some nice magic to compile all
xxx_detect.c files or something like that.

'simple' doesn't want to know about the firmware, 'simple' wants to get
Linux up and running. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
