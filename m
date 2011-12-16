Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C80A91007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2011 07:33:59 +1100 (EST)
Date: Fri, 16 Dec 2011 15:32:54 -0500 (EST)
Message-Id: <20111216.153254.1998330487051662169.davem@davemloft.net>
To: timur@freescale.com
Subject: Re: [PATCH] phylib: update mdiobus_alloc() to allocate extra
 private space
From: David Miller <davem@davemloft.net>
In-Reply-To: <4EEA2A61.8050302@freescale.com>
References: <1323967895-5205-1-git-send-email-timur@freescale.com>
 <8ABCAC4C-1D11-41AD-AE46-96EB9D40588D@freescale.com>
 <4EEA2A61.8050302@freescale.com>
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
Date: Thu, 15 Dec 2011 11:12:01 -0600

> Andy Fleming wrote:
>> Why? Doesn't this just obfuscate things a little, while providing no immediate benefit?
> 
> I see code like this frequently:
> 
> 	bus = mdiobus_alloc();
> 	if (bus == NULL)
> 		return -ENOMEM;
> 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> 	if (priv == NULL) {
> 		err = -ENOMEM;
> 		goto out_free;
> 	}
> 	bus->priv = priv;

Where "frequently", all of the mdiobus_alloc() call sites in your patch just
get translated to pass "0" for the private size.

Make the change how I suggested, where mdiobus_alloc() retains it's current
function signature and semantics.  Then you can edit drivers as needed rather
than from the beginning.
