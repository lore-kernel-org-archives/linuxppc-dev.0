From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Cc: <cort@fsmlabs.com>
Subject: Re: 2.4.0-test3
Date: Tue, 11 Jul 2000 12:41:05 +0200
Message-Id: <20000711104105.21032@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10007111104060.9548-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10007111104060.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Now imagine here that IBAT3U is zero (I think the code is executing in
>1:1 mapped mode here). You just have set IBATL on a 601 hence the valid
>flag and you temporarily have a mapping that says:
>
>(1st 8 Mb of virtual address space) -> video memory
>
>what happens if the instruction fetcher decides to start loading a cache
>line (executing from video memory) ? Might it also depending on firmware,
>create a multiple BAT match (which is a definitive no-no) ?

Well, in theory, this code is run with MMU off.

>That's a single instruction slot, yes, but it may hurt. Simply swapping
>these instructions might solve the problem since you are not supposed to
>access the display virtual address at this time, it will have a transient
>mapping:
>
>(video memory) -> first 8 Mb of physical memory
>
>but it sounds harmless.

Ok, I'll flip them anyway.

>Oh and please add an isync before and after touching the BATS, this is
>required by the architecture (as I've indicated with my hand made pseudo
>unified diffs).
>
>The fact that the valid bits are BATL on 601 and BATU on the other makes
>all the BAT manipulation extremely delicate. Maybe it would be better for
>robustness not to try to save a few instructions and have 2 completely
>different code paths...

Well, I'll try that. But again, the MMU is supposed to be off at this point.

>Besides looking at load_bat macros, the comment does not quite exactly
>reflect the code and might crash on 601:
>/* 601 only have IBAT cr0.eq is set on 601 when using this macro */
>It should be reordered, even if slightly bigger. I believe that, once upon
>a time, there was a LOAD_601_BAT macro.
>#define LOAD_BAT(n, offset, reg, RA, RB) \
>        /* see the comment for clear_bats() -- Cort */ \
>        li      RA,0;                   \
>        mtspr   IBAT##n##U,RA;          \
>        mtspr   DBAT##n##U,RA;          \   <-- Wrong, might crash 601 !
>        lwz     RA,offset+0(reg);       \
>        lwz     RB,offset+4(reg);       \
>        mtspr   IBAT##n##U,RA;          \
>        mtspr   IBAT##n##L,RB;          \
>        beq     1f;                     \
>
>This should be fixed but it seems to be there since so long...
>
>I don't know whether one of the chunks of code that I suspect is the
>source of the problem, but they might well be.

Ok, that would cause a crash when loading the BAT after MMU is re-
enabled. Cort, what's your explanation ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
