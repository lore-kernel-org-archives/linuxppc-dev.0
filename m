From: benh@kernel.crashing.org
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	Edward Swarthout <Ed.Swarthout@Motorola.com>
Cc: <yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Mon, 4 Feb 2002 19:23:08 +0100
Message-Id: <20020204182308.21006@mailhost.mipsys.com>
In-Reply-To: <20020204175119.RDWC23298.tomts23-srv.bellnexxia.net@there>
References: <20020204175119.RDWC23298.tomts23-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>They clearly say that 7451 and 7455 do not have a settable DOZE state.
>Instead the DOZE state is just an intermediate state between the Full
>Power Mode state and the NAP state.   They have a nice event transition
>driven state diagram to illustrate all of this.   According to the manual
>the purpose of this transitory state (DOZE) is to allow bus snooping.
>There is also a SLEEP mode that is diferent from NAP (saves more power)
>and that does not ever enter the trasient DOZE state on its way back to
>the FULL Power State.

Yes, they don't have the specific DOZE mode (DOZE bit in HID0), which
is why we should split those 2 features. Some CPUs can DOZE & NAP,
some can NAP only, but some montherboard don't allow NAP because the
host bridge don't properly assert QACK to enforce cache coherency.

So instead of the current cruft, let's properly say which CPU can
do what in cputable.c. Then, in idle.c, the algorithm should be:

 if (powersave_nap && cpu_can_nap)
        nap
 else if (cpu_can_doze)
        doze
 else
        do nothing

(powersave_nap is set by pmac_feature and indicates if the motherboard
supports NAP mode & cache coherency or not).

>The differnces between NAP and SLEEP are as follows (according to the
>manual)

 (...)

Yup, this basically explains that SLEEP mode won't enforce cache coherency.
We currently don't use SLEEP mode (except eventually when putting the laptops
to sleep, which is a different matter).

>It is interesting to note that the recommended algo to enter either sleep
>or nap includes the following (again quoting from the revised manual)
>
>
>---
>10.2.4 Power Management Software Considerations
>Because the MPC7451 is a three-issue processor with out-of-order execution
>capability, care must be taken in how the power management mode is
>entered. Furthermore, nap and sleep modes require all outstanding bus
>operations to be completed before these modes are entered. Normally,
>during system configuration time, one of these power management
>modes would be selected by setting the appropriate HID0 bit. Later on, the
>mode is invoked by setting MSR[POW]. To ensure a clean transition into and
>out of a power-management mode, the mtmsr which sets the POW bit must be
>preceded by the proper cache flushes, instruction cache disable followed
>by isync, TLB invalidates, and then dssall and sync
>instructions. The sleep mode entry sequence is as follows:
>
>mtHIDO (NAP | SLEEP)
>...
>...
>dssall
>... cache flushes... (1)
>... instruction cache disable ... (2)
>isync (3)
>... TLB invalidates ... (4)
>loop    sync
>mtmsr[POW = 1]
>isync
>b loop

That's interesting. My understanding was that NAP didn't require that.
This might explains (or might not) some stability issues some people
are still having with dual 7450's.

>
>The dssall instruction is needed to kill any outstanding stream touch
>instructions not killed by a sync.

Ok, this one has to be added I beleive, probably also to the laptop
sleep code.
>
>So this looks pretty detailed and it clearly says to flush all caches
>before entering and disable the instruction cache but it does not  show
>any differences between NAP and SLEEP.
>
>So what advantage of bus snooping with NAP (that tranistions to DOZE and
>back) if you must flush all of the cache's before entering and leaving NAP
>or SLEEP?

Which makes few sense as the purpose of bus snooping is actually to keep
cache coherency. Can someone from MOTO explain ? Edward ?

>I don't understand the advantage of NAP unless the QACK(bar) signal to the
>processor is enabled for all memory writes by all other processors, DMA
>chips, etc.   Is this true for *everything* that accesses L1, L2, L3 cache?
>
>Can anyone explain what I am misunderstanding here?

Hrm... not me.... All I can say is that I currently do none of the above and
use NAP mode on my 7450 based laptop with no problem so far.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
