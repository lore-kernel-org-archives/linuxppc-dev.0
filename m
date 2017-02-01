Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCvW31yvbzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 18:13:51 +1100 (AEDT)
Message-ID: <1485933206.2953.19.camel@kernel.crashing.org>
Subject: Re: Timekeeping oddities on MacMini G4s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hal Murray <hmurray@megapathdsl.net>
Cc: Hugh Blemings <hugh@blemings.org>, linuxppc-dev@ozlabs.org,
 devel@ntpsec.org, Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <michael@ellerman.id.au>
Date: Wed, 01 Feb 2017 18:13:26 +1100
In-Reply-To: <20170201065932.92618406061@ip-64-139-1-69.sjc.megapath.net>
References: <20170201065932.92618406061@ip-64-139-1-69.sjc.megapath.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-31 at 22:59 -0800, Hal Murray wrote:
> Thanks.
> 
> benh@kernel.crashing.org said:
> > Right, we just use the value provided by Open Firmware. Any chance you can
> > try with MacOS X ? 
> 
> Not easily.  I'm using boxes from eBay.  They didn't come with CDs and I've 
> already installed other software.

Ok, I do have one though somewhere with OS X on it. If you give me instructions
on how to test (I know near to nothing about ntpsec), I should be able to compile
and run it.
> 
> > From the value in the properties you showed me (and the ones I have in some
> > DT snapshots) it looks like the value isn't fixed but somewhat calibrated by
> > Open Firmware during boot. 
> 
> I rebooted several times.  It always got the exact same clock speed numbers.

Interesting. Though different units get different numbers...

> I don't know anything about the insides of the PowerPC chip.  Can you confirm 
> that the kernel time keeping works off an always ticking register similar to 
> the Intel TSC and uses the timebase-frequency as the scale factor?

It should be externally clocked on these CPUs. Either that or a divisor of
the bus frequency, I don't remember, but I *think* Apple uses an external
clock.

But yes, the timebase is supposed to be always running at a constant speed
which is the timebase-frequency (no scaling, the register is always running
at *that* speed).

> If so, I should be able to "fix" it from Open Firmware.  I tried that but 
> things got worse.  I could easily have fatfingered something but more likely 
> my reasoning for computing the right value was buggy.  I guess I'll try again.
> 
> I see that powerpc/kernel/time.c reads both timebase-frequency and 
> clock-frequency, but doesn't seem to use clock-frequency.  Was that just a 
> handy place to read it that got called before anybody else needed it?

Right, it's for display in /proc/cpuinfo in absence of a specific frequency
control driver for the platform (there should be one for the mac mini though).

Cheers,
Ben.
