Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 76DF5679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 06:24:44 +1000 (EST)
Date: Fri, 5 May 2006 13:24:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: Calculating virtual address from physical address
Message-ID: <20060505132441.B30563@cox.net>
References: <445B6A80.2090202@ics-ltd.com> <445BA736.30208@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <445BA736.30208@246tNt.com>;
	from tnt@246tNt.com on Fri, May 05, 2006 at 09:27:50PM +0200
Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 05, 2006 at 09:27:50PM +0200, Sylvain Munaut wrote:
> Chris Dumoulin wrote:
> > I'm using a Virtex II Pro-based board with a PPC405. The board is 
> > hanging somewhere very early in the kernel boot process. I believe it 
> > may be dying at the point where the MMU is enabled. In order to 
> > determine the exact point at which my board hangs, I'm blinking two LEDs 
> > in the assembly code found in arch/ppc/kernel/head_4xx.S, . Currently I 
> > am only able to successfully access the LEDs before the MMU is turned 
> > on, but I can't be sure that I'm calculating the virtual address 
> > properly when I try to access the LED after the MMU is turned on.
> 
> Typical when trying to bring up board ...
> 
> Once the MMU is turned on, you leds register are most likely ... nowhere
> ... i.e.
> if you don't create a mapping your self there is just no virtual address
> that will
> access your leds physical address.
> 
> What I did on some ppc work was tu use a quick BAT mapping to map some leds.
> It's pretty easy to setup. Be aware though that this mapping will get
> wiped out when
> the kernel sets up the BAT for itself.

There are no BATs on 4xx. However, the same conceptual thing can be
done by wiring a fixed TLB entry to cover those LEDs temporarily
during bringup debug.  The temporary TLB entry will be wiped out by
normal tlb misses after things are running whenever the fixed entry
is clobbered by the round robin replacement.

-Matt
