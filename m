Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDF98DE145
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 07:28:59 +1000 (EST)
In-Reply-To: <20080529141246.b9cea683.kim.phillips@freescale.com>
References: <20080529141246.b9cea683.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <52e09c438efa8ff0e415d820ba4beddc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] update crypto node definition and device tree
	instances
Date: Fri, 30 May 2008 23:28:38 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nice cleanup!  Just one thing...

> +    - compatible : Should contain entries for all compatible SEC 
> versions,
> +      high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"

*All* compatible versions?  That's not really correct -- for
example that would include *future* versions!

The first entry should describe the exact device version.  If
there are more entries, they should be for device versions where
the driver for that device version can be reasonably expected to
do something useful with this newer device (reduced functionality,
perhaps).  Listing *all* compatible devices is a) infeasible,
b) not useful, and c) insane :-)

Say you have a 3.3 device, and all 3.x devices have the same
programming interface; also, the 2.x interface works with reduced
functionality, and 1.x isn't useful at all; in that case, you would
list 3.3, 3.0, 2.0.  The driver that knows about 3.x would probe
for 3.0, while an older driver would probe for 2.0.  The driver
doesn't need to probe for 3.3, since devices implementing 3.3
should show they are compatible with 3.0 (and the binding should
say they should show this).

Also, the binding should explicitly list all defined compatible
entries (and what they mean), not just give a few examples.


Segher
