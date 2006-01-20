Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 618616891D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 20:29:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17360.44337.425946.347577@alkaid.it.uu.se>
Date: Fri, 20 Jan 2006 10:28:17 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
In-Reply-To: <20060119.165635.104653932.davem@davemloft.net>
References: <17358.19458.555996.684819@alkaid.it.uu.se>
	<20060118150158.GL4603@sunbeam.de.gnumonks.org>
	<20060120004512.GT4603@sunbeam.de.gnumonks.org>
	<20060119.165635.104653932.davem@davemloft.net>
Cc: laforge@netfilter.org, linuxppc-dev@ozlabs.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David S. Miller writes:
 > From: Harald Welte <laforge@netfilter.org>
 > Date: Fri, 20 Jan 2006 01:45:12 +0100
 > 
 > > [NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32
 > > 
 > > To keep backwards compatibility with old iptables userspace programs,
 > > the new XT_ALIGN macro always has to return the same value as IPT_ALIGN,
 > > IP6T_ALIGN or ARPT_ALIGN in previous kernels.
 > > 
 > > However, in those kernels the macro was defined in dependency to the
 > > respective layer3 specifi data structures, which we can no longer do with
 > > x_tables.
 > > 
 > > The fix is an ugly kludge, but it has been tested to solve the problem. Yet
 > > another reason to move away from the current {ip,ip6,arp,eb}tables like
 > > data structures.
 > > 
 > > Signed-off-by: Harald Welte <laforge@netfilter.org>
 > 
 > Harald, I'm going to modify this to just use u_int64_t as that
 > should be totally sufficient.

ACK. Both Harald's patch and DaveM's simplification of it
(simply s/void */u_int64_t/g in XT_ALIGN()) fix the iptables
problems on my ppc32 box.

/Mikael
