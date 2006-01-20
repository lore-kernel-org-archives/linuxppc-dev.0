Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D95A689AD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 12:36:24 +1100 (EST)
Date: Thu, 19 Jan 2006 16:56:35 -0800 (PST)
Message-Id: <20060119.165635.104653932.davem@davemloft.net>
To: laforge@netfilter.org
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060120004512.GT4603@sunbeam.de.gnumonks.org>
References: <17358.19458.555996.684819@alkaid.it.uu.se>
	<20060118150158.GL4603@sunbeam.de.gnumonks.org>
	<20060120004512.GT4603@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org, mikpe@user.it.uu.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Harald Welte <laforge@netfilter.org>
Date: Fri, 20 Jan 2006 01:45:12 +0100

> [NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32
> 
> To keep backwards compatibility with old iptables userspace programs,
> the new XT_ALIGN macro always has to return the same value as IPT_ALIGN,
> IP6T_ALIGN or ARPT_ALIGN in previous kernels.
> 
> However, in those kernels the macro was defined in dependency to the
> respective layer3 specifi data structures, which we can no longer do with
> x_tables.
> 
> The fix is an ugly kludge, but it has been tested to solve the problem. Yet
> another reason to move away from the current {ip,ip6,arp,eb}tables like
> data structures.
> 
> Signed-off-by: Harald Welte <laforge@netfilter.org>

Harald, I'm going to modify this to just use u_int64_t as that
should be totally sufficient.

It is the largest type, and will produce the desired results without
the silly structure.

Some malloc() implementations use "long double" to figure out the
largest type size and alignment requirements any C type might have
on the machine.  But there is no reason to use that here.
