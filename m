Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 319D6DDF1F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 08:51:54 +1100 (EST)
Date: Thu, 22 Jan 2009 13:51:54 -0800 (PST)
Message-Id: <20090122.135154.96272626.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] phylib: Fix oops in suspend/resume paths
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090122180930.GA27624@oksana.dev.rtsoft.ru>
References: <20090122180930.GA27624@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, jgarzik@pobox.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 22 Jan 2009 21:09:30 +0300

> Suspend/resume routines check for phydrv != NULL, but that is
> wrong because "phydrv" comes from container_of(drv). If drv is NULL,
> then container_of(drv) will return non-NULL result, and the checks
> won't work.
> 
> The Freescale TBI PHYs are driver-less, so "drv" is NULL, and that
> leads to the following oops:
 ...
> This patch fixes the issue, plus removes unneeded parentheses
> and fixes indentation level in mdio_bus_suspend().
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks Anton.
