Date: Fri, 14 Dec 2001 18:57:14 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, paulus@samba.org
Subject: Re: 7450 bugs & fixes
In-Reply-To: <20011129150047.11980@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.21.0112030102320.582-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry for the delay, it took me some time to try to understand all the
errata. Actually I've not yet finished, but I'm going to be without
regular net access from tonight until January 3rd or so.

On Thu, 29 Nov 2001, Benjamin Herrenschmidt wrote:

>
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

- erratum 13 ?


>
>  - errata 15: mismatched lwarx/stwcx. pairs can cause loss of
>    atomicity. That errata basically says we mustn't issue an
>    stwcx. if we didn't have a previous lwarx. That mean our
>    instance of stwcx. in the return from exception path should
>    be added an lwarx. Any other candidate spotted ?

Irrelevant as already explained.

>
>  - errata 18: seem to imply NAP/SLEEP can't be used for us on rev 2.0
>    Well, that's weird as it seem that darwin has specific workarounds
>    for another rev 2.0 errata related to NAP/SLEEP (L1 coherency lost),
>    I'll ask my Apple contact about this one. I didn't find the exact
>    errata for the L1 issue though....

and

>  - errata 39: We must stop doing any DOZE/NAP in idle.c when we have an
>    L3 cache.

I am slightly confused, but:

- only destops are affected by 39 since portables don't have L3 caches.

- the net result of 18 is that nap and sleep modes won't be entered,
which is harmless if it only affects desktops.

- however, if the processor does not actually enter nap/sleep modes, how
can it cause L3 cache corruption ? (or does it only happen if you work
around 18 by disabling interrupts and using reset/machine-check to wakeup)

I now realize that there is no explicit doze state on 7450, whether
NAP/SLEEP are entered or not depends on hardware handshake. With disabled
hardware handshake (QREQ/QACK pins IIRC), it would only enter doze mode.

>
>  - errata 23: Not sure how that one can affect us. I don't think we do
>    explicit cache flush on locations subject to snooping from external
>    HW, at least not on UP (and rev 2.0 isn't used on SMP setups afaik)

Very serious if drivers program DMA from application memory to devices
(zero copy TCP for example, raw device I/O). A malicious program could
cause a hang.

>
>  - errata 28: dcbst reserving L2 cache lines. That one is bad, as afaik,
>    it could be used by userland code to kill the L2 cache. We should
>    probably replace use of dcbst by dcbf in the kernel.

I consider that one to be much less serious than the previous one. It is
only a performance loss. I also believe that all dcbst are followed by a
sync (at least after the loop for cache flushes > 1 line).

>
>  - errata 29: do we ever switch MSR:IR off via an mtmsr ? If yes, we
>    need to add a sync, but I don't think we do.

No, because kernel is not mapped 1:1 to physical memory, doing this would
cause an implicit jump, which is prohibited by the architecture. Note that
it also solves erratum 37 (different symptom and bug, same cure).

>
>  - errata 31: BTIC corruption. This one affect only rev 2.0 which isn't
>    used on SMP. So only the UP case matters. I'm not sure what a proper
>    fix would be, maybe the isync recommended workaround. Paul ?

I am not sure about that one, but I think that the isync would be
sufficient. Motorola does not detail under which conditions the processor
might hang, which makes it hard to tell whether it is possible to get a
hang with icbi only of if it only happens in the tlbie case. Or if the
hang can only be caused in in kernel mode because it would require the
execution of an unwanted supervisor instruction (spurious mtmsr for
example). Typical cache flush routines do not have 2 branches between icbi
and isync AFAICT and are not affected, so whether you can cause a hang
from applications or not is the fundamental question.


I still don't follow very well the Motorola explanation that icbi can be
used by applications and therefore the solution may be impossible to
implement: AFAIR after an icbi or string of icbi instructions, an isync
(actually a context synchronizing instruction) is compulsory to avoid
stale instruction in the (potentially infinitely long) instruction
prefetch queue.

erratum 36 ?

>
>  - errata 38: Should be worked around in HW by Apple on SMP macs using
>    7450 2.1. Other machines may need to implement software tablewalk
>    instead though (beware of other erratas related to using software
>    tablewalk then ;)
>

I don't understand how they can do a hardware workaround on that one!

>
>  - errata 47: dcbz vs. snoop hang. I need some more input on this one
>    we may have to disable store gathering when we have an L3 cache...

It looks insufficient, since I understand that it could be used by
malicious application to cause a hang, more or less in the same way as
erratum 23.


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
