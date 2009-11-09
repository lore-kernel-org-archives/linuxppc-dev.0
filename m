Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1F325B70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 00:32:35 +1100 (EST)
Date: Mon, 9 Nov 2009 16:32:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RFC] gianfar: Make polling safe with IRQs disabled
Message-ID: <20091109133231.GA26965@oksana.dev.rtsoft.ru>
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<20091108.010533.212571001.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091108.010533.212571001.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	jason.wessel@windriver.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 08, 2009 at 01:05:33AM -0800, David Miller wrote:
...
> > When using KGDBoE, gianfar driver spits 'Interrupt problem' messages,
> > which appears to be a legitimate warning, i.e. we may end up calling
> > netif_receive_skb() or vlan_hwaccel_receive_skb() with IRQs disabled.
> > 
> > This patch reworks the RX path so that if netpoll is enabled (the
> > only case when the driver don't know from what context the polling
> > may be called), we check whether IRQs are disabled, and if so we
> > fall back to safe variants of skb receiving functions.
> 
> This is bogus, I'll tell you why.
> 
> When you go into netif_receive_skb() we have a special check,
> "if (netpoll_receive_skb(..." that takes care of all of the
> details concerning doing a ->poll() from IRQ disabled context
> via netpoll.
> 
> So this code you're adding should not be necessary.
> 
> Or, explain to me why no other driver needs special logic in their
> ->poll() handler like this and does not run into any kinds of netpoll
> problems :-)

Hm, I was confused by the following note:

/**
 *      netif_receive_skb - process receive buffer from network
 *      @skb: buffer to process
...
 *      This function may only be called from softirq context and interrupts
 *      should be enabled.


Looking into the code though, I can indeed see that there
are netpoll checks, and __netpoll_rx() is actually called with
irqs disabled. So, in the end it appears that we should just
remove the 'Interrupt problem' message.


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
