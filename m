Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1C53DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 02:21:04 +1100 (EST)
In-Reply-To: <20090325142540.GA20944@oksana.dev.rtsoft.ru>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
	<20090325142540.GA20944@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
MIME-Version: 1.0
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
Message-ID: <OF6FCD73B2.9477636F-ONC1257584.0053EFCE-C1257584.005451CC@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 25 Mar 2009 16:21:00 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>, leoli@freescale.com,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 25/03/2009 15:25:40:
> 
> On Wed, Mar 25, 2009 at 02:30:49PM +0100, Joakim Tjernlund wrote:
> > >>From 1c2f23b1f37f4818c0fd0217b93eb38ab6564840 Mon Sep 17 00:00:00 
2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 24 Mar 2009 10:19:27 +0100
> > Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
> >  Also increase NAPI weight somewhat.
> >  This will make the system alot more responsive while
> >  ping flooding the ucc_geth ethernet interaface.
> 
> Some time ago I've tried a similar thing for this driver, but during
> tcp (or udp I don't quite remember) netperf tests I was getting tx
> watchdog timeouts after ~2-5 minutes of work. I was testing with a
> gigabit and 100 Mbit link, with 100 Mbit link the issue was not
> reproducible.
> 
> Though, I recalling I was doing a bit more than your patch: I was
> also clearing the TX events in the ucce register before calling
> ucc_geth_tx, that way I was trying to avoid stale interrupts. That

Sure, but that is another patch I think.

> helped to increase an overall performance (not only responsiveness),
> but as I said my approach didn't pass the tests.
> 
> I don't really think that your patch may cause this, but can you
> try netperf w/ this patch applied anyway? And see if it really
> doesn't cause any issues under stress?

Ran this on my host against my target board:
 netperf -t UDP_RR  -H 192.168.1.16
 netperf -t UDP_STREAM -H 192.168.1.16
 netperf -t TCP_STREAM -H 192.168.1.16
 netperf -t TCP_SENDFILE -H 192.168.1.16
 netperf -t TCP_MAERTS -H 192.168.1.16
 netperf -t TCP_RR -H 192.168.1.16
 netperf -t TCP_CRR -H 192.168.1.16

Didn't notice any timeouts, but I only have 100Mbit interfaces.
