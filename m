Message-ID: <3C153D33.353AC3C8@wvi.com>
Date: Mon, 10 Dec 2001 14:54:44 -0800
From: Jim <jrp@wvi.com>
Reply-To: jrp@wvi.com
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, paulus@samba.org
Subject: Re: 7450 bugs & fixes
References: <20011129150047.11980@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm working on an embedded project that has two 7450's.

Is anyone else doing any 7450 SMP work (perhaps on the new dual 800
PowerMac's)?
Also, do any of our more experienced people have any tips or helpful
thoughts -- particularly the area of interrupts?  Thanks a bunch.


> After reading the 7450 errata book, I'm now trying to figure out
> what need to be done for our kernel to work properly on these.
> I'd appreciate any input from other people here as some of the
> errata exact consequences aren't that clear to me.
>
> I've figured out so far that we need to handle 7450's as far as
> rev 2.0 included. Apple seem to be the company who used the earliest
> ones in released products and according to the infos I got from them,
> they used rev 2.0 on uniprocessor desktop machines only, and rev. 2.1
> on SMP machines & laptops. They also seem to have developed a HW
> workaround for errata #38 making safe the use of the HW hashtable
> loopkups on rev. 2.1 CPUs. (at least according to an Apple engineer
> I contacted on the Darwin mailing list).
>
> Here are the errata I think we are concerned about. I didn't list
> errata for things I beleive we don't use so far, like L3 flush assist,
> but those may have impacts I didn't foresee.
>
>  - errata 15: mismatched lwarx/stwcx. pairs can cause loss of
>    atomicity. That errata basically says we mustn't issue an
>    stwcx. if we didn't have a previous lwarx. That mean our
>    instance of stwcx. in the return from exception path should
>    be added an lwarx. Any other candidate spotted ?
>
>  - errata 18: seem to imply NAP/SLEEP can't be used for us on rev 2.0
>    Well, that's weird as it seem that darwin has specific workarounds
>    for another rev 2.0 errata related to NAP/SLEEP (L1 coherency lost),
>    I'll ask my Apple contact about this one. I didn't find the exact
>    errata for the L1 issue though....
>
>  - errata 23: Not sure how that one can affect us. I don't think we do
>    explicit cache flush on locations subject to snooping from external
>    HW, at least not on UP (and rev 2.0 isn't used on SMP setups afaik)
>
>  - errata 28: dcbst reserving L2 cache lines. That one is bad, as afaik,
>    it could be used by userland code to kill the L2 cache. We should
>    probably replace use of dcbst by dcbf in the kernel.
>
>  - errata 29: do we ever switch MSR:IR off via an mtmsr ? If yes, we
>    need to add a sync, but I don't think we do.
>
>  - errata 31: BTIC corruption. This one affect only rev 2.0 which isn't
>    used on SMP. So only the UP case matters. I'm not sure what a proper
>    fix would be, maybe the isync recommended workaround. Paul ?
>
>  - errata 38: Should be worked around in HW by Apple on SMP macs using
>    7450 2.1. Other machines may need to implement software tablewalk
>    instead though (beware of other erratas related to using software
>    tablewalk then ;)
>
>  - errata 39: We must stop doing any DOZE/NAP in idle.c when we have an
>    L3 cache.
>
>  - errata 47: dcbz vs. snoop hang. I need some more input on this one
>    we may have to disable store gathering when we have an L3 cache...
>
> That's all for now (pfffeww....), I'd recommend anybody who want some
> cold fever to read that errata document, available from moto web site.
>
> Ben.
>

--
Sincerely,

Jim Potter
45th Parallel Processing
(503) 769-9138
jrp@wvi.com

  Those that would give up a necessary freedom for
  temporary safety deserve neither freedom nor safety.
    -- Ben Franklin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
