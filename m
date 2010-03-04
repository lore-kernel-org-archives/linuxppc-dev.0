Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CFE17B7CED
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 19:41:39 +1100 (EST)
Date: Thu, 04 Mar 2010 00:41:57 -0800 (PST)
Message-Id: <20100304.004157.18721737.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] gianfar: Fix TX ring processing on SMP machines
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100303181858.GA458@oksana.dev.rtsoft.ru>
References: <20100303181858.GA458@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, martyn.welch@ge.com,
	paul.gortmaker@windriver.com, Sandeep.Kumar@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 3 Mar 2010 21:18:58 +0300

> Starting with commit a3bc1f11e9b867a4f49505 ("gianfar: Revive SKB
> recycling") gianfar driver sooner or later stops transmitting any
> packets on SMP machines.
> 
> start_xmit() prepares new skb for transmitting, generally it does
> three things:
> 
> 1. sets up all BDs (marks them ready to send), except the first one.
> 2. stores skb into tx_queue->tx_skbuff so that clean_tx_ring()
>    would cleanup it later.
> 3. sets up the first BD, i.e. marks it ready.
> 
> Here is what clean_tx_ring() does:
> 
> 1. reads skbs from tx_queue->tx_skbuff
> 2. checks if the *last* BD is ready. If it's still ready [to send]
>    then it it isn't transmitted, so clean_tx_ring() returns.
>    Otherwise it actually cleanups BDs. All is OK.
> 
> Now, if there is just one BD, code flow:
> 
> - start_xmit(): stores skb into tx_skbuff. Note that the first BD
>   (which is also the last one) isn't marked as ready, yet.
> - clean_tx_ring(): sees that skb is not null, *and* its lstatus
>   says that it is NOT ready (like if BD was sent), so it cleans
>   it up (bad!)
> - start_xmit(): marks BD as ready [to send], but it's too late.
> 
> We can fix this simply by reordering lstatus/tx_skbuff writes.
> 
> Reported-by: Martyn Welch <martyn.welch@ge.com>
> Bisected-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Tested-by: Martyn Welch <martyn.welch@ge.com>

Applied.
