From: linas@austin.ibm.com
Date: Wed, 19 Nov 2003 15:51:39 -0600
To: David Edelsohn <dje@watson.ibm.com>
Cc: benh@kernel.crashing.org, Olaf Hering <olh@suse.de>,
	Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031119155139.A34070@forte.austin.ibm.com>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <benh@kernel.crashing.org> <200311162304.hAGN4CT32140@makai.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311162304.hAGN4CT32140@makai.watson.ibm.com>; from dje@watson.ibm.com on Sun, Nov 16, 2003 at 06:04:11PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 16, 2003 at 06:04:11PM -0500, David Edelsohn wrote:
>
> >>>>> Benjamin Herrenschmidt writes:
>
> Ben> I remember beeing regulary told (I think by Apple while I was still
> Ben> doing MacOS hacking) that those string instructions were evil,
> Ben> deprecated, and should be avoided as they weren't peforming better
> Ben> than the equivalent set of load/store instructions... Is this
> Ben> still true ? In which case we may want to avoid generating them
> Ben> from gcc..
>
> 	The information that you received about lwsi are overly
> simplistic.  The instructions are neither overly good nor overly bad --
> they should not be used for everything, but neither should they be avoided
> at all cost.  They are particularly good for producing compact code and
> preserving the instruction cache.  Remember, programming, including
> assembly language programming, is an art.

Back in ye olde dayes, these insns were way better (by a factor of 3x)
for doing load/stores to i/o space, cause they could pump out a word
every bus cycle as opposed to every 3 cycles (due to pipeline stalls).

I guess things like G5, etc. now have enough load/store units and
etc. hardware that this is no longer an issue?  So that if I wanted
to, I could PIO fast enough to e.g. keep a pci bus saturated?
(We used PIO in ye olde days for dynamic data that would have gone
stale by the time a dma was set up and run.)  Just curious,  these
insn's used to be freinds, not enemies.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
