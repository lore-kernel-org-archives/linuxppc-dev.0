Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF2DEDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 16:15:36 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207351869.6675.0.camel@johannes.berg>
References: <20080404213932.GA15847@farnsworth.org>
	<1207351869.6675.0.camel@johannes.berg>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 16:14:56 +1100
Message-Id: <1207372496.10388.441.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-04-05 at 01:31 +0200, Johannes Berg wrote:
> > This version takes care to save and restore *all* the volatile registers
> > around the call to trace_hardirqs_off in transfer_to_handler, and should
> > fix the anomalies seen by Johannes Berg.  I've tested on 7447- and 8548-
> > based boards.
> 
> Still has problems on my machine. Maybe to do with non-maskable PMU
> interrupts? (saw a patch about something like that float by, don't
> really have any idea whether it's related to this work or not)

Or more likely he missed some clobber somewhere, it took me a while to
get that right on ppc64 (well... hopefully it -is- right by now :-)

Ben.
