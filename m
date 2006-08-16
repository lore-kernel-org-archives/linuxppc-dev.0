Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 89FDD67B53
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 07:19:30 +1000 (EST)
Date: Wed, 16 Aug 2006 13:46:40 -0700 (PDT)
Message-Id: <20060816.134640.115912460.davem@davemloft.net>
To: jeff@garzik.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E38157.4070805@garzik.org>
References: <44E34825.2020105@garzik.org>
	<20060816203043.GJ20551@austin.ibm.com>
	<44E38157.4070805@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeff Garzik <jeff@garzik.org>
Date: Wed, 16 Aug 2006 16:34:31 -0400

> Linas Vepstas wrote:
> > I was under the impression that NAPI was for the receive side only.
> 
> That depends on the driver implementation.

What Jeff is trying to say is that TX reclaim can occur in
the NAPI poll routine, and in fact this is what the vast
majority of NAPI drivers do.

It also makes the locking simpler.

In practice, the best thing seems to be to put both RX and TX
work into ->poll() and have a very mild hw interrupt mitigation
setting programmed into the chip.

I'm not familiar with the spidernet TX side interrupt capabilities
so I can't say whether that is something that can be directly
implied.  In fact, I get the impression that spidernet is limited
in some way and that's where all the strange approaches are coming
from :)
