Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84177DDF9B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 12:52:54 +1000 (EST)
Subject: Re: question about softirqs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090508.165358.97542490.davem@davemloft.net>
References: <4A04B76D.20106@nortel.com>
	<18948.49541.735156.176919@cargo.ozlabs.ibm.com>
	<20090508.165358.97542490.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 09 May 2009 12:52:43 +1000
Message-Id: <1241837563.29028.53.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The soft irq stuff is pretty much all generic code these days, except
> > for the code to switch to the softirq stack.
> 
> Grumble, when did that happen :-(
> 
> That's horrible for latency compared to handling it directly
> in the trap return path.

If it is indeed such a problem, it would be reasonably easy to
handle it in the return-to-userspace path around the same place
where we test for pending signals (isn't what we used to do
anyway ?)

Cheers,
Ben.
