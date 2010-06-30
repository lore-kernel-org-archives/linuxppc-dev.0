Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 56403100AF9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 04:37:14 +1000 (EST)
Date: Wed, 30 Jun 2010 11:37:27 -0700 (PDT)
Message-Id: <20100630.113727.257507106.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH v2 3/3] gianfar: Implement workaround for eTSEC-A002
	erratum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100630163915.GC23337@oksana.dev.rtsoft.ru>
References: <20100630163804.GA636@oksana.dev.rtsoft.ru>
	<20100630163915.GC23337@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Sandeep.Kumar@freescale.com, manfred.rudigier@omicron.at,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@mvista.com>
Date: Wed, 30 Jun 2010 20:39:15 +0400

> MPC8313ECE says:
> 
> "If the controller receives a 1- or 2-byte frame (such as an illegal
>  runt packet or a packet with RX_ER asserted) before GRS is asserted
>  and does not receive any other frames, the controller may fail to set
>  GRSC even when the receive logic is completely idle. Any subsequent
>  receive frame that is larger than two bytes will reset the state so
>  the graceful stop can complete. A MAC receiver (Rx) reset will also
>  reset the state."
> 
> This patch implements the proposed workaround:
> 
> "If IEVENT[GRSC] is still not set after the timeout, read the eTSEC
>  register at offset 0xD1C. If bits 7-14 are the same as bits 23-30,
>  the eTSEC Rx is assumed to be idle and the Rx can be safely reset.
>  If the register fields are not equal, wait for another timeout
>  period and check again."
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Applied.
