From: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
To: <linuxppc-commit@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: PVR hell
Date: Tue, 27 Mar 2001 15:21:06 +0200
Message-Id: <20010327132106.15522@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

We have a problem..

Currently we have bloat of code testing against PVR, in different ways &
places, sometimes using constants, sometimes, not, and possibly missing
some CPUs (in fact, we do miss some: with the 7410 used in the TiPB, we
will miss the L2 cache and Altivec).

I'd like to get this all cleaned up. The best way to acheive that is I
beleive a bit similar to what Apple does in Darwin: a table with mask/
value pairs used to "match' the PVR. The table will then give you the CPU
name, eventually a pointer to some early init code, etc... and a bitmask
of CPU "features". This bitmask can then be used for things like "has
L2CR", "has Altivec", "has L3", "has reliable TAU", etc...

The mask/value also allow, if we want it, to match against specific revs
and if not, fallback to the generic case for a given CPU if we want a
"feature" disabled or enabled on a given CPU rev.

I want to fix that now, as I'm already biten by this problem on the
Titanium PowerBook, will be more with the 7450 used in new macs, and
whatever new PPC may come out.

The only thing for which I'm not too sure is where should I store that
"feature" bitmask once the CPU has been matched during early boot. Darwin
stores the CPU infos (including the CPU number) stuffed in an SPRG
reserved to that for the entire kernel life. This looks like a good idea,
but I'm not sure we have an SPRG free in our kernel. In most case,
accessing the current CPU feature mask in memory would be harmless as
it's really useful for one-shot operations, like tapping the L2CR.
However, there is at least one critical place (and maybe more) which is
testing for an altivec in the context switch code.

If we store it in memory, we can hard-code the location, meaning that we
only support configs where all CPUs share the same "feature" mask and
potentially causing cache ping-pong. Or we store it in a per-CPU
location, effectively doubling the memory overhead (retreive CPU number
via r2, then figure out the feature bit mask for the current CPU).

For now, I'm going toward the single location in memory shared by all
CPUs, as this is only read (never written), lowering the possibility of
cache ping-pong, with the address of this location resolved at compile/
link time.

Any comment ?

Note: This _is_ a _2_4 thing, I'm really tired of the PVR mess in the
current code. We have bits in head.S, misc.S, ppc_htab.c, entry.S,
setup.c, pmac_setup.c, maybe more, with not always complete tables, some
of them only recently updated for G4, all of them missing the 7410 (I
don't even think about the 7450), etc...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
