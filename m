Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2B1FDDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:09:21 +1000 (EST)
Subject: Re: [RFC] [patch 2/2] powerpc 2.6.21-rt1: fix kernel hang and/or panic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
In-Reply-To: <yyiirau5v8g.wl@toshiba.co.jp>
References: <yyilkfq5vsj.wl@toshiba.co.jp>  <yyiirau5v8g.wl@toshiba.co.jp>
Content-Type: text/plain
Date: Tue, 15 May 2007 20:09:02 +1000
Message-Id: <1179223742.32247.184.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 17:47 +0900, Tsutomu OWA wrote:
> >   It occurs on 2.6.21 + patch-2.6.21-rt1 + series of patches that I posted
> > yesterday.
> 
>   I encountered the following error when doing netperf from other machine 
> to Celleb running RT kernel.  PREEPT_NONE kernel works just fine as well.

Hrm... sounds a bit weird. I wonder if there's a locking bug in the
driver in the first place.

Linas, what's your take ?

Ben.

> Unable to handle kernel paging request for data at address 0x00000009
> Faulting instruction address: 0xc000000000295434
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT SMP NR_CPUS=2 NUMA 
> Modules linked in:
> NIP: C000000000295434 LR: C000000000295420 CTR: 0000000000000000
> REGS: c0000000095d6e30 TRAP: 0300   Not tainted  (2.6.21-rc5-rt7)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000482  XER: 20000000
> DAR: 0000000000000009, DSISR: 0000000040000000
> TASK = c000000001e7c440[626] 'netserver' THREAD: c0000000095d4000 CPU: 0
> GPR00: 0000000000000800 C0000000095D70B0 C0000000005D77B8 0000000000000001 
> GPR04: 0000000000000001 0000000000000000 C0000000095D7080 0000000000000000 
> GPR08: C0000000095D7030 0000000000000000 C0000000095D7040 0000000000000000 
> GPR12: FC69925300080D5D C0000000004DE680 0000000000000000 0000000000422208 
> GPR16: 0000000000400000 0000000000420D10 0000000000000000 C0000000095D7C88 
> GPR20: C000000001E7C440 0000000000000000 0000000000000001 C000000008ACEAE0 
> GPR24: 0000000000000020 C000000000E50C80 0000000081F84C5E C000000001C00BE0 
> GPR28: C000000001C05430 C000000001C00B80 C000000000570F30 C000000001FD1720 
> NIP [C000000000295434] .spider_net_xmit+0x1dc/0x448
> LR [C000000000295420] .spider_net_xmit+0x1c8/0x448
> Call Trace:
> [C0000000095D70B0] [C000000000295420] .spider_net_xmit+0x1c8/0x448 (unreliable)
> [C0000000095D7160] [C000000000327EE8] .dev_hard_start_xmit+0x238/0x300
> [C0000000095D7200] [C00000000033A7F4] .__qdisc_run+0xdc/0x2a4
> [C0000000095D72B0] [C00000000032A948] .dev_queue_xmit+0x1b0/0x2fc
> [C0000000095D7350] [C00000000034B470] .ip_output+0x280/0x2d8
> [C0000000095D73F0] [C00000000034C6CC] .ip_queue_xmit+0x448/0x4d8
> [C0000000095D74F0] [C00000000035F6D8] .tcp_transmit_skb+0x850/0x8c0
> [C0000000095D75C0] [C00000000035C394] .__tcp_ack_snd_check+0x84/0xc0
> [C0000000095D7650] [C00000000035E114] .tcp_rcv_established+0x4f0/0x8ac
> [C0000000095D7700] [C000000000365B24] .tcp_v4_do_rcv+0x5c/0x448
> [C0000000095D77D0] [C00000000031C2C4] .release_sock+0x94/0x11c
> [C0000000095D7870] [C000000000354E7C] .tcp_recvmsg+0x374/0x8d8
> [C0000000095D7960] [C00000000031B8A0] .sock_common_recvmsg+0x5c/0x84
> [C0000000095D79F0] [C00000000031921C] .sock_recvmsg+0x110/0x15c
> [C0000000095D7C00] [C00000000031AA50] .sys_recvfrom+0xf0/0x174
> [C0000000095D7D90] [C000000000339368] .compat_sys_socketcall+0x178/0x214
> [C0000000095D7E30] [C000000000008634] syscall_exit+0x0/0x40
> Instruction dump:
> 60000000 81790088 901f000c 913f0018 913f0008 917f0004 48132e8d 60000000 
> a019009e 2f800800 409e0038 e9390038 <88690009> 2f830006 419e0010 2f830011 
> 
> I suspect spidernet expects spin_lock_irqsave()/restore() to disable/enable
> interrupts in vain on RT kernel.
> 
> This patch works fine as far as I've tested, but I feel it's a kind of
> workaround.  Any comments, suggestions, patches are welcome.
> 
> Thanks in advance
> 
> Signed-off-by: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
> -- owa
> 
> diff -rup linux-2.6.21-rt1/drivers/net/spider_net.c rt/drivers/net/spider_net.c
> --- linux-2.6.21-rt1/drivers/net/spider_net.c	2007-04-26 12:08:32.000000000 +0900
> +++ rt/drivers/net/spider_net.c	2007-05-07 14:11:24.000000000 +0900
> @@ -688,7 +688,6 @@ spider_net_prepare_tx_descr(struct spide
>  	struct spider_net_descr *descr;
>  	struct spider_net_hw_descr *hwdescr;
>  	dma_addr_t buf;
> -	unsigned long flags;
>  
>  	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
>  	if (pci_dma_mapping_error(buf)) {
> @@ -699,10 +698,8 @@ spider_net_prepare_tx_descr(struct spide
>  		return -ENOMEM;
>  	}
>  
> -	spin_lock_irqsave(&chain->lock, flags);
>  	descr = card->tx_chain.head;
>  	if (descr->next == chain->tail->prev) {
> -		spin_unlock_irqrestore(&chain->lock, flags);
>  		pci_unmap_single(card->pdev, buf, skb->len, PCI_DMA_TODEVICE);
>  		return -ENOMEM;
>  	}
> @@ -717,7 +714,6 @@ spider_net_prepare_tx_descr(struct spide
>  
>  	hwdescr->dmac_cmd_status =
>  			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
> -	spin_unlock_irqrestore(&chain->lock, flags);
>  
>  	if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == CHECKSUM_PARTIAL)
>  		switch (skb->nh.iph->protocol) {
> @@ -742,7 +738,6 @@ spider_net_set_low_watermark(struct spid
>  {
>  	struct spider_net_descr *descr = card->tx_chain.tail;
>  	struct spider_net_hw_descr *hwdescr;
> -	unsigned long flags;
>  	int status;
>  	int cnt=0;
>  	int i;
> @@ -768,7 +763,6 @@ spider_net_set_low_watermark(struct spid
>  		descr = descr->next;
>  
>  	/* Set the new watermark, clear the old watermark */
> -	spin_lock_irqsave(&card->tx_chain.lock, flags);
>  	descr->hwdescr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
>  	if (card->low_watermark && card->low_watermark != descr) {
>  		hwdescr = card->low_watermark->hwdescr;
> @@ -776,7 +770,7 @@ spider_net_set_low_watermark(struct spid
>  		     hwdescr->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
>  	}
>  	card->low_watermark = descr;
> -	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
> +
>  	return cnt;
>  }
>  
> @@ -784,6 +778,7 @@ spider_net_set_low_watermark(struct spid
>   * spider_net_release_tx_chain - processes sent tx descriptors
>   * @card: adapter structure
>   * @brutal: if set, don't care about whether descriptor seems to be in use
> + * @locked: if set, tx_chain locked is held by caller.
>   *
>   * returns 0 if the tx ring is empty, otherwise 1.
>   *
> @@ -793,7 +788,7 @@ spider_net_set_low_watermark(struct spid
>   * scheduled again (if we were scheduled) and will not loose initiative.
>   */
>  static int
> -spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
> +spider_net_release_tx_chain(struct spider_net_card *card, int brutal, int locked)
>  {
>  	struct spider_net_descr_chain *chain = &card->tx_chain;
>  	struct spider_net_descr *descr;
> @@ -804,9 +799,11 @@ spider_net_release_tx_chain(struct spide
>  	int status;
>  
>  	while (1) {
> -		spin_lock_irqsave(&chain->lock, flags);
> +		if (!locked)
> +			spin_lock_irqsave(&chain->lock, flags);
>  		if (chain->tail == chain->head) {
> -			spin_unlock_irqrestore(&chain->lock, flags);
> +			if (!locked)
> +				spin_unlock_irqrestore(&chain->lock, flags);
>  			return 0;
>  		}
>  		descr = chain->tail;
> @@ -821,7 +818,8 @@ spider_net_release_tx_chain(struct spide
>  
>  		case SPIDER_NET_DESCR_CARDOWNED:
>  			if (!brutal) {
> -				spin_unlock_irqrestore(&chain->lock, flags);
> +				if (!locked)
> +					spin_unlock_irqrestore(&chain->lock, flags);
>  				return 1;
>  			}
>  
> @@ -842,7 +840,8 @@ spider_net_release_tx_chain(struct spide
>  		default:
>  			card->netdev_stats.tx_dropped++;
>  			if (!brutal) {
> -				spin_unlock_irqrestore(&chain->lock, flags);
> +				if (!locked)
> +					spin_unlock_irqrestore(&chain->lock, flags);
>  				return 1;
>  			}
>  		}
> @@ -852,7 +851,9 @@ spider_net_release_tx_chain(struct spide
>  		skb = descr->skb;
>  		descr->skb = NULL;
>  		buf_addr = hwdescr->buf_addr;
> -		spin_unlock_irqrestore(&chain->lock, flags);
> +
> +		if (!locked)
> +			spin_unlock_irqrestore(&chain->lock, flags);
>  
>  		/* unmap the skb */
>  		if (skb) {
> @@ -916,18 +917,28 @@ spider_net_xmit(struct sk_buff *skb, str
>  {
>  	int cnt;
>  	struct spider_net_card *card = netdev_priv(netdev);
> +	unsigned long flags;
> +
> +	if (!spin_trylock_irqsave(&card->tx_chain.lock, flags))
> +		return NETDEV_TX_BUSY;
> +		//? collision ? return NETDEV_TX_LOCKED;
>  
> -	spider_net_release_tx_chain(card, 0);
> +	spider_net_release_tx_chain(card, 0, 1);
>  
>  	if (spider_net_prepare_tx_descr(card, skb) != 0) {
> +		spin_unlock_irqrestore(&card->tx_chain.lock, flags);
>  		card->netdev_stats.tx_dropped++;
>  		netif_stop_queue(netdev);
>  		return NETDEV_TX_BUSY;
>  	}
>  
>  	cnt = spider_net_set_low_watermark(card);
> +
> +	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
> +
>  	if (cnt < 5)
>  		spider_net_kick_tx_dma(card);
> +
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -943,11 +954,20 @@ spider_net_xmit(struct sk_buff *skb, str
>  static void
>  spider_net_cleanup_tx_ring(struct spider_net_card *card)
>  {
> -	if ((spider_net_release_tx_chain(card, 0) != 0) &&
> +	unsigned long flags;
> +
> +	if (!spin_trylock_irqsave(&card->tx_chain.lock, flags))
> +		return;
> +
> +	if ((spider_net_release_tx_chain(card, 0, 1) != 0) &&
>  	    (card->netdev->flags & IFF_UP)) {
> +		spin_unlock_irqrestore(&card->tx_chain.lock, flags);
>  		spider_net_kick_tx_dma(card);
>  		netif_wake_queue(card->netdev);
> -	}
> +	} else
> +		spin_unlock_irqrestore(&card->tx_chain.lock, flags);
> +
> +
>  }
>  
>  /**
> @@ -2092,7 +2112,7 @@ spider_net_stop(struct net_device *netde
>  	spider_net_disable_rxdmac(card);
>  
>  	/* release chains */
> -	spider_net_release_tx_chain(card, 1);
> +	spider_net_release_tx_chain(card, 1, 0);
>  	spider_net_free_rx_chain_contents(card);
>  
>  	spider_net_free_chain(card, &card->tx_chain);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
