Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74D6CB7F79
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 05:19:46 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 37419DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 05:19:46 +1000 (EST)
Date: Fri, 11 Sep 2009 12:19:58 -0700 (PDT)
Message-Id: <20090911.121958.06510883.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3 3/3] ucc_geth: Fix hangs after switching from full
	to half duplex
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090910214812.GA30564@oksana.dev.rtsoft.ru>
References: <20090910194053.GA24363@oksana.dev.rtsoft.ru>
	<20090910210935.GA26037@oksana.dev.rtsoft.ru>
	<20090910214812.GA30564@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, netdev@vger.kernel.org, afleming@freescale.com,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 11 Sep 2009 01:48:12 +0400

> MPC8360 QE UCC ethernet controllers hang when changing link duplex
> under a load (a bit of NFS activity is enough).
> 
>   PHY: mdio@e0102120:00 - Link is Up - 1000/Full
>   sh-3.00# ethtool -s eth0 speed 100 duplex half autoneg off
>   PHY: mdio@e0102120:00 - Link is Down
>   PHY: mdio@e0102120:00 - Link is Up - 100/Half
>   NETDEV WATCHDOG: eth0 (ucc_geth): transmit queue 0 timed out
>   ------------[ cut here ]------------
>   Badness at c01fcbd0 [verbose debug info unavailable]
>   NIP: c01fcbd0 LR: c01fcbd0 CTR: c0194e44
>   ...
> 
> The cure is to disable the controller before changing speed/duplex
> and enable it afterwards.
> 
> Though, disabling the controller might take quite a while, so we
> better not grab any spinlocks in adjust_link(). Instead, we quiesce
> the driver's activity, and only then disable the controller.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
