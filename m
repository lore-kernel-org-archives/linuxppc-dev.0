From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>, <paulus@samba.org>
Subject: Re: 7450 bugs & fixes
Date: Fri, 14 Dec 2001 20:19:20 +0100
Message-Id: <20011214191920.4144@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.21.0112030102320.582-100000@ltgp.iram.es>
References: <Pine.LNX.4.21.0112030102320.582-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>  - errata 18: seem to imply NAP/SLEEP can't be used for us on rev 2.0
>>    Well, that's weird as it seem that darwin has specific workarounds
>>    for another rev 2.0 errata related to NAP/SLEEP (L1 coherency lost),
>>    I'll ask my Apple contact about this one. I didn't find the exact
>>    errata for the L1 issue though....
>
>and
>
>>  - errata 39: We must stop doing any DOZE/NAP in idle.c when we have an
>>    L3 cache.
>
>I am slightly confused, but:
>
>- only destops are affected by 39 since portables don't have L3 caches.

Yes.

>- the net result of 18 is that nap and sleep modes won't be entered,
>which is harmless if it only affects desktops.

Yes. I changed the kernel to not have the DOZE/NAP capability at all
on rev 2.0 chips to avoid confusion.

>- however, if the processor does not actually enter nap/sleep modes, how
>can it cause L3 cache corruption ? (or does it only happen if you work
>around 18 by disabling interrupts and using reset/machine-check to wakeup)

Revision 2.1 can enter NAP and some desktops use 2.1 and L3. I modified
the setup_7450 function in head.S to clear the DOZE/NAP capability when
L3 has been enabled by the firmware.

>I now realize that there is no explicit doze state on 7450, whether
>NAP/SLEEP are entered or not depends on hardware handshake. With disabled
>hardware handshake (QREQ/QACK pins IIRC), it would only enter doze mode.

Who know what undocumented HW does ? :)
>>
>>  - errata 23: Not sure how that one can affect us. I don't think we do
>>    explicit cache flush on locations subject to snooping from external
>>    HW, at least not on UP (and rev 2.0 isn't used on SMP setups afaik)
>
>Very serious if drivers program DMA from application memory to devices
>(zero copy TCP for example, raw device I/O). A malicious program could
>cause a hang.

Yes
>>
>>  - errata 28: dcbst reserving L2 cache lines. That one is bad, as afaik,
>>    it could be used by userland code to kill the L2 cache. We should
>>    probably replace use of dcbst by dcbf in the kernel.
>
>I consider that one to be much less serious than the previous one. It is
>only a performance loss. I also believe that all dcbst are followed by a
>sync (at least after the loop for cache flushes > 1 line).

Ok.

>>  - errata 29: do we ever switch MSR:IR off via an mtmsr ? If yes, we
>>    need to add a sync, but I don't think we do.
>
>No, because kernel is not mapped 1:1 to physical memory, doing this would
>cause an implicit jump, which is prohibited by the architecture. Note that
>it also solves erratum 37 (different symptom and bug, same cure).

Yup. I just wanted to ask anyway ;) Maybe some early bootloaders do that.

>>  - errata 31: BTIC corruption. This one affect only rev 2.0 which isn't
>>    used on SMP. So only the UP case matters. I'm not sure what a proper
>>    fix would be, maybe the isync recommended workaround. Paul ?
>
>I am not sure about that one, but I think that the isync would be
>sufficient. Motorola does not detail under which conditions the processor
>might hang, which makes it hard to tell whether it is possible to get a
>hang with icbi only of if it only happens in the tlbie case. Or if the
>hang can only be caused in in kernel mode because it would require the
>execution of an unwanted supervisor instruction (spurious mtmsr for
>example). Typical cache flush routines do not have 2 branches between icbi
>and isync AFAICT and are not affected, so whether you can cause a hang
>from applications or not is the fundamental question.
>
>
>I still don't follow very well the Motorola explanation that icbi can be
>used by applications and therefore the solution may be impossible to
>implement: AFAIR after an icbi or string of icbi instructions, an isync
>(actually a context synchronizing instruction) is compulsory to avoid
>stale instruction in the (potentially infinitely long) instruction
>prefetch queue.
>
>>  - errata 38: Should be worked around in HW by Apple on SMP macs using
>>    7450 2.1. Other machines may need to implement software tablewalk
>>    instead though (beware of other erratas related to using software
>>    tablewalk then ;)
>>
>
>I don't understand how they can do a hardware workaround on that one!

I don't neither, they didn't give me any detail. Could they catch
icache misses on the bus and delay incoming tlbie (freezing the emitter)
when that happen ? I don't know the bus protocol ...

>>  - errata 47: dcbz vs. snoop hang. I need some more input on this one
>>    we may have to disable store gathering when we have an L3 cache...
>
>It looks insufficient, since I understand that it could be used by
>malicious application to cause a hang, more or less in the same way as
>erratum 23.

Hrm...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
