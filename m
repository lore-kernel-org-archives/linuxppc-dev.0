Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 805F7DDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 13:15:09 +1100 (EST)
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20071204012329.GA18903@mag.az.mvista.com>
References: <20071129152836.GB13751@ru.mvista.com>
	<1196715170.13230.228.camel@pasglop>
	<20071204012329.GA18903@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 13:14:43 +1100
Message-Id: <1196734483.13230.256.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 .../... (snip scary bunch of errata)

> - "FEr PCI-#4" (Detailed by Application Note AN-84):
> 
> [This isn't strictly a coherency issue but having coherency enabled
> exacerbates the problem.]  Basically, the bridge can let the cpu read
> a pci device's registers before all of the data the PCI devices has
> written has actually made it to memory.  This and the fact that the
> device's write data may be stuck in the PCI Slave Write Buffer
> (which isn't checked for coherency), the cpu can get stale data.
> 
> There are no plans to fix that erratum.

So if I understand correctly, there's no plan to fix a major PCI spec
violation which prevent any kind of reliable implementation whatsoever ?

Or rather... the part just doesn't work, period. Don't use it. If you
do, you're on your own.

> - "FEr PCI-#5" (Detailed by Application Note AN-85):
> 
> With certain PCI devices and with coherency enabled, some combinations
> of PCI transactions can cause a deadlock.  There is a workaround
> documented but I've tried it and it didn't work for me (but I can't be
> sure that was the erratum I was bumping into).
> 
> There are no plans to fix that erratum.

Yeah... great. Oh well, Paul, what about we just don't support people
using that chip ?

> So, the answer depends on what part & what rev of the part you have
> (e.g., the pegasos doesn't use the MPSC and apparently has the other
> issues worked around so it can turn on coherency but the prpmc2800
> doesn't so it needs coherency off).
> 
> BTW, I haven't forgotten the inherent bug you described when coherency
> is off (/me too lazy to find link to the email) but AFAIK I've never run
> into it.  However, if I turn on coherency and stress the PCI bus, it
> hangs (I can't even look at memory thru a bdi).

Well, as it is today, the "classic" MMU code cannot deal with !coherent.
The entire linear mapping is always mapped cacheable with BATs, so stuff
may be brought into the cache at any time, potentially polluting DMA
data.

Dealing with that would be hard. It might be possible by using G on the
entire linear mapping like we do on 4xx (yuck), and/or by not using
D-BATs (the kernel will blow up in various areas without I-BATs).

Ben.
