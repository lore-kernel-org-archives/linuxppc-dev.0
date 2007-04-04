Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 34DCEDDEE2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 10:02:12 +1000 (EST)
Date: Tue, 03 Apr 2007 17:02:12 -0700 (PDT)
Message-Id: <20070403.170212.02298297.davem@davemloft.net>
To: dwmw2@infradead.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175644642.10567.31.camel@shinybook.infradead.org>
References: <1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
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
Date: Tue, 03 Apr 2007 19:57:22 -0400

> Not really. Non-8250 serial ports, such as the multiport PCI cards from
> Cyclades, Stallion, etc. have had their own device numbers for _years_.
> With hindsight, it was a mistake for pmac_zilog ever to have been called
> 'ttyS0' and to have used the ttyS0 device numbers in the first place.

Sparc does the same thing, it's a common convention and you really
should not break it.

Every powerpc and sparc system out that is using ttyS0 with dynamic
minor numbers being allocated.  I really think this should be
generalized instead of breaking serial on every powerpc machine out
there.  (sparc won't be broken because we have our own copy of
the 8250 driver that does ttyS? minor allocations and keyboard/
mouse serio hookups properly).
