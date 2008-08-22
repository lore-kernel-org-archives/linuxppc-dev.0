Return-Path: <temerkhanov@yandex.ru>
Received: from smtp4.yandex.ru (smtp4.yandex.ru [213.180.223.136])
	by ozlabs.org (Postfix) with ESMTP id 793FEDE283
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 02:10:24 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:61650 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S737730AbYHVQKI
	(ORCPT <rfc822;linuxppc-embedded@ozlabs.org>);
	Fri, 22 Aug 2008 20:10:08 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Linux Device Driver for Xilinx LL TEMAC 10/100/1000
	Ethernet NIC
Date: Fri, 22 Aug 2008 20:10:34 +0400
References: <48AA938C.4060309@dlasys.net>
In-Reply-To: <48AA938C.4060309@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808222010.35183.temerkhanov@yandex.ru>
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 19 August 2008 13:34:04 David H. Lynch Jr. wrote:
> Pass II

> +       cur_p->phys = (unsigned char *)pci_map_single(NULL,
> +                       skb->data, skb->len,
> +                       PCI_DMA_TODEVICE);
> +       cur_p->app4 = (unsigned long)skb;
> +
> +       for (ii = 0; ii < num_frag; ii++) {
> +               lp->tx_bd_tail++;
> +               if (lp->tx_bd_tail >= TX_BD_NUM)
> +                       lp->tx_bd_tail = 0;
> +
> +               cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
> +               cur_p->phys = (unsigned char *)pci_map_single(NULL,
> +                               (void *)page_address(frag->page)
> +                               + frag->page_offset,
> +                               frag->size,
> +                               PCI_DMA_TODEVICE);

1. Why is pci_* API is used instead of dma_*?
2. Why pci_map_single() in skb_shinfo(skb)->frags processing instead of 
dma_map_page()?

> +               if (ii == (TX_BD_NUM - 1))
> +                       lp->tx_bd_v[ii].next = &lp->tx_bd_p[0];
> +               else
> +                       lp->tx_bd_v[ii].next = &lp->tx_bd_p[ii + 1];

3. It would be much simpler to use masking by (TX_BD_NUM - 1) instead of  "if 
(ii == (TX_BD_NUM - 1))" constructs.

4. There is a need of global locking mechanism for indirect registers access, 
as according to Xilinx documentation only one hard core at a a time can be 
accessed.
