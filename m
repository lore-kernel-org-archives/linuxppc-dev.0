Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B3BA67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 May 2006 03:55:16 +1000 (EST)
Date: Fri, 19 May 2006 10:55:13 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: MPC8xx: resolution of gettimeofday() ?
Message-ID: <20060519175513.GA12121@gate.ebshome.net>
References: <446C8E70.3040601@imc-berlin.de>
	<20060518164812.GA21075@gate.ebshome.net>
	<446D7CFA.5060505@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <446D7CFA.5060505@imc-berlin.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 10:08:26AM +0200, Steven Scholz wrote:
> Eugene,
> 
> >> what is the resolution of gettimeofday() for an MPC8xx?
> >>
> >> IIUC then the "decrementer" is used to generate the timer interrupts every 10ms.
> >>
> >> This decrementer runs at cpuclk/16. Thus with 80MHz CPU clock has a
> >> resolution of 16/80MHz = 200ns and overflows every 50000 ticks.
> >>
> >> But is this decrementer used to update xtime?
> >> Will gettimeofday() have a resolution of 200ns?
> >>
> >> How about linux 2.4 where xtime is a "struct timeval" rather then "struct
> >> timespec"?
> >>
> > 
> > Usually on PPC we use timebase to interpolate time between Decrementer 
> > interrupts. In this case gettimeofday resolution is determined by 
> > timebase resolution which is quite high (megahertz range).
> 
> Sorry. I don't understand. What do you mean with "timebase"? Is there a
> second timer/counter?

PowerPC has a facility called timebase. This is 64-bit counter which 
can be accessed using special instructions (mftb, mftbu on 32-bit PPC).
Counter resolution depends on particular chip implementation, some 
use core clock, other use bus clock...

It's similar to the time-stamp counter in Intel CPUs (accessed 
with rdtsc instruction).

Please, refer to PPC arch manuals for more information. Also, if you 
really interested in how gettimeofday() is implemented, why don't you 
look at the source code yourself?

-- 
Eugene
