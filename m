Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3D7E6DDDFD
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 15:05:36 +1100 (EST)
Date: Sat, 25 Oct 2008 21:05:13 -0700 (PDT)
Message-Id: <20081025.210513.80339263.davem@davemloft.net>
To: kevdig@hypersurf.com
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <4903A37A.50607@hypersurf.com>
References: <20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop> <4903A37A.50607@hypersurf.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kevin Diggs <kevdig@hypersurf.com>
Date: Sat, 25 Oct 2008 15:53:46 -0700

> What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
> thing supposed to be able to spread irq between its cpus?

Networking interrupts should lock onto a single CPU, unconditionally.
That's the optimal way to handle networking interrupts, especially
with multiqueue chips.

This is what the userland IRQ balance daemon does.
