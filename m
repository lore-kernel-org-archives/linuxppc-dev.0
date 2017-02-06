Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGrbb2sxfzDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:12:59 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGrbZ4QpDz9ryk
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 13:12:58 +1100 (AEDT)
Date: Sun, 5 Feb 2017 20:12:34 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Fred Wright <fw@fwright.net>, linuxppc-dev@ozlabs.org, devel@ntpsec.org
Subject: Re: Timekeeping oddities on MacMini G4s
Message-ID: <20170206021234.GD21840@gate.crashing.org>
References: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
 <Pine.LNX.4.58L1X.1702041524560.6886@bolt.sonic.net>
 <1486336921.4850.74.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1486336921.4850.74.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2017 at 10:22:01AM +1100, Benjamin Herrenschmidt wrote:
> >   On the plus side, that means that the values are guaranteed not
> > to be core-specific.  On the minus side, it means that its count rate is
> > lower, and it's sufficiently "distant" that accessing it is somewhat more
> > expensive.
> 
> Right so there are various configuration options and ways to feed the timebase
> to PowerPC chips depending on the generation and manufacturer. On the old
> 32-bit chips, typically it was either a divisor of the bus frequency or
> externally clocked. Apple typically used the latter.

On all 6xx and most 7xx/7xxx it is 1:4 of the bus clock.  And on the
newer machines the clock chip uses clock spreading.  So you then cannot
calibrate with a dumb fast routine (the time base ticks pretty slow
anyhow, you cannot calibrate any fast if you want decent results; but
with clock spreading you either have to measure for many seconds, or you
need to find the period of the spreading and work with that).

> > The PowerPC architecture permits the timebase frequency to be variable,
> > but I'm not aware of any implementations that take advantage of that.
> 
> I think it's pretty much accepted that this would be a very bad idea
> and no implementation did it.

See above.

> >   The
> > Motorola 32-bit implementations in general run it on the "bus clock",
> > which is independent of processor-clock multipliers, and is also common
> > across processor chips in systems with more than one.
> 
> There's also a TBEN external pin iirc which can be used to feed it.

Some implementations have an MSR bit to stop the TB as well (7450 for
example).


Segher
