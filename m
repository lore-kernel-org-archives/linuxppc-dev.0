Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4B38FB7BA5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 04:34:11 +1100 (EST)
Date: Thu, 5 Nov 2009 20:34:09 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gopalpet-B05799 <B05799@freescale.com>
Subject: Re: [PATCH RFC] gianfar: Do not call skb recycling with disabled IRQs
Message-ID: <20091105173409.GA24801@oksana.dev.rtsoft.ru>
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<E1N62ti-0003iS-K2@jdl.com>
	<20091105142028.GB17171@oksana.dev.rtsoft.ru>
	<E1N63WM-0003xK-PN@jdl.com> <E1N64UY-00049g-Hb@jdl.com>
	<20091105165738.GA31923@oksana.dev.rtsoft.ru>
	<9F4C7D19E8361D4C94921B95BE08B81B950713@zin33exm22.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9F4C7D19E8361D4C94921B95BE08B81B950713@zin33exm22.fsl.freescale.net>
Cc: Jon Loeliger <jdl@jdl.com>, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Fleming Andy-AFLEMING <afleming@freescale.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 10:53:08PM +0530, Kumar Gopalpet-B05799 wrote:
[...]
> >(spin_trylock_irqsave(&tx_queue->txlock, flags)) {
> >-				tx_cleaned += 
> >gfar_clean_tx_ring(tx_queue);
> >-				
> >spin_unlock_irqrestore(&tx_queue->txlock,
> >-							flags);
> >-			}
> >+			netif_tx_lock_bh(priv->ndev);
> 
> Will this not lead to locking all the tx queues even though at this
> point we are working on a "particular queue" ?

Yeah, per-txq locking would be better (or not.. I need to netperf
it).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
