Date: Mon, 16 Dec 2002 13:13:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: PPC Tree structures (Was, at some point: Re: Support for Arctic platform (405LP based))
Message-ID: <20021216201301.GA2513@opus.bloom.county>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com> <20021215174120.E30568@duath.fsmlabs.com> <20021216150442.GJ6095@opus.bloom.county> <20021216124931.B9431@duath.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216124931.B9431@duath.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 12:49:31PM -0700, Cort Dougan wrote:
> } I'm not sure how that would stop the growth of the '_devel' tree, it
> } would just split it up into 4xx, and everything else.  And my goal of
> } the new few weeks is to try and move everything that's not 4xx that I
> } can get my hands on to test into the _2_4 tree.  I'm not sure just how
> } much of that I'll actually be able to do, but I'm going to try.
>
> There would be no _devel tree in that case.  They'd all be based on
> Marcelo's so moving back and forth would be easier.  There would also be
> more trees and smaller patches.

But more trees with smaller patches doesn't mean that the 'growth'
stops.  Furthermore, there's only 4 things in _devel right now:
1) 4xx - It's "stable", in that there haven't been any big changes for
some time, and as far as I know few "bugs".  But there's still a lot to
be done.
2) 8xx - This can quite probably all go right on up and out, pending
time.
3) OpenPIC / i8259 cleanups, some backported from 2.5 some original, all
of which is quite stable right now.  There's just boards which need
updating still (!!!).  This is ready to go up and out, and will move a
large chunk of code out of _devel with it.
4) gt64260 support.  What's in _devel now is stale, and this doesn't
depend on anything in _devel now anyhow.  FWIW, this exists in its own
tree anyways :)

> Right now, if you want an embedded board to boot your only chance is to try
> the wildly divergent - likely unstable - _devel tree.

But that's just it, it's not "likely unstable" and with a few exceptions
noted above hasn't been for some time (it's either fine or non-compiling
iirc).

> Having something
> like this would be much nicer:
>
>
> marcelo ---> linuxppc_2_4 --- linuxppc_2_4_4xx
>                   |                 |
> 		  |		    ---> linuxppc_2_4_4xx_walnut
> 		  |		    |
> 		  |		    ---> linuxppc_2_4_4xx_crazystuff
> 		  |		    |
> 		  |		    ---> linuxppc_2_4_4xx_some_whacky_port

Far too much division, which also makes moving things up more painful as
each one will conflict on the cpu-specific stuff, the config.in entry,
etc.

But regardless of all of that, there's nothing related to this being a
'marcelo' tree or not as you can't pick and choose bk csets without
everything preceeding it.  Ideally we can get to the point of not really
needing a seperate tree like 2.2 is (which could go if someone wants to
sit down and think about the LongTrail-specific changes in there).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
