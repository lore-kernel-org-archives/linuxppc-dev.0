Date: Mon, 16 Dec 2002 13:36:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based))
Message-ID: <20021216203606.GB2513@opus.bloom.county>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com> <20021215174120.E30568@duath.fsmlabs.com> <20021216150442.GJ6095@opus.bloom.county> <20021216124931.B9431@duath.fsmlabs.com> <20021216201301.GA2513@opus.bloom.county> <20021216131340.D9431@duath.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216131340.D9431@duath.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 01:13:40PM -0700, Cort Dougan wrote:
``
> Right, changes would keep going.  Having many trees all based on the same
> root would make moving patches back and forth much easier.

It's irrelevant what they're based on, Marcelo would never pull from the
'linux-2.4-4xx-walnut' tree, nor the 'linux-2.4-4xx' tree, as there will
be lots of "whoops, lets try it this way now" stuff, etc.

> People would be able to grab what they need (a booting walnut, for example)
> without pulling in >1 years worth of development and unstable changes.  I
> definitely think it would be useful.

But that's just it, the >1 year of "development and unstable changes" is
4xx.  The largest problem with the _devel tree right now is that once
something becomes stable it hasn't moved up and out to Marcelo (and in
some cases, Linus).  It's not because things can't be taken out, it's
been around 80% time / timing, 15% style / cleanliness / minor tweaking,
and maybe 5% of actual unstable code.

> } But more trees with smaller patches doesn't mean that the 'growth'
> } stops.  Furthermore, there's only 4 things in _devel right now:
> } 1) 4xx - It's "stable", in that there haven't been any big changes for
> } some time, and as far as I know few "bugs".  But there's still a lot to
> } be done.
>
> Exactly my point.  It's mired in the next of _devel right now but should be
> shoved up into the stable tree.

4xx should not be shoved up into the 'stable' tree as it's not ready for
Marcelo.  I fully expect Paul to want a largescale backport of a lot of
what's been done in 2.5 for 4xx, once it's done.

> } 3) OpenPIC / i8259 cleanups, some backported from 2.5 some original, all
> } of which is quite stable right now.  There's just boards which need
> } updating still (!!!).  This is ready to go up and out, and will move a
> } large chunk of code out of _devel with it.
> } 4) gt64260 support.  What's in _devel now is stale, and this doesn't
> } depend on anything in _devel now anyhow.  FWIW, this exists in its own
> } tree anyways :)
>
> All the more reason for a linuxppc_2_4_galileo tree.

Where it has been for some time.  IIRC, the linuxpcp_2_4_galileo tree is
rather stable, but in this case it's 99% time of why it hasn't been put
back into _devel where it's more noticable to Paul.

> } Far too much division, which also makes moving things up more painful as
> } each one will conflict on the cpu-specific stuff, the config.in entry,
> } etc.
>
> I don't think so.  It just illustrates what is already the case - it's just
> not organized.  Each BK tree is its own node in that graph I drew.  This
> just formalizes it a bit so people know where to push/pull from when they
> want a specific thing.

But that's just it, the specific thing most people want is a stable 40x
tree so they can modify things for their own custom port.  If all of the
40x code is in one place perhaps they will pick up on a similar change
another port needed, and potentially encourage them to think generically
for some quirk they hit.

Which reminds me of another issue, if we have too many trees things it
makes it even harder to get Paul to potentially notice code and comment
on things.

> } But regardless of all of that, there's nothing related to this being a
> } 'marcelo' tree or not as you can't pick and choose bk csets without
> } everything preceeding it.  Ideally we can get to the point of not really
> } needing a seperate tree like 2.2 is (which could go if someone wants to
> } sit down and think about the LongTrail-specific changes in there).
>
> Is there a point to this not being based on the Marcelo tree?  A good
> cleanout and shift over to it is certainly worthwhile.

A "good cleanout" is bad as we loose all of that history.  It came in
quite handy for me to have a copy of the old linuxppc_2_3 and
linuxppc_2_5 trees (until that drive died) when trying to figure out why
something was done.  I really don't want to see that happen again for
2.4.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
