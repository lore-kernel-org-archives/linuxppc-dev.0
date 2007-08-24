Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D44DFDDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:32:22 +1000 (EST)
Date: Fri, 24 Aug 2007 14:32:20 -0700 (PDT)
Message-Id: <20070824.143220.55503163.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708241559.17055.ossthema@de.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, meder@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Fri, 24 Aug 2007 15:59:16 +0200

> =A0 =A0It would be nice if it is possible to schedule queues to other=
 CPU's, or
> =A0 =A0at least to use interrupts to put the queue to another cpu (no=
t nice for =

> =A0 =A0as you never know which one you will hit). =

> =A0 =A0I'm not sure how bad the tradeoff would be.

Once the per-cpu NAPI poll queues start needing locks, much of the
gain will be lost.  This is strictly what we want to avoid.

We need real facilities for IRQ distribution policies.  With that none
of this is an issue.

This is also a platform specific problem with IRQ behavior, the IRQ
distibution scheme you mention would never occur on sparc64 for
example.  We use a fixed round-robin distribution of interrupts to
CPUS there, they don't move.

Each scheme has it's advantages, but you want a difference scheme here
than what is implemented and the fix is therefore not in the
networking :-)

Furthermore, most cards that will be using multi-queue will be
using hashes on the packet headers to choose the MSI-X interrupt
and thus the cpu to be targetted.  Those cards will want fixed
instead of dynamic interrupt to cpu distribution schemes as well,
so your problem is not unique and they'll need the same fix as
you do.
