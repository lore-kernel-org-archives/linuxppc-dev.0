From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sysctl support for ICTC
Date: Tue, 12 Sep 2000 22:55:47 +0200
Message-Id: <20000912205547.30777@192.168.1.10>
In-Reply-To: <200009122044.WAA00841@piglet.grunz.lu>
References: <200009122044.WAA00841@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>As an exercise ;-), I've added sysctl support for controlling and
>displaying the contents of the G3 (and G4?) ICTC register.

Heh ! Nice ;) That's something I've wanted to do for years and never
ended up actually coding ;)

>What this register does: it slows down the rate at which instruction are
>taken out of the L1 instruction cache for execution. Bit 31 (lowets bit)
>enables the feature, the next 8 bits (23-31) define the number of clock
>cycles to wait between instruction fetches.
>
>Why it is useful: when combined with DPM (dynamic power management), the
>effect of reducing the instrucion fetch rate is that DPM will more often
>shut down the various execution units while being idle, thus reducing
>power consumption and heat dissipation. This is good for battery life in
>portable applications, since there's less power consumed in the
>processor, and the fan can stay off (if combined with temperature
>monitoring).
>
>So, managing ICTC could be part of an intelligent apmd-style daemon
>specifically for PPC.

Well, I didn't think about that aspect of things with DPM.

The Darwin code has complete temperature control and uses the ICTC to
regulate it. That could be done from userland too on linux, by also
adding some support for the temp. registers.

>If anyone wants to go ahead and implement that daemon, attached is the
>ICTC part already ;-) It's a patch against kernel.org 2.2.17. It is
>nothing intelligent, rather a copy of the existing l2cr support. It adds
>an entry under the proc filesystem:

Well, put it on sourceforge, and if noone picks it up, I'll merge it one
of these days.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
