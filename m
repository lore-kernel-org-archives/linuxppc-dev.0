Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D21EADDF16
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 09:47:20 +1100 (EST)
Date: Wed, 21 Jan 2009 14:47:22 -0800 (PST)
Message-Id: <20090121.144722.52306013.davem@davemloft.net>
To: tklein@de.ibm.com
Subject: Re: [PATCH 3/3] ehea: Improve driver behaviour in low mem conditions
From: David Miller <davem@davemloft.net>
In-Reply-To: <200901211549.41352.tklein@de.ibm.com>
References: <200901211549.41352.tklein@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	hering2@de.ibm.com, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Thomas Klein <tklein@de.ibm.com>
Date: Wed, 21 Jan 2009 15:49:41 +0100

> Reworked receive queue fill policies to make the driver more tolerant
> in low memory conditions.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>

Applied, but there is an even better way to handle this.

You should be allocating replacement RX skbs at receive time.  And if
the RX allocation fails, you simply give the RX skb back to the chip
and do not pass it up into the stack.

This is what many ethernet drivers do to ensure that the chip never
can reach a situation where the free RX packet queue becomes empty.
