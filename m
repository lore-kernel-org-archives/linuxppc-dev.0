Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Mon, 4 Feb 2002 12:57:20 -0500
References: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there> <20020202201115.17827@smtp.wanadoo.fr>
In-Reply-To: <20020202201115.17827@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20020204175119.RDWC23298.tomts23-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

Okay the following is a bit over my head.  So any helpful hints welcomed
from anyone!

>Then go figure if the L3 is also incompatible with
> NAP mode or not. If it is not, you can strip the code that clears
> the "can DOZE" feature. Note that ideally, we should change that
> code to be 2 different feature bits, one for can DOZE, and one for
> can NAP (as the 7450/55 can only NAP, not DOZE).
> You can change that easily, basically define the new bit for NAP
> in cputable.h, set it for all CPUs (except 7450 rev 2.0) in
> cputable, and remove DOZE capability from 7450/55. Once done,
> tweak the code in arch/ppc/kernel/idle.c so that it does power
> save if either of these bits is set, but also make sure it does
> not try to NAP if powersave_nap isn't set (as some host bridges
> can't handle it, it will be set properly by pmac_feature).
> If your CPU can't DOZE but can NAP, but powersave_nap is false,
> do nothing.

I just finished reading Section 10.2 of the newly revised 7450 family User
Manual (that thing is over 800 pages long).

They clearly say that 7451 and 7455 do not have a settable DOZE state.
Instead the DOZE state is just an intermediate state between the Full
Power Mode state and the NAP state.   They have a nice event transition
driven state diagram to illustrate all of this.   According to the manual
the purpose of this transitory state (DOZE) is to allow bus snooping.
There is also a SLEEP mode that is diferent from NAP (saves more power)
and that does not ever enter the trasient DOZE state on its way back to
the FULL Power State.

The differnces between NAP and SLEEP are as follows (according to the
manual)

---
10.2.2 Nap Mode
...
 Because the processor is in nap mode, the system
causes the processor to enter doze state by negating QACK(bar). The
processor snoops bus operations and performs appropriate memory coherency
operations while in the doze mode. When the system reasserts QACK(bar),
the processor returns to the nap mode after completing any memory
operations.
---

versus

---
10.2.3 Sleep Mode
The sleep mode disables all clocking in the MPC7451. The PLL remains
locked for fast wake response. The JTAG logic remains operational. Note
that the MPC7451 does not enter doze state to snoop if it is in sleep
mode. Caches must be flushed to guarantee cache coherency if other system
components access memory while the MPC7451 is sleeping.
---


It is interesting to note that the recommended algo to enter either sleep
or nap includes the following (again quoting from the revised manual)


---
10.2.4 Power Management Software Considerations
Because the MPC7451 is a three-issue processor with out-of-order execution
capability, care must be taken in how the power management mode is
entered. Furthermore, nap and sleep modes require all outstanding bus
operations to be completed before these modes are entered. Normally,
during system configuration time, one of these power management
modes would be selected by setting the appropriate HID0 bit. Later on, the
mode is invoked by setting MSR[POW]. To ensure a clean transition into and
out of a power-management mode, the mtmsr which sets the POW bit must be
preceded by the proper cache flushes, instruction cache disable followed
by isync, TLB invalidates, and then dssall and sync
instructions. The sleep mode entry sequence is as follows:

mtHIDO (NAP | SLEEP)
...
...
dssall
... cache flushes... (1)
... instruction cache disable ... (2)
isync (3)
... TLB invalidates ... (4)
loop    sync
mtmsr[POW = 1]
isync
b loop


The dssall instruction is needed to kill any outstanding stream touch
instructions not killed by a sync.
----

So this looks pretty detailed and it clearly says to flush all caches
before entering and disable the instruction cache but it does not  show
any differences between NAP and SLEEP.

So what advantage of bus snooping with NAP (that tranistions to DOZE and
back) if you must flush all of the cache's before entering and leaving NAP
or SLEEP?

I don't understand the advantage of NAP unless the QACK(bar) signal to the
processor is enabled for all memory writes by all other processors, DMA
chips, etc.   Is this true for *everything* that accesses L1, L2, L3 cache?

Can anyone explain what I am misunderstanding here?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
