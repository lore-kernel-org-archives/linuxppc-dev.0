Date: Tue, 27 Mar 2001 17:36:47 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
Cc: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PVR hell
In-Reply-To: <20010327132106.15522@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10103271719590.392-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Mar 2001, Benjamin Herrenschmidt wrote:

> Hi !
>
> We have a problem..
>
> Currently we have bloat of code testing against PVR, in different ways &
> places, sometimes using constants, sometimes, not, and possibly missing
> some CPUs (in fact, we do miss some: with the 7410 used in the TiPB, we
> will miss the L2 cache and Altivec).
>
> I'd like to get this all cleaned up. The best way to acheive that is I
> beleive a bit similar to what Apple does in Darwin: a table with mask/
> value pairs used to "match' the PVR. The table will then give you the CPU
> name, eventually a pointer to some early init code, etc... and a bitmask
> of CPU "features". This bitmask can then be used for things like "has
> L2CR", "has Altivec", "has L3", "has reliable TAU", etc...

That's exactly why I did not like the solution of emulting mfpvr in user
space: applications or libraries using Altivec on a 7400 will have to be
at least recompiled when run on later processors.

For this we should define additional values in the auxiliary table which
is passed to applications and forget about emulating mfpvr (a trick I have
systematically patched out in my kernels BTW).

> The mask/value also allow, if we want it, to match against specific revs
> and if not, fallback to the generic case for a given CPU if we want a
> "feature" disabled or enabled on a given CPU rev.

BTW, there is also another feature that you forget about and for which
mfpvr is currently used (hidden in USE_RTC macro): rtc or timebase for
gettimeofday() and friends.

> I want to fix that now, as I'm already biten by this problem on the
> Titanium PowerBook, will be more with the 7450 used in new macs, and
> whatever new PPC may come out.
>
> The only thing for which I'm not too sure is where should I store that
> "feature" bitmask once the CPU has been matched during early boot. Darwin
> stores the CPU infos (including the CPU number) stuffed in an SPRG
> reserved to that for the entire kernel life. This looks like a good idea,
> but I'm not sure we have an SPRG free in our kernel. In most case,
> accessing the current CPU feature mask in memory would be harmless as
> it's really useful for one-shot operations, like tapping the L2CR.
> However, there is at least one critical place (and maybe more) which is
> testing for an altivec in the context switch code.

For this an SPRG is a waste, there are not enough. I'd rather have it in
memory, cache lines which are only or mostly read are shared among
processors and do not cause ping-pongs (unless you have MP 603/603e/750).
They are even more efficiently shared with maxbus.

> If we store it in memory, we can hard-code the location, meaning that we
> only support configs where all CPUs share the same "feature" mask and
> potentially causing cache ping-pong. Or we store it in a per-CPU
> location, effectively doubling the memory overhead (retreive CPU number
> via r2, then figure out the feature bit mask for the current CPU).
>
> For now, I'm going toward the single location in memory shared by all
> CPUs, as this is only read (never written), lowering the possibility of
> cache ping-pong, with the address of this location resolved at compile/
> link time.

I basically agree for now (the definitive solution would be a boot time
link of all the critical code, but that's a long term project).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
