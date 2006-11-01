Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <454902F9.20206@bplan-gmbh.de>
References: <454902F9.20206@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 09:12:18 +1100
Message-Id: <1162419138.25682.453.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My only remaining comment is what I said earlier about the way you
divided the interrupt in levels.

In fact, I've finally dug into the doc and found out that the situation
is even less clear :)

The whole point of this division is to avoid special cases and properly
deal with the separation in different HW registers. We have basically 4
register sets controlling irqs:

 - intr->ctrl
 - intr->main_mask
 - intr->per_mask
 - sdma (different device)

Now, your current setup ends up defining a "level" and 5 irq_chips !!!

 - intr->ctrl bit 11 has it's own chip
 - intr->ctrl other bits or intr->main_mask (2 different chips)
 - intr->per_mask a chip 
 - sdma a chip

which seems to totally gross since the first one is basically "main" irq
0, and has no reason whatsoever to be kept separate from "main". Which
would give us something much more sensible with 4 levels and 4 chips:

 - intr->ctrl based interrupts (crit and main, crit being just main 0)
 - intr->main_mask
 - intr->per_mask
 - sdma

In that case, you have a nice 1 level == 1 irq_chip == one register set.

Now, in addition to that, we have another issue I haven't spotted
before, but it might be worth considering:

Do we actually want the sdma interrupts handled there ? Because if you
look closely, the SDMA is basically a cascaded interrupt controller. It
hangs of per interrupt 0 :)

Thus we could simply remove the code for it from that driver and
implement it as as separate controller with a separate interrupt domain.
I know you won't like that idea because it means having a different
interrupt tree but it's worth having the discussion.

Ben.
