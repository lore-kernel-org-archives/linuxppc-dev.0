Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F0ECB6F77
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 22:11:46 +1000 (EST)
Date: Tue, 12 Jul 2011 05:08:17 -0700 (PDT)
Message-Id: <20110712.050817.1253941735409335652.davem@davemloft.net>
To: ronny.meeus@gmail.com
Subject: Re: softirqs are invoked while bottom halves are masked
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAMJ=MEeC1hoqufs7AfFRn3yJoC8mdw7v+14N+7e=wQuJefm4_w@mail.gmail.com>
References: <CAAXf6LXHeiCT+n=Wpdf=QfUXUHUSd7fmx9y3kB7te8N3ON1fTg@mail.gmail.com>
	<1310465411.3314.6.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<CAMJ=MEeC1hoqufs7AfFRn3yJoC8mdw7v+14N+7e=wQuJefm4_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	patrickdepinguin+linuxppc@gmail.com, eric.dumazet@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 12 Jul 2011 14:03:04 +0200

> but we still see the issue "BUG: sleeping function called from invalid context":
> 
> [   91.015989] BUG: sleeping function called from invalid context at
> include/linux/skbuff.h:786
> [   91.117096] in_atomic(): 1, irqs_disabled(): 0, pid: 1865, name: NMTX_T1842
> [   91.200461] Call Trace:
> [   91.229672] [ec58bbd0] [c000789c] show_stack+0x78/0x18c (unreliable)
> [   91.305791] [ec58bc10] [c0022900] __might_sleep+0x100/0x118
> [   91.372524] [ec58bc20] [c029f8d8] dpa_tx+0x128/0x758

Because this dpa driver's transmit method is doing something else that
is not allowed in software interrupt context.

You must remove all things that might sleep in this driver's
->ndo_start_xmit method, and I do mean everything.
