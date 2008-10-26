Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EB06DDDE0
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 17:48:58 +1100 (EST)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4903A37A.50607@hypersurf.com>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>  <4903A37A.50607@hypersurf.com>
Content-Type: text/plain
Date: Sun, 26 Oct 2008 17:48:43 +1100
Message-Id: <1225003723.7654.490.camel@pasglop>
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


> What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
> thing supposed to be able to spread irq between its cpus?

Depends on the interrupt controller. I don't know that machine
but for example the Apple Dual G5's use an MPIC that can spread
based on an internal HW round robin scheme. This isn't always
the best idea tho for cache reasons... depends if an at what level
your caches are shared between CPUs.

Ben.
