Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54488B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 07:09:39 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E03E9DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 07:09:38 +1000 (EST)
Date: Fri, 11 Sep 2009 01:09:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/3] ucc_geth: Fix hangs after switching from full
	to	half duplex
Message-ID: <20090910210935.GA26037@oksana.dev.rtsoft.ru>
References: <20090910020145.GC31083@oksana.dev.rtsoft.ru>
	<20090910175852.GA18948@oksana.dev.rtsoft.ru>
	<4AA93FB0.5060802@freescale.com>
	<20090910194053.GA24363@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090910194053.GA24363@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Andy Fleming <afleming@freescale.com>, David Miller <davem@davemloft.net>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 10, 2009 at 11:40:53PM +0400, Anton Vorontsov wrote:
> On Thu, Sep 10, 2009 at 01:04:32PM -0500, Scott Wood wrote:
> > Anton Vorontsov wrote:
> > >MPC8360 QE UCC ethernet controllers hang when changing link duplex
> > >under a load (a bit of NFS activity is enough).
> > >
> > >  PHY: mdio@e0102120:00 - Link is Up - 1000/Full
> > >  sh-3.00# ethtool -s eth0 speed 100 duplex half autoneg off
> > >  PHY: mdio@e0102120:00 - Link is Down
> > >  PHY: mdio@e0102120:00 - Link is Up - 100/Half
> > >  NETDEV WATCHDOG: eth0 (ucc_geth): transmit queue 0 timed out
> > >  ------------[ cut here ]------------
> > >  Badness at c01fcbd0 [verbose debug info unavailable]
> > >  NIP: c01fcbd0 LR: c01fcbd0 CTR: c0194e44
> > >  ...
> > >
> > >The cure is to disable the controller before changing speed/duplex
> > >and enable it afterwards.
> > >
> > >Since ugeth_graceful_stop_{tx,rx} now may be called from an atomic
> > >context, switch the two functions from msleep() to mdelay().
> > 
> > Ouch.
> 
> Yeah, right... delaying for 10ms with irqs off isn't good.
> 
> > Can we put this in a workqueue or something?
> 
> adjust_link() itself isn't called from an atomic context.

Oops. I though that phylib calls us from a workqueue, not a timer. Hm...

Will be a little bit more work..

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
