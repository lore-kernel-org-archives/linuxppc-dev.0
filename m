Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5573BDDE47
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:16:46 +1000 (EST)
Date: Tue, 03 Apr 2007 18:16:45 -0700 (PDT)
Message-Id: <20070403.181645.68159458.davem@davemloft.net>
To: dwmw2@infradead.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175648051.10567.61.camel@shinybook.infradead.org>
References: <1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 03 Apr 2007 20:54:10 -0400

> Yes, it would be theoretically possible to come up with a way to share
> minor numbers so we can use 'ttyS0' for the first serial port regardless
> of what type of port it is. We could take the arch-specific hack that
> SPARC has and try to move it to generic code. But what's the point?

The point is that it will work and the user will not be bothered
with what kind of serial port they happen to have.  A major number
per serial chip type is incredibly stupid.

I don't need to know anything about the inanrds of my computer to
bring up the ethernet interface, me caveman me bringup eth0, me on
network, caveman happy.  The same should be true for serial ports.

It's a serial port dammit, don't make it something else!

In the case of multiple instances, ordering is a sperate issue from
naming.  You keep bringing up the ordering issue but it distracts away
from the more important part which is the user having to know what
kind of serial port they have.

It's a serial port, and like a scsi disk or and ethernet interface, we
should give it a consistent name.
