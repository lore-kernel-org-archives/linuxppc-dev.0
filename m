Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 55036DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 22:43:07 +1000 (EST)
Date: Mon, 27 Apr 2009 05:42:58 -0700 (PDT)
Message-Id: <20090427.054258.16622932.davem@davemloft.net>
To: rbrito@ime.usp.br
Subject: Re: [PATCH] powerpc: convert mace to netdev_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090427121633.GA29608@ime.usp.br>
References: <20090426155708.GA23159@ime.usp.br>
	<20090426.230648.254087966.davem@davemloft.net>
	<20090427121633.GA29608@ime.usp.br>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rog=E9rio Brito <rbrito@ime.usp.br>
Date: Mon, 27 Apr 2009 09:16:33 -0300

> Is this anything close to what needs to be done? It's not without
> failures, because the function mace_set_timeout receives a pointer to=
 a
> struct net_device, but is marked inline and is used by mace_tx_timeou=
t,
> which receives an unsigned long (which calls mace_set_timeout).
> =

> Perhaps it would be a case of removing the inline hint to the compile=
r?
> I guess that BenH or Paul could comment here better...
> =

> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>

You can fix the mace_set_timeout() function arguments by having
a helper function that simply wraps around it and provides the
second expection of argument types.

Your patch is also wrong, it's missing a lot of netdev_ops
entries that are implicitly obtained via alloc_etherdev(),
namely:

	.ndo_change_mtu		=3D eth_change_mtu,
	.ndo_set_mac_address 	=3D eth_mac_addr,
	.ndo_validate_addr	=3D eth_validate_addr,
