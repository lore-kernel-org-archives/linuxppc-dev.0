Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2C72FDE067
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 05:26:27 +1000 (EST)
Date: Wed, 20 May 2009 12:26:22 -0700 (PDT)
Message-Id: <20090520.122622.112939264.davem@davemloft.net>
To: a.beregalov@gmail.com
Subject: Re: [PATCH] powerpc/ep8248e: phylib needs NET_SCHED to build
From: David Miller <davem@davemloft.net>
In-Reply-To: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
References: <1242821902-16836-1-git-send-email-a.beregalov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 20 May 2009 16:18:22 +0400

> Fix this build error:
> drivers/built-in.o: In function `phy_state_machine':
> drivers/net/phy/phy.c:893: undefined reference to 'netif_carrier_off'
> drivers/net/phy/phy.c:854: undefined reference to 'netif_carrier_on'
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

This isn't right.  Otherwise no networking driver would build
with NET_SCHED disabled.

net/sched/sch_generic.c is always built when NET is enabled
and that's where netif_carrier_off() is defined.

As you can see in net/sched/Makefile, sch_generic.o is
"obj-y", did you even check? :-)
