Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B4EB8DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 10:00:41 +1100 (EST)
Date: Fri, 27 Mar 2009 16:00:29 -0700 (PDT)
Message-Id: <20090327.160029.157396274.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Fix three oopses in PHY {de,}initialization code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090327174047.GA23111@oksana.dev.rtsoft.ru>
References: <20090327174047.GA23111@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, Joakim.Tjernlund@transmode.se,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 27 Mar 2009 20:40:47 +0300

> When there are no free snums, UCC ethernet should gracefully fail, but
> currently it oopses this way:
 ...
> Also, when device tree specifies fixed-link, and CONFIG_FIXED_PHY
> is disabled, we'll get this oops:
 ...
> This patch fixes all three oopses simply by rearranging some code:
> 
> - In ucc_geth_open(): move init_phy() call to the beginning, so
>   that we only call ucc_geth_stop() with a PHY attached;
> - Move phy_disconnect() call from ucc_geth_close() to
>   ucc_geth_stop(), so that we'll always disconnect the PHY.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks Anton.
