Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EBC071007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2011 07:32:44 +1100 (EST)
Date: Fri, 16 Dec 2011 15:31:37 -0500 (EST)
Message-Id: <20111216.153137.729586714371685980.davem@davemloft.net>
To: timur@freescale.com
Subject: Re: [PATCH] phylib: update mdiobus_alloc() to allocate extra
 private space
From: David Miller <davem@davemloft.net>
In-Reply-To: <1323967895-5205-1-git-send-email-timur@freescale.com>
References: <1323967895-5205-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Dec 2011 10:51:35 -0600

> Augment mdiobus_alloc() to take a parameter indicating the number of extra
> bytes to allocate for private data.  Almost all callers of mdiobus_alloc()
> separately allocate a private data structure.  By allowing mdiobus_alloc()
> to allocate extra memory, the two allocations can be merged into one.
> 
> This patch does not change any of the callers to actually take advantage
> of this feature, however.  That change can be made by the individual
> maintainers at their leisure.  For now, all callers ask for zero additional
> bytes, which mimics the previous behavior.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Come on...

Not one driver even uses the new facility, and on top of it you edit
all of these drivers for no reason at all.

You could edit only two source files instead of more than 30 by simply
doing:

struct mii_bus *mdiobus_alloc_size(size_t size);

static inline struct mii_bus *mdiobus_alloc(void)
{
	return mdiobus_alloc_size(0):
}
