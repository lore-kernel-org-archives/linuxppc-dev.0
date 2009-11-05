Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A0822B7BA8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:20:29 +1100 (EST)
Date: Thu, 5 Nov 2009 17:20:28 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH RFC] gianfar: Make polling safe with IRQs disabled
Message-ID: <20091105142028.GB17171@oksana.dev.rtsoft.ru>
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<E1N62ti-0003iS-K2@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E1N62ti-0003iS-K2@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>,
	Andy Fleming <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 08:01:10AM -0600, Jon Loeliger wrote:
> > When using KGDBoE, gianfar driver spits 'Interrupt problem' messages,
> > which appears to be a legitimate warning, i.e. we may end up calling
> > netif_receive_skb() or vlan_hwaccel_receive_skb() with IRQs disabled.
> > 
> > This patch reworks the RX path so that if netpoll is enabled (the
> > only case when the driver don't know from what context the polling
> > may be called), we check whether IRQs are disabled, and if so we
> > fall back to safe variants of skb receiving functions.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> > 
> > I'm not sure if this is suitable for mainline since it doesn't
> > have KGDBoE support. Jason, if the patch is OK, would you like
> > to merge it into KGDB tree?
> 
> It's a legitimate problem with or without KGDBoE.  I see it
> occasionally when conn_track is enabled as well, for example.

Hm, then I'd better remove the #ifdef CONFIG_NETPOLL.

Interestingly though, why conn_track does the polling with irqs
disabled, could be a bug in the conn_track? Because pretty much
drivers assume that polling is called with IRQs enabled.

If it's easily reproducible, could you replace the printk() with
WARN_ON(1) and post the backtrace? Or I can try to reproduce the
issue if you tell me how.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
