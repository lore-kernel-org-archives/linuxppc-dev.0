Date: Tue, 11 Jul 2000 14:38:25 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, cort@fsmlabs.com
Subject: Re: 2.4.0-test3
In-Reply-To: <20000711104105.21032@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10007111341520.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:

> >
> >Now imagine here that IBAT3U is zero (I think the code is executing in
> >1:1 mapped mode here). You just have set IBATL on a 601 hence the valid
> >flag and you temporarily have a mapping that says:
> >
> >(1st 8 Mb of virtual address space) -> video memory
> >
> >what happens if the instruction fetcher decides to start loading a cache
> >line (executing from video memory) ? Might it also depending on firmware,
> >create a multiple BAT match (which is a definitive no-no) ?
>
> Well, in theory, this code is run with MMU off.

Possibly, I'm still trying to access this damned bk repository (anybody
know what happens to the net today or is is just me ?) to see the code.
I don't see how you can run into problems then. But the 601 is known to
occasionally exhibit some strange behaviour. Anyway I don't have any Mac
to test (hope to get an old 601 based one soon).

> Ok, I'll flip them anyway.
>
> >Oh and please add an isync before and after touching the BATS, this is
> >required by the architecture (as I've indicated with my hand made pseudo
> >unified diffs).
> >
> >The fact that the valid bits are BATL on 601 and BATU on the other makes
> >all the BAT manipulation extremely delicate. Maybe it would be better for
> >robustness not to try to save a few instructions and have 2 completely
> >different code paths...
>
> Well, I'll try that. But again, the MMU is supposed to be off at this point.

In this case, are we sure that the 601 problems are introduced by this
change ? Historically, there have been other 601 related problems, like
code touching HID0 without checking processor version or so.

Another possibility is an ordering problem, it seems that the code
reloads all the BATs from the BAT array setup by mm/init.c. Is it possible
that the crash happens this late and do you still need BAT3 after this ?

Maybe the fix will be as simple as writing 0 to the IBATL in LOAD_BAT so
that we are sure that the BAT is disabled before being reloaded, or call
again clear_bats before the series of LOAD_BATs.

> >Besides looking at load_bat macros, the comment does not quite exactly
> >reflect the code and might crash on 601:
> >/* 601 only have IBAT cr0.eq is set on 601 when using this macro */
> >It should be reordered, even if slightly bigger. I believe that, once upon
> >a time, there was a LOAD_601_BAT macro.
> >#define LOAD_BAT(n, offset, reg, RA, RB) \
> >        /* see the comment for clear_bats() -- Cort */ \
> >        li      RA,0;                   \
> >        mtspr   IBAT##n##U,RA;          \
> >        mtspr   DBAT##n##U,RA;          \   <-- Wrong, might crash 601 !
> >        lwz     RA,offset+0(reg);       \
> >        lwz     RB,offset+4(reg);       \
> >        mtspr   IBAT##n##U,RA;          \
> >        mtspr   IBAT##n##L,RB;          \
> >        beq     1f;                     \
> >
> >This should be fixed but it seems to be there since so long...
> >
> >I don't know whether one of the chunks of code that I suspect is the
> >source of the problem, but they might well be.
>
> Ok, that would cause a crash when loading the BAT after MMU is re-
> enabled. Cort, what's your explanation ?

Or at any time AFAICS, trying to access a DBAT (a non existent SPR on a
601) is strictly prohibited, the processor can do anything it wants
although my 601 doc says for mtspr that "if the SPR field contains an
invalid value, the instruction is treated as a nop". So the LOAD_BAT macro
looks safe (but not clean and I can't stand comments which obviously
disagree with the code).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
