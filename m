From: linas@austin.ibm.com
Date: Wed, 19 Nov 2003 16:50:01 -0600
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031119165001.B34072@forte.austin.ibm.com>
References: <20031119155139.A34070@forte.austin.ibm.com> <9851EA7C-1ADC-11D8-AB84-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9851EA7C-1ADC-11D8-AB84-000A95A0560C@us.ibm.com>; from hollisb@us.ibm.com on Wed, Nov 19, 2003 at 04:06:15PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 19, 2003 at 04:06:15PM -0600, Hollis Blanchard wrote:
> On Wednesday, Nov 19, 2003, at 15:51 US/Central, linas@austin.ibm.com
> wrote:
> > Just curious,  these insn's used to be freinds, not enemies.
>
> I think they've always been the enemy of the CPU designers. At least
> that's how it was explained to me from a Motorolan, and I assume the
> same is true for IBM. And they're the ones writing the CPU manuals
> telling people not to use the instructions... :)

Depends on whose CPU designer camp you visit.

DEC Alpha strategy: pump up the clock; minimize number of gate
    delays between start of insn cycle and end of cycle.  Less
    gate delay == faster clock.

Ye olde superscalar strategy: do more per clock cycle by deploying
    more transistors (even if one must have slower clock as a result.)

The load string insn needs a big fat shift register with oodles of
gate delays right in the middle of the load/store path.  No other
insn's need or use this register.   Getting rid of it allows you
to pump up the clock.

The original POWER cpu designers clearly thought it was a worthwhile
tradeoff, otherwise it wouldn't have been in the insn set to begin
with.  But the alpha camp sure made a clear and ringing point ...

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
